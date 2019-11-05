Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F058C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0417214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbfKEOa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:30:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbfKEOa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:30:28 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78F22EEBB3532B380AED;
        Tue,  5 Nov 2019 22:30:25 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 22:30:18 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <perex@perex.cz>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>, <allison@lohutok.net>,
        <tglx@linutronix.de>, <joe@perches.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v2] hp100: remove set but not used variable val
Date:   Tue, 5 Nov 2019 22:36:59 +0800
Message-ID: <1572964619-76671-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20191105133554.6C01F9A06CB85816F399@huawei.com>
References: <20191105133554.6C01F9A06CB85816F399@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenwandun <chenwandun@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/hp/hp100.c: In function hp100_start_xmit:
drivers/staging/hp/hp100.c:1629:10: warning: variable val set but not used [-Wunused-but-set-variable]

Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 drivers/staging/hp/hp100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/hp/hp100.c b/drivers/staging/hp/hp100.c
index 6ec78f5..6fc7733 100644
--- a/drivers/staging/hp/hp100.c
+++ b/drivers/staging/hp/hp100.c
@@ -1626,7 +1626,9 @@ static netdev_tx_t hp100_start_xmit(struct sk_buff *skb,
 	unsigned long flags;
 	int i, ok_flag;
 	int ioaddr = dev->base_addr;
+#ifdef HP100_DEBUG_TX
 	u_short val;
+#endif
 	struct hp100_private *lp = netdev_priv(dev);
 
 #ifdef HP100_DEBUG_B
@@ -1695,7 +1697,9 @@ static netdev_tx_t hp100_start_xmit(struct sk_buff *skb,
 
 	spin_lock_irqsave(&lp->lock, flags);
 	hp100_ints_off();
+#ifdef HP100_DEBUG_TX
 	val = hp100_inw(IRQ_STATUS);
+#endif
 	/* Ack / clear the interrupt TX_COMPLETE interrupt - this interrupt is set
 	 * when the current packet being transmitted on the wire is completed. */
 	hp100_outw(HP100_TX_COMPLETE, IRQ_STATUS);
-- 
2.7.4

