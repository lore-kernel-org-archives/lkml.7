Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A1C20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfCYIxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:53:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45018 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCYIxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:53:31 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8LMG-0005e8-SB; Mon, 25 Mar 2019 09:53:29 +0100
Date:   Mon, 25 Mar 2019 09:53:28 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, minlei@redhat.com
Subject: Re: Virtio-scsi multiqueue irq affinity
In-Reply-To: <20190325070616.GA9642@ming.t460p>
Message-ID: <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
References: <20190318062150.GC6654@xz-x1> <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de> <20190325050213.GH9149@xz-x1> <20190325070616.GA9642@ming.t460p>
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

Ming,

On Mon, 25 Mar 2019, Ming Lei wrote:
> On Mon, Mar 25, 2019 at 01:02:13PM +0800, Peter Xu wrote:
> > One thing I can think of is the real-time scenario where "isolcpus="
> > is provided, then logically we should not allow any isolated CPUs to
> > be bound to any of the multi-queue IRQs.  Though Ming Lei and I had a
> 
> So far, this behaviour is made by user-space.
> 
> >From my understanding, IRQ subsystem doesn't handle "isolcpus=", even
> though the Kconfig help doesn't mention irq affinity affect:
> 
>           Make sure that CPUs running critical tasks are not disturbed by
>           any source of "noise" such as unbound workqueues, timers, kthreads...
>           Unbound jobs get offloaded to housekeeping CPUs. This is driven by
>           the "isolcpus=" boot parameter.

isolcpus has no effect on the interupts. That's what 'irqaffinity=' is for.

> Yeah, some RT application may exclude 'isolcpus=' from some IRQ's
> affinity via /proc/irq interface, and now it becomes not possible any
> more to do that for managed IRQ.
> 
> > discussion offlist before and Ming explained to me that as long as the
> > isolated CPUs do not generate any IO then there will be no IRQ on
> > those isolated (real-time) CPUs at all.  Can we guarantee that?  Now
> 
> It is only guaranteed for 1:1 mapping.
> 
> blk-mq uses managed IRQ's affinity to setup queue mapping, for example:
> 
> 1) single hardware queue
> - this queue's IRQ affinity includes all CPUs, then the hardware queue's
> IRQ is only fired on one specific CPU for IO submitted from any CPU

Right. We can special case that for single HW queue to honor the default
affinity setting. That's not hard to achieve.
 
> 2) multi hardware queue
> - there are N hardware queues
> - for each hardware queue i(i < N), its IRQ's affinity may include N(i) CPUs,
> then IRQ for this hardware queue i is fired on one specific CPU among N(i).

Correct and that's the sane case where it does not matter much, because if
your task on an isolated CPU does I/O then redirecting it through some
other CPU does not make sense. If it doesn't do I/O it wont be affected by
the dormant queue.

Thanks,

	tglx
