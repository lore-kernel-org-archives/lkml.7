Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F276FC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41942175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfCTScK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:32:10 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41485 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbfCTScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:32:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TNDTpod_1553106713;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNDTpod_1553106713)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Mar 2019 02:31:55 +0800
Subject: Re: [PATCH] mm: mempolicy: make mbind() return -EIO when
 MPOL_MF_STRICT is specified
To:     Oscar Salvador <osalvador@suse.de>
Cc:     chrubis@suse.cz, vbabka@suse.cz, kirill@shutemov.name,
        akpm@linux-foundation.org, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190320081643.3c4m5tec5vx653sn@d104.suse.de>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3c880e88-6eb7-cd6d-fbf3-394b89355e10@linux.alibaba.com>
Date:   Wed, 20 Mar 2019 11:31:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190320081643.3c4m5tec5vx653sn@d104.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/19 1:16 AM, Oscar Salvador wrote:
> On Wed, Mar 20, 2019 at 02:35:56AM +0800, Yang Shi wrote:
>> Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
>> Reported-by: Cyril Hrubis <chrubis@suse.cz>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: stable@vger.kernel.org
>> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Hi Yang, thanks for the patch.
>
> Some observations below.
>
>>   	}
>>   	page = pmd_page(*pmd);
>> @@ -473,8 +480,15 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>>   	ret = 1;
>>   	flags = qp->flags;
>>   	/* go to thp migration */
>> -	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
>> +	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>> +		if (!vma_migratable(walk->vma)) {
>> +			ret = -EIO;
>> +			goto unlock;
>> +		}
>> +
>>   		migrate_page_add(page, qp->pagelist, flags);
>> +	} else
>> +		ret = -EIO;
> 	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
>         	        !vma_migratable(walk->vma)) {
>                 	ret = -EIO;
>                  goto unlock;
>          }
>
> 	migrate_page_add(page, qp->pagelist, flags);
> unlock:
>          spin_unlock(ptl);
> out:
>          return ret;
>
> seems more clean to me?

Yes, it sounds so.

>
>
>>   unlock:
>>   	spin_unlock(ptl);
>>   out:
>> @@ -499,8 +513,10 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>>   	ptl = pmd_trans_huge_lock(pmd, vma);
>>   	if (ptl) {
>>   		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
>> -		if (ret)
>> +		if (ret > 0)
>>   			return 0;
>> +		else if (ret < 0)
>> +			return ret;
> I would go with the following, but that's a matter of taste I guess.
>
> if (ret < 0)
> 	return ret;
> else
> 	return 0;

No, this is not correct. queue_pages_pmd() may return 0, which means THP 
gets split. If it returns 0 the code should just fall through instead of 
returning.

>
>>   	}
>>   
>>   	if (pmd_trans_unstable(pmd))
>> @@ -521,11 +537,16 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>>   			continue;
>>   		if (!queue_pages_required(page, qp))
>>   			continue;
>> -		migrate_page_add(page, qp->pagelist, flags);
>> +		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>> +			if (!vma_migratable(vma))
>> +				break;
>> +			migrate_page_add(page, qp->pagelist, flags);
>> +		} else
>> +			break;
> I might be missing something, but AFAICS neither vma nor flags is going to change
> while we are in queue_pages_pte_range(), so, could not we move the check just
> above the loop?
> In that way, 1) we only perform the check once and 2) if we enter the loop
> we know that we are going to do some work, so, something like:
>
> index af171ccb56a2..7c0e44389826 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -487,6 +487,9 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>          if (pmd_trans_unstable(pmd))
>                  return 0;
>   
> +       if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) || !vma_migratable(vma))
> +               return -EIO;

It sounds not correct to me. We need check if there is existing page on 
the node which is not allowed by the policy. This is what 
queue_pages_required() does.

Thanks,
Yang

> +
>          pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>          for (; addr != end; pte++, addr += PAGE_SIZE) {
>                  if (!pte_present(*pte))
>
>
>>   	}
>>   	pte_unmap_unlock(pte - 1, ptl);
>>   	cond_resched();
>> -	return 0;
>> +	return addr != end ? -EIO : 0;
> If we can do the above, we can leave the return value as it was.
>

