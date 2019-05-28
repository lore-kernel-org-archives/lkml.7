Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64033C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DE3208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfE1SYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:24:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:41723 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1SYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:24:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 11:24:16 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2019 11:24:16 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D6318580372;
        Tue, 28 May 2019 11:24:15 -0700 (PDT)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528133022.GX2606@hirez.programming.kicks-ass.net>
Message-ID: <a3722bae-9506-21f0-7e6e-a85217313bf8@linux.intel.com>
Date:   Tue, 28 May 2019 14:24:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528133022.GX2606@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 9:30 AM, Peter Zijlstra wrote:
> On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
>> +static u64 icl_metric_update_event(struct perf_event *event, u64 val)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	u64 newval, metric, slots_val = 0, new, last;
>> +	bool nmi = in_nmi();
>> +	int txn_flags = nmi ? 0 : cpuc->txn_flags;
>> +
>> +	/*
>> +	 * Use cached value for transaction.
>> +	 */
>> +	newval = 0;
>> +	if (txn_flags) {
>> +		newval = cpuc->txn_metric;
>> +		slots_val = cpuc->txn_slots;
>> +	} else if (nmi) {
>> +		newval = cpuc->nmi_metric;
>> +		slots_val = cpuc->nmi_slots;
>> +	}
>> +
>> +	if (!newval) {
>> +		slots_val = val;
>> +
>> +		rdpmcl((1<<29), newval);
>> +		if (txn_flags) {
>> +			cpuc->txn_metric = newval;
>> +			cpuc->txn_slots = slots_val;
>> +		} else if (nmi) {
>> +			cpuc->nmi_metric = newval;
>> +			cpuc->nmi_slots = slots_val;
>> +		}
>> +
>> +		if (!(txn_flags & PERF_PMU_TXN_REMOVE)) {
>> +			/* Reset the metric value when reading
>> +			 * The SLOTS register must be reset when PERF_METRICS reset,
>> +			 * otherwise PERF_METRICS may has wrong output.
>> +			 */
> 
> broken comment style.. (and grammer)

Missed a full stop.
Should be "Reset the metric value for each read."
> 
>> +			wrmsrl(MSR_PERF_METRICS, 0);
>> +			wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
> 
> I don't get this, overflow happens on when we flip sign, so why is
> programming 0 a sane thing to do?

Reset the counters (programming 0) don't trigger overflow.
We have to reset both registers for each read to avoid the known 
PERF_METRICS issue.


> 
>> +			hwc->saved_metric = 0;
>> +			hwc->saved_slots = 0;
>> +		} else {
>> +			/* saved metric and slots for context switch */
>> +			hwc->saved_metric = newval;
>> +			hwc->saved_slots = val;
>> +
>> +		}
>> +		/* cache the last metric and slots */
>> +		cpuc->last_metric = hwc->last_metric;
>> +		cpuc->last_slots = hwc->last_slots;
>> +		hwc->last_metric = 0;
>> +		hwc->last_slots = 0;
>> +	}
>> +
>> +	/* The METRICS and SLOTS have been reset when reading */
>> +	if (!(txn_flags & PERF_PMU_TXN_REMOVE))
>> +		local64_set(&hwc->prev_count, 0);
>> +
>> +	if (is_slots_event(event))
>> +		return (slots_val - cpuc->last_slots);
>> +
>> +	/*
>> +	 * The metric is reported as an 8bit integer percentage
>> +	 * suming up to 0xff. As the counter is less than 64bits
>> +	 * we can use the not used bits to get the needed precision.
>> +	 * Use 16bit fixed point arithmetic for
>> +	 * slots-in-metric = (MetricPct / 0xff) * val
>> +	 * This works fine for upto 48bit counters, but will
>> +	 * lose precision above that.
>> +	 */
>> +
>> +	metric = (cpuc->last_metric >> ((hwc->idx - INTEL_PMC_IDX_FIXED_METRIC_BASE)*8)) & 0xff;
>> +	last = (((metric * 0xffff) >> 8) * cpuc->last_slots) >> 16;
> 
> How is that cpuc->last_* crap not broken for NMIs ?

There should be no NMI for slots or metric events at the moment, because 
the MSR_PERF_METRICS and MSR_CORE_PERF_FIXED_CTR3 are reset in first read.
Other NMIs will not touch the codes here.

Thanks,
Kan

> 
>> +
>> +	metric = (newval >> ((hwc->idx - INTEL_PMC_IDX_FIXED_METRIC_BASE)*8)) & 0xff;
>> +	new = (((metric * 0xffff) >> 8) * slots_val) >> 16;
>> +
>> +	return (new - last);
>> +}
> 
> 
> This is diguisting.. and unreadable.
> 
> mul_u64_u32_shr() is actually really fast, use it.
> 
