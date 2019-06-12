Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC264215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfFLT7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:59:34 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36121 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387605AbfFLT7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:59:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TU03sVe_1560369565;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU03sVe_1560369565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jun 2019 03:59:28 +0800
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
To:     Hugh Dickins <hughd@google.com>
Cc:     mhocko@suse.com, vbabka@suse.cz, rientjes@google.com,
        kirill@shutemov.name, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1906072008210.3614@eggly.anvils>
 <578b7903-40ef-e616-d700-473713f438c0@linux.alibaba.com>
 <alpine.LSU.2.11.1906121120240.1107@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <185ccaa5-c380-f84a-ddbb-b89c8f49445a@linux.alibaba.com>
Date:   Wed, 12 Jun 2019 12:59:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1906121120240.1107@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/19 11:44 AM, Hugh Dickins wrote:
> On Mon, 10 Jun 2019, Yang Shi wrote:
>> On 6/7/19 8:58 PM, Hugh Dickins wrote:
>>> Yes, that is correct; and correctly placed. But a little more is needed:
>>> see how mm/memory.c's transhuge_vma_suitable() will only allow a pmd to
>>> be used instead of a pte if the vma offset and size permit. smaps should
>>> not report a shmem vma as THPeligible if its offset or size prevent it.
>>>
>>> And I see that should also be fixed on anon vmas: at present smaps
>>> reports even a 4kB anon vma as THPeligible, which is not right.
>>> Maybe a test like transhuge_vma_suitable() can be added into
>>> transparent_hugepage_enabled(), to handle anon and shmem together.
>>> I say "like transhuge_vma_suitable()", because that function needs
>>> an address, which here you don't have.
>> Thanks for the remind. Since we don't have an address I'm supposed we just
>> need check if the vma's size is big enough or not other than other alignment
>> check.
>>
>> And, I'm wondering whether we could reuse transhuge_vma_suitable() by passing
>> in an impossible address, i.e. -1 since it is not a valid userspace address.
>> It can be used as and indicator that this call is from THPeligible context.
> Perhaps, but sounds like it will abuse and uglify transhuge_vma_suitable()
> just for smaps. Would passing transhuge_vma_suitable() the address
>      ((vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE)
> give the the correct answer in all cases?

Yes, it looks better.

>
>>> The anon offset situation is interesting: usually anon vm_pgoff is
>>> initialized to fit with its vm_start, so the anon offset check passes;
>>> but I wonder what happens after mremap to a different address - does
>>> transhuge_vma_suitable() then prevent the use of pmds where they could
>>> actually be used? Not a Number#1 priority to investigate or fix here!
>>> but a curiosity someone might want to look into.
>> Will mark on my TODO list.
>>
>>> Even with your changes
>>> ShmemPmdMapped:     4096 kB
>>> THPeligible:    0
>>> will easily be seen: THPeligible reflects whether a huge page can be
>>> allocated and mapped by pmd in that vma; but if something else already
>>> allocated the huge page earlier, it will be mapped by pmd in this vma
>>> if offset and size allow, whatever THPeligible says. We could change
>>> transhuge_vma_suitable() to force ptes in that case, but it would be
>>> a silly change, just to make what smaps shows easier to explain.
>> Where did this come from? From the commit log? If so it is the example for
>> the wrong smap output. If that case really happens, I think we could document
>> it since THPeligible should just show the current status.
> Please read again what I explained there: it's not necessarily an example
> of wrong smaps output, it's reasonable smaps output for a reasonable case.
>
> Yes, maybe Documentation/filesystems/proc.txt should explain "THPeligble"
> a little better - "eligible for allocating THP pages" rather than just
> "eligible for THP pages" would be good enough? we don't want to write
> a book about the various cases.

Yes, I agree.

>
> Oh, and the "THPeligible" output lines up very nicely there in proc.txt:
> could the actual alignment of that 0 or 1 be fixed in smaps itself too?

Sure.

Thanks,
Yang

>
> Thanks,
> Hugh

