Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3063DC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE4F21897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfIBECM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 00:02:12 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:31969 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728329AbfIBECL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:02:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tb3eA21_1567396916;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Tb3eA21_1567396916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 12:01:58 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com
Subject: [PATCH v6 1/3] genirq: enhance error recovery code in free irq
Date:   Mon,  2 Sep 2019 12:01:50 +0800
Message-Id: <d2d582fc17b7a469f9e7294fe0f868a8ed168c0d.1567394624.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567394624.git.luoben@linux.alibaba.com>
References: <cover.1567394624.git.luoben@linux.alibaba.com>
In-Reply-To: <cover.1567394624.git.luoben@linux.alibaba.com>
References: <cover.1567394624.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__free_irq()/__free_percpu_irq() need to return if called from IRQ
context because the interrupt handler loop runs with desc->lock dropped
and dev_id can be subject to load and store tearing. Also move WARNs
out of lock region and print out dev_id to help debugging.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 kernel/irq/manage.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e8f7f17..10ec3e9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1690,7 +1690,10 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	struct irqaction *action, **action_ptr;
 	unsigned long flags;
 
-	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
+	if (WARN(in_interrupt(),
+		 "Trying to free IRQ %d (dev_id %p) from IRQ context!\n",
+		 irq, dev_id))
+		return NULL;
 
 	mutex_lock(&desc->request_mutex);
 	chip_bus_lock(desc);
@@ -1705,10 +1708,11 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		action = *action_ptr;
 
 		if (!action) {
-			WARN(1, "Trying to free already-free IRQ %d\n", irq);
 			raw_spin_unlock_irqrestore(&desc->lock, flags);
 			chip_bus_sync_unlock(desc);
 			mutex_unlock(&desc->request_mutex);
+			WARN(1, "Trying to free already-free IRQ %d (dev_id %p)\n",
+			     irq, dev_id);
 			return NULL;
 		}
 
@@ -2286,7 +2290,10 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	struct irqaction *action;
 	unsigned long flags;
 
-	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
+	if (WARN(in_interrupt(),
+		 "Trying to free IRQ %d (dev_id %p) from IRQ context!\n",
+		 irq, dev_id))
+		return NULL;
 
 	if (!desc)
 		return NULL;
@@ -2295,14 +2302,17 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 
 	action = desc->action;
 	if (!action || action->percpu_dev_id != dev_id) {
-		WARN(1, "Trying to free already-free IRQ %d\n", irq);
-		goto bad;
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		WARN(1, "Trying to free already-free IRQ (dev_id %p) %d\n",
+		     dev_id, irq);
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
@@ -2317,10 +2327,6 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
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

