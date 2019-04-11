Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E09C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6790021850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDKNaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:30:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:63445 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfDKNaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:30:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 06:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,337,1549958400"; 
   d="scan'208";a="160287908"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2019 06:30:12 -0700
Received: from [10.254.82.195] (kliang2-mobl.ccr.corp.intel.com [10.254.82.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C9C495805FC;
        Thu, 11 Apr 2019 06:30:11 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] perf/x86/intel: Add Tremont core PMU support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <1554922629-126287-1-git-send-email-kan.liang@linux.intel.com>
 <1554922629-126287-3-git-send-email-kan.liang@linux.intel.com>
 <20190411090658.GD4038@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9ef797ad-bce6-2883-8245-20bdf0b79142@linux.intel.com>
Date:   Thu, 11 Apr 2019 09:30:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411090658.GD4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2019 5:06 AM, Peter Zijlstra wrote:
> On Wed, Apr 10, 2019 at 11:57:09AM -0700, kan.liang@linux.intel.com wrote:
>> +static struct event_constraint *
>> +tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>> +			  struct perf_event *event)
> 
> That 'tnt' still cracks me up, I keep seeing explosions.
>

Boom!

>> +{
>> +	struct event_constraint *c;
>> +
>> +	/*
>> +	 * :ppp means to do reduced skid PEBS,
>> +	 * which is available on PMC0 and fixed counter 0.
>> +	 */
>> +	if (event->attr.precise_ip == 3) {
>> +		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
>> +		if (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0))
>> +			return &fixed0_counter0_constraint;
>> +
>> +		return &counter0_constraint;
>> +	}
>> +
>> +	c = intel_get_event_constraints(cpuc, idx, event);
>> +
>> +	return c;
>> +}
> 
> I changed that like so:
> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3508,7 +3508,7 @@ tnt_get_event_constraints(struct cpu_hw_
>   	 */
>   	if (event->attr.precise_ip == 3) {
>   		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
> -		if (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0))
> +		if (constraint_match(&fixed_counter0_constraint, event->hw.config))

Should be
	if (constraint_match(&fixed0_counter0_constraint, event->hw.config))
>   			return &fixed0_counter0_constraint;
>   
>   		return &counter0_constraint;
> 
> 
> And maybe we should do:
> 
> 	s/fixed_counter0_constraint/fixed0_constraint/'
>

Yes, definitely. It has already caused confusions. :)

Thanks,
Kan

> Those two constraints only differ by a single character, that's bad for
> reading comprehension.
> 
> In fact, I just did that too.
> 
