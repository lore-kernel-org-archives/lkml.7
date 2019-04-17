Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1958BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD8A2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bHJJfJba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfDQIN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:13:26 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33560 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbfDQINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:13:24 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id E76C12E145C;
        Wed, 17 Apr 2019 11:13:21 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id tyKNRnWhQ2-DLoOacZo;
        Wed, 17 Apr 2019 11:13:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1555488801; bh=erQjNL5gbIE//F78NAsnJp4HRRQg3PFtAJnUT1IRkZE=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=bHJJfJba+FA5aWWTIIGEzUQciZrmfp72Vp/9N1kFEx4hN6Mu7wNZUCi8nYx9qaDmE
         0xx/moDmxWmdLQth9QM9TBLTIo52/FuP+MfYvQRTfDao/xUFIsXypSNPs5ICYtpEHs
         rIsRdpNVN14GMjRG/Xgc+CwTMO4prpQYne2oyVlM=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:f5ec:9361:ed45:768f])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5VSG6SVdjC-DK0ipQ0r;
        Wed, 17 Apr 2019 11:13:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/2] e1000e: start network tx queue only when link is up
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, Joseph Yasi <joe.yasi@gmail.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        e1000-devel@lists.sourceforge.net
Date:   Wed, 17 Apr 2019 11:13:20 +0300
Message-ID: <155548880068.3454.1621821881762819373.stgit@buzz>
In-Reply-To: <155548879651.3454.13167784936351314661.stgit@buzz>
References: <155548879651.3454.13167784936351314661.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver does not want to keep packets in tx queue when link is lost.
But present code only reset NIC to flush them, but does not prevent
queuing new packets. Moreover reset sequence itself could generate
new packets via netconsole and NIC falls into endless reset loop.

This patch wakes tx queue only when NIC is ready to send packets.

This is proper fix for problem addressed by commit 0f9e980bf5ee
("e1000e: fix cyclic resets at link up with active tx").

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ba96e52aa8d1..fe643d66aa10 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4209,7 +4209,7 @@ void e1000e_up(struct e1000_adapter *adapter)
 		e1000_configure_msix(adapter);
 	e1000_irq_enable(adapter);
 
-	netif_start_queue(adapter->netdev);
+	/* tx queue started by watchdog timer when link is up */
 
 	e1000e_trigger_lsc(adapter);
 }
@@ -4607,6 +4607,7 @@ int e1000e_open(struct net_device *netdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	netif_carrier_off(netdev);
+	netif_stop_queue(netdev);
 
 	/* allocate transmit descriptors */
 	err = e1000e_setup_tx_resources(adapter->tx_ring);
@@ -4667,7 +4668,6 @@ int e1000e_open(struct net_device *netdev)
 	e1000_irq_enable(adapter);
 
 	adapter->tx_hang_recheck = false;
-	netif_start_queue(netdev);
 
 	hw->mac.get_link_status = true;
 	pm_runtime_put(&pdev->dev);
@@ -5289,6 +5289,7 @@ static void e1000_watchdog_task(struct work_struct *work)
 			if (phy->ops.cfg_on_link_up)
 				phy->ops.cfg_on_link_up(hw);
 
+			netif_wake_queue(netdev);
 			netif_carrier_on(netdev);
 
 			if (!test_bit(__E1000_DOWN, &adapter->state))
@@ -5302,6 +5303,7 @@ static void e1000_watchdog_task(struct work_struct *work)
 			/* Link status message must follow this format */
 			pr_info("%s NIC Link is Down\n", adapter->netdev->name);
 			netif_carrier_off(netdev);
+			netif_stop_queue(netdev);
 			if (!test_bit(__E1000_DOWN, &adapter->state))
 				mod_timer(&adapter->phy_info_timer,
 					  round_jiffies(jiffies + 2 * HZ));

