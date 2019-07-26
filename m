Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B6C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39458217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfGZHpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:45:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:41775 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfGZHpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:45:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 00:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="369456530"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 00:45:40 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, <jhladky@redhat.com>,
        <lvenanci@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] autonuma: Fix scan period updating
References: <20190725080124.494-1-ying.huang@intel.com>
        <20190725173516.GA16399@linux.vnet.ibm.com>
Date:   Fri, 26 Jul 2019 15:45:39 +0800
In-Reply-To: <20190725173516.GA16399@linux.vnet.ibm.com> (Srikar Dronamraju's
        message of "Thu, 25 Jul 2019 23:05:16 +0530")
Message-ID: <87y30l5jdo.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Srikar,

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> * Huang, Ying <ying.huang@intel.com> [2019-07-25 16:01:24]:
>
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> From the commit log and comments of commit 37ec97deb3a8 ("sched/numa:
>> Slow down scan rate if shared faults dominate"), the autonuma scan
>> period should be increased (scanning is slowed down) if the majority
>> of the page accesses are shared with other processes.  But in current
>> code, the scan period will be decreased (scanning is speeded up) in
>> that situation.
>> 
>> The commit log and comments make more sense.  So this patch fixes the
>> code to make it match the commit log and comments.  And this has been
>> verified via tracing the scan period changing and /proc/vmstat
>> numa_pte_updates counter when running a multi-threaded memory
>> accessing program (most memory areas are accessed by multiple
>> threads).
>> 
>
> Lets split into 4 modes.
> More Local and Private Page Accesses:
> We definitely want to scan slowly i.e increase the scan window.
>
> More Local and Shared Page Accesses:
> We still want to scan slowly because we have consolidated and there is no
> point in scanning faster. So scan slowly + increase the scan window.
> (Do remember access on any active node counts as local!!!)
>
> More Remote + Private page Accesses:
> Most likely the Private accesses are going to be local accesses.
>
> In the unlikely event of the private accesses not being local, we should
> scan faster so that the memory and task consolidates.
>
> More Remote + Shared page Accesses: This means the workload has not
> consolidated and needs to scan faster. So we need to scan faster.

This sounds reasonable.  But

lr_ratio < NUMA_PERIOD_THRESHOLD

doesn't indicate More Remote.  If Local = Remote, it is also true.  If
there are also more Shared, we should slow down the scanning.  So, the
logic could be

if (lr_ratio >= NUMA_PERIOD_THRESHOLD)
    slow down scanning
else if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
    if (NUMA_PERIOD_SLOTS - lr_ratio >= NUMA_PERIOD_THRESHOLD)
        speed up scanning
    else
        slow down scanning
} else
   speed up scanning

This follows your idea better?

Best Regards,
Huang, Ying

> So I would think we should go back to before 37ec97deb3a8.
>
> i.e 
>
> 	int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
>
> 	if (!slot)
> 		slot = 1;
> 	diff = slot * period_slot;
>
>
> No?
>
>> Fixes: 37ec97deb3a8 ("sched/numa: Slow down scan rate if shared faults dominate")
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Rik van Riel <riel@redhat.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: jhladky@redhat.com
>> Cc: lvenanci@redhat.com
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>  kernel/sched/fair.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 036be95a87e9..468a1c5038b2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1940,7 +1940,7 @@ static void update_task_scan_period(struct task_struct *p,
>>  			unsigned long shared, unsigned long private)
>>  {
>>  	unsigned int period_slot;
>> -	int lr_ratio, ps_ratio;
>> +	int lr_ratio, sp_ratio;
>>  	int diff;
>>  
>>  	unsigned long remote = p->numa_faults_locality[0];
>> @@ -1971,22 +1971,22 @@ static void update_task_scan_period(struct task_struct *p,
>>  	 */
>>  	period_slot = DIV_ROUND_UP(p->numa_scan_period, NUMA_PERIOD_SLOTS);
>>  	lr_ratio = (local * NUMA_PERIOD_SLOTS) / (local + remote);
>> -	ps_ratio = (private * NUMA_PERIOD_SLOTS) / (private + shared);
>> +	sp_ratio = (shared * NUMA_PERIOD_SLOTS) / (private + shared);
>>  
>> -	if (ps_ratio >= NUMA_PERIOD_THRESHOLD) {
>> +	if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
>>  		/*
>> -		 * Most memory accesses are local. There is no need to
>> -		 * do fast NUMA scanning, since memory is already local.
>> +		 * Most memory accesses are shared with other tasks.
>> +		 * There is no point in continuing fast NUMA scanning,
>> +		 * since other tasks may just move the memory elsewhere.
>
> With this change, I would expect that with Shared page accesses,
> consolidation to take a hit.
>
>>  		 */
>> -		int slot = ps_ratio - NUMA_PERIOD_THRESHOLD;
>> +		int slot = sp_ratio - NUMA_PERIOD_THRESHOLD;
>>  		if (!slot)
>>  			slot = 1;
>>  		diff = slot * period_slot;
>>  	} else if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
>>  		/*
>> -		 * Most memory accesses are shared with other tasks.
>> -		 * There is no point in continuing fast NUMA scanning,
>> -		 * since other tasks may just move the memory elsewhere.
>> +		 * Most memory accesses are local. There is no need to
>> +		 * do fast NUMA scanning, since memory is already local.
>
> Comment wise this make sense.
>
>>  		 */
>>  		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
>>  		if (!slot)
>> @@ -1998,7 +1998,7 @@ static void update_task_scan_period(struct task_struct *p,
>>  		 * yet they are not on the local NUMA node. Speed up
>>  		 * NUMA scanning to get the memory moved over.
>>  		 */
>> -		int ratio = max(lr_ratio, ps_ratio);
>> +		int ratio = max(lr_ratio, sp_ratio);
>>  		diff = -(NUMA_PERIOD_THRESHOLD - ratio) * period_slot;
>>  	}
>>  
>> -- 
>> 2.20.1
>> 
