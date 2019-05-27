Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34743C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2BA208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfE0SdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:33:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:22033 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfE0SdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:33:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 11:33:11 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 27 May 2019 11:33:11 -0700
Received: from [10.251.8.20] (kliang2-mobl.ccr.corp.intel.com [10.251.8.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 62C65580434;
        Mon, 27 May 2019 11:33:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf/x86: Disable non generic regs for software/probe
 events
To:     Ingo Molnar <mingo@kernel.org>
Cc:     vincent.weaver@maine.edu, ak@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@redhat.com, eranian@google.com, linux-kernel@vger.kernel.org
References: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
 <20190525084808.GA15802@gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <85585e79-612c-f667-dc2a-e4b589d13778@linux.intel.com>
Date:   Mon, 27 May 2019 14:33:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190525084808.GA15802@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/2019 4:48 AM, Ingo Molnar wrote:
> 
> * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> 
>> @@ -57,6 +57,11 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
>>   #endif
>>   };
>>   
>> +u64 non_generic_regs_mask(void)
>> +{
>> +	return (~((1ULL << PERF_REG_X86_XMM0) - 1));
>> +}
>> +
>>   u64 perf_reg_value(struct pt_regs *regs, int idx)
>>   {
>>   	struct x86_perf_regs *perf_regs;
>> diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
>> index 4767474..c1c3454 100644
>> --- a/include/linux/perf_regs.h
>> +++ b/include/linux/perf_regs.h
>> @@ -9,6 +9,8 @@ struct perf_regs {
>>   	struct pt_regs	*regs;
>>   };
>>   
>> +u64 non_generic_regs_mask(void);
> 
> This is a *constant* value, why is it in a separate function, not an
> inline?
> 
> Or rather, since it's obviously a constant, name it in such a way.
> (PERF_REG_X86_NON_GENERIC_MASK or so. >
> To the generic code define it as 0 if arch headers haven't overriden it.
>

I will name it PERF_REG_NON_GENERIC_MASK in generic code.

Perf tool also defined a similar macro. I think I will define 
PERF_REG_NON_GENERIC_MASK in X86 uapi header. So both kernel and user 
space can use it.

I will send out V2 to address all comments.

Thanks,
Kan

>> +u64 __weak non_generic_regs_mask(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline bool has_non_generic_regs(struct perf_event *event)
>> +{
>> +	u64 mask = non_generic_regs_mask();
>> +
>> +	return ((event->attr.sample_regs_user & mask) ||
>> +		(event->attr.sample_regs_intr & mask));
> 
> 'return' is not a function ...
> 
>> +	/* only support generic regs */
>> +	if (has_non_generic_regs(event))
>> +		return -EOPNOTSUPP;
> 
> In human readable comments please use complete sentences with no
> unnecessary abbreviations, i.e. "Only support generic registers".
> 
> Thanks,
> 
> 	Ingo
> 
