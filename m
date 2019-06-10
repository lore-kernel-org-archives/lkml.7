Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37651C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E25520859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfFJRdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:33:19 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55555 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387492AbfFJRdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:33:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TTrbe0._1560187990;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TTrbe0._1560187990)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Jun 2019 01:33:13 +0800
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
To:     Hugh Dickins <hughd@google.com>
Cc:     mhocko@suse.com, vbabka@suse.cz, rientjes@google.com,
        kirill@shutemov.name, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1906072008210.3614@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <578b7903-40ef-e616-d700-473713f438c0@linux.alibaba.com>
Date:   Mon, 10 Jun 2019 10:33:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1906072008210.3614@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/19 8:58 PM, Hugh Dickins wrote:
> On Wed, 24 Apr 2019, Yang Shi wrote:
>
>> The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each
>> vma") introduced THPeligible bit for processes' smaps. But, when checking
>> the eligibility for shmem vma, __transparent_hugepage_enabled() is
>> called to override the result from shmem_huge_enabled().  It may result
>> in the anonymous vma's THP flag override shmem's.  For example, running a
>> simple test which create THP for shmem, but with anonymous THP disabled,
>> when reading the process's smaps, it may show:
>>
>> 7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
>> Size:               4096 kB
>> ...
>> [snip]
>> ...
>> ShmemPmdMapped:     4096 kB
>> ...
>> [snip]
>> ...
>> THPeligible:    0
>>
>> And, /proc/meminfo does show THP allocated and PMD mapped too:
>>
>> ShmemHugePages:     4096 kB
>> ShmemPmdMapped:     4096 kB
>>
>> This doesn't make too much sense.  The anonymous THP flag should not
>> intervene shmem THP.  Calling shmem_huge_enabled() with checking
>> MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
>> dax vma check since we already checked if the vma is shmem already.
>>
>> Fixes: 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each vma")
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v2: Check VM_NOHUGEPAGE per Michal Hocko
>>
>>   mm/huge_memory.c | 4 ++--
>>   mm/shmem.c       | 3 +++
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 165ea46..5881e82 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -67,8 +67,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>>   {
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
>> index 2275a0f..6f09a31 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3873,6 +3873,9 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
>>   	loff_t i_size;
>>   	pgoff_t off;
>>   
>> +	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>> +		return false;
> Yes, that is correct; and correctly placed. But a little more is needed:
> see how mm/memory.c's transhuge_vma_suitable() will only allow a pmd to
> be used instead of a pte if the vma offset and size permit. smaps should
> not report a shmem vma as THPeligible if its offset or size prevent it.
>
> And I see that should also be fixed on anon vmas: at present smaps
> reports even a 4kB anon vma as THPeligible, which is not right.
> Maybe a test like transhuge_vma_suitable() can be added into
> transparent_hugepage_enabled(), to handle anon and shmem together.
> I say "like transhuge_vma_suitable()", because that function needs
> an address, which here you don't have.

Thanks for the remind. Since we don't have an address I'm supposed we 
just need check if the vma's size is big enough or not other than other 
alignment check.

And, I'm wondering whether we could reuse transhuge_vma_suitable() by 
passing in an impossible address, i.e. -1 since it is not a valid 
userspace address. It can be used as and indicator that this call is 
from THPeligible context.

>
> The anon offset situation is interesting: usually anon vm_pgoff is
> initialized to fit with its vm_start, so the anon offset check passes;
> but I wonder what happens after mremap to a different address - does
> transhuge_vma_suitable() then prevent the use of pmds where they could
> actually be used? Not a Number#1 priority to investigate or fix here!
> but a curiosity someone might want to look into.

Will mark on my TODO list.

>
>>   	if (shmem_huge == SHMEM_HUGE_FORCE)
>>   		return true;
>>   	if (shmem_huge == SHMEM_HUGE_DENY)
>> -- 
>> 1.8.3.1
>
> Even with your changes
> ShmemPmdMapped:     4096 kB
> THPeligible:    0
> will easily be seen: THPeligible reflects whether a huge page can be
> allocated and mapped by pmd in that vma; but if something else already
> allocated the huge page earlier, it will be mapped by pmd in this vma
> if offset and size allow, whatever THPeligible says. We could change
> transhuge_vma_suitable() to force ptes in that case, but it would be
> a silly change, just to make what smaps shows easier to explain.

Where did this come from? From the commit log? If so it is the example 
for the wrong smap output. If that case really happens, I think we could 
document it since THPeligible should just show the current status.

>
> Hugh

