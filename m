Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD1C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7929D2189D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfHHMHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:07:06 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:40800 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbfHHMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:07:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TYy96hE_1565265994;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TYy96hE_1565265994)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Aug 2019 20:06:42 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tao.ma@linux.alibaba.com, gerry@linux.alibaba.com
Subject: [PATCH 1/2] genirq: introduce update_irq_devid()
Date:   Thu,  8 Aug 2019 20:07:31 +0800
Message-Id: <39a5009c77d07c3ce42ef784465c05e36d5f684d.1565263723.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1565263723.git.luoben@linux.alibaba.com>
References: <cover.1565263723.git.luoben@linux.alibaba.com>
In-Reply-To: <cover.1565263723.git.luoben@linux.alibaba.com>
References: <cover.1565263723.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, only the dev_id field of irqaction need to be changed.
E.g. KVM VM with device passthru via VFIO may switch irq injection
path between KVM irqfd and userspace eventfd. These two paths
share the same irq num and handler for the same vector of a device,
only with different dev_id referencing to different fds' contexts.

So, instead of free/request irq, only update dev_id of irqaction.
This narrows the gap for setting up new irq (and irte, if has)
and also gains some performance benefit.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
---
 include/linux/interrupt.h |  3 ++
 kernel/irq/manage.c       | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5b8328a..2838113 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -172,6 +172,9 @@ struct irqaction {
 request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 		   const char *devname, void __percpu *dev);
 
+extern int update_irq_devid(unsigned int irq, void *dev_id,
+		void *new_dev_id);
+
 extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e8f7f17..18dc10d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2059,6 +2059,80 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 EXPORT_SYMBOL(request_threaded_irq);
 
 /**
+ *	update_irq_devid - update irq dev_id to a new one
+ *	@irq: Interrupt line to update
+ *	@dev_id: A cookie to find the irqaction to update
+ *	@new_dev_id: New cookie passed to the handler function
+ *
+ *	Sometimes, only the cookie data need to be changed.
+ *	Instead of free/request irq, only update dev_id here
+ *	Not only to gain some performance benefit, but also
+ *	reduce the risk of losing interrupt.
+ *
+ *	E.g. irq affinity setting in a VM with VFIO passthru
+ *	device is carried out in a free-then-request-irq way
+ *	since lack of this very function. The free_irq()
+ *	eventually triggers deactivation of IR domain, which
+ *	will cleanup IRTE. There is a gap before request_irq()
+ *	finally setup the IRTE again. In this gap, a in-flight
+ *	irq buffering in hardware layer may trigger DMAR fault
+ *	and be lost.
+ *
+ *	On failure, it returns a negative value. On success,
+ *	it returns 0
+ */
+int update_irq_devid(unsigned int irq, void *dev_id, void *new_dev_id)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irqaction *action, **action_ptr;
+	unsigned long flags;
+
+	WARN(in_interrupt(),
+			"Trying to update IRQ %d from IRQ context!\n", irq);
+
+	if (!desc)
+		return -EINVAL;
+
+	chip_bus_lock(desc);
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
+			WARN(1, "Trying to update already-free IRQ %d\n", irq);
+			raw_spin_unlock_irqrestore(&desc->lock, flags);
+			chip_bus_sync_unlock(desc);
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
+	chip_bus_sync_unlock(desc);
+
+	/*
+	 * Make sure it's not being used on another CPU:
+	 * There is a risk of UAF for old *dev_id, if it is
+	 * freed in a short time after this func returns
+	 */
+	synchronize_irq(irq);
+
+	return 0;
+}
+EXPORT_SYMBOL(update_irq_devid);
+
+/**
  *	request_any_context_irq - allocate an interrupt line
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs.
-- 
1.8.3.1

