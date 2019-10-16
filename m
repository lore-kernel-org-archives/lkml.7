Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F28FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402B1205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405184AbfJPMUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:20:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:56526 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392928AbfJPMUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:20:22 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iKiHd-0008JI-Fd; Wed, 16 Oct 2019 15:20:05 +0300
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real
 shadow memory
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
References: <20191001065834.8880-1-dja@axtens.net>
 <20191001065834.8880-2-dja@axtens.net>
 <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com>
 <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <8f573b40-3a5a-ed36-dffb-4a54faf3c4e1@virtuozzo.com>
Date:   Wed, 16 Oct 2019 15:19:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/14/19 4:57 PM, Daniel Axtens wrote:
> Hi Andrey,
> 
> 
>>> +	/*
>>> +	 * Ensure poisoning is visible before the shadow is made visible
>>> +	 * to other CPUs.
>>> +	 */
>>> +	smp_wmb();
>>
>> I'm not quite understand what this barrier do and why it needed.
>> And if it's really needed there should be a pairing barrier
>> on the other side which I don't see.
> 
> Mark might be better able to answer this, but my understanding is that
> we want to make sure that we never have a situation where the writes are
> reordered so that PTE is installed before all the poisioning is written
> out. I think it follows the logic in __pte_alloc() in mm/memory.c:
> 
> 	/*
> 	 * Ensure all pte setup (eg. pte page lock and page clearing) are
> 	 * visible before the pte is made visible to other CPUs by being
> 	 * put into page tables.
> 	 *
> 	 * The other side of the story is the pointer chasing in the page
> 	 * table walking code (when walking the page table without locking;
> 	 * ie. most of the time). Fortunately, these data accesses consist
> 	 * of a chain of data-dependent loads, meaning most CPUs (alpha
> 	 * being the notable exception) will already guarantee loads are
> 	 * seen in-order. See the alpha page table accessors for the
> 	 * smp_read_barrier_depends() barriers in page table walking code.
> 	 */
> 	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
> 
> I can clarify the comment.
> 

I don't see how is this relevant here.

barrier in __pte_alloc() for very the following case:

CPU 0							CPU 1
__pte_alloc():                                          pte_offset_kernel(pmd_t * dir, unsigned long address):
     pgtable_t new = pte_alloc_one(mm);                        pte_t *new = (pte_t *) pmd_page_vaddr(*dir) + ((address >> PAGE_SHIFT) & (PTRS_PER_PAGE - 1));  
     smp_wmb();                                                smp_read_barrier_depends();
     pmd_populate(mm, pmd, new);
							/* do something with pte, e.g. check if (pte_none(*new)) */


It's needed to ensure that if CPU1 sees pmd_populate() it also sees initialized contents of the 'new'.

In our case the barrier would have been needed if we had the other side like this:

if (!pte_none(*vmalloc_shadow_pte)) {
	shadow_addr = (unsigned long)__va(pte_pfn(*vmalloc_shadow_pte) << PAGE_SHIFT);
	smp_read_barrier_depends();
	*shadow_addr; /* read the shadow, barrier ensures that if we see installed pte, we will see initialized shadow memory. */
}


Without such other side the barrier is pointless.
