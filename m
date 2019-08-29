Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793512166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfH2Pvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:51:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:32846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728301AbfH2Pui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:50:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE61BB6A1;
        Thu, 29 Aug 2019 15:50:36 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 net-next 14/15] net: sgi: ioc3-eth: protect emcr in all cases
Date:   Thu, 29 Aug 2019 17:50:12 +0200
Message-Id: <20190829155014.9229-15-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190829155014.9229-1-tbogendoerfer@suse.de>
References: <20190829155014.9229-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

emcr in private struct wasn't always protected by spinlock.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 00942b37a1e4..d2b6659adba6 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -729,6 +729,8 @@ static inline void ioc3_setup_duplex(struct ioc3_private *ip)
 {
 	struct ioc3_ethregs *regs = ip->regs;
 
+	spin_lock_irq(&ip->ioc3_lock);
+
 	if (ip->mii.full_duplex) {
 		writel(ETCSR_FD, &regs->etcsr);
 		ip->emcr |= EMCR_DUPLEX;
@@ -737,6 +739,8 @@ static inline void ioc3_setup_duplex(struct ioc3_private *ip)
 		ip->emcr &= ~EMCR_DUPLEX;
 	}
 	writel(ip->emcr, &regs->emcr);
+
+	spin_unlock_irq(&ip->ioc3_lock);
 }
 
 static void ioc3_timer(struct timer_list *t)
@@ -1628,6 +1632,8 @@ static void ioc3_set_multicast_list(struct net_device *dev)
 
 	netif_stop_queue(dev);				/* Lock out others. */
 
+	spin_lock_irq(&ip->ioc3_lock);
+
 	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous.  */
 		ip->emcr |= EMCR_PROMISC;
 		writel(ip->emcr, &regs->emcr);
@@ -1656,6 +1662,8 @@ static void ioc3_set_multicast_list(struct net_device *dev)
 		writel(ip->ehar_l, &regs->ehar_l);
 	}
 
+	spin_unlock_irq(&ip->ioc3_lock);
+
 	netif_wake_queue(dev);			/* Let us get going again. */
 }
 
-- 
2.13.7

