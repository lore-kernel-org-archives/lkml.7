Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA39DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9003820830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="YdBtSbjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfJCLcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:32:52 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:55548 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfJCLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:32:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 382E43F4D9;
        Thu,  3 Oct 2019 13:32:49 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="YdBtSbjF";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3wFipsKRcHup; Thu,  3 Oct 2019 13:32:48 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 075B53F456;
        Thu,  3 Oct 2019 13:32:45 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 712EB360058;
        Thu,  3 Oct 2019 13:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570102365; bh=+Kcj+oZhCXXqWRzSU0liAB7tNi7jmHUWd2i35d6EPv4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YdBtSbjFkpUtQOrE94CWW4Kuaan52+Ac9KjroROllwg0VGDWj9jZUgFRnT8eBA6ww
         eEz28K4Vdtr+xFEnch980qtFMm9fcWYWaRB94A0rTm56AQ7yYhZ8Oodi2RrspYzJSt
         ssNuZCoWyVnVs9Qt/7X/GC4/Hfk9v32bNCIz9G4U=
Subject: Re: [PATCH v3 2/7] mm: Add a walk_page_mapping() function to the
 pagewalk code
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-3-thomas_os@shipmail.org>
 <20191003111708.sttkkrhiidleivc6@box>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <d336497b-3716-0748-d838-378902399439@shipmail.org>
