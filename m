Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC535C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745762465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhxHrFsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLSI2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:28:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34803 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbfLSI2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576744119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kP6dGiwQFLPeMqMtCVdXCZMad4G8ZIEEzNzDP3d4C9c=;
        b=QhxHrFsa0X+HBJyReUvR9T1h9SLCziMWW5XG9iBw/htwD3f+l5+ATV7ZXU+2S3t0G/vKGj
        WuDVdJIGahBIHZPzIg1JmVmA9DwI6kwjvXWflUGe6kA+x7pE3lA483qC8iZB5q91apqa5G
        Yv/NQOyFXIdGdwXwmMQkzT1pCtMwRq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-XPn5euO_MYyFa-Vy2v3IqA-1; Thu, 19 Dec 2019 03:28:36 -0500
X-MC-Unique: XPn5euO_MYyFa-Vy2v3IqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50A551005502;
        Thu, 19 Dec 2019 08:28:35 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D1D910013A1;
        Thu, 19 Dec 2019 08:28:24 +0000 (UTC)
Date:   Thu, 19 Dec 2019 16:28:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel-managed IRQ affinity (cont)
Message-ID: <20191219082819.GB15731@ming.t460p>
References: <20191216195712.GA161272@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216195712.GA161272@xz-x1>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Dec 16, 2019 at 02:57:12PM -0500, Peter Xu wrote:
> Hi, Thomas,
> 
> (Sorry I must have lost the discussion during an email migration, so
>  I'll start with a new one)
> 
> This is a continued discussion of previous one on kernel managed IRQ
> affinity [1].  I think at that time the conclusion is that we don't
> have a usage scenario to change current policy [2].  However recently
> I noticed that it is probably a very fundamental requirement for some
> real-time scenarios, even when there's no multi-queue involved.
> 
> In my test case, it was a very common realtime guest with 10 vcpus,
> 0-1 are housekeeping vcpus, 2-9 are realtime vcpus.  The guest has one
> virtio-blk device as boot disk.  With a distribution very close to
> latest upstream, we can observe high spikes, probably due to the IRQs.
> 
> To guarantee realtime responsiveness, we need to make sure the IRQs
> will be managable, say, when I run a real-time workload on vcpu9, we
> should be able to move all the IRQs from vcpu9 to the other vcpus
> (most probably vcpu0 and vcpu1).  However with the kernel managed IRQs
> we can't echo to /proc/irq/N/smp_affinity.  Here, vcpu9 gets IRQ 38
> from the virtio-blk device:
> 
>   # cat /proc/interrupts | grep -w 38
>   38: 0 0 0 0 0 0 0 0 0 15206 PCI-MSI 2621441-edge virtio2-req.0
>   # cat /proc/irq/38/smp_affinity
>   3ff
>   # cat /proc/irq/38/effective_affinity
>   200
> 
> Meanwhile, I don't think there's anything special for VMs, so this
> issue should exist even for hosts as long as the IRQ is managed in the
> same way here as the virtio-blk device.
> 
> As Ming has mentioned in previous discussions [3], I think it would be
> at least good if the kernel IRQ system can respect "irqaffinity=" when
> assigning IRQs to the cores.  Currently it's not.  What would you
> suggest in this case?  Do you think this is a valid user scenario?
> 
> Thanks,
> 
> [1] https://lkml.org/lkml/2019/3/18/15
> [2] https://lkml.org/lkml/2019/3/25/562
> [3] https://lkml.org/lkml/2019/3/25/308

The following patch supposes to implementation the requirement for you,
can you test it by passing 'isolcpus=managed_irq,X-Y'?

With this kind of change, you can't run any IO from any isolated
CPU core, otherwise, unpredictable error may be triggered, either oops or
IO hang.

Another conservative approach is to only select effective CPU from
non-isolated cpus, however, the assigned CPUs may not be balanced among
interrupt vectors. But it is safer, since the system still works even if
someone submits IO from any isolated cpu core.

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 6c8512d3be88..0fbcbacd1b29 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -13,6 +13,7 @@ enum hk_flags {
 	HK_FLAG_TICK		= (1 << 4),
 	HK_FLAG_DOMAIN		= (1 << 5),
 	HK_FLAG_WQ		= (1 << 6),
+	HK_FLAG_MANAGED_IRQ	= (1 << 7),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4d89ad4fae3b..f18f6fa29b73 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/sort.h>
+#include <linux/sched/isolation.h>
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_vec)
@@ -269,6 +270,8 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
+			if (!cpumask_intersects(cpu_mask, node_to_cpumask[n]))
+				continue;
 			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
 				   node_to_cpumask[n]);
 			if (++curvec == last_affv)
@@ -341,26 +344,29 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 {
 	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
-	cpumask_var_t nmsk, npresmsk;
+	cpumask_var_t nmsk, cpumsk;
 	int ret = -ENOMEM;
+	const struct cpumask * housekeeping_mask =
+		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return ret;
 
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&cpumsk, GFP_KERNEL))
 		goto fail_nmsk;
 
 	node_to_cpumask = alloc_node_to_cpumask();
 	if (!node_to_cpumask)
-		goto fail_npresmsk;
+		goto fail_cpumsk;
 
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
 
+	cpumask_and(cpumsk, housekeeping_mask, cpu_present_mask);
 	/* Spread on present CPUs starting from affd->pre_vectors */
 	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
-					 node_to_cpumask, cpu_present_mask,
+					 node_to_cpumask, cpumsk,
 					 nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
@@ -376,9 +382,10 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 		curvec = firstvec;
 	else
 		curvec = firstvec + nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	cpumask_andnot(cpumsk, cpu_possible_mask, cpu_present_mask);
+	cpumask_and(cpumsk, cpumsk, housekeeping_mask);
 	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
-					 node_to_cpumask, npresmsk, nmsk,
+					 node_to_cpumask, cpumsk, nmsk,
 					 masks);
 	if (ret >= 0)
 		nr_others = ret;
@@ -391,8 +398,8 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 
 	free_node_to_cpumask(node_to_cpumask);
 
- fail_npresmsk:
-	free_cpumask_var(npresmsk);
+ fail_cpumsk:
+	free_cpumask_var(cpumsk);
 
  fail_nmsk:
 	free_cpumask_var(nmsk);
@@ -405,6 +412,16 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 	affd->set_size[0] = affvecs;
 }
 
+static void set_default_affinity(cpumask_var_t mask)
+{
+	const struct cpumask * housekeeping_mask =
+		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+
+	cpumask_and(mask, housekeeping_mask, irq_default_affinity);
+	if (cpumask_weight(mask) == 0)
+		cpumask_and(mask, housekeeping_mask, cpu_possible_mask);
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -452,7 +469,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
+		set_default_affinity(&masks[curvec].mask);
 
 	/*
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
@@ -478,7 +495,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	else
 		curvec = affd->pre_vectors + usedvecs;
 	for (; curvec < nvecs; curvec++)
-		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
+		set_default_affinity(&masks[curvec].mask);
 
 	/* Mark the managed interrupts */
 	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 9fcb2a695a41..008d6ac2342b 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -163,6 +163,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "managed_irq,", 12)) {
+			str += 12;
+			flags |= HK_FLAG_MANAGED_IRQ;
+			continue;
+		}
+
 		pr_warn("isolcpus: Error, unknown flag\n");
 		return 0;
 	}

-- 
Ming

