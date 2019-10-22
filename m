Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BBDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC282075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbfJVXis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:38:48 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48494 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732854AbfJVXis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:38:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TfwXB6r_1571787520;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TfwXB6r_1571787520)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Oct 2019 07:38:43 +0800
Subject: Re: [PATCH] mm: thp: handle page cache THP correctly in
 PageTransCompoundMap
To:     Hugh Dickins <hughd@google.com>
Cc:     aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        gavin.dg@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1571769577-89735-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1910221454060.2077@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <4ea5d015-19cb-d5d9-42f7-d1319d8de7c4@linux.alibaba.com>
Date:   Tue, 22 Oct 2019 16:38:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1910221454060.2077@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/19 3:27 PM, Hugh Dickins wrote:
> On Wed, 23 Oct 2019, Yang Shi wrote:
>
>> We have usecase to use tmpfs as QEMU memory backend and we would like to
>> take the advantage of THP as well.  But, our test shows the EPT is not
>> PMD mapped even though the underlying THP are PMD mapped on host.
>> The number showed by /sys/kernel/debug/kvm/largepage is much less than
>> the number of PMD mapped shmem pages as the below:
>>
>> 7f2778200000-7f2878200000 rw-s 00000000 00:14 262232 /dev/shm/qemu_back_mem.mem.Hz2hSf (deleted)
>> Size:            4194304 kB
>> [snip]
>> AnonHugePages:         0 kB
>> ShmemPmdMapped:   579584 kB
>> [snip]
>> Locked:                0 kB
>>
>> cat /sys/kernel/debug/kvm/largepages
>> 12
>>
>> And some benchmarks do worse than with anonymous THPs.
>>
>> By digging into the code we figured out that commit 127393fbe597 ("mm:
>> thp: kvm: fix memory corruption in KVM with THP enabled") checks if
>> there is a single PTE mapping on the page for anonymous THP when
>> setting up EPT map.  But, the _mapcount < 0 check doesn't fit to page
>> cache THP since every subpage of page cache THP would get _mapcount
>> inc'ed once it is PMD mapped, so PageTransCompoundMap() always returns
>> false for page cache THP.  This would prevent KVM from setting up PMD
>> mapped EPT entry.
>>
>> So we need handle page cache THP correctly.  However, when page cache
>> THP's PMD gets split, kernel just remove the map instead of setting up
>> PTE map like what anonymous THP does.  Before KVM calls get_user_pages()
>> the subpages may get PTE mapped even though it is still a THP since the
>> page cache THP may be mapped by other processes at the mean time.
>>
>> Checking its _mapcount and whether the THP is double mapped or not since
>> we can't tell if the single PTE mapping comes from the current process
>> or not by _mapcount.  Although this may report some false negative cases
>> (PTE mapped by other processes), it looks not trivial to make this
>> accurate.
>>
>> With this fix /sys/kernel/debug/kvm/largepage would show reasonable
>> pages are PMD mapped by EPT as the below:
>>
>> 7fbeaee00000-7fbfaee00000 rw-s 00000000 00:14 275464 /dev/shm/qemu_back_mem.mem.SKUvat (deleted)
>> Size:            4194304 kB
>> [snip]
>> AnonHugePages:         0 kB
>> ShmemPmdMapped:   557056 kB
>> [snip]
>> Locked:                0 kB
>>
>> cat /sys/kernel/debug/kvm/largepages
>> 271
>>
>> And the benchmarks are as same as anonymous THPs.
>>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
>> Tested-by: Gang Deng <gavin.dg@linux.alibaba.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: <stable@vger.kernel.org> 4.8+
>> ---
>>   include/linux/page-flags.h | 54 ++++++++++++++++++++++++++++------------------
>>   1 file changed, 33 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index f91cb88..3b8e5c5 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -610,27 +610,6 @@ static inline int PageTransCompound(struct page *page)
>>   }
>>   
>>   /*
>> - * PageTransCompoundMap is the same as PageTransCompound, but it also
>> - * guarantees the primary MMU has the entire compound page mapped
>> - * through pmd_trans_huge, which in turn guarantees the secondary MMUs
>> - * can also map the entire compound page. This allows the secondary
>> - * MMUs to call get_user_pages() only once for each compound page and
>> - * to immediately map the entire compound page with a single secondary
>> - * MMU fault. If there will be a pmd split later, the secondary MMUs
>> - * will get an update through the MMU notifier invalidation through
>> - * split_huge_pmd().
>> - *
>> - * Unlike PageTransCompound, this is safe to be called only while
>> - * split_huge_pmd() cannot run from under us, like if protected by the
>> - * MMU notifier, otherwise it may result in page->_mapcount < 0 false
>> - * positives.
>> - */
>> -static inline int PageTransCompoundMap(struct page *page)
>> -{
>> -	return PageTransCompound(page) && atomic_read(&page->_mapcount) < 0;
>> -}
>> -
>> -/*
>>    * PageTransTail returns true for both transparent huge pages
>>    * and hugetlbfs pages, so it should only be called when it's known
>>    * that hugetlbfs pages aren't involved.
>> @@ -681,6 +660,39 @@ static inline int TestClearPageDoubleMap(struct page *page)
>>   	return test_and_clear_bit(PG_double_map, &page[1].flags);
>>   }
>>   
>> +/*
>> + * PageTransCompoundMap is the same as PageTransCompound, but it also
>> + * guarantees the primary MMU has the entire compound page mapped
>> + * through pmd_trans_huge, which in turn guarantees the secondary MMUs
>> + * can also map the entire compound page. This allows the secondary
>> + * MMUs to call get_user_pages() only once for each compound page and
>> + * to immediately map the entire compound page with a single secondary
>> + * MMU fault. If there will be a pmd split later, the secondary MMUs
>> + * will get an update through the MMU notifier invalidation through
>> + * split_huge_pmd().
>> + *
>> + * Unlike PageTransCompound, this is safe to be called only while
>> + * split_huge_pmd() cannot run from under us, like if protected by the
>> + * MMU notifier, otherwise it may result in page->_mapcount check false
>> + * positives.
>> + *
>> + * We have to treat page cache THP differently since every subpage of it
>> + * would get _mapcount inc'ed once it is PMD mapped.  But, it may be PTE
>> + * mapped in the current process so checking PageDoubleMap flag to rule
>> + * this out.
>> + */
>> +static inline int PageTransCompoundMap(struct page *page)
>> +{
>> +	bool pmd_mapped;
>> +
>> +	if (PageAnon(page))
>> +		pmd_mapped = atomic_read(&page->_mapcount) < 0;
>> +	else
>> +		pmd_mapped = atomic_read(&page->_mapcount) >= 0 &&
>> +			     !PageDoubleMap(compound_head(page));
>> +
>> +	return PageTransCompound(page) && pmd_mapped;
>> +}
>>   #else
>>   TESTPAGEFLAG_FALSE(TransHuge)
>>   TESTPAGEFLAG_FALSE(TransCompound)
>> -- 
>> 1.8.3.1
> I completely agree that the current PageTransCompoundMap() is wrong.
>
> A fix for that is one of many patches I've not yet got to upstreaming.
> Comparing yours and mine, I'm worried by your use of PageDoubleMap(),
> because really that's a flag for anon THP, and not properly supported
> on shmem (or now I suppose file) THP - I forget the details, is it
> that it sometimes gets set, but never cleared?  Generally, we just
> don't refer to PageDoubleMap() on shmem THPs (but there may be
> exceptions: sorting out the THP mapcount maze, and eliminating
> PageDoubleMap(), is one of my long-held ambitions, not yet reached).
>
> Here's the patch I've been carrying, but it's from earlier, so I
> should warn that I've done no more than build-testing it on 5.4,
> and I'm too far away from these issues at the moment to be able to
> make a good judgement or argue for it - I hope you and others can
> decide which patch is the better.  I should also add that we're
> barely using PageTransCompoundMap() at all: at best it can only
> give a heuristic guess as to whether the page is pmd-mapped in
> any particular case, and we preferred to take forward the KVM
> patches we posted back in April 2016, plumbing hva down to where
> it's needed - though of course those are somewhat different now.

