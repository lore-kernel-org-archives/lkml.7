Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E33C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817152184D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfIBEMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 00:12:19 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:30221 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbfIBEMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:12:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tb4Gnpz_1567396918;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Tb4Gnpz_1567396918)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 12:02:01 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com
Subject: [PATCH v6 2/3] genirq: introduce irq_update_devid()
Date:   Mon,  2 Sep 2019 12:01:51 +0800
Message-Id: <dccc49c34393c9c6114b3695feaab489d680d62d.1567394624.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567394624.git.luoben@linux.alibaba.com>
References: <cover.1567394624.git.luoben@linux.alibaba.com>
In-Reply-To: <cover.1567394624.git.luoben@linux.alibaba.com>
References: <cover.1567394624.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, only the dev_id field of irqaction needs to be changed.

E.g. KVM VM with device passthru via VFIO may switch the interrupt
injection path between KVM irqfd and userspace eventfd. These two
paths share the same interrupt number and handler for the same msi
vector of a device, only with different 'dev_id's referencing to
different fds' contexts. Set interrupt affinity in this VM is a way
to trigger the path switching.

Currently, VFIO uses a free-then-request-irq way for the path switching.
There is a time window between free_irq() and request_irq() where the
target IRTE is invalid. So, in-flight interrupts (buffering in hardware
layer and unfortunately cannot be synchronized in software) can cause
DMAR faults and even worse, this VM may hang in waiting IO completion.

By using irq_update_devid(), this issue can be avoided since IRTE will
not be invalidated during the whole process.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 include/linux/interrupt.h |  3 ++
 kernel/irq/manage.c       | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5b8328a..09b6a0f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -172,6 +172,9 @@ struct irqaction {
 request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 		   const char *devname, void __percpu *dev);
 
+extern int __must_check
+irq_update_devid(unsigned int irq, void *dev_id, void *new_dev_id);
+
 extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 10ec3e9..adb1980 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2063,6 +2063,81 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 EXPORT_SYMBOL(request_threaded_irq);
 
 /**
+ *	irq_update_devid - update irq dev_id to a new one
+ *
+ *	@irq:		Interrupt line to update
+ *	@dev_id:	A cookie to find the irqaction to update
+ *	@new_dev_id:	New cookie passed to the handler function
+ *
+ *	Sometimes, only the cookie data need to be changed. Instead of
+ *	free-then-request interrupt, only update dev_id of irqaction can
+ *	not only gain some performance benefit, but also reduce the risk
+ *	of losing interrupt.
+ *
+ *	This function won't update dev_id until any executing interrupts
+ *	for this IRQ have completed. This function must not be called
+ *	from interrupt context.
+ *
+ *	On failure, it returns a negative value. On success,
+ *	it returns 0
+ */
+int irq_update_devid(unsigned int irq, void *dev_id, void *new_dev_id)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irqaction *action, **action_ptr;
+	unsigned long flags;
+
+	if (WARN(in_interrupt(),
+		 "Trying to update IRQ %d (dev_id %p to %p) from IRQ context!\n",
+		 irq, dev_id, new_dev_id))
+		return -EPERM;
+
+	if (!desc)
+		return -EINVAL;
+
+	/*
+	 * Ensure that an interrupt in flight on another CPU which uses the
+	 * old 'dev_id' has completed because the caller can free the memory
+	 * to which it points after this function returns. And also avoid to
+	 * update 'dev_id' in the middle of a threaded interrupt process, it
+	 * can lead to a twist that primary handler uses old 'dev_id' but new
+	 * 'dev_id' is used by secondary handler.
+	 */
+	disable_irq(irq);
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	/*
+	 * There can be multiple actions per IRQ descriptor, find the right
+	 * one based on the dev_id:
+	 */
+	action_ptr = &desc->action;
+	for (;;) {
+		action = *action_ptr;
+
+		if (!action) {
+			raw_spin_unlock_irqrestore(&desc->lock, flags);
+			enable_irq(irq);
+			WARN(1,
+			     "Trying to update already-free IRQ %d (dev_id %p to %p)\n",
+			     irq, dev_id, new_dev_id);
+			return -ENXIO;
+		}
+
+		if (action->dev_id == dev_id) {
+			action->dev_id = new_dev_id;
+			break;
+		}
+		action_ptr = &action->next;
+	}
+
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	enable_irq(irq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(irq_update_devid);
+
+/**
  *	request_any_context_irq - allocate an interrupt line
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs.
-- 
1.8.3.1

