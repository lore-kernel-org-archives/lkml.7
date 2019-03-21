Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BA6218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfCUQVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:21:46 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53493 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbfCUQVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:21:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNI4zah_1553185300;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNI4zah_1553185300)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Mar 2019 00:21:42 +0800
Subject: Re: [RFC PATCH] mm: mempolicy: remove MPOL_MF_LAZY
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190321145745.GS8696@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <75059b39-dbc4-3649-3e6b-7bdf282e3f53@linux.alibaba.com>
Date:   Thu, 21 Mar 2019 09:21:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190321145745.GS8696@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/19 7:57 AM, Michal Hocko wrote:
> On Wed 20-03-19 08:27:39, Yang Shi wrote:
>> MPOL_MF_LAZY was added by commit b24f53a0bea3 ("mm: mempolicy: Add
>> MPOL_MF_LAZY"), then it was disabled by commit a720094ded8c ("mm:
>> mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from userspace for now")
>> right away in 2012.  So, it is never ever exported to userspace.
>>
>> And, it looks nobody is interested in revisiting it since it was
>> disabled 7 years ago.  So, it sounds pointless to still keep it around.
> The above changelog owes us a lot of explanation about why this is
> safe and backward compatible. I am also not sure you can change
> MPOL_MF_INTERNAL because somebody still might use the flag from
> userspace and we want to guarantee it will have the exact same semantic.

Since MPOL_MF_LAZY is never exported to userspace (Mel helped to confirm 
this in the other thread), so I'm supposed it should be safe and 
backward compatible to userspace.

I'm also not sure if anyone use MPOL_MF_INTERNAL or not and how they use 
it in their applications, but how about keeping it unchanged?

Thanks,
Yang

>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> Hi folks,
>> I'm not sure if you still would like to revisit it later. And, I may be
>> not the first one to try to remvoe it. IMHO, it sounds pointless to still
>> keep it around if nobody is interested in it.
>>
>>   include/uapi/linux/mempolicy.h |  3 +--
>>   mm/mempolicy.c                 | 13 -------------
>>   2 files changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>> index 3354774..eb52a7a 100644
>> --- a/include/uapi/linux/mempolicy.h
>> +++ b/include/uapi/linux/mempolicy.h
>> @@ -45,8 +45,7 @@ enum {
>>   #define MPOL_MF_MOVE	 (1<<1)	/* Move pages owned by this process to conform
>>   				   to policy */
>>   #define MPOL_MF_MOVE_ALL (1<<2)	/* Move every page to conform to policy */
>> -#define MPOL_MF_LAZY	 (1<<3)	/* Modifies '_MOVE:  lazy migrate on fault */
>> -#define MPOL_MF_INTERNAL (1<<4)	/* Internal flags start here */
>> +#define MPOL_MF_INTERNAL (1<<3)	/* Internal flags start here */
>>   
>>   #define MPOL_MF_VALID	(MPOL_MF_STRICT   | 	\
>>   			 MPOL_MF_MOVE     | 	\
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index af171cc..67886f4 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -593,15 +593,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>>   
>>   	qp->prev = vma;
>>   
>> -	if (flags & MPOL_MF_LAZY) {
>> -		/* Similar to task_numa_work, skip inaccessible VMAs */
>> -		if (!is_vm_hugetlb_page(vma) &&
>> -			(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)) &&
>> -			!(vma->vm_flags & VM_MIXEDMAP))
>> -			change_prot_numa(vma, start, endvma);
>> -		return 1;
>> -	}
>> -
>>   	/* queue pages from current vma */
>>   	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
>>   		return 0;
>> @@ -1181,9 +1172,6 @@ static long do_mbind(unsigned long start, unsigned long len,
>>   	if (IS_ERR(new))
>>   		return PTR_ERR(new);
>>   
>> -	if (flags & MPOL_MF_LAZY)
>> -		new->flags |= MPOL_F_MOF;
>> -
>>   	/*
>>   	 * If we are using the default policy then operation
>>   	 * on discontinuous address spaces is okay after all
>> @@ -1226,7 +1214,6 @@ static long do_mbind(unsigned long start, unsigned long len,
>>   		int nr_failed = 0;
>>   
>>   		if (!list_empty(&pagelist)) {
>> -			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>>   			nr_failed = migrate_pages(&pagelist, new_page, NULL,
>>   				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
>>   			if (nr_failed)
>> -- 
>> 1.8.3.1
>>

