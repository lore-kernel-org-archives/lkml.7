Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C846C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B53921473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfDHPqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:46:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:10486 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfDHPqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:46:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 08:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="149048078"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 08:46:01 -0700
Received: from [10.254.87.204] (kliang2-mobl.ccr.corp.intel.com [10.254.87.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A8FD55807A0;
        Mon,  8 Apr 2019 08:46:00 -0700 (PDT)
Subject: Re: [PATCH V5 08/12] perf/x86/intel: Add Icelake support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190402194509.2832-9-kan.liang@linux.intel.com>
 <20190408150654.GV12232@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4ff8fec9-fb41-b11d-b7ed-4c716b558adc@linux.intel.com>
Date:   Mon, 8 Apr 2019 11:45:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408150654.GV12232@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2019 11:06 AM, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 12:45:05PM -0700, kan.liang@linux.intel.com wrote:
>> +static struct event_constraint *
>> +icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>> +			  struct perf_event *event)
>> +{
>> +	/*
>> +	 * Fixed counter 0 has less skid.
>> +	 * Force instruction:ppp in Fixed counter 0
>> +	 */
>> +	if ((event->attr.precise_ip == 3) &&
>> +	    ((event->hw.config & X86_RAW_EVENT_MASK) == 0x00c0))
>> +		return &fixed_counter0_constraint;
> 
> Does that want to be:
> 
> 		event->hw.config == X86_CONFIG(.event=0xc0)
> 
> ?
> 
> That is, are there really bits we want to mask in there?

For instruction event, right, we don't need mask it.
I will change it.

Thanks,
Kan

> 
>> +
>> +	return hsw_get_event_constraints(cpuc, idx, event);
>> +}
