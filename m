Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1098420857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCKOwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:52:21 -0400
Received: from smtprz14.163.net ([106.3.154.247]:60612 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727334AbfCKOwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:52:21 -0400
Received: from 172.25.16.147 (unknown [172.25.16.147])
        by freemail01.tom.com (Postfix) with ESMTP id 257F11C8245B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:52:15 +0800 (CST)
Received: from 172.25.16.90 (HELO smtp.tom.com) ([172.25.16.90])
          by localhost (TOM SMTP Server) with SMTP ID -517847186
          for <linux-kernel@vger.kernel.org>;
          Mon, 11 Mar 2019 22:52:15 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 430491C821C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:52:14 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 35ED010017DE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:52:14 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B3OUaPaZxEis for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 22:52:13 +0800 (CST)
Received: from localhost (unknown [110.184.152.196])
        by antispam1.tom.com (Postfix) with ESMTPA id AD8441001713;
        Mon, 11 Mar 2019 22:52:12 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     tglx@linutronix.de
Cc:     jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] irqchip/gic: fix passing wrong start irq number to irq_alloc_descs() for secondary GICs
Date:   Mon, 11 Mar 2019 22:52:08 +0800
Message-Id: <1552315928-3292-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For secondary GICs, the start irq number should skip over SGIs
and PPIs. Its value should be 32. So we should pass hwirq_base to 
irq_alloc_descs() rather than a constant number 16.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ba2a37a..351f576 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1157,7 +1157,7 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 
 		gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
 
-		irq_base = irq_alloc_descs(irq_start, 16, gic_irqs,
+		irq_base = irq_alloc_descs(irq_start, hwirq_base, gic_irqs,
 					   numa_node_id());
 		if (irq_base < 0) {
 			WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
-- 
1.9.1

