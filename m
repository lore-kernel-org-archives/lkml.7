Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4286C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD173217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH1TfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:35:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:11689 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1TfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:35:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 12:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="175025884"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2019 12:35:04 -0700
Received: from [10.254.95.196] (kliang2-mobl.ccr.corp.intel.com [10.254.95.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CA4BB580107;
        Wed, 28 Aug 2019 12:35:03 -0700 (PDT)
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828150238.GC17205@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9e5f9292-9767-d17a-2223-37dff9e759c7@linux.intel.com>
Date:   Wed, 28 Aug 2019 15:35:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828150238.GC17205@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2019 11:02 AM, Peter Zijlstra wrote:
>> Reset
>> ======
>>
>> The PERF_METRICS and Fixed counter 3 have to be reset for each read,
>> because:
>> - The 8bit metrics ratio values lose precision when the measurement
>>    period gets longer.
> So it musn't be too hot,
> 
>> - The PERF_METRICS may report wrong value if its delta was less than
>>    1/255 of SLOTS (Fixed counter 3).

The "delta" is actually for the internal counters. Sorry for the
confusion.

> it also musn't be too cold. But that leaves it unspecified what exactly
> is the right range.
> 
> IOW, you want a Goldilocks number of SLOTS.
> 
>> Also, for counting, the -max_period is the initial value of the SLOTS.
>> The huge initial value will definitely trigger the issue mentioned
>> above. Force initial value as 0 for topdown and slots event counting.
> But you just told us that 0 is wrong too (too cold).

We set -max_period (0x8000 0000 0001) as initial value of FIXCTR3 for 
counting. But the internal counters probably starts counting from 0.
PERF_METRICS is fraction of internal counters / FIXCTR3.
So PERF_METRICS will never works.
We have to make FIXCTR3 count from 0 as well.

Thanks,
Kan
