Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0119DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D603C23A83
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE2Olw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:41:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:22072 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2Olw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:41:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:41:51 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 29 May 2019 07:41:51 -0700
Received: from [10.251.0.80] (kliang2-mobl.ccr.corp.intel.com [10.251.0.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 98C95580258;
        Wed, 29 May 2019 07:41:50 -0700 (PDT)
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528133022.GX2606@hirez.programming.kicks-ass.net>
 <a3722bae-9506-21f0-7e6e-a85217313bf8@linux.intel.com>
 <20190529073421.GZ2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8ef9f52d-0ec6-8093-d1ea-ffa3450699fa@linux.intel.com>
Date:   Wed, 29 May 2019 10:41:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529073421.GZ2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2019 3:34 AM, Peter Zijlstra wrote:
>>>> +			wrmsrl(MSR_PERF_METRICS, 0);
>>>> +			wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
>>> I don't get this, overflow happens on when we flip sign, so why is
>>> programming 0 a sane thing to do?
>> Reset the counters (programming 0) don't trigger overflow.
> Right, so why then do you allow creating this thing as
> is_sampling_event() ?

Perf metrics event doesn't support sampling.
SLOTs/FIXED3 event + Perf metrics event don't support sampling either.

Only the case SLOTs/FIXED3 event without Perf metrics events support 
sampling. But the case doesn't reach this code path. It is handled by 
the normal routing, like other sampling events.

So there is no sampling event in this code path.

> 
>> We have to reset both registers for each read to avoid the known
>> PERF_METRICS issue.
> 'the known PERF_METRICS issue' is unknown to me and any other reader.
> 
>>>> +	metric = (cpuc->last_metric >> ((hwc->idx - INTEL_PMC_IDX_FIXED_METRIC_BASE)*8)) & 0xff;
>>>> +	last = (((metric * 0xffff) >> 8) * cpuc->last_slots) >> 16;
>>> How is that cpuc->last_* crap not broken for NMIs ?
>> There should be no NMI for slots or metric events at the moment, because the
>> MSR_PERF_METRICS and MSR_CORE_PERF_FIXED_CTR3 are reset in first read.
>> Other NMIs will not touch the codes here.
> What happens if someone does: read(perf_fd) and then has the NMI hit?

Right, it looks like there is a corner case we cannot handle. The NMI 
hit can happen right after rdpmcl, but before reset.

My current thought is to disable the METRICS and SLOTs counter for first 
read. I will think about it.

Thanks,
Kan

