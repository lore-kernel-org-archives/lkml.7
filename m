Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BB3C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BE62173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfGPRSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:18:36 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54995 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728695AbfGPRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:18:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TX46jml_1563297508;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX46jml_1563297508)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Jul 2019 01:18:30 +0800
Subject: Re: [v2 PATCH 1/2] mm: mempolicy: make the behavior consistent when
 MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
 <1561162809-59140-2-git-send-email-yang.shi@linux.alibaba.com>
 <fb74d657-90cd-6667-f253-162c951f1b05@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <efe90132-6832-d61a-5d55-d2cc134c7087@linux.alibaba.com>
Date:   Tue, 16 Jul 2019 10:18:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fb74d657-90cd-6667-f253-162c951f1b05@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/19 1:12 AM, Vlastimil Babka wrote:
> On 6/22/19 2:20 AM, Yang Shi wrote:
>> When both MPOL_MF_MOVE* and MPOL_MF_STRICT was specified, mbind() should
>> try best to migrate misplaced pages, if some of the pages could not be
>> migrated, then return -EIO.
>>
>> There are three different sub-cases:
>> 1. vma is not migratable
>> 2. vma is migratable, but there are unmovable pages
>> 3. vma is migratable, pages are movable, but migrate_pages() fails
>>
>> If #1 happens, kernel would just abort immediately, then return -EIO,
>> after the commit a7f40cfe3b7ada57af9b62fd28430eeb4a7cfcb7 ("mm:
>> mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified").
>>
>> If #3 happens, kernel would set policy and migrate pages with best-effort,
>> but won't rollback the migrated pages and reset the policy back.
>>
>> Before that commit, they behaves in the same way.  It'd better to keep
>> their behavior consistent.  But, rolling back the migrated pages and
>> resetting the policy back sounds not feasible, so just make #1 behave as
>> same as #3.
>>
>> Userspace will know that not everything was successfully migrated (via
>> -EIO), and can take whatever steps it deems necessary - attempt rollback,
>> determine which exact page(s) are violating the policy, etc.
>>
>> Make queue_pages_range() return 1 to indicate there are unmovable pages
>> or vma is not migratable.
>>
>> The #2 is not handled correctly in the current kernel, the following
>> patch will fix it.
>>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Agreed with the goal, but I think there's a bug, and room for improvement.
>
>> ---
>>   mm/mempolicy.c | 86 +++++++++++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 61 insertions(+), 25 deletions(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 01600d8..b50039c 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -429,11 +429,14 @@ static inline bool queue_pages_required(struct page *page,
>>   }
>>   
>>   /*
>> - * queue_pages_pmd() has three possible return values:
>> + * queue_pages_pmd() has four possible return values:
>> + * 2 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
>> + *     specified.
>>    * 1 - pages are placed on the right node or queued successfully.
>>    * 0 - THP was split.
> I think if you renumbered these, it would be more consistent with
> queue_pages_pte_range() and simplify the code there.
> 0 - pages on right node/queued
> 1 - unmovable page with right flags specified
> 2 - THP split
>
>> - * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
>> - *        page was already on a node that does not follow the policy.
>> + * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
>> + *        existing page was already on a node that does not follow the
>> + *        policy.
>>    */
>>   static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>>   				unsigned long end, struct mm_walk *walk)
>> @@ -463,7 +466,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>>   	/* go to thp migration */
>>   	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>>   		if (!vma_migratable(walk->vma)) {
>> -			ret = -EIO;
>> +			ret = 2;
>>   			goto unlock;
>>   		}
>>   
>> @@ -488,16 +491,29 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
> Perhaps this function now also deserves a list of possible return values.

Sure, will add some comments to elaborate the return values.

>
>>   	struct queue_pages *qp = walk->private;
>>   	unsigned long flags = qp->flags;
>>   	int ret;
>> +	bool has_unmovable = false;
>>   	pte_t *pte;
>>   	spinlock_t *ptl;
>>   
>>   	ptl = pmd_trans_huge_lock(pmd, vma);
>>   	if (ptl) {
>>   		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
>> -		if (ret > 0)
>> +		switch (ret) {
> With renumbering suggested above, this could be:
> if (ret != 2)
>      return ret;
>
>> +		/* THP was split, fall through to pte walk */
>> +		case 0:
>> +			break;
>> +		/* Pages are placed on the right node or queued successfully */
>> +		case 1:
>>   			return 0;
>> -		else if (ret < 0)
>> +		/*
>> +		 * Met unmovable pages, MPOL_MF_MOVE* & MPOL_MF_STRICT
>> +		 * were specified.
>> +		 */
>> +		case 2:
>> +			return 1;
>> +		case -EIO:
>>   			return ret;
>> +		}
>>   	}
>>   
>>   	if (pmd_trans_unstable(pmd))
>> @@ -519,14 +535,21 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>>   		if (!queue_pages_required(page, qp))
>>   			continue;
>>   		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>> -			if (!vma_migratable(vma))
>> +			/* MPOL_MF_STRICT must be specified if we get here */
>> +			if (!vma_migratable(vma)) {
>> +				has_unmovable |= true;
>>   				break;
>> +			}
>>   			migrate_page_add(page, qp->pagelist, flags);
>>   		} else
>>   			break;
>>   	}
>>   	pte_unmap_unlock(pte - 1, ptl);
>>   	cond_resched();
>> +
>> +	if (has_unmovable)
>> +		return 1;
>> +
>>   	return addr != end ? -EIO : 0;
>>   }
>>   
>> @@ -639,7 +662,13 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>>    *
>>    * If pages found in a given range are on a set of nodes (determined by
>>    * @nodes and @flags,) it's isolated and queued to the pagelist which is
>> - * passed via @private.)
>> + * passed via @private.
>> + *
>> + * queue_pages_range() has three possible return values:
>> + * 1 - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
>> + *     specified.
>> + * 0 - queue pages successfully or no misplaced page.
>> + * -EIO - there is misplaced page and only MPOL_MF_STRICT was specified.
>>    */
>>   static int
>>   queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
>> @@ -1182,6 +1211,7 @@ static long do_mbind(unsigned long start, unsigned long len,
>>   	struct mempolicy *new;
>>   	unsigned long end;
>>   	int err;
>> +	int ret;
>>   	LIST_HEAD(pagelist);
>>   
>>   	if (flags & ~(unsigned long)MPOL_MF_VALID)
>> @@ -1243,26 +1273,32 @@ static long do_mbind(unsigned long start, unsigned long len,
>>   	if (err)
>>   		goto mpol_out;
>>   
>> -	err = queue_pages_range(mm, start, end, nmask,
>> +	ret = queue_pages_range(mm, start, end, nmask,
>>   			  flags | MPOL_MF_INVERT, &pagelist);
>> -	if (!err)
>> -		err = mbind_range(mm, start, end, new);
>> -
>> -	if (!err) {
>> -		int nr_failed = 0;
>>   
>> -		if (!list_empty(&pagelist)) {
>> -			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>> -			nr_failed = migrate_pages(&pagelist, new_page, NULL,
>> -				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
>> -			if (nr_failed)
>> -				putback_movable_pages(&pagelist);
>> -		}
>> +	if (ret < 0)
>> +		err = -EIO;
> I think after your patch, you miss putback_movable_pages() in cases
> where some were queued, and later the walk returned -EIO. The previous
> code doesn't miss it, but it's also not obvious due to the multiple if
> (!err) checks. I would rewrite it some thing like this:
>
> if (ret < 0) {
>      putback_movable_pages(&pagelist);
>      err = ret;
>      goto mmap_out; // a new label above up_write()
> }

Yes, the old code had putback_movable_pages called when !err. But, I 
think that is for error handling of mbind_range() if I understand it 
correctly since if queue_pages_range() returns -EIO (only MPOL_MF_STRICT 
was specified and there was misplaced page) that page list should be 
empty . The old code should checked whether that list is empty or not.

So, in the new code I just removed that.

>
> The rest can have reduced identation now.

Yes, the goto does eliminate the extra indentation.

>
>> +	else {
>> +		err = mbind_range(mm, start, end, new);
>>   
>> -		if (nr_failed && (flags & MPOL_MF_STRICT))
>> -			err = -EIO;
>> -	} else
>> -		putback_movable_pages(&pagelist);
>> +		if (!err) {
>> +			int nr_failed = 0;
>> +
>> +			if (!list_empty(&pagelist)) {
>> +				WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>> +				nr_failed = migrate_pages(&pagelist, new_page,
>> +					NULL, start, MIGRATE_SYNC,
>> +					MR_MEMPOLICY_MBIND);
>> +				if (nr_failed)
>> +					putback_movable_pages(&pagelist);
>> +			}
>> +
>> +			if ((ret > 0) ||
>> +			    (nr_failed && (flags & MPOL_MF_STRICT)))
>> +				err = -EIO;
>> +		} else
>> +			putback_movable_pages(&pagelist);
> While at it, IIRC the kernel style says that when the 'if' part uses
> '{ }' then the 'else' part should as well, and it shouldn't be mixed.

Really? The old code doesn't have '{ }' for else, and checkpatch doesn't 
report any error or warning.

Thanks,
Yang

>
> Thanks,
> Vlastimil
>
>> +	}
>>   
>>   	up_write(&mm->mmap_sem);
>>    mpol_out:
>>

