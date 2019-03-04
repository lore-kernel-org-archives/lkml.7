Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CB3C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA33220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688875;
	bh=v8AYj4xA4rWa5AFyhYoUXIBcDBFrruwxkSeLVLzRc9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fqB3q+41WaF+ViU7QlfkIZh9pO9W9blXT2QUjAz63zb2xbuQfq4fB8wT3zg3nsLU8
	 oVuTKyTf1MNhqTQonal5w6BfU1I0QhAg4Ct6XG0ildgDPwUQv+RxbyzmjAu/TKykIZ
	 UXtne1KIxy818s5VdhR2Tu3DunrVWn29isErykeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfCDIcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfCDIcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B40842146E;
        Mon,  4 Mar 2019 08:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688322;
        bh=v8AYj4xA4rWa5AFyhYoUXIBcDBFrruwxkSeLVLzRc9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mny6pPLODfAGxd0aKuCbVfxbqpr7weHr7vgQVuoiaGebMCmVLxHbzHn1j9cyejdW6
         2YHGQJUlFNK+E74nM+jLfF1+pRNHK/HAewijZrdErl2GuGu4fjZKAQLGBQElJQHRw7
         xyTd7W5qtTU0ZgNHO7aBma8pKnLi0ybLZDhdpttI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 01/88] genirq/matrix: Improve target CPU selection for managed interrupts.
Date:   Mon,  4 Mar 2019 09:21:44 +0100
Message-Id: <20190304081630.672174148@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e8da8794a7fd9eef1ec9a07f0d4897c68581c72b ]

On large systems with multiple devices of the same class (e.g. NVMe disks,
using managed interrupts), the kernel can affinitize these interrupts to a
small subset of CPUs instead of spreading them out evenly.

irq_matrix_alloc_managed() tries to select the CPU in the supplied cpumask
of possible target CPUs which has the lowest number of interrupt vectors
allocated.

This is done by searching the CPU with the highest number of available
vectors. While this is correct for non-managed CPUs it can select the wrong
CPU for managed interrupts. Under certain constellations this results in
affinitizing the managed interrupts of several devices to a single CPU in
a set.

The book keeping of available vectors works the following way:

 1) Non-managed interrupts:

    available is decremented when the interrupt is actually requested by
    the device driver and a vector is assigned. It's incremented when the
    interrupt and the vector are freed.

 2) Managed interrupts:

    Managed interrupts guarantee vector reservation when the MSI/MSI-X
    functionality of a device is enabled, which is achieved by reserving
    vectors in the bitmaps of the possible target CPUs. This reservation
    decrements the available count on each possible target CPU.

    When the interrupt is requested by the device driver then a vector is
    allocated from the reserved region. The operation is reversed when the
    interrupt is freed by the device driver. Neither of these operations
    affect the available count.

    The reservation persist up to the point where the MSI/MSI-X
    functionality is disabled and only this operation increments the
    available count again.

For non-managed interrupts the available count is the correct selection
criterion because the guaranteed reservations need to be taken into
account. Using the allocated counter could lead to a failing allocation in
the following situation (total vector space of 10 assumed):

		 CPU0	CPU1
 available:	    2	   0
 allocated:	    5	   3   <--- CPU1 is selected, but available space = 0
 managed reserved:  3	   7

 while available yields the correct result.

For managed interrupts the available count is not the appropriate
selection criterion because as explained above the available count is not
affected by the actual vector allocation.

The following example illustrates that. Total vector space of 10
assumed. The starting point is:

		 CPU0	CPU1
 available:	    5	   4
 allocated:	    2	   3
 managed reserved:  3	   3

 Allocating vectors for three non-managed interrupts will result in
 affinitizing the first two to CPU0 and the third one to CPU1 because the
 available count is adjusted with each allocation:

		  CPU0	CPU1
 available:	     5	   4	<- Select CPU0 for 1st allocation
 --> allocated:	     3	   3

 available:	     4	   4	<- Select CPU0 for 2nd allocation
 --> allocated:	     4	   3

 available:	     3	   4	<- Select CPU1 for 3rd allocation
 --> allocated:	     4	   4

 But the allocation of three managed interrupts starting from the same
 point will affinitize all of them to CPU0 because the available count is
 not affected by the allocation (see above). So the end result is:

		  CPU0	CPU1
 available:	     5	   4
 allocated:	     5	   3

