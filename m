Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047AEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DD120870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCWRQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:16:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfCWRQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:16:03 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7kFU-0005PT-Ds; Sat, 23 Mar 2019 18:16:00 +0100
Date:   Sat, 23 Mar 2019 18:15:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Virtio-scsi multiqueue irq affinity
In-Reply-To: <20190318062150.GC6654@xz-x1>
Message-ID: <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de>
References: <20190318062150.GC6654@xz-x1>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Mon, 18 Mar 2019, Peter Xu wrote:
> I noticed that starting from commit 0d9f0a52c8b9 ("virtio_scsi: use
> virtio IRQ affinity", 2017-02-27) the virtio scsi driver is using a
> new way (via irq_create_affinity_masks()) to automatically initialize
> IRQ affinities for the multi-queues, which is different comparing to
> all the other virtio devices (like virtio-net, which still uses
> virtqueue_set_affinity(), which is actually, irq_set_affinity_hint()).
> 
> Firstly, it will definitely broke some of the userspace programs with
> that when the scripts wanted to do the bindings explicitly like before
> and they could simply fail with -EIO now every time when echoing to
> /proc/irq/N/smp_affinity of any of the multi-queues (see
> write_irq_affinity()).

Did it break anything? I did not see a report so far. Assumptions about
potential breakage are not really useful.

> Is there any specific reason to do it with the new way?  Since AFAIU
> we should still allow the system admins to decide what to do for such
> configurations, .e.g., what if we only want to provision half of the
> CPU resources to handle IRQs for a specific virtio-scsi controller?
> We won't be able to achieve that with current policy.  Or, could this
> be a question for the IRQ system (irq_create_affinity_masks()) in
> general?  Any special considerations behind the big picture?

That has nothing to do with the irq subsystem. That merily provides the
mechanisms.

The reason behind this is that multi-queue devices set up queues per cpu or
if not enough queues are available queues per cpu groups. So it does not
make sense to move the interrupt away from the CPU or the CPU group.

Aside of that in the CPU hotunplug case, interrupts used to be moved to the
online CPUs which resulted in problems for e.g. hibernation because on
large systems moving all interrupts to the boot CPU does not work due to
vector space exhaustion. Also CPU hotunplug is used for power management
purposes and there it does not make sense either to have the per cpu queues
of the offlined CPUs moved to the still online CPUs which then end up with
several queues.

The new way to deal with this is to strictly bind per CPU (per CPU group)
queues. If the CPU or the last CPU in the group goes offline the following
happens:

 1) The queue is disabled, i.e. no new requests can be queued

 2) Wait for the outstanding requests to complete

 3) Shut down the interrupt

 This avoids having multiple queues moved to the still online CPUs and also
 prevents vector space exhaustion because the shut down interrupt does not
 have to be migrated.

When the CPU (or the first in the group) comes online again:

 1) Reenable the interrupt

 2) Reenable the queue

Hope that helps.

Thanks,

	tglx