Thanks for catching this. I was definitely thinking about using 
compount_mapcount instead of DoubleMap flag when I was working the 
patch. I just simply thought it would change less file by using 
DoubleMap flag but I didn't notice it was kind of unbalanced for file THP.

With the unbalanced DoubleMap flag, it sounds better to use 
compound_mapcount.

Thanks for sharing your patch, I'm going to rework v2 by using 
compound_mapcount. Do you mind I might steal your patch?

I'm supposed we'd better fix this bug regardless of whether you would 
like to move forward your KVM patches.

>
> [PATCH] mm: kvm: huge tmpfs: fix PageTransCompoundMap()
>
> 4.6 commit 127393fbe597
> ("mm: thp: kvm: fix memory corruption in KVM with THP enabled")
> replaced the PageTransCompound() in KVM's transparent_hugepage_adjust()
> by a new PageTransCompoundMap() which also checks page _mapcount;
> while 4.8 commit dd78fedde4b9 ("rmap: support file thp")
> was under development, making shmem file THP's use of page _mapcount
> different from anon THP's (to avoid double-accounting in the tiresome
> NR_FILE_MAPPED statistic, I believe).
>
> Nobody spotted the disconnect, whose consequence has been that KVM
> could not recognize a shmem file THP, so could not optimize for it.
>
> Fix PageTransCompoundMap() to handle both cases.  Unfortunately, its
> definition has been placed (as you would suppose from the CamelCase)
> in page-flags.h, but now it needs compound_mapcount_ptr() from mm.h.
> My zest for header file refactoring has ebbed: instead, put identical
> defines of it in both files - no build will get far if they disagree.
>
> Whether PageTransCompoundMap() is actually correct is another matter.
> Good enough heuristic, erring on the safe side?  Good enough heuristic
> for anon, but not so good for shmem file (if a random other usage could
> ever map some ptes)?
>
> Fixes: dd78fedde4b9 ("rmap: support file thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>
>   include/linux/mm.h         |    6 ++----
>   include/linux/page-flags.h |   20 +++++++++++++++++---
>   2 files changed, 19 insertions(+), 7 deletions(-)
>
> --- 5.4-rc4/include/linux/mm.h	2019-10-06 17:20:18.473153411 -0700
> +++ linux/include/linux/mm.h	2019-10-22 13:00:30.697944228 -0700
> @@ -695,10 +695,8 @@ static inline void *kvcalloc(size_t n, s
>   
>   extern void kvfree(const void *addr);
>   
> -static inline atomic_t *compound_mapcount_ptr(struct page *page)
> -{
> -	return &page[1].compound_mapcount;
> -}
> +/* #define in order to validate duplicate definition in page-flags.h */
> +#define compound_mapcount_ptr(head)	(&(head)[1].compound_mapcount)
>   
>   static inline int compound_mapcount(struct page *page)
>   {
> --- 5.4-rc4/include/linux/page-flags.h	2019-09-15 14:19:32.000000000 -0700
> +++ linux/include/linux/page-flags.h	2019-10-22 13:00:30.697944228 -0700
> @@ -609,6 +609,9 @@ static inline int PageTransCompound(stru
>   	return PageCompound(page);
>   }
>   
> +/* #define in order to validate duplicate definition in mm.h */
> +#define compound_mapcount_ptr(head)	(&(head)[1].compound_mapcount)
> +
>   /*
>    * PageTransCompoundMap is the same as PageTransCompound, but it also
>    * guarantees the primary MMU has the entire compound page mapped
> @@ -622,12 +625,23 @@ static inline int PageTransCompound(stru
>    *
>    * Unlike PageTransCompound, this is safe to be called only while
>    * split_huge_pmd() cannot run from under us, like if protected by the
> - * MMU notifier, otherwise it may result in page->_mapcount < 0 false
> - * positives.
> + * MMU notifier, otherwise it may result in false positives.
>    */
>   static inline int PageTransCompoundMap(struct page *page)
>   {
> -	return PageTransCompound(page) && atomic_read(&page->_mapcount) < 0;
> +	struct page *head;
> +
> +	if (!PageTransCompound(page))
> +		return 0;
> +	if (PageAnon(page))
> +		return atomic_read(&page->_mapcount) < 0;
> +	/*
> +	 * pmd mappings are not included in anon THP's _mapcounts,
> +	 * but they are included in shmem file THP's _mapcounts.
> +	 */
> +	head = compound_head(page);
> +	return atomic_read(&page->_mapcount) ==
> +		atomic_read(compound_mapcount_ptr(head));
>   }
>   
>   /*

