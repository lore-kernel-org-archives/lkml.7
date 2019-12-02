Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A435AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E720865
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfLBUfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:35:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:60990 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfLBUfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:35:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 12:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="213174665"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2019 12:35:02 -0800
Received: from [10.251.15.70] (kliang2-mobl.ccr.corp.intel.com [10.251.15.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 683715800FF;
        Mon,  2 Dec 2019 12:35:01 -0800 (PST)
Subject: Re: [RFC PATCH 2/8] perf: Helpers for alloc/init/fini PMU specific
 data
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        ak@linux.intel.com
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-2-git-send-email-kan.liang@linux.intel.com>
 <20191202131646.GD2827@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2d036aa5-542a-8c01-762c-3b68136887f5@linux.intel.com>
Date:   Mon, 2 Dec 2019 15:35:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202131646.GD2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/2019 8:16 AM, Peter Zijlstra wrote:
> On Thu, Nov 28, 2019 at 07:14:25AM -0800, kan.liang@linux.intel.com wrote:
> 
>> +static int
>> +__alloc_task_ctx_data_rcu(struct task_struct *task,
>> +			  size_t ctx_size, gfp_t flags)
>> +{
>> +	struct perf_ctx_data *ctx_data = task->perf_ctx_data;
>> +	int ret;
>> +
>> +	lockdep_assert_held_once(&task->perf_ctx_data_lock);
>> +
>> +	ret = alloc_perf_ctx_data(ctx_size, flags, &ctx_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ctx_data->refcount = 1;
>> +
>> +	rcu_assign_pointer(task->perf_ctx_data, ctx_data);
>> +
>> +	return 0;
>> +}
> 
>> +static int
>> +__init_task_ctx_data_rcu(struct task_struct *task, size_t ctx_size, gfp_t flags)
>> +{
>> +	struct perf_ctx_data *ctx_data = task->perf_ctx_data;
>> +
>> +	lockdep_assert_held_once(&task->perf_ctx_data_lock);
>> +
>> +	if (ctx_data) {
>> +		ctx_data->refcount++;
>> +		return 0;
>> +	}
>> +
>> +	return __alloc_task_ctx_data_rcu(task, ctx_size, flags);
>> +}
> 
>> +/**
>> + * Free perf_ctx_data RCU pointer for a task
>> + * @task:        Target Task
>> + * @force:       Unconditionally free perf_ctx_data
>> + *
>> + * If force is set, free perf_ctx_data unconditionally.
>> + * Otherwise, free perf_ctx_data when there are no users.
>> + * Lock is required to sync the writers of perf_ctx_data RCU pointer
>> + * and refcount.
>> + */
>> +static void
>> +fini_task_ctx_data_rcu(struct task_struct *task, bool force)
>> +{
>> +	struct perf_ctx_data *ctx_data;
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&task->perf_ctx_data_lock, flags);
>> +
>> +	ctx_data = task->perf_ctx_data;
>> +	if (!ctx_data)
>> +		goto unlock;
>> +
>> +	if (!force && --ctx_data->refcount)
>> +		goto unlock;
>> +
>> +	RCU_INIT_POINTER(task->perf_ctx_data, NULL);
>> +	call_rcu(&ctx_data->rcu_head, free_perf_ctx_data);
>> +
>> +unlock:
>> +	raw_spin_unlock_irqrestore(&task->perf_ctx_data_lock, flags);
>> +}
> 
> All this refcount under lock is an anti-pattern. Also the naming is
> insane.
> 

Could you please give me an example?

I think we do need something to protect the refcount. Are you suggesting 
atomic_*?

Thanks,
Kan

