Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E74523A84
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfE2Okz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:40:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:21994 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2Oky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:40:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:40:54 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 29 May 2019 07:40:54 -0700
Received: from [10.251.0.80] (kliang2-mobl.ccr.corp.intel.com [10.251.0.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 596C758054E;
        Wed, 29 May 2019 07:40:53 -0700 (PDT)
Subject: Re: [PATCH 2/9] perf/x86/intel: Basic support for metrics counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-3-kan.liang@linux.intel.com>
 <20190528121508.GS2606@hirez.programming.kicks-ass.net>
 <991ef247-8efe-bc21-a988-3d628733d915@linux.intel.com>
 <20190529072855.GX2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <dfaeb4b4-bf49-593d-b9e4-33dd8c050d4e@linux.intel.com>
Date:   Wed, 29 May 2019 10:40:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529072855.GX2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2019 3:28 AM, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 02:21:49PM -0400, Liang, Kan wrote:
>>
>>
>> On 5/28/2019 8:15 AM, Peter Zijlstra wrote:
>>> On Tue, May 21, 2019 at 02:40:48PM -0700, kan.liang@linux.intel.com wrote:
>>>> +/*
>>>> + * We model PERF_METRICS as more magic fixed-mode PMCs, one for each metric
>>>> + * and another for the whole slots counter
>>>> + *
>>>> + * Internally they all map to Fixed Ctr 3 (SLOTS), and allocate PERF_METRICS
>>>> + * as an extra_reg. PERF_METRICS has no own configuration, but we fill in
>>>> + * the configuration of FxCtr3 to enforce that all the shared users of SLOTS
>>>> + * have the same configuration.
>>>> + */
>>>> +#define INTEL_PMC_IDX_FIXED_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 17)
>>>> +#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 0)
>>>> +#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 1)
>>>> +#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 2)
>>>> +#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 3)
>>>> +#define INTEL_PMC_MSK_ANY_SLOTS			((0xfull << INTEL_PMC_IDX_FIXED_METRIC_BASE) | \
>>>> +						 INTEL_PMC_MSK_FIXED_SLOTS)
>>>> +static inline bool is_metric_idx(int idx)
>>>> +{
>>>> +	return idx >= INTEL_PMC_IDX_FIXED_METRIC_BASE && idx <= INTEL_PMC_IDX_TD_BE_BOUND;
>>>> +}
>>>
>>> Something like:
>>>
>>> 	return (idx >> INTEL_PMC_IDX_FIXED_METRIC_BASE) & 0xf;
>>>
>>> might be faster code... (if it wasn't for 64bit literals being a pain,
>>> it could be a simple test instruction).
>>>
>>
>> is_metric_idx() is not a mask. It's to check if the idx between 49 and 52.
> 
> blergh, indeed. Check that it compiles into a single branch though, if
> it gets that wrong it needs hand holding.
> 
> One way would be to make these 48-51 and put BTS as 52, and then you do

Can we put BTS 47?
Now we only support L1 Topdown metrics. Probably there will be L2 
Topdown metrics. I think we need some space to extend.


Thanks,
Kan

> have a mask.
> 
> Another way would be to write it as:
> 
> 	(unsigned)(idx - INTEL_PMC_IDX_FIXED_METRIC_BASE) < 4;
> 
> 
