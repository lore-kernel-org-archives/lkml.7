Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFAA2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfCYJn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbfCYJn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 004603092656;
        Mon, 25 Mar 2019 09:43:57 +0000 (UTC)
Received: from xz-x1 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A480160C05;
        Mon, 25 Mar 2019 09:43:44 +0000 (UTC)
Date:   Mon, 25 Mar 2019 17:43:40 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, minlei@redhat.com
Subject: Re: Virtio-scsi multiqueue irq affinity
Message-ID: <20190325094340.GJ9149@xz-x1>
References: <20190318062150.GC6654@xz-x1>
 <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de>
 <20190325050213.GH9149@xz-x1>
 <20190325070616.GA9642@ming.t460p>
 <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 25 Mar 2019 09:43:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:53:28AM +0100, Thomas Gleixner wrote:
> Ming,
> 
> On Mon, 25 Mar 2019, Ming Lei wrote:
> > On Mon, Mar 25, 2019 at 01:02:13PM +0800, Peter Xu wrote:
> > > One thing I can think of is the real-time scenario where "isolcpus="
> > > is provided, then logically we should not allow any isolated CPUs to
> > > be bound to any of the multi-queue IRQs.  Though Ming Lei and I had a
> > 
> > So far, this behaviour is made by user-space.
> > 
> > >From my understanding, IRQ subsystem doesn't handle "isolcpus=", even
> > though the Kconfig help doesn't mention irq affinity affect:
> > 
> >           Make sure that CPUs running critical tasks are not disturbed by
> >           any source of "noise" such as unbound workqueues, timers, kthreads...
> >           Unbound jobs get offloaded to housekeeping CPUs. This is driven by
> >           the "isolcpus=" boot parameter.
> 
> isolcpus has no effect on the interupts. That's what 'irqaffinity=' is for.
> 
> > Yeah, some RT application may exclude 'isolcpus=' from some IRQ's
> > affinity via /proc/irq interface, and now it becomes not possible any
> > more to do that for managed IRQ.
> > 
> > > discussion offlist before and Ming explained to me that as long as the
> > > isolated CPUs do not generate any IO then there will be no IRQ on
> > > those isolated (real-time) CPUs at all.  Can we guarantee that?  Now
> > 
> > It is only guaranteed for 1:1 mapping.
> > 
> > blk-mq uses managed IRQ's affinity to setup queue mapping, for example:
> > 
> > 1) single hardware queue
> > - this queue's IRQ affinity includes all CPUs, then the hardware queue's
> > IRQ is only fired on one specific CPU for IO submitted from any CPU
> 
> Right. We can special case that for single HW queue to honor the default
> affinity setting. That's not hard to achieve.
>  
> > 2) multi hardware queue
> > - there are N hardware queues
> > - for each hardware queue i(i < N), its IRQ's affinity may include N(i) CPUs,
> > then IRQ for this hardware queue i is fired on one specific CPU among N(i).
> 
> Correct and that's the sane case where it does not matter much, because if
> your task on an isolated CPU does I/O then redirecting it through some
> other CPU does not make sense. If it doesn't do I/O it wont be affected by
> the dormant queue.

(My thanks to both.)

Now I understand it can be guaranteed so it should not break
determinism of the real-time applications.  But again, I'm curious
whether we can specify how to spread the hardware queues of a block
controller (as I asked in my previous post) instead of the default one
(which is to spread the queues upon all the cores)?  I'll try to give
a detailed example on this one this time: Let's assume we've had a
host with 2 nodes and 8 cores (Node 0 with CPUs 0-3, Node 1 with CPUs
4-7), and a SCSI controller with 4 queues.  We want to take the 2nd
node to run the real-time applications so we do isolcpus=4-7.  By
default, IIUC the hardware queues will be allocated like this:

  - queue 1: CPU 0,1
  - queue 2: CPU 2,3
  - queue 3: CPU 4,5
  - queue 4: CPU 6,7

And the IRQs of the queues will be bound to the same cpuset that the
queue is bound to.

So my previous question is: since we know that CPU 4-7 won't generate
any IO after all (and they shouldn't), could it be possible that we
configure the system somehow to reflect a mapping like below:

  - queue 1: CPU 0
  - qeueu 2: CPU 1
  - queue 3: CPU 2
  - queue 4: CPU 3

Then we disallow the CPUs 4-7 to generate IO and return failure if
they tries to.

Again, I'm pretty uncertain on whether this case can be anything close
to useful...  It just came out of my pure curiosity.  I think it at
least has some benefits like: we will guarantee that the realtime CPUs
won't send block IO requests (which could be good because it could
simply break real-time determinism), and we'll save two queues from
being totally idle (so if we run non-real-time block applications on
cores 0-3 we still gain 4 hardware queues's throughput rather than 2).

Thanks,

-- 
Peter Xu
