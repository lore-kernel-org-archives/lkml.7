Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13436C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05B2207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgAFQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:18:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:1506 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFQS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:18:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 08:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="222875855"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 06 Jan 2020 08:18:26 -0800
Received: from [10.251.17.71] (kliang2-mobl.ccr.corp.intel.com [10.251.17.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3294858033E;
        Mon,  6 Jan 2020 08:18:25 -0800 (PST)
Subject: Re: [RFC PATCH V2 2/7] perf: Init/fini PMU specific data
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com
References: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
 <1578080364-5928-2-git-send-email-kan.liang@linux.intel.com>
 <20200106103832.GO2810@hirez.programming.kicks-ass.net>
 <20200106142343.GK15478@tassilo.jf.intel.com>
 <20200106143138.GN2844@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e12e347e-505e-2703-537f-c4394bebce89@linux.intel.com>
Date:   Mon, 6 Jan 2020 11:18:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200106143138.GN2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/2020 9:31 AM, Peter Zijlstra wrote:
> On Mon, Jan 06, 2020 at 06:23:43AM -0800, Andi Kleen wrote:
>>>> +	rcu_read_lock();
>>>> +	for_each_process_thread(g, p) {
>>>> +		mutex_lock(&p->perf_event_mutex);
>>>> +		if (p->perf_ctx_data) {
>>>> +			/*
>>>> +			 * The perf_ctx_data for this thread may has been
>>>> +			 * allocated by per-task event.
>>>> +			 * Only update refcount for the case.
>>>> +			 */
>>>> +			refcount_inc(&p->perf_ctx_data->refcount);
>>>> +			mutex_unlock(&p->perf_event_mutex);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		if (pos < num_thread) {
>>>> +			refcount_set(&data[pos]->refcount, 1);
>>>> +			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
>>>> +		} else {
>>>> +			/*
>>>> +			 * There may be some new threads created,
>>>> +			 * when we allocate space.
>>>> +			 * Track the number in nr_new_tasks.
>>>> +			 */
>>>> +			nr_new_tasks++;
>>>> +		}
>>>> +		mutex_unlock(&p->perf_event_mutex);
>>>> +	}
>>>> +	rcu_read_unlock();
>>>> +
>>>> +	raw_spin_unlock_irqrestore(&task_data_sys_wide_events_lock, flags);
>>>
>>> Still NAK. That's some mightly broken code there.
>>
>> Yes, Kan you cannot use a mutex (sleeping) inside rcu_read_lock().
>> Can perf_event_mutex be a spin lock?
> 
> Or insize that raw_spin_lock.

The task_data_sys_wide_events_lock is a global lock. I think we just 
need per-task lock here.

I think I will add a new dedicate per-task raw_spin_lock for 
perf_ctx_data here.


> And last time I expressly said to not do
> what whole tasklist iteration under a spinlock.
> 

We need an indicator to tell if the assignment for all existing tasks 
has been finished. Because we have to wait before processing the cases 
as below.
- Allocate the space for new threads. If we don't wait the assignments 
finished, we cannot tell if the perf_ctx_data is allocated by previous 
per-task event, or this system-wide event. The refcount may double count.
- There may be two or more system-wide events at the same time. When we 
are allocating the space for the first event, the second one may start 
profiling if we don't wait. The LBR shorten issue still exists.
- We have to serialize assignment and free.

If we cannot use spinlock to serialize the cases here, can we set a 
state when the assignment is finished, and use wait_var_event() in the 
cases as above?


Thanks,
Kan