Date:   Thu, 3 Oct 2019 13:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191003111708.sttkkrhiidleivc6@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/19 1:17 PM, Kirill A. Shutemov wrote:
> On Wed, Oct 02, 2019 at 03:47:25PM +0200, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> For users that want to travers all page table entries pointing into a
>> region of a struct address_space mapping, introduce a walk_page_mapping()
>> function.
>>
>> The walk_page_mapping() function will be initially be used for dirty-
>> tracking in virtual graphics drivers.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Jérôme Glisse <jglisse@redhat.com>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> ---
>>   include/linux/pagewalk.h |  9 ++++
>>   mm/pagewalk.c            | 99 +++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 107 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
>> index bddd9759bab9..6ec82e92c87f 100644
>> --- a/include/linux/pagewalk.h
>> +++ b/include/linux/pagewalk.h
>> @@ -24,6 +24,9 @@ struct mm_walk;
>>    *			"do page table walk over the current vma", returning
>>    *			a negative value means "abort current page table walk
>>    *			right now" and returning 1 means "skip the current vma"
>> + * @pre_vma:            if set, called before starting walk on a non-null vma.
>> + * @post_vma:           if set, called after a walk on a non-null vma, provided
>> + *                      that @pre_vma and the vma walk succeeded.
>>    */
>>   struct mm_walk_ops {
>>   	int (*pud_entry)(pud_t *pud, unsigned long addr,
>> @@ -39,6 +42,9 @@ struct mm_walk_ops {
>>   			     struct mm_walk *walk);
>>   	int (*test_walk)(unsigned long addr, unsigned long next,
>>   			struct mm_walk *walk);
>> +	int (*pre_vma)(unsigned long start, unsigned long end,
>> +		       struct mm_walk *walk);
>> +	void (*post_vma)(struct mm_walk *walk);
>>   };
>>   
>>   /**
>> @@ -62,5 +68,8 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>>   		void *private);
>>   int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>>   		void *private);
>> +int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
>> +		      pgoff_t nr, const struct mm_walk_ops *ops,
>> +		      void *private);
>>   
>>   #endif /* _LINUX_PAGEWALK_H */
>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>> index d48c2a986ea3..658d1e5ec428 100644
>> --- a/mm/pagewalk.c
>> +++ b/mm/pagewalk.c
>> @@ -253,13 +253,23 @@ static int __walk_page_range(unsigned long start, unsigned long end,
>>   {
>>   	int err = 0;
>>   	struct vm_area_struct *vma = walk->vma;
>> +	const struct mm_walk_ops *ops = walk->ops;
>> +
>> +	if (vma && ops->pre_vma) {
>> +		err = ops->pre_vma(start, end, walk);
>> +		if (err)
>> +			return err;
>> +	}
>>   
>>   	if (vma && is_vm_hugetlb_page(vma)) {
>> -		if (walk->ops->hugetlb_entry)
>> +		if (ops->hugetlb_entry)
>>   			err = walk_hugetlb_range(start, end, walk);
>>   	} else
>>   		err = walk_pgd_range(start, end, walk);
>>   
>> +	if (vma && ops->post_vma)
>> +		ops->post_vma(walk);
>> +
>>   	return err;
>>   }
>>   
>> @@ -285,11 +295,17 @@ static int __walk_page_range(unsigned long start, unsigned long end,
>>    *  - <0 : failed to handle the current entry, and return to the caller
>>    *         with error code.
>>    *
>> + *
>>    * Before starting to walk page table, some callers want to check whether
>>    * they really want to walk over the current vma, typically by checking
>>    * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
>>    * purpose.
>>    *
>> + * If operations need to be staged before and committed after a vma is walked,
>> + * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
>> + * since it is intended to handle commit-type operations, can't return any
>> + * errors.
>> + *
>>    * struct mm_walk keeps current values of some common data like vma and pmd,
>>    * which are useful for the access from callbacks. If you want to pass some
>>    * caller-specific data to callbacks, @private should be helpful.
>> @@ -376,3 +392,84 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>>   		return err;
>>   	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
>>   }
>> +
>> +/**
>> + * walk_page_mapping - walk all memory areas mapped into a struct address_space.
>> + * @mapping: Pointer to the struct address_space
>> + * @first_index: First page offset in the address_space
>> + * @nr: Number of incremental page offsets to cover
>> + * @ops:	operation to call during the walk
>> + * @private:	private data for callbacks' usage
>> + *
>> + * This function walks all memory areas mapped into a struct address_space.
>> + * The walk is limited to only the given page-size index range, but if
>> + * the index boundaries cross a huge page-table entry, that entry will be
>> + * included.
>> + *
>> + * Also see walk_page_range() for additional information.
>> + *
>> + * Locking:
>> + *   This function can't require that the struct mm_struct::mmap_sem is held,
>> + *   since @mapping may be mapped by multiple processes. Instead
>> + *   @mapping->i_mmap_rwsem must be held. This might have implications in the
>> + *   callbacks, and it's up tho the caller to ensure that the
>> + *   struct mm_struct::mmap_sem is not needed.
>> + *
>> + *   Also this means that a caller can't rely on the struct
>> + *   vm_area_struct::vm_flags to be constant across a call,
>> + *   except for immutable flags. Callers requiring this shouldn't use
>> + *   this function.
>> + *
>> + *   If @mapping allows faulting of huge pmds and puds, it is desirable
>> + *   that its huge_fault() handler blocks while this function is running on
>> + *   @mapping. Otherwise a race may occur where the huge entry is split when
>> + *   it was intended to be handled in a huge entry callback. This requires an
>> + *   external lock, for example that @mapping->i_mmap_rwsem is held in
>> + *   write mode in the huge_fault() handlers.
> Em. No. We have ptl for this. It's the only lock required (plus mmap_sem
> on read) to split PMD entry into PTE table. And it can happen not only
> from fault path.
>
> If you care about splitting compound page under you, take a pin or lock a
> page. It will block split_huge_page().
>
> Suggestion to block fault path is not viable (and it will not happen
> magically just because of this comment).
>
I was specifically thinking of this:

https://elixir.bootlin.com/linux/latest/source/mm/pagewalk.c#L103

If a huge pud is concurrently faulted in here, it will immediatly get 
split without getting processed in pud_entry(). An external lock would 
protect against that, but that's perhaps a bug in the pagewalk code?  
For pmds the situation is not the same since when pte_entry is used, all 
pmds will unconditionally get split.

There's a similar more scary race in

https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L3931

It looks like if a concurrent thread faults in a huge pud just after the 
test for pud_none in that pmd_alloc, things might go pretty bad.

/Thomas


