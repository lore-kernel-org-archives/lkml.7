Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA401C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB342196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497571;
	bh=Kmfu4VmPrjZjFSmVSk+Vfr1mMgssEHe99ALGGhkqr0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIj35Tn5IerYj5NO8bVzqxsXFVHKHb1U+t/k4Y0e8t/LxqO1sFgQa5vTpXBLD3HnU
	 97CRsDw6Ip1astIkZt02NTLjmuwakAZm38Oiir+bvnSKDwHdOTMTTgkuXYzISwhVq/
	 TVa6gsr8wRKLunLgj2XK1cpYolZ4wWfw1txLP8xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfKKSja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfKKSjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:39:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF4E8204FD;
        Mon, 11 Nov 2019 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497565;
        bh=Kmfu4VmPrjZjFSmVSk+Vfr1mMgssEHe99ALGGhkqr0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMKU/TS2B16oM/6ngAwfO9VWgqKVisG/nIorn8yugFwkKZB4VUEk1Pd4Eee3eWAlL
         Gf7k7LxDMZLaktynKQ5ssbv1JMXAjxGSVdSBRoy0sNJUjH/ZOa9Jn+xZTdcUhFIlCQ
         9ukK/Eqc8rlankLCegxLt4HVHg6IvDB0MTPPmRyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 099/105] e1000: fix memory leaks
Date:   Mon, 11 Nov 2019 19:29:09 +0100
Message-Id: <20191111181449.035227403@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 8472ba62154058b64ebb83d5f57259a352d28697 ]

In e1000_set_ringparam(), 'tx_old' and 'rx_old' are not deallocated if
e1000_up() fails, leading to memory leaks. Refactor the code to fix this
issue.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index 10df2d60c1814..88b34f7223375 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -627,6 +627,7 @@ static int e1000_set_ringparam(struct net_device *netdev,
 	for (i = 0; i < adapter->num_rx_queues; i++)
 		rxdr[i].count = rxdr->count;
 
+	err = 0;
 	if (netif_running(adapter->netdev)) {
 		/* Try to get new resources before deleting old */
 		err = e1000_setup_all_rx_resources(adapter);
@@ -647,14 +648,13 @@ static int e1000_set_ringparam(struct net_device *netdev,
 		adapter->rx_ring = rxdr;
 		adapter->tx_ring = txdr;
 		err = e1000_up(adapter);
-		if (err)
-			goto err_setup;
 	}
 	kfree(tx_old);
 	kfree(rx_old);
 
 	clear_bit(__E1000_RESETTING, &adapter->flags);
-	return 0;
+	return err;
+
 err_setup_tx:
 	e1000_free_all_rx_resources(adapter);
 err_setup_rx:
@@ -666,7 +666,6 @@ err_alloc_rx:
 err_alloc_tx:
 	if (netif_running(adapter->netdev))
 		e1000_up(adapter);
-err_setup:
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return err;
 }
-- 
2.20.1



