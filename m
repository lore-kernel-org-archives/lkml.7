Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D977216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfE1SU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:20:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:59756 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727752AbfE1SU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:20:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 11:20:55 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2019 11:20:55 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7C994580372;
        Tue, 28 May 2019 11:20:54 -0700 (PDT)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 2/9] perf/x86/intel: Basic support for metrics counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-3-kan.liang@linux.intel.com>
 <20190528120528.GR2606@hirez.programming.kicks-ass.net>
Message-ID: <ee07aed8-eb57-4b01-11de-ed357dd96455@linux.intel.com>
Date:   Tue, 28 May 2019 14:20:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528120528.GR2606@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 8:05 AM, Peter Zijlstra wrote:
> On Tue, May 21, 2019 at 02:40:48PM -0700, kan.liang@linux.intel.com wrote:
>> From: Andi Kleen <ak@linux.intel.com>
>>
>> Metrics counters (hardware counters containing multiple metrics)
>> are modeled as separate registers for each TopDown metric events,
>> with an extra reg being used for coordinating access to the
>> underlying register in the scheduler.
>>
>> This patch adds the basic infrastructure to separate the scheduler
>> register indexes from the actual hardware register indexes. In
>> most cases the MSR address is already used correctly, but for
>> code using indexes we need a separate reg_idx field in the event
>> to indicate the correct underlying register.
> 
> That doesn't parse. What exactly is the difference between reg_idx and
> idx? AFAICT there is a fixed relation like:
> 
>    reg_idx = is_metric_idx(idx) ? INTEL_PMC_IDX_FIXED_SLOTS : idx;
> 
> Do we really need a variable for that?

It may save the calculation. But, right, a variable is not necessary.

> 
> Also, why do we need that whole enabled_events[] array. Do we really not
> have that information elsewhere?

No. We don't have a case that several events share a counter at the same 
time. We don't need to check if other events are enabled when we try to 
disable a counter. So we don't save such information.
But we have to do it for metrics events.

Thanks,
Kan
> 
> I shouldn've have to reverse engineer patches :/
> 
