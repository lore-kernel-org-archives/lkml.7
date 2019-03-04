Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD8C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A859420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689098;
	bh=NrYCS8oTnFl/FsAMm+TClRhqyFBs9HUivAEGy3l/DNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJCcaUav+oVnFD+sKdRDy/Mw0g7GLrD8LRuLZJucOYR5u3/n1x8tlam+aOVbLNKme
	 1oGaG8Xgf3GPe5DT6S0PVQDL9VR173MEfeF2Co1SMZN7p+Gw56YlpBeB3rcS2lqDu1
	 g3Vm1QOW6paNubSbRAZA8lq/LlnTzPeOUEizQPrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfCDI2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfCDI2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:28:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E9821019;
        Mon,  4 Mar 2019 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688095;
        bh=NrYCS8oTnFl/FsAMm+TClRhqyFBs9HUivAEGy3l/DNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLXJCR7A0u4zQRKw20wclzbcr4ZzcDLeM0RFgj+F22s6TOYm/W0IP8tALsAQQlzOD
         7UXFvk/pXwbQ3eUTe09nd6dn0p2NlYToeCvAZ3bMhAMisL8ntievq/VcTUKJsc1wwz
         xLgifr28VkVOKrT1ZOKmr2EocmRYx+3g4TwnVBu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 02/78] irq/matrix: Spread managed interrupts on allocation
Date:   Mon,  4 Mar 2019 09:21:45 +0100
Message-Id: <20190304081625.621366512@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

[ Upstream commit 76f99ae5b54d48430d1f0c5512a84da0ff9761e0 ]

Linux spreads out the non managed interrupt across the possible target CPUs
to avoid vector space exhaustion.

Managed interrupts are treated differently, as for them the vectors are
reserved (with guarantee) when the interrupt descriptors are initialized.

When the interrupt is requested a real vector is assigned. The assignment
logic uses the first CPU in the affinity mask for assignment. If the
interrupt has more than one CPU in the affinity mask, which happens when a
multi queue device has less queues than CPUs, then doing the same search as
for non managed interrupts makes sense as it puts the interrupt on the
least interrupt plagued CPU. For single CPU affine vectors that's obviously
a NOOP.

Restructre the matrix allocation code so it does the 'best CPU' search, add
the sanity check for an empty affinity mask and adapt the call site in the
x86 vector management code.

[ tglx: Added the empty mask check to the core and improved change log ]

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180908175838.14450-2-dou_liyang@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/apic/vector.c |    9 ++++-----
 include/linux/irq.h           |    3 ++-
 kernel/irq/matrix.c           |   17 ++++++++++++++---
 3 files changed, 20 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -313,14 +313,13 @@ assign_managed_vector(struct irq_data *i
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	int vector, cpu;
 
-	cpumask_and(vector_searchmask, vector_searchmask, affmsk);
-	cpu = cpumask_first(vector_searchmask);
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+	cpumask_and(vector_searchmask, dest, affmsk);
+
 	/* set_affinity might call here for nothing */
 	if (apicd->vector && cpumask_test_cpu(apicd->cpu, vector_searchmask))
 		return 0;
-	vector = irq_matrix_alloc_managed(vector_matrix, cpu);
+	vector = irq_matrix_alloc_managed(vector_matrix, vector_searchmask,
+					  &cpu);
 	trace_vector_alloc_managed(irqd->irq, vector, vector);
 	if (vector < 0)
 		return vector;
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1151,7 +1151,8 @@ void irq_matrix_offline(struct irq_matri
 void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit, bool replace);
 int irq_matrix_reserve_managed(struct irq_matrix *m, const struct cpumask *msk);
 void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk);
-int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu);
+int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
+				unsigned int *mapped_cpu);
 void irq_matrix_reserve(struct irq_matrix *m);
 void irq_matrix_remove_reserved(struct irq_matrix *m);
 int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -260,11 +260,21 @@ void irq_matrix_remove_managed(struct ir
  * @m:		Matrix pointer
  * @cpu:	On which CPU the interrupt should be allocated
  */
-int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu)
+int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
+			     unsigned int *mapped_cpu)
 {
-	struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
-	unsigned int bit, end = m->alloc_end;
+	unsigned int bit, cpu, end = m->alloc_end;
+	struct cpumap *cm;
 
+	if (cpumask_empty(msk))
+		return -EINVAL;
+
+	cpu = matrix_find_best_cpu(m, msk);
+	if (cpu == UINT_MAX)
+		return -ENOSPC;
+
+	cm = per_cpu_ptr(m->maps, cpu);
+	end = m->alloc_end;
 	/* Get managed bit which are not allocated */
 	bitmap_andnot(m->scratch_map, cm->managed_map, cm->alloc_map, end);
 	bit = find_first_bit(m->scratch_map, end);
@@ -273,6 +283,7 @@ int irq_matrix_alloc_managed(struct irq_
 	set_bit(bit, cm->alloc_map);
 	cm->allocated++;
 	m->total_allocated++;
+	*mapped_cpu = cpu;
 	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
 	return bit;
 }


