Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A602C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF7F208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfE1SZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:25:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:64042 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1SZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:25:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 11:24:58 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2019 11:24:58 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 99E4B580372;
        Tue, 28 May 2019 11:24:57 -0700 (PDT)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528134845.GQ2623@hirez.programming.kicks-ass.net>
Message-ID: <2d693635-9697-2cf5-54dc-b91da4dfd14f@linux.intel.com>
Date:   Tue, 28 May 2019 14:24:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528134845.GQ2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 9:48 AM, Peter Zijlstra wrote:
> On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index b980b9e95d2a..0d7081434d1d 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -133,6 +133,11 @@ struct hw_perf_event {
>>   
>>   			struct hw_perf_event_extra extra_reg;
>>   			struct hw_perf_event_extra branch_reg;
>> +
>> +			u64		saved_metric;
>> +			u64		saved_slots;
>> +			u64		last_slots;
>> +			u64		last_metric;
> 
> This is really sad, and I'm thinking much of that really isn't needed
> anyway, due to how you're not using some of the other fields.

If we don't cache the value, we have to update all metrics events when 
reading any metrics event. I think that could bring high overhead.

Thanks,
Kan
> 
>>   		};
>>   		struct { /* software */
>>   			struct hrtimer	hrtimer;
>> -- 
>> 2.14.5
>>