Introduce a "managed_allocated" field in struct cpumap to track the vector
allocation for managed interrupts separately. Use this information to
select the target CPU when a vector is allocated for a managed interrupt,
which results in more evenly distributed vector assignments. The above
example results in the following allocations:

		 CPU0	CPU1
 managed_allocated: 0	   0	<- Select CPU0 for 1st allocation
 --> allocated:	    3	   3

 managed_allocated: 1	   0	<- Select CPU1 for 2nd allocation
 --> allocated:	    3	   4

 managed_allocated: 1	   1	<- Select CPU0 for 3rd allocation
 --> allocated:	    4	   4

The allocation of non-managed interrupts is not affected by this change and
is still evaluating the available count.

The overall distribution of interrupt vectors for both types of interrupts
might still not be perfectly even depending on the number of non-managed
and managed interrupts in a system, but due to the reservation guarantee
for managed interrupts this cannot be avoided.

Expose the new field in debugfs as well.

[ tglx: Clarified the background of the problem in the changelog and
  	described it independent of NVME ]

Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kelley <mikelley@microsoft.com>
Link: https://lkml.kernel.org/r/20181106040000.27316-1-longli@linuxonhyperv.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/matrix.c |   34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -14,6 +14,7 @@ struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
 	unsigned int		managed;
+	unsigned int		managed_allocated;
 	bool			initialized;
 	bool			online;
 	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
@@ -145,6 +146,27 @@ static unsigned int matrix_find_best_cpu
 	return best_cpu;
 }
 
+/* Find the best CPU which has the lowest number of managed IRQs allocated */
+static unsigned int matrix_find_best_cpu_managed(struct irq_matrix *m,
+						const struct cpumask *msk)
+{
+	unsigned int cpu, best_cpu, allocated = UINT_MAX;
+	struct cpumap *cm;
+
+	best_cpu = UINT_MAX;
+
+	for_each_cpu(cpu, msk) {
+		cm = per_cpu_ptr(m->maps, cpu);
+
+		if (!cm->online || cm->managed_allocated > allocated)
+			continue;
+
+		best_cpu = cpu;
+		allocated = cm->managed_allocated;
+	}
+	return best_cpu;
+}
+
 /**
  * irq_matrix_assign_system - Assign system wide entry in the matrix
  * @m:		Matrix pointer
@@ -269,7 +291,7 @@ int irq_matrix_alloc_managed(struct irq_
 	if (cpumask_empty(msk))
 		return -EINVAL;
 
-	cpu = matrix_find_best_cpu(m, msk);
+	cpu = matrix_find_best_cpu_managed(m, msk);
 	if (cpu == UINT_MAX)
 		return -ENOSPC;
 
@@ -282,6 +304,7 @@ int irq_matrix_alloc_managed(struct irq_
 		return -ENOSPC;
 	set_bit(bit, cm->alloc_map);
 	cm->allocated++;
+	cm->managed_allocated++;
 	m->total_allocated++;
 	*mapped_cpu = cpu;
 	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
@@ -395,6 +418,8 @@ void irq_matrix_free(struct irq_matrix *
 
 	clear_bit(bit, cm->alloc_map);
 	cm->allocated--;
+	if(managed)
+		cm->managed_allocated--;
 
 	if (cm->online)
 		m->total_allocated--;
@@ -464,13 +489,14 @@ void irq_matrix_debug_show(struct seq_fi
 	seq_printf(sf, "Total allocated:  %6u\n", m->total_allocated);
 	seq_printf(sf, "System: %u: %*pbl\n", nsys, m->matrix_bits,
 		   m->system_map);
-	seq_printf(sf, "%*s| CPU | avl | man | act | vectors\n", ind, " ");
+	seq_printf(sf, "%*s| CPU | avl | man | mac | act | vectors\n", ind, " ");
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
 
-		seq_printf(sf, "%*s %4d  %4u  %4u  %4u  %*pbl\n", ind, " ",
-			   cpu, cm->available, cm->managed, cm->allocated,
+		seq_printf(sf, "%*s %4d  %4u  %4u  %4u %4u  %*pbl\n", ind, " ",
+			   cpu, cm->available, cm->managed,
+			   cm->managed_allocated, cm->allocated,
 			   m->matrix_bits, cm->alloc_map);
 	}
 	cpus_read_unlock();


