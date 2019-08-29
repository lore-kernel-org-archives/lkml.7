Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D9F2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfH2Pup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:50:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:32962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728306AbfH2Pui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:50:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14997AF79;
        Thu, 29 Aug 2019 15:50:37 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 net-next 15/15] net: sgi: ioc3-eth: no need to stop queue set_multicast_list
Date:   Thu, 29 Aug 2019 17:50:13 +0200
Message-Id: <20190829155014.9229-16-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190829155014.9229-1-tbogendoerfer@suse.de>
References: <20190829155014.9229-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netif_stop_queue()/netif_wake_qeue() aren't needed for changing
multicast filters.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index d2b6659adba6..3f6dffd0351e 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1630,8 +1630,6 @@ static void ioc3_set_multicast_list(struct net_device *dev)
 	struct netdev_hw_addr *ha;
 	u64 ehar = 0;
 
-	netif_stop_queue(dev);				/* Lock out others. */
-
 	spin_lock_irq(&ip->ioc3_lock);
 
 	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous.  */
@@ -1663,8 +1661,6 @@ static void ioc3_set_multicast_list(struct net_device *dev)
 	}
 
 	spin_unlock_irq(&ip->ioc3_lock);
-
-	netif_wake_queue(dev);			/* Let us get going again. */
 }
 
 module_pci_driver(ioc3_driver);
-- 
2.13.7

