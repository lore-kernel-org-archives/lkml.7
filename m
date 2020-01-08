Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03D4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE60020705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgAHTxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:53:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:37299 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgAHTxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:53:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 11:52:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="303651399"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 11:52:13 -0800
Received: from [10.251.6.5] (kliang2-mobl.ccr.corp.intel.com [10.251.6.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9A0F85803E3;
        Wed,  8 Jan 2020 11:52:12 -0800 (PST)
Subject: Re: [RFC PATCH V3 2/7] perf: attach/detach PMU specific data
To:     Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com
References: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
 <1578495789-95006-2-git-send-email-kan.liang@linux.intel.com>
 <20200108165009.GQ15478@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <78364595-78f5-f9da-1b45-a94f49f81996@linux.intel.com>
Date:   Wed, 8 Jan 2020 14:52:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108165009.GQ15478@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2020 11:50 AM, Andi Kleen wrote:
>> +static int
>> +attach_system_wide_ctx_data(size_t ctx_size)
>> +{
>> +	int i, num_thread, pos, nr_failed_alloc;
>> +	unsigned long flags = GFP_ATOMIC;
>> +	struct perf_ctx_data *tsk_data;
>> +	struct perf_ctx_data **data;
>> +	struct task_struct *g, *p;
>> +	bool re_alloc = true;
>> +
>> +	/* Retrieve total number of threads */
>> +	num_thread = nr_threads;
>> +
>> +	data = kcalloc(num_thread, sizeof(*data), GFP_KERNEL);
> 
> This probably needs kvcalloc for reliability and avoiding stalls.
>

Yes, kvcalloc looks better.

>> +	if (!data) {
>> +		printk_once(KERN_DEBUG
>> +			    "Failed to allocate space for LBR callstack. "
>> +			    "The LBR callstack for all tasks may be cutoff.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	atomic_inc(&nr_task_data_sys_wide_events);
>> +
>> +repeat:
>> +	/*
>> +	 * Allocate perf_ctx_data for all existing threads.
>> +	 * The perf_ctx_data for new threads will be allocated in
>> +	 * perf_event_fork().
>> +	 * Do a quick allocation in first round with GFP_ATOMIC.
>> +	 */
>> +	for (i = 0; i < num_thread; i++) {
>> +		if (alloc_perf_ctx_data(ctx_size, flags, &data[i]))
>> +			break;
>> +	}
>> +	num_thread = i;
>> +	nr_failed_alloc = 0;
>> +	pos = 0;
>> +
> 
>> +	rcu_read_lock();
>> +	for_each_process_thread(g, p) {
>> +		raw_spin_lock(&p->perf_ctx_data_lock);
>> +		tsk_data = p->perf_ctx_data;
>> +		if (tsk_data) {
> 
> That will be a lot of locks even for tasks that don't use perf, but I guess we
> really need it and it's bounded by the number of tasks.

Right. We don't know which tasks will be monitored later. So we have to 
attach the perf_ctx_data for all of them. The per-task lock is required 
to sync the writers of perf_ctx_data RCU pointer.


Thanks,
Kan
> 
>> +		}
>> +
>> +		if (pos < num_thread) {
>> +			refcount_set(&data[pos]->refcount, TASK_DATA_SYS_WIDE);
>> +			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
>> +		} else {
>> +			/*
>> +			 * The quick allocation in first round may be failed.
>> +			 * Track the number in nr_failed_alloc.
>> +			 */
>> +			nr_failed_alloc++;
>> +		}
>> +		raw_spin_unlock(&p->perf_ctx_data_lock);
>> +	}
>> +	rcu_read_unlock();
> 
> 
> -Andi
> 
