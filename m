Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0202C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E492084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbfHORfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:35:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfHORfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:35:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98DBE83F3C;
        Thu, 15 Aug 2019 17:35:15 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B9FE3796;
        Thu, 15 Aug 2019 17:35:13 +0000 (UTC)
Date:   Thu, 15 Aug 2019 13:35:11 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815173511.GG30916@redhat.com>
References: <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
 <20190815084429.GE9477@dhcp22.suse.cz>
 <20190815130415.GD21596@ziepe.ca>
 <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
 <20190815143759.GG21596@ziepe.ca>
 <CAKMK7uEJQ6mPQaOWbT_6M+55T-dCVbsOxFnMC6KzLAMQNa-RGg@mail.gmail.com>
 <20190815151028.GJ21596@ziepe.ca>
 <20190815163238.GA30781@redhat.com>
 <20190815171622.GL21596@ziepe.ca>
 <CAKMK7uGm_vg_6sqU2X=Owu79zLcC8d5U+Yr2O-oEsCnTjeWzCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uGm_vg_6sqU2X=Owu79zLcC8d5U+Yr2O-oEsCnTjeWzCw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 15 Aug 2019 17:35:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 07:21:47PM +0200, Daniel Vetter wrote:
> On Thu, Aug 15, 2019 at 7:16 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Aug 15, 2019 at 12:32:38PM -0400, Jerome Glisse wrote:
> > > On Thu, Aug 15, 2019 at 12:10:28PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Aug 15, 2019 at 04:43:38PM +0200, Daniel Vetter wrote:
> > > >
> > > > > You have to wait for the gpu to finnish current processing in
> > > > > invalidate_range_start. Otherwise there's no point to any of this
> > > > > really. So the wait_event/dma_fence_wait are unavoidable really.
> > > >
> > > > I don't envy your task :|
> > > >
> > > > But, what you describe sure sounds like a 'registration cache' model,
> > > > not the 'shadow pte' model of coherency.
> > > >
> > > > The key difference is that a regirstationcache is allowed to become
> > > > incoherent with the VMA's because it holds page pins. It is a
> > > > programming bug in userspace to change VA mappings via mmap/munmap/etc
> > > > while the device is working on that VA, but it does not harm system
> > > > integrity because of the page pin.
> > > >
> > > > The cache ensures that each initiated operation sees a DMA setup that
> > > > matches the current VA map when the operation is initiated and allows
> > > > expensive device DMA setups to be re-used.
> > > >
> > > > A 'shadow pte' model (ie hmm) *really* needs device support to
> > > > directly block DMA access - ie trigger 'device page fault'. ie the
> > > > invalidate_start should inform the device to enter a fault mode and
> > > > that is it.  If the device can't do that, then the driver probably
> > > > shouldn't persue this level of coherency. The driver would quickly get
> > > > into the messy locking problems like dma_fence_wait from a notifier.
> > >
> > > I think here we do not agree on the hardware requirement. For GPU
> > > we will always need to be able to wait for some GPU fence from inside
> > > the notifier callback, there is just no way around that for many of
> > > the GPUs today (i do not see any indication of that changing).
> >
> > I didn't say you couldn't wait, I was trying to say that the wait
> > should only be contigent on the HW itself. Ie you can wait on a GPU
> > page table lock, and you can wait on a GPU page table flush completion
> > via IRQ.
> >
> > What is troubling is to wait till some other thread gets a GPU command
> > completion and decr's a kref on the DMA buffer - which kinda looks
> > like what this dma_fence() stuff is all about. A driver like that
> > would have to be super careful to ensure consistent forward progress
> > toward dma ref == 0 when the system is under reclaim.
> >
> > ie by running it's entire IRQ flow under fs_reclaim locking.
> 
> This is correct. At least for i915 it's already a required due to our
> shrinker also having to do the same. I think amdgpu isn't bothering
> with that since they have vram for most of the stuff, and just limit
> system memory usage to half of all and forgo the shrinker. Probably
> not the nicest approach. Anyway, both do the same mmu_notifier dance,
> just want to explain that we've been living with this for longer
> already.
> 
> So yeah writing a gpu driver is not easy.
> 
> > > associated with the mm_struct. In all GPU driver so far it is a short
> > > lived lock and nothing blocking is done while holding it (it is just
> > > about updating page table directory really wether it is filling it or
> > > clearing it).
> >
> > The main blocking I expect in a shadow PTE flow is waiting for the HW
> > to complete invalidations of its PTE cache.
> >
> > > > It is important to identify what model you are going for as defining a
> > > > 'registration cache' coherence expectation allows the driver to skip
> > > > blocking in invalidate_range_start. All it does is invalidate the
> > > > cache so that future operations pick up the new VA mapping.
> > > >
> > > > Intel's HFI RDMA driver uses this model extensively, and I think it is
> > > > well proven, within some limitations of course.
> > > >
> > > > At least, 'registration cache' is the only use model I know of where
> > > > it is acceptable to skip invalidate_range_end.
> > >
> > > Here GPU are not in the registration cache model, i know it might looks
> > > like it because of GUP but GUP was use just because hmm did not exist
> > > at the time.
> >
> > It is not because of GUP, it is because of the lack of
> > invalidate_range_end. A driver cannot correctly implement the SPTE
> > model without invalidate_range_end, even if it holds the page pins via
> > GUP.
> >
> > So, I've been assuming the few drivers without invalidate_range_end
> > are trying to do registration caching, rather than assuming they are
> > broken.
> 
> I915 might just be broken. amdgpu does the full thing, using
> hmm_mirror. But still with dma_fence_wait.

Yeah i915 is broken but it never hurted anyone ;) I posted patch
a long time ago to convert it to hmm but i delayed that to until
i can get through making something of GUPfast that can also be
use for HMM/ODP user.

Cheers,
Jérôme
