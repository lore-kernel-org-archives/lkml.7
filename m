Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B02EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187802085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfCYHGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:06:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62461 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbfCYHGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:06:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E15A3307D941;
        Mon, 25 Mar 2019 07:06:42 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2682E6683F;
        Mon, 25 Mar 2019 07:06:22 +0000 (UTC)
Date:   Mon, 25 Mar 2019 15:06:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, minlei@redhat.com
Subject: Re: Virtio-scsi multiqueue irq affinity
Message-ID: <20190325070616.GA9642@ming.t460p>
References: <20190318062150.GC6654@xz-x1>
 <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de>
 <20190325050213.GH9149@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325050213.GH9149@xz-x1>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 25 Mar 2019 07:06:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 01:02:13PM +0800, Peter Xu wrote:
> On Sat, Mar 23, 2019 at 06:15:59PM +0100, Thomas Gleixner wrote:
> > Peter,
> 
> Hi, Thomas,
> 
> > 
> > On Mon, 18 Mar 2019, Peter Xu wrote:
> > > I noticed that starting from commit 0d9f0a52c8b9 ("virtio_scsi: use
> > > virtio IRQ affinity", 2017-02-27) the virtio scsi driver is using a
> > > new way (via irq_create_affinity_masks()) to automatically initialize
> > > IRQ affinities for the multi-queues, which is different comparing to
> > > all the other virtio devices (like virtio-net, which still uses
> > > virtqueue_set_affinity(), which is actually, irq_set_affinity_hint()).
> > > 
> > > Firstly, it will definitely broke some of the userspace programs with
> > > that when the scripts wanted to do the bindings explicitly like before
> > > and they could simply fail with -EIO now every time when echoing to
> > > /proc/irq/N/smp_affinity of any of the multi-queues (see
> > > write_irq_affinity()).
> > 
> > Did it break anything? I did not see a report so far. Assumptions about
> > potential breakage are not really useful.
> 
> It broke some automation scripts e.g. where they tried to bind CPUs to
> IRQs before staring IO but these scripts failed early during setup
> when trying to echo into the affinity procfs file.  Actually I started
> to look into this because of such script breakage reported by QEs.
> Iinitially it was thought as a kernel bug but later we noticed that
> it's a change in policy.
> 
> > 
> > > Is there any specific reason to do it with the new way?  Since AFAIU
> > > we should still allow the system admins to decide what to do for such
> > > configurations, .e.g., what if we only want to provision half of the
> > > CPU resources to handle IRQs for a specific virtio-scsi controller?
> > > We won't be able to achieve that with current policy.  Or, could this
> > > be a question for the IRQ system (irq_create_affinity_masks()) in
> > > general?  Any special considerations behind the big picture?
> > 
> > That has nothing to do with the irq subsystem. That merily provides the
> > mechanisms.
> > 
> > The reason behind this is that multi-queue devices set up queues per cpu or
> > if not enough queues are available queues per cpu groups. So it does not
> > make sense to move the interrupt away from the CPU or the CPU group.
> > 
> > Aside of that in the CPU hotunplug case, interrupts used to be moved to the
> > online CPUs which resulted in problems for e.g. hibernation because on
> > large systems moving all interrupts to the boot CPU does not work due to
> > vector space exhaustion. Also CPU hotunplug is used for power management
> > purposes and there it does not make sense either to have the per cpu queues
> > of the offlined CPUs moved to the still online CPUs which then end up with
> > several queues.
> > 
> > The new way to deal with this is to strictly bind per CPU (per CPU group)
> > queues. If the CPU or the last CPU in the group goes offline the following
> > happens:
> > 
> >  1) The queue is disabled, i.e. no new requests can be queued
> > 
> >  2) Wait for the outstanding requests to complete
> > 
> >  3) Shut down the interrupt
> > 
> >  This avoids having multiple queues moved to the still online CPUs and also
> >  prevents vector space exhaustion because the shut down interrupt does not
> >  have to be migrated.
> > 
> > When the CPU (or the first in the group) comes online again:
> > 
> >  1) Reenable the interrupt
> > 
> >  2) Reenable the queue
> > 
> > Hope that helps.
> 
> Thanks for explaining everything!  It helps a lot, and yes it makes
> perfect sense to me.
> 
> If no one reported any issue I think either the scripts are not
> checking the return code so they might fail silently but it might not
> matter much (e.g., if the only thing that a script wants to do is to
> spread the CPUs upon the IRQs then the script can simply cancel the
> setup procedure of this, and even failing of those echos won't affect
> much too), or they're just simpled fixed up later on.  Now the only
> thing I am unsure about is whether there could be scenarios that we
> may not want to use the default policy to spread the cores.
> 
> One thing I can think of is the real-time scenario where "isolcpus="
> is provided, then logically we should not allow any isolated CPUs to
> be bound to any of the multi-queue IRQs.  Though Ming Lei and I had a

So far, this behaviour is made by user-space.

From my understanding, IRQ subsystem doesn't handle "isolcpus=", even
though the Kconfig help doesn't mention irq affinity affect:

          Make sure that CPUs running critical tasks are not disturbed by
          any source of "noise" such as unbound workqueues, timers, kthreads...
          Unbound jobs get offloaded to housekeeping CPUs. This is driven by
          the "isolcpus=" boot parameter.

Yeah, some RT application may exclude 'isolcpus=' from some IRQ's
affinity via /proc/irq interface, and now it becomes not possible any
more to do that for managed IRQ.

> discussion offlist before and Ming explained to me that as long as the
> isolated CPUs do not generate any IO then there will be no IRQ on
> those isolated (real-time) CPUs at all.  Can we guarantee that?  Now

It is only guaranteed for 1:1 mapping.

blk-mq uses managed IRQ's affinity to setup queue mapping, for example:

1) single hardware queue
- this queue's IRQ affinity includes all CPUs, then the hardware queue's
IRQ is only fired on one specific CPU for IO submitted from any CPU

2) multi hardware queue
- there are N hardware queues
- for each hardware queue i(i < N), its IRQ's affinity may include N(i) CPUs,
then IRQ for this hardware queue i is fired on one specific CPU among N(i).


Thanks,
Ming
