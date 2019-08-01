Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551B4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3386F2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfHAFsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:48:07 -0400
Received: from foss.arm.com ([217.140.110.172]:58460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbfHAFsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:48:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC921337;
        Wed, 31 Jul 2019 22:48:05 -0700 (PDT)
Received: from [10.163.1.81] (unknown [10.163.1.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BE013F694;
        Wed, 31 Jul 2019 22:50:07 -0700 (PDT)
Subject: Re: [PATCH] fork: Improve error message for corrupted page tables
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <56ad91b8-1ea0-6736-5bc5-eea0ced01054@arm.com>
Date:   Thu, 1 Aug 2019 11:18:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2019 03:48 AM, Sai Praneeth Prakhya wrote:
> When a user process exits, the kernel cleans up the mm_struct of the user
> process and during cleanup, check_mm() checks the page tables of the user
> process for corruption (E.g: unexpected page flags set/cleared). For
> corrupted page tables, the error message printed by check_mm() isn't very
> clear as it prints the loop index instead of page table type (E.g: Resident
> file mapping pages vs Resident shared memory pages). Hence, improve the
> error message so that it's more informative.

The loop index in check_mm() also happens to be the index in rss_stat[] which
represents individual memory type stats. But you are right, index value here
in the print does not make any sense.

> 
> Without patch:
> --------------
> [  204.836425] mm/pgtable-generic.c:29: bad p4d 0000000089eb4e92(800000025f941467)
> [  204.836544] BUG: Bad rss-counter state mm:00000000f75895ea idx:0 val:2
> [  204.836615] BUG: Bad rss-counter state mm:00000000f75895ea idx:1 val:5
> [  204.836685] BUG: non-zero pgtables_bytes on freeing mm: 20480
> 
> With patch:
> -----------
> [   69.815453] mm/pgtable-generic.c:29: bad p4d 0000000084653642(800000025ca37467)
> [   69.815872] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_FILEPAGES val:2
> [   69.815962] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_ANONPAGES val:5
> [   69.816050] BUG: non-zero pgtables_bytes on freeing mm: 20480

Yes, this is definitely better.

> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by/Acked-by: Dave Hansen <dave.hansen@intel.com>

Though I am not sure, should the above be two separate lines instead ?

> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>  include/linux/mm_types_task.h | 7 +++++++
>  kernel/fork.c                 | 4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
> index d7016dcb245e..881f4ea3a1b5 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -44,6 +44,13 @@ enum {
>  	NR_MM_COUNTERS
>  };
>  
> +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> +	"MM_FILEPAGES",
> +	"MM_ANONPAGES",
> +	"MM_SWAPENTS",
> +	"MM_SHMEMPAGES",
> +};

Should index them to match respective typo macros.

	[MM_FILEPAGES] = "MM_FILEPAGES",
	[MM_ANONPAGES] = "MM_ANONPAGES",
	[MM_SWAPENTS] = "MM_SWAPENTS",
	[MM_SHMEMPAGES] = "MM_SHMEMPAGES",

> +
>  #if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
>  #define SPLIT_RSS_COUNTING
>  /* per-thread cached information, */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2852d0e76ea3..6aef5842d4e0 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -649,8 +649,8 @@ static void check_mm(struct mm_struct *mm)
>  		long x = atomic_long_read(&mm->rss_stat.count[i]);
>  
>  		if (unlikely(x))
> -			printk(KERN_ALERT "BUG: Bad rss-counter state "
> -					  "mm:%p idx:%d val:%ld\n", mm, i, x);
> +			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
> +				 mm, resident_page_types[i], x);
It changes the print function as well, though very minor change but perhaps
mention that in the commit message ?
