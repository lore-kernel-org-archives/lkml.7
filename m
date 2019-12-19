Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8951C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3A4227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCDbmYi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLSQLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:11:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28889 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726817AbfLSQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576771899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEL17WIpG3LEd5X64zpTxJsbKnklF1WKFE5kdzZrk1c=;
        b=aCDbmYi14O/r84NAqgPPka6L3weIx8Z6evUQbNJD8v0A2+cp2jbzqobwYg9DeeH13cv2td
        GB+7PLDK5hMOxRJmZmyquJzi/trAl6M0q9DuMeBEN5iHU/R68qKLSMDcwoB1S4qZVGGmZx
        60br5e0fFbRtisDJv0yqTNab5/n0I2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-HNt-mm9-ML2BVQFz_GSw2g-1; Thu, 19 Dec 2019 11:11:37 -0500
X-MC-Unique: HNt-mm9-ML2BVQFz_GSw2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550B1102CE14;
        Thu, 19 Dec 2019 16:11:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69B6917143;
        Thu, 19 Dec 2019 16:11:19 +0000 (UTC)
Date:   Fri, 20 Dec 2019 00:11:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel-managed IRQ affinity (cont)
Message-ID: <20191219161115.GA18672@ming.t460p>
References: <20191216195712.GA161272@xz-x1>
 <20191219082819.GB15731@ming.t460p>
 <20191219143214.GA50561@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219143214.GA50561@xz-x1>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 09:32:14AM -0500, Peter Xu wrote:
> On Thu, Dec 19, 2019 at 04:28:19PM +0800, Ming Lei wrote:
> > Hi Peter,
> 
> Hi, Ming,
> 
> > 
> > On Mon, Dec 16, 2019 at 02:57:12PM -0500, Peter Xu wrote:
> > > Hi, Thomas,
> > > 
> > > (Sorry I must have lost the discussion during an email migration, so
> > >  I'll start with a new one)
> > > 
> > > This is a continued discussion of previous one on kernel managed IRQ
> > > affinity [1].  I think at that time the conclusion is that we don't
> > > have a usage scenario to change current policy [2].  However recently
> > > I noticed that it is probably a very fundamental requirement for some
> > > real-time scenarios, even when there's no multi-queue involved.
> > > 
> > > In my test case, it was a very common realtime guest with 10 vcpus,
> > > 0-1 are housekeeping vcpus, 2-9 are realtime vcpus.  The guest has one
> > > virtio-blk device as boot disk.  With a distribution very close to
> > > latest upstream, we can observe high spikes, probably due to the IRQs.
> > > 
> > > To guarantee realtime responsiveness, we need to make sure the IRQs
> > > will be managable, say, when I run a real-time workload on vcpu9, we
> > > should be able to move all the IRQs from vcpu9 to the other vcpus
> > > (most probably vcpu0 and vcpu1).  However with the kernel managed IRQs
> > > we can't echo to /proc/irq/N/smp_affinity.  Here, vcpu9 gets IRQ 38
> > > from the virtio-blk device:
> > > 
> > >   # cat /proc/interrupts | grep -w 38
> > >   38: 0 0 0 0 0 0 0 0 0 15206 PCI-MSI 2621441-edge virtio2-req.0
> > >   # cat /proc/irq/38/smp_affinity
> > >   3ff
> > >   # cat /proc/irq/38/effective_affinity
> > >   200
> > > 
> > > Meanwhile, I don't think there's anything special for VMs, so this
> > > issue should exist even for hosts as long as the IRQ is managed in the
> > > same way here as the virtio-blk device.
> > > 
> > > As Ming has mentioned in previous discussions [3], I think it would be
> > > at least good if the kernel IRQ system can respect "irqaffinity=" when
> > > assigning IRQs to the cores.  Currently it's not.  What would you
> > > suggest in this case?  Do you think this is a valid user scenario?
> > > 
> > > Thanks,
> > > 
> > > [1] https://lkml.org/lkml/2019/3/18/15
> > > [2] https://lkml.org/lkml/2019/3/25/562
> > > [3] https://lkml.org/lkml/2019/3/25/308
> > 
> > The following patch supposes to implementation the requirement for you,
> > can you test it by passing 'isolcpus=managed_irq,X-Y'?
> 
> I really appreciate your patch!  I'll keep this version, while before
> I start to test it...
> 
> > 
> > With this kind of change, you can't run any IO from any isolated
> > CPU core, otherwise, unpredictable error may be triggered, either oops or
> > IO hang.
> 
> ... I'm not sure whether this can be acceptable for a production
> environment.
> 
> In our case, the IRQ should come from virtio-blk which is the root
> disk, so I assume even the RT core could use it at least when loading
> the executable into RAM.  So...
> 
> > 
> > Another conservative approach is to only select effective CPU from
> > non-isolated cpus, however, the assigned CPUs may not be balanced among
> > interrupt vectors. But it is safer, since the system still works even if
> > someone submits IO from any isolated cpu core.
> 
> ... this one seems to be more appealing at least to me.

OK, please try the following patch:


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
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..0a75a09cc4e8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
+#include <linux/sched/isolation.h>
 
 #include "internals.h"
 
@@ -212,12 +213,33 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	const struct cpumask *housekeeping_mask =
+		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
 	int ret;
+	cpumask_var_t tmp_mask;
 
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	ret = chip->irq_set_affinity(data, mask, force);
+	if (!zalloc_cpumask_var(&tmp_mask, GFP_KERNEL))
+		return -EINVAL;
+
+	/*
+	 * Userspace can't change managed irq's affinity, make sure
+	 * that isolated CPU won't be selected as the effective CPU
+	 * if this irq's affinity includes both isolated CPU and
+	 * housekeeping CPU.
+	 *
+	 * This way guarantees that isolated CPU won't be interrupted
+	 * by IO submitted from housekeeping CPU.
+	 */
+	if (irqd_affinity_is_managed(data) &&
+			cpumask_intersects(mask, housekeeping_mask))
+		cpumask_and(tmp_mask, mask, housekeeping_mask);
+	else
+		cpumask_copy(tmp_mask, mask);
+
+	ret = chip->irq_set_affinity(data, tmp_mask, force);
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
@@ -229,6 +251,8 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 		ret = 0;
 	}
 
+	free_cpumask_var(tmp_mask);
+
 	return ret;
 }
 
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

