Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC79C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A09F2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfHLIw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:52:26 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58205 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfHLIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:52:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TZFSTW7_1565599934;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TZFSTW7_1565599934)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Aug 2019 16:52:21 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: [PATCH v2 1/3] genirq: enhance error recovery code in free irq
Date:   Mon, 12 Aug 2019 16:52:04 +0800
Message-Id: <91dbf91cc98c5db2552cccf6b2dde9e6800a71e8.1565594108.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1565594108.git.luoben@linux.alibaba.com>
References: <cover.1565594108.git.luoben@linux.alibaba.com>
In-Reply-To: <cover.1565594108.git.luoben@linux.alibaba.com>
References: <cover.1565263723.git.luoben@linux.alibaba.com> <cover.1565594108.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Thomas Gleixner's comments:
1) free_irq/free_percpu_irq returns if called from IRQ context
2) move WARN out of the locked region and print out dev_id

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 kernel/irq/manage.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e8f7f17..b97ee5e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1690,7 +1690,11 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	struct irqaction *action, **action_ptr;
 	unsigned long flags;
 
-	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
+	if (in_interrupt()) {
+		WARN(1, "Trying to free IRQ %d (dev_id %p) from IRQ context!\n",
+				irq, dev_id);
+		return NULL;
+	}
 
 	mutex_lock(&desc->request_mutex);
 	chip_bus_lock(desc);
@@ -1705,10 +1709,11 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		action = *action_ptr;
 
 		if (!action) {
-			WARN(1, "Trying to free already-free IRQ %d\n", irq);
 			raw_spin_unlock_irqrestore(&desc->lock, flags);
 			chip_bus_sync_unlock(desc);
 			mutex_unlock(&desc->request_mutex);
+			WARN(1, "Trying to free already-free IRQ %d (dev_id %p)\n",
+					irq, dev_id);
 			return NULL;
 		}
 
@@ -2286,7 +2291,11 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	struct irqaction *action;
 	unsigned long flags;
 
-	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
+	if (in_interrupt()) {
+		WARN(1, "Trying to free IRQ %d (dev_id %p) from IRQ context!\n",
+				irq, dev_id);
+		return NULL;
+	}
 
 	if (!desc)
 		return NULL;
@@ -2295,14 +2304,17 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 
 	action = desc->action;
 	if (!action || action->percpu_dev_id != dev_id) {
-		WARN(1, "Trying to free already-free IRQ %d\n", irq);
-		goto bad;
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		WARN(1, "Trying to free already-free IRQ (dev_id %p) %d\n",
+				irq, dev_id);
+		return NULL;
 	}
 
 	if (!cpumask_empty(desc->percpu_enabled)) {
-		WARN(1, "percpu IRQ %d still enabled on CPU%d!\n",
-		     irq, cpumask_first(desc->percpu_enabled));
-		goto bad;
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		WARN(1, "percpu IRQ %d (dev_id %p) still enabled on CPU%d!\n",
+		     irq, dev_id, cpumask_first(desc->percpu_enabled));
+		return NULL;
 	}
 
 	/* Found it - now remove it from the list of entries: */
@@ -2317,10 +2329,6 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	irq_chip_pm_put(&desc->irq_data);
 	module_put(desc->owner);
 	return action;
-
-bad:
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-	return NULL;
 }
 
 /**
-- 
1.8.3.1

