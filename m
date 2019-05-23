Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40023C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D03D20868
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JA5v5DeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbfEWSrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:47:47 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2330 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfEWSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:47:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce6ead10000>; Thu, 23 May 2019 11:47:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 11:47:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 11:47:45 -0700
Received: from [10.2.169.219] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 18:47:44 +0000
Subject: Re: [PATCH 3/5] mm/hmm: Use mm_get_hmm() in hmm_range_register()
To:     Jason Gunthorpe <jgg@ziepe.ca>, <rcampbell@nvidia.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-4-rcampbell@nvidia.com>
 <20190523125108.GA14013@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1435fa10-fef1-0fbf-de20-70ed145ab6ab@nvidia.com>
Date:   Thu, 23 May 2019 11:46:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523125108.GA14013@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558637265; bh=tVzIzXhTQ6hb7xFSzDM7/YhxaHOlgS0CMmNs/PhECls=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JA5v5DeRlkhcFTDxT2DHtmNJydY8aluWht3QgPQHhzM8CkXOmI10blP375OYVWc3j
         chssnY/fB/6okvOrxAm11slC0pLddF7r8e3mhOTKI6UpGEO4oGUQLqXowSdACMdcev
         pfivN58HleoZZTLzsHthXLW+PHrMHnHbtmgoHE/aiBHrN82z0iCOpNCDmV0fWIN2jB
         8B7ixIe0KIEhUkEVG7d46BnHWF56JCQKDHo2EZaNdD5ko/I/UDVRc2rrWAijh2cqbg
         RbFQnEMTA+MyQj4Wjt7WqigTpz5S4W0K/jXc2J9Pfrn5ZnuT6Sxr+Y8ulFFU3rpcQq
         qu8My+EHH1OHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 5:51 AM, Jason Gunthorpe wrote:
> On Mon, May 06, 2019 at 04:29:40PM -0700, rcampbell@nvidia.com wrote:
>> From: Ralph Campbell <rcampbell@nvidia.com>
>>
>> In hmm_range_register(), the call to hmm_get_or_create() implies that
>> hmm_range_register() could be called before hmm_mirror_register() when
>> in fact, that would violate the HMM API.
>>
>> Use mm_get_hmm() instead of hmm_get_or_create() to get the HMM structure.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Souptick Joarder <jrdr.linux@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>   mm/hmm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index f6c4c8633db9..2aa75dbed04a 100644
>> +++ b/mm/hmm.c
>> @@ -936,7 +936,7 @@ int hmm_range_register(struct hmm_range *range,
>>   	range->start = start;
>>   	range->end = end;
>>   
>> -	range->hmm = hmm_get_or_create(mm);
>> +	range->hmm = mm_get_hmm(mm);
>>   	if (!range->hmm)
>>   		return -EFAULT;
> 
> I looked for documentation saying that hmm_range_register should only
> be done inside a hmm_mirror_register and didn't see it. Did I miss it?
> Can you add a comment?
> 
> It is really good to fix this because it means we can rely on mmap sem
> to manage mm->hmm!
> 
> If this is true then I also think we should change the signature of
> the function to make this dependency relationship clear, and remove
> some possible confusing edge cases.
> 
> What do you think about something like this? (unfinished)

I like it...

> 
> commit 29098bd59cf481ad1915db40aefc8435dabb8b28
> Author: Jason Gunthorpe <jgg@mellanox.com>
> Date:   Thu May 23 09:41:19 2019 -0300
> 
>      mm/hmm: Use hmm_mirror not mm as an argument for hmm_register_range
>      
>      Ralf observes that hmm_register_range() can only be called by a driver

       ^Ralph
:)

>      while a mirror is registered. Make this clear in the API by passing
>      in the mirror structure as a parameter.
>      
>      This also simplifies understanding the lifetime model for struct hmm,
>      as the hmm pointer must be valid as part of a registered mirror
>      so all we need in hmm_register_range() is a simple kref_get.
>      
>      Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
>      Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 8b91c90d3b88cb..87d29e085a69f7 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -503,7 +503,7 @@ static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
>    * Please see Documentation/vm/hmm.rst for how to use the range API.
>    */
>   int hmm_range_register(struct hmm_range *range,
> -		       struct mm_struct *mm,
> +		       struct hmm_mirror *mirror,
>   		       unsigned long start,
>   		       unsigned long end,
>   		       unsigned page_shift);
> @@ -539,7 +539,8 @@ static inline bool hmm_vma_range_done(struct hmm_range *range)
>   }
>   
>   /* This is a temporary helper to avoid merge conflict between trees. */
> -static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> +static inline int hmm_vma_fault(struct hmm_mirror *mirror,
> +				struct hmm_range *range, bool block)
>   {
>   	long ret;
>   
> @@ -552,7 +553,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>   	range->default_flags = 0;
>   	range->pfn_flags_mask = -1UL;
>   
> -	ret = hmm_range_register(range, range->vma->vm_mm,
> +	ret = hmm_range_register(range, mirror,
>   				 range->start, range->end,
>   				 PAGE_SHIFT);
>   	if (ret)
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 824e7e160d8167..fa1b04fcfc2549 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -927,7 +927,7 @@ static void hmm_pfns_clear(struct hmm_range *range,
>    * Track updates to the CPU page table see include/linux/hmm.h
>    */
>   int hmm_range_register(struct hmm_range *range,
> -		       struct mm_struct *mm,
> +		       struct hmm_mirror *mirror,
>   		       unsigned long start,
>   		       unsigned long end,
>   		       unsigned page_shift)
> @@ -935,7 +935,6 @@ int hmm_range_register(struct hmm_range *range,
>   	unsigned long mask = ((1UL << page_shift) - 1UL);
>   
>   	range->valid = false;
> -	range->hmm = NULL;
>   
>   	if ((start & mask) || (end & mask))
>   		return -EINVAL;
> @@ -946,15 +945,12 @@ int hmm_range_register(struct hmm_range *range,
>   	range->start = start;
>   	range->end = end;
>   
> -	range->hmm = hmm_get_or_create(mm);
> -	if (!range->hmm)
> -		return -EFAULT;
> -
>   	/* Check if hmm_mm_destroy() was call. */
> -	if (range->hmm->mm == NULL || range->hmm->dead) {
> -		hmm_put(range->hmm);
> +	if (mirror->hmm->mm == NULL || mirror->hmm->dead)
>   		return -EFAULT;
> -	}
> +
> +	range->hmm = mirror->hmm;
> +	kref_get(&range->hmm->kref);
>   
>   	/* Initialize range to track CPU page table update */
>   	mutex_lock(&range->hmm->lock);
> 

So far, this looks very good to me. Passing the mirror around is an
elegant API solution to the "we must have a valid mirror in order to
call this function" constraint.


thanks,
-- 
John Hubbard
NVIDIA
