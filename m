Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F529C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CD220854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfDJN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:58:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:60835 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbfDJN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:58:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="222233401"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2019 06:58:43 -0700
Received: from [10.251.26.102] (kliang2-mobl.ccr.corp.intel.com [10.251.26.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1FEEE5807A6;
        Wed, 10 Apr 2019 06:58:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf/x86/intel: Add Tremont core PMU support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
 <1554858600-148296-3-git-send-email-kan.liang@linux.intel.com>
 <20190410075138.GX11158@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <da0ac4a5-b749-ecaa-f1b1-aff164a1fec5@linux.intel.com>
Date:   Wed, 10 Apr 2019 09:58:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410075138.GX11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2019 3:51 AM, Peter Zijlstra wrote:
> On Tue, Apr 09, 2019 at 06:10:00PM -0700, kan.liang@linux.intel.com wrote:
> 
>> The generic purpose counter 0 and fixed counter 0 have less skid.
>> Force :ppp events on generic purpose counter 0.
>> Force instruction:ppp always on fixed counter 0.
> 
>> +static struct event_constraint *
>> +tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>> +			  struct perf_event *event)
>> +{
>> +	struct event_constraint *c;
>> +
>> +	/*
>> +	 * :ppp means to do reduced skid PEBS,
>> +	 * which is available at PMC0 and fixed counter 0.
>> +	 */
>> +	if (event->attr.precise_ip == 3) {
>> +		/* Force instruction:ppp in Fixed counter 0 */
>> +		if (event->hw.config == X86_CONFIG(.event=0xc0))
>> +			return &fixed_counter0_constraint;
>> +
>> +		return &counter0_constraint;
> 
> I'm confused, 0xc0 is the architectural 'instructions' event, surely we
> can program that on pmc0 too?
> 
> Did we want a fixed0_counter0_constraint for that?
> 

Yes, I will send out V2 shortly to fix it.

Thanks,
Kan
