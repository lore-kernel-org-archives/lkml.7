Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9016CC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DAB2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368689;
	bh=ZHYS66eIgUY+gf3oL70NpDwkygBdpNUpnUHaZi6Z1v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vlNJZ5YuWftm+VWNhPtH2on+f6VDZOwe0l9ileZodh9Msuf2Xhx/ZT/gAfB9IDzS/
	 YLuRmmE8Dm+JEGfRBNG3TYyyy3wVv9gdZKx3MDvWJF3fogbBVA9HB8NGNUoRuRaG2d
	 NGMGLB4Ynt9FZ+NgMrxomCZEPrWFFXukiFuR4T4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfDDJEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbfDDJEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84400214AF;
        Thu,  4 Apr 2019 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368683;
        bh=ZHYS66eIgUY+gf3oL70NpDwkygBdpNUpnUHaZi6Z1v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNz3gR/c6URvS6SqKz+Zd+swrotBSsNMdNVB9QVAt3D2XY54uajeHX45KtW5JM7Ie
         Cw4dW5rZjgpTjnVeUyb1S6EPR0fEDyzD5diznRViKXNR/0rnZl3L9ati5nv5eb8qhz
         68Ff1SndZlLzsXwOgF/fefYDdHs7z5BzVOgKdhnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
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
Subject: [PATCH 4.19 115/187] genirq: Avoid summation loops for /proc/stat
Date:   Thu,  4 Apr 2019 10:47:32 +0200
Message-Id: <20190404084608.679112212@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



