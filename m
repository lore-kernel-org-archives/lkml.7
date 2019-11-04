Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99397CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ED3217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfKDClO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 21:41:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:8537 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfKDClO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 21:41:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 18:41:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,265,1569308400"; 
   d="scan'208";a="199889282"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga008.fm.intel.com with ESMTP; 03 Nov 2019 18:41:11 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 08/10] autonuma, memory tiering: Select hotter pages to promote to fast memory node
References: <20191101075727.26683-1-ying.huang@intel.com>
        <20191101075727.26683-9-ying.huang@intel.com>
        <20191101092404.GS4131@hirez.programming.kicks-ass.net>
Date:   Mon, 04 Nov 2019 10:41:10 +0800
In-Reply-To: <20191101092404.GS4131@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 1 Nov 2019 10:24:04 +0100")
Message-ID: <87k18gcqih.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Nov 01, 2019 at 03:57:25PM +0800, Huang, Ying wrote:
>> index 8ec38b11b361..59e2151734ab 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -484,6 +484,11 @@ struct mm_struct {
>>  
>>  		/* numa_scan_seq prevents two threads setting pte_numa */
>>  		int numa_scan_seq;
>> +
>> +#define NUMA_SCAN_NR_HIST	16
>> +		int numa_scan_idx;
>> +		unsigned long numa_scan_jiffies[NUMA_SCAN_NR_HIST];
>> +		unsigned long numa_scan_starts[NUMA_SCAN_NR_HIST];
>
> Why 16? This is 4 cachelines.

We want to keep the NUMA scanning history reasonably long.  From
task_scan_min(), the minimal interval between task_numa_work() running
is about 100 ms by default.  So we can keep 1600 ms history by default
if NUMA_SCAN_NR_HIST is 16.  If user choose to use smaller
sysctl_numa_balancing_scan_size, then we can only keep shorter history.
In general, we want to keep no less than 1000 ms history.  So 16 appears
like a reasonable choice for us.  Any other suggestion?

>>  #endif
>>  		/*
>>  		 * An operation with batched TLB flushing is going on. Anything
>
>> +static long numa_hint_fault_latency(struct task_struct *p, unsigned long addr)
>> +{
>> +	struct mm_struct *mm = p->mm;
>> +	unsigned long now = jiffies;
>> +	unsigned long start, end;
>> +	int i, j;
>> +	long latency = 0;
>> +
>> +	i = READ_ONCE(mm->numa_scan_idx);
>> +	i = i ? i - 1 : NUMA_SCAN_NR_HIST - 1;
>> +	/*
>> +	 * Paired with smp_wmb() in task_numa_work() to check
>> +	 * scan range buffer after get current index
>> +	 */
>> +	smp_rmb();
>
> That wants to be:
>
> 	i = smp_load_acquire(&mm->numa_scan_idx)
> 	i = (i - 1) % NUMA_SCAN_NR_HIST;
>
> (and because NUMA_SCAN_NR_HIST is a power of 2, the compiler will
> conveniently make that a bitwise and operation)
>
> And: "DEC %0; AND $15, %0" is so much faster than a branch.

This looks much better.  Thanks!  I will use it in the next version.

>> +	end = READ_ONCE(mm->numa_scan_offset);
>> +	start = READ_ONCE(mm->numa_scan_starts[i]);
>> +	if (start == end)
>> +		end = start + MAX_SCAN_WINDOW * (1UL << 22);
>> +	for (j = 0; j < NUMA_SCAN_NR_HIST; j++) {
>> +		latency = now - READ_ONCE(mm->numa_scan_jiffies[i]);
>> +		start = READ_ONCE(mm->numa_scan_starts[i]);
>> +		/* Scan pass the end of address space */
>> +		if (end < start)
>> +			end = TASK_SIZE;
>> +		if (addr >= start && addr < end)
>> +			return latency;
>> +		end = start;
>> +		i = i ? i - 1 : NUMA_SCAN_NR_HIST - 1;
>
> 		i = (i - 1) % NUMA_SCAN_NR_HIST;

Will use this in the next version.

>> +	}
>> +	/*
>> +	 * The tracking window isn't large enough, approximate to the
>> +	 * max latency in the tracking window.
>> +	 */
>> +	return latency;
>> +}
>
>> @@ -2583,6 +2640,19 @@ void task_numa_work(struct callback_head *work)
>>  		start = 0;
>>  		vma = mm->mmap;
>>  	}
>> +	idx = mm->numa_scan_idx;
>> +	WRITE_ONCE(mm->numa_scan_starts[idx], start);
>> +	WRITE_ONCE(mm->numa_scan_jiffies[idx], jiffies);
>> +	/*
>> +	 * Paired with smp_rmb() in should_numa_migrate_memory() to
>> +	 * update scan range buffer index after update the buffer
>> +	 * contents.
>> +	 */
>> +	smp_wmb();
>> +	if (idx + 1 >= NUMA_SCAN_NR_HIST)
>> +		WRITE_ONCE(mm->numa_scan_idx, 0);
>> +	else
>> +		WRITE_ONCE(mm->numa_scan_idx, idx + 1);
>
> 	smp_store_release(&mm->nums_scan_idx, idx % NUMA_SCAN_NR_HIST);

Will use this in the next version.

Best Regards,
Huang, Ying
