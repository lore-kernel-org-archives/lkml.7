Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71938C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4731F218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfDXAWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:22:53 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39771 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbfDXAWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:22:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TQ5BmiI_1556065358;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TQ5BmiI_1556065358)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Apr 2019 08:22:48 +0800
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     vbabka@suse.cz, rientjes@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190423175252.GP25106@dhcp22.suse.cz>
 <6004f688-99d8-3f8c-a106-66ee52c1f0ee@linux.alibaba.com>
Message-ID: <dace50e0-b72c-33db-5624-bf7449552ff8@linux.alibaba.com>
Date:   Tue, 23 Apr 2019 17:22:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6004f688-99d8-3f8c-a106-66ee52c1f0ee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/19 11:34 AM, Yang Shi wrote:
>
>
> On 4/23/19 10:52 AM, Michal Hocko wrote:
>> On Wed 24-04-19 00:43:01, Yang Shi wrote:
>>> The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for 
>>> each
>>> vma") introduced THPeligible bit for processes' smaps. But, when 
>>> checking
>>> the eligibility for shmem vma, __transparent_hugepage_enabled() is
>>> called to override the result from shmem_huge_enabled().  It may result
>>> in the anonymous vma's THP flag override shmem's.  For example, 
>>> running a
>>> simple test which create THP for shmem, but with anonymous THP 
>>> disabled,
>>> when reading the process's smaps, it may show:
>>>
>>> 7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
>>> Size:               4096 kB
>>> ...
>>> [snip]
>>> ...
>>> ShmemPmdMapped:     4096 kB
>>> ...
>>> [snip]
>>> ...
>>> THPeligible:    0
>>>
>>> And, /proc/meminfo does show THP allocated and PMD mapped too:
>>>
>>> ShmemHugePages:     4096 kB
>>> ShmemPmdMapped:     4096 kB
>>>
>>> This doesn't make too much sense.  The anonymous THP flag should not
>>> intervene shmem THP.  Calling shmem_huge_enabled() with checking
>>> MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
>>> dax vma check since we already checked if the vma is shmem already.
>> Kirill, can we get a confirmation that this is really intended behavior
>> rather than an omission please? Is this documented? What is a global
>> knob to simply disable THP system wise?
>>
>> I have to say that the THP tuning API is one giant mess :/
>>
>> Btw. this patch also seem to fix khugepaged behavior because it 
>> previously
>> ignored both VM_NOHUGEPAGE and MMF_DISABLE_THP.

Second look shows this is not ignored. hugepage_vma_check() would check 
this for both anonymous vma and shmem vma before scanning. It is called 
before shmem_huge_enabled().

>
> Aha, I didn't notice this. It looks we need separate the patch to fix 
> that khugepaged problem for both 5.1-rc and LTS.
>
>>
>>> Fixes: 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each 
>>> vma")
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: David Rientjes <rientjes@google.com>
>>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>> ---
>>> v2: Check VM_NOHUGEPAGE per Michal Hocko
>>>
>>>   mm/huge_memory.c | 4 ++--
>>>   mm/shmem.c       | 3 +++
>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 165ea46..5881e82 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -67,8 +67,8 @@ bool transparent_hugepage_enabled(struct 
>>> vm_area_struct *vma)
>>>   {
>>>       if (vma_is_anonymous(vma))
>>>           return __transparent_hugepage_enabled(vma);
>>> -    if (vma_is_shmem(vma) && shmem_huge_enabled(vma))
>>> -        return __transparent_hugepage_enabled(vma);
>>> +    if (vma_is_shmem(vma))
>>> +        return shmem_huge_enabled(vma);
>>>         return false;
>>>   }
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 2275a0f..6f09a31 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -3873,6 +3873,9 @@ bool shmem_huge_enabled(struct vm_area_struct 
>>> *vma)
>>>       loff_t i_size;
>>>       pgoff_t off;
>>>   +    if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>> +        test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>>> +        return false;
>>>       if (shmem_huge == SHMEM_HUGE_FORCE)
>>>           return true;
>>>       if (shmem_huge == SHMEM_HUGE_DENY)
>>> -- 
>>> 1.8.3.1
>>>
>

