Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A06AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEF821741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710438;
	bh=HJBIWWpFRyG8EiqPEY90J8PGrb5cInWuhS7KdR7tCgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fhieXESlPunoFCBhBkmH0ym2kDk24DDdc3jOW2Yl8AcoWbpNBIROZiVp8046pU5o1
	 PwXsPCgfJpH93K0yASHAzHwBdYZY/6Pqof6U1c0DmTon/H6UQuA08cyd6lC7Xgb2p5
	 jhMT0OJnIMVESKv8RFiqfYOz+Qp3gEzzgGEPAbuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfC0SN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389200AbfC0SNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5EA921738;
        Wed, 27 Mar 2019 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710433;
        bh=HJBIWWpFRyG8EiqPEY90J8PGrb5cInWuhS7KdR7tCgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2zcvnjVK3pYD8Px6864IxhI5ndJzzErReCvuD+K0xLnjSHrspW4tNFQaGxIxhzV0
         ZldIfJWjuLfCPL6MCoPFHJZg9PWEolOsUG92Dy2dMEvpBMrbinb63KTJT37Oz6zWPg
         l2Z96AuT6Hj13X6vOaClJX+0XcQ5lEeHX9UUO+88=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 117/192] genirq: Avoid summation loops for /proc/stat
Date:   Wed, 27 Mar 2019 14:09:09 -0400
Message-Id: <20190327181025.13507-117-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 1136b0728969901a091f0471968b2b76ed14d9ad ]

Waiman reported that on large systems with a large amount of interrupts the
readout of /proc/stat takes a long time to sum up the interrupt
statistics. In principle this is not a problem. but for unknown reasons
some enterprise quality software reads /proc/stat with a high frequency.

The reason for this is that interrupt statistics are accounted per cpu. So
the /proc/stat logic has to sum up the interrupt stats for each interrupt.

This can be largely avoided for interrupts which are not marked as
'PER_CPU' interrupts by simply adding a per interrupt summation counter
which is incremented along with the per interrupt per cpu counter.

The PER_CPU interrupts need to avoid that and use only per cpu accounting
because they share the interrupt number and the interrupt descriptor and
concurrent updates would conflict or require unwanted synchronization.

Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Daniel Colascione <dancol@google.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Link: https://lkml.kernel.org/r/20190208135020.925487496@linutronix.de

8<-------------

v2: Undo the unintentional layout change of struct irq_desc.

 include/linux/irqdesc.h |    1 +
 kernel/irq/chip.c       |   12 ++++++++++--
 kernel/irq/internals.h  |    8 +++++++-
 kernel/irq/irqdesc.c    |    7 ++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/irqdesc.h |  1 +
 kernel/irq/chip.c       | 12 ++++++++++--
 kernel/irq/internals.h  |  8 +++++++-
 kernel/irq/irqdesc.c    |  7 ++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd1e40ddac7d..875c41b23f20 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -65,6 +65,7 @@ struct irq_desc {
 	unsigned int		core_internal_state__do_not_mess_with_it;
 	unsigned int		depth;		/* nested irq disables */
 	unsigned int		wake_depth;	/* nested wake enables */
+	unsigned int		tot_count;
 	unsigned int		irq_count;	/* For detecting broken IRQs */
 	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
 	unsigned int		irqs_unhandled;
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index a2b3d9de999c..811009ebacd4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -855,7 +855,11 @@ void handle_percpu_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	kstat_incr_irqs_this_cpu(desc);
+	/*
+	 * PER CPU interrupts are not serialized. Do not touch
+	 * desc->tot_count.
+	 */
+	__kstat_incr_irqs_this_cpu(desc);
 
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
@@ -884,7 +888,11 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
-	kstat_incr_irqs_this_cpu(desc);
+	/*
+	 * PER CPU interrupts are not serialized. Do not touch
+	 * desc->tot_count.
+	 */
+	__kstat_incr_irqs_this_cpu(desc);
 
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ca6afa267070..e74e7eea76cf 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -242,12 +242,18 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 
 #undef __irqd_to_state
 
-static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
+static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
 	__this_cpu_inc(*desc->kstat_irqs);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
+static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
+{
+	__kstat_incr_irqs_this_cpu(desc);
+	desc->tot_count++;
+}
+
 static inline int irq_desc_get_node(struct irq_desc *desc)
 {
 	return irq_common_data_get_node(&desc->irq_common_data);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 578d0e5f1b5b..ba454cba4069 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -119,6 +119,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->depth = 1;
 	desc->irq_count = 0;
 	desc->irqs_unhandled = 0;
+	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
@@ -915,11 +916,15 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 unsigned int kstat_irqs(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	int cpu;
 	unsigned int sum = 0;
+	int cpu;
 
 	if (!desc || !desc->kstat_irqs)
 		return 0;
+	if (!irq_settings_is_per_cpu_devid(desc) &&
+	    !irq_settings_is_per_cpu(desc))
+	    return desc->tot_count;
+
 	for_each_possible_cpu(cpu)
 		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
 	return sum;
-- 
2.19.1

