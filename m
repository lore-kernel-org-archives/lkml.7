Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB6CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3604206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfHFIbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:31:46 -0400
Received: from foss.arm.com ([217.140.110.172]:58618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFIbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:31:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D59F337;
        Tue,  6 Aug 2019 01:31:45 -0700 (PDT)
Received: from [10.163.1.69] (unknown [10.163.1.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B3763F706;
        Tue,  6 Aug 2019 01:31:42 -0700 (PDT)
Subject: Re: [PATCH V2] fork: Improve error message for corrupted page tables
To:     Vlastimil Babka <vbabka@suse.cz>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
 <5ba88460-cf01-3d53-6d13-45e650b4eacd@suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <926d50ce-4742-0ae7-474c-ef561fe23cdd@arm.com>
Date:   Tue, 6 Aug 2019 14:02:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ba88460-cf01-3d53-6d13-45e650b4eacd@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2019 01:23 PM, Vlastimil Babka wrote:
> 
> On 8/6/19 5:05 AM, Sai Praneeth Prakhya wrote:
>> When a user process exits, the kernel cleans up the mm_struct of the user
>> process and during cleanup, check_mm() checks the page tables of the user
>> process for corruption (E.g: unexpected page flags set/cleared). For
>> corrupted page tables, the error message printed by check_mm() isn't very
>> clear as it prints the loop index instead of page table type (E.g: Resident
>> file mapping pages vs Resident shared memory pages). The loop index in
>> check_mm() is used to index rss_stat[] which represents individual memory
>> type stats. Hence, instead of printing index, print memory type, thereby
>> improving error message.
>>
>> Without patch:
>> --------------
>> [  204.836425] mm/pgtable-generic.c:29: bad p4d 0000000089eb4e92(800000025f941467)
>> [  204.836544] BUG: Bad rss-counter state mm:00000000f75895ea idx:0 val:2
>> [  204.836615] BUG: Bad rss-counter state mm:00000000f75895ea idx:1 val:5
>> [  204.836685] BUG: non-zero pgtables_bytes on freeing mm: 20480
>>
>> With patch:
>> -----------
>> [   69.815453] mm/pgtable-generic.c:29: bad p4d 0000000084653642(800000025ca37467)
>> [   69.815872] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_FILEPAGES val:2
>> [   69.815962] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_ANONPAGES val:5
>> [   69.816050] BUG: non-zero pgtables_bytes on freeing mm: 20480
>>
>> Also, change print function (from printk(KERN_ALERT, ..) to pr_alert()) so
>> that it matches the other print statement.
>>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Acked-by: Dave Hansen <dave.hansen@intel.com>
>> Suggested-by: Dave Hansen <dave.hansen@intel.com>
>> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> I would also add something like this to reduce risk of breaking it in the
> future:
> 
> ----8<----
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
> index d7016dcb245e..a6f83cbe4603 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -36,6 +36,9 @@ struct vmacache {
>  	struct vm_area_struct *vmas[VMACACHE_SIZE];
>  };
>  
> +/*
> + * When touching this, update also resident_page_types in kernel/fork.c
> + */
>  enum {
>  	MM_FILEPAGES,	/* Resident file mapping pages */
>  	MM_ANONPAGES,	/* Resident anonymous pages */
> 

Agreed and with that

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
