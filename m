Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E43C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D072177B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfFSQ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:29:25 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40810 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfFSQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:29:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TUccovW_1560961724;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TUccovW_1560961724)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Jun 2019 00:28:47 +0800
Subject: Re: [v3 PATCH 2/2] mm: thp: fix false negative of shmem vma's THP
 eligibility
To:     Vlastimil Babka <vbabka@suse.cz>, hughd@google.com,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        rientjes@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560401041-32207-3-git-send-email-yang.shi@linux.alibaba.com>
 <4a07a6b8-8ff2-419c-eac8-3e7dc17670df@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <5dde4380-68b4-66ee-2c3c-9b9da0c243ca@linux.alibaba.com>
Date:   Wed, 19 Jun 2019 09:28:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4a07a6b8-8ff2-419c-eac8-3e7dc17670df@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/19 5:12 AM, Vlastimil Babka wrote:
> On 6/13/19 6:44 AM, Yang Shi wrote:
>> The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each
>> vma") introduced THPeligible bit for processes' smaps. But, when checking
>> the eligibility for shmem vma, __transparent_hugepage_enabled() is
>> called to override the result from shmem_huge_enabled().  It may result
>> in the anonymous vma's THP flag override shmem's.  For example, running a
>> simple test which create THP for shmem, but with anonymous THP disabled,
>> when reading the process's smaps, it may show:
> ...
>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 01d4eb0..6a13882 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -796,7 +796,8 @@ static int show_smap(struct seq_file *m, void *v)
>>   
>>   	__show_smap(m, &mss);
>>   
>> -	seq_printf(m, "THPeligible:    %d\n", transparent_hugepage_enabled(vma));
>> +	seq_printf(m, "THPeligible:		%d\n",
>> +		   transparent_hugepage_enabled(vma));
>>   
>>   	if (arch_pkeys_enabled())
>>   		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 4bc2552..36f0225 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -65,10 +65,15 @@
>>   
>>   bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>>   {
>> +	/* The addr is used to check if the vma size fits */
>> +	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
>> +
>> +	if (!transhuge_vma_suitable(vma, addr))
>> +		return false;
> Sorry for replying rather late, and not in the v2 thread, but unlike
> Hugh I'm not convinced that we should include vma size/alignment in the
> test for reporting THPeligible, which was supposed to reflect
> administrative settings and madvise hints. I guess it's mostly a matter
> of personal feeling. But one objective distinction is that the admin
> settings and madvise do have an exact binary result for the whole VMA,
> while this check is more fuzzy - only part of the VMA's span might be
> properly sized+aligned, and THPeligible will be 1 for the whole VMA.

I think THPeligible is used to tell us if the vma is suitable for 
allocating THP. Both anonymous and shmem THP checks vma size/alignment 
to decide to or not to allocate THP.

And, if vma size/alignment is not checked, THPeligible may show "true" 
for even 4K mapping. This doesn't make too much sense either.

>
>>   	if (vma_is_anonymous(vma))
>>   		return __transparent_hugepage_enabled(vma);
>> -	if (vma_is_shmem(vma) && shmem_huge_enabled(vma))
>> -		return __transparent_hugepage_enabled(vma);
>> +	if (vma_is_shmem(vma))
>> +		return shmem_huge_enabled(vma);
>>   
>>   	return false;
>>   }
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 1bb3b8d..a807712 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3872,6 +3872,9 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
>>   	loff_t i_size;
>>   	pgoff_t off;
>>   
>> +	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>> +		return false;
>>   	if (shmem_huge == SHMEM_HUGE_FORCE)
>>   		return true;
>>   	if (shmem_huge == SHMEM_HUGE_DENY)
>>

