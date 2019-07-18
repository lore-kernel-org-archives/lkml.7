Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562F3C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0FB2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419199;
	bh=JFTBxaKMojFpgikaKkfjlhcOl+A8lazwN8wO3Sr7K8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bENYC6drMzpkx1RO08voNkkgj+npIFFg98bonW2ieMMmZoMxw5EiSfzxwVcgMsKtY
	 s6CAeq5fMhEf+CAkRj3f84P+/3Ch9icsFcO2q6n/WxzarP7/fTRDarzpKuI4wJzrCf
	 drox25l0oTj+YXK42/Ai1nwaVZfSB3uOy0W2ZtN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390254AbfGRDGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390224AbfGRDGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:06:34 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C1A2053B;
        Thu, 18 Jul 2019 03:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419193;
        bh=JFTBxaKMojFpgikaKkfjlhcOl+A8lazwN8wO3Sr7K8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yqypyu/iUEC1pZDiYt3+KR96Y1y+3RMzqv3Ywqmj8q/zYe4dEXkt3nFVb9RXUSuib
         GjSWrChfaitPDcaWPgcHOvBsLs+Ga9XX6/9O/jA7b9lF8GYsU4qaMDPYcExrFAioUX
         5B6jrGeUwCI1w3LYoYKVZbsLbzud3NuJKkSEhnGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Joseph Yasi <joe.yasi@gmail.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 4.19 02/47] e1000e: start network tx queue only when link is up
Date:   Thu, 18 Jul 2019 12:01:16 +0900
Message-Id: <20190718030047.017203434@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit d17ba0f616a08f597d9348c372d89b8c0405ccf3 upstream.

Driver does not want to keep packets in Tx queue when link is lost.
But present code only reset NIC to flush them, but does not prevent
queuing new packets. Moreover reset sequence itself could generate
new packets via netconsole and NIC falls into endless reset loop.

This patch wakes Tx queue only when NIC is ready to send packets.

This is proper fix for problem addressed by commit 0f9e980bf5ee
("e1000e: fix cyclic resets at link up with active tx").

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Tested-by: Joseph Yasi <joe.yasi@gmail.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/e1000e/netdev.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4208,7 +4208,7 @@ void e1000e_up(struct e1000_adapter *ada
 		e1000_configure_msix(adapter);
 	e1000_irq_enable(adapter);
 
-	netif_start_queue(adapter->netdev);
+	/* Tx queue started by watchdog timer when link is up */
 
 	e1000e_trigger_lsc(adapter);
 }
@@ -4584,6 +4584,7 @@ int e1000e_open(struct net_device *netde
 	pm_runtime_get_sync(&pdev->dev);
 
 	netif_carrier_off(netdev);
+	netif_stop_queue(netdev);
 
 	/* allocate transmit descriptors */
 	err = e1000e_setup_tx_resources(adapter->tx_ring);
@@ -4644,7 +4645,6 @@ int e1000e_open(struct net_device *netde
 	e1000_irq_enable(adapter);
 
 	adapter->tx_hang_recheck = false;
-	netif_start_queue(netdev);
 
 	hw->mac.get_link_status = true;
 	pm_runtime_put(&pdev->dev);
@@ -5266,6 +5266,7 @@ static void e1000_watchdog_task(struct w
 			if (phy->ops.cfg_on_link_up)
 				phy->ops.cfg_on_link_up(hw);
 
+			netif_wake_queue(netdev);
 			netif_carrier_on(netdev);
 
 			if (!test_bit(__E1000_DOWN, &adapter->state))
@@ -5279,6 +5280,7 @@ static void e1000_watchdog_task(struct w
 			/* Link status message must follow this format */
 			pr_info("%s NIC Link is Down\n", adapter->netdev->name);
 			netif_carrier_off(netdev);
+			netif_stop_queue(netdev);
 			if (!test_bit(__E1000_DOWN, &adapter->state))
 				mod_timer(&adapter->phy_info_timer,
 					  round_jiffies(jiffies + 2 * HZ));


