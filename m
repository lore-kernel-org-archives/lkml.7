Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0AAFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C472067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393566AbfJPNWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:22:41 -0400
Received: from foss.arm.com ([217.140.110.172]:39824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbfJPNWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:22:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69FD8142F;
        Wed, 16 Oct 2019 06:22:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8962B3F68E;
        Wed, 16 Oct 2019 06:22:38 -0700 (PDT)
Date:   Wed, 16 Oct 2019 14:22:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        luto@kernel.org, linux-kernel@vger.kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20191016132233.GA46264@lakrids.cambridge.arm.com>
References: <20191001065834.8880-1-dja@axtens.net>
 <20191001065834.8880-2-dja@axtens.net>
 <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com>
 <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
 <8f573b40-3a5a-ed36-dffb-4a54faf3c4e1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f573b40-3a5a-ed36-dffb-4a54faf3c4e1@virtuozzo.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, Oct 16, 2019 at 03:19:50PM +0300, Andrey Ryabinin wrote:
> On 10/14/19 4:57 PM, Daniel Axtens wrote:
> >>> +	/*
> >>> +	 * Ensure poisoning is visible before the shadow is made visible
> >>> +	 * to other CPUs.
> >>> +	 */
> >>> +	smp_wmb();
> >>
> >> I'm not quite understand what this barrier do and why it needed.
> >> And if it's really needed there should be a pairing barrier
> >> on the other side which I don't see.
> > 
> > Mark might be better able to answer this, but my understanding is that
> > we want to make sure that we never have a situation where the writes are
> > reordered so that PTE is installed before all the poisioning is written
> > out. I think it follows the logic in __pte_alloc() in mm/memory.c:
> > 
> > 	/*
> > 	 * Ensure all pte setup (eg. pte page lock and page clearing) are
> > 	 * visible before the pte is made visible to other CPUs by being
> > 	 * put into page tables.
> > 	 *
> > 	 * The other side of the story is the pointer chasing in the page
> > 	 * table walking code (when walking the page table without locking;
> > 	 * ie. most of the time). Fortunately, these data accesses consist
> > 	 * of a chain of data-dependent loads, meaning most CPUs (alpha
> > 	 * being the notable exception) will already guarantee loads are
> > 	 * seen in-order. See the alpha page table accessors for the
> > 	 * smp_read_barrier_depends() barriers in page table walking code.
> > 	 */
> > 	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
> > 
> > I can clarify the comment.
> 
> I don't see how is this relevant here.

The problem isn't quite the same, but it's a similar shape. See below
for more details.

> barrier in __pte_alloc() for very the following case:
> 
> CPU 0							CPU 1
> __pte_alloc():                                          pte_offset_kernel(pmd_t * dir, unsigned long address):
>      pgtable_t new = pte_alloc_one(mm);                        pte_t *new = (pte_t *) pmd_page_vaddr(*dir) + ((address >> PAGE_SHIFT) & (PTRS_PER_PAGE - 1));  
>      smp_wmb();                                                smp_read_barrier_depends();
>      pmd_populate(mm, pmd, new);
> 							/* do something with pte, e.g. check if (pte_none(*new)) */
> 
> 
> It's needed to ensure that if CPU1 sees pmd_populate() it also sees initialized contents of the 'new'.
> 
> In our case the barrier would have been needed if we had the other side like this:
> 
> if (!pte_none(*vmalloc_shadow_pte)) {
> 	shadow_addr = (unsigned long)__va(pte_pfn(*vmalloc_shadow_pte) << PAGE_SHIFT);
> 	smp_read_barrier_depends();
> 	*shadow_addr; /* read the shadow, barrier ensures that if we see installed pte, we will see initialized shadow memory. */
> }
> 
> 
> Without such other side the barrier is pointless.

The barrier isn't pointless, but we are relying on a subtlety that is
not captured in LKMM, as one of the observers involved is the TLB (and
associated page table walkers) of the CPU.

Until the PTE written by CPU 0 has been observed by the TLB of CPU 1, it
is not possible for CPU 1 to satisfy loads from the memory that PTE
maps, as it doesn't yet know which memory that is.

Once the PTE written by CPU has been observed by the TLB of CPU 1, it is
possible for CPU 1 to satisfy those loads. At this instant, CPU 1 must
respect the smp_wmb() before the PTE was written, and hence sees zeroes
written before this. Note that if this were not true, we could not
safely swap userspace memory.

There is the risk (as laid out in [1]) that CPU 1 attempts to hoist the
loads of the shadow memory above the load of the PTE, samples a stale
(faulting) status from the TLB, then performs the load of the PTE and
sees a valid value. In this case (on arm64) a spurious fault could be
taken when the access is architecturally performed.

It is possible on arm64 to use a barrier here to prevent the spurious
fault, but this is not smp_read_barrier_depends(), as that does nothing
for everyone but alpha. On arm64 We have a spurious fault handler to fix
this up.

Thanks,
Mark.

[1] https://lore.kernel.org/linux-arm-kernel/20190827131818.14724-1-will@kernel.org/
[2] https://lore.kernel.org/linux-mm/20191014152717.GA20438@lakrids.cambridge.arm.com/
