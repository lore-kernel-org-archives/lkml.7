Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09FDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D6A217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfLBUNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:13:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:11966 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbfLBUNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:13:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 12:13:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="235608334"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 02 Dec 2019 12:13:36 -0800
Received: from [10.251.15.70] (kliang2-mobl.ccr.corp.intel.com [10.251.15.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 13A5C5800FF;
        Mon,  2 Dec 2019 12:13:34 -0800 (PST)
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
 <20191202145957.GM84886@tassilo.jf.intel.com>
 <20191202162152.GG2827@hirez.programming.kicks-ass.net>
 <20191202191519.GN84886@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8612523d-f035-b2aa-28f5-e4122ef59901@linux.intel.com>
Date:   Mon, 2 Dec 2019 15:13:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202191519.GN84886@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/2019 2:15 PM, Andi Kleen wrote:
> On Mon, Dec 02, 2019 at 05:21:52PM +0100, Peter Zijlstra wrote:
>> On Mon, Dec 02, 2019 at 06:59:57AM -0800, Andi Kleen wrote:
>>>>
>>>> This is atricous crap. Also it is completely broken for -RT.
>>>
>>> Well can you please suggest how you would implement it instead?
>>
>> I don't think that is on me; at best I get to explain why it is
> 
> Normally code review is expected to be constructive.
> 
>> completely unacceptible to have O(nr_tasks) and allocations under a
>> raw_spinlock_t, but I was thinking you'd already know that.
> 
> Ok if that's the only problem then a lock breaker + retry
> if rescheduling is needed + some limit against live lock
> should be sufficient.
> 

OK. I will move the allocation out of critical sections.
Here is some pseudo code.

if (atomic_read(&nr_task_data_events))
	return;

//get current number of threads
read_lock(&tasklist_lock);
for_each_process_thread(g, p)
	num_thread++;
read_unlock(&tasklist_lock);

//allocate the space for them
for (i = 0; i < num_thread; i++)
	data[i] = kzalloc(ctx_size, flags);
i = 0;

/*
  * Assign the space to tasks
  * There may be some new threads created when we allocate space.
  * new_task will track its number.
  */
raw_spin_lock_irqsave(&task_data_events_lock, flags);

if (atomic_inc_return(&nr_task_data_events) > 1)
	goto unlock;

for_each_process_thread(g, p) {
	if (i < num_thread)
		p->perf_ctx_data = data[i++];
	else
		new_task++;
}
raw_spin_unlock_irqrestore(&task_data_events_lock, flags);

if (i < num_thread)
	goto end;

/*
  * Try again to allocate the space for the task created when
  * we first allocate space.
  * We don't need to worry about the task created after
  * atomic_inc_return(). It will be handled in perf_event_fork().
  * Retry one is enough.
  */
for (i = 0; i < new_task; i++)
	data[i] = kzalloc(ctx_size, flags);

raw_spin_lock_irqsave(&task_data_events_lock, flags);

for_each_process_thread(g, p) {
	if (i < unallocated)
		p->perf_ctx_data = data[i++];
	else
		WARN_ON
}
raw_spin_unlock_irqrestore(&task_data_events_lock, flags);

unlock:
	raw_spin_unlock_irqrestore(&task_data_events_lock, flags);

end:
	free unused data[]

Thanks,
Kan
