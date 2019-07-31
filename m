Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8983120693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfGaN4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:56:40 -0400
Received: from foss.arm.com ([217.140.110.172]:47626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfGaN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:56:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA3BE344;
        Wed, 31 Jul 2019 06:56:38 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20BCA3F694;
        Wed, 31 Jul 2019 06:56:38 -0700 (PDT)
Subject: Re: [PATCH] Function stack size and its name mismatch in arm64
To:     Jiping Ma <jiping.ma2@windriver.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190731090437.19867-1-jiping.ma2@windriver.com>
 <20190731065755.5f5bd8a0@gandalf.local.home>
From:   James Morse <james.morse@arm.com>
Message-ID: <9556feaa-cf38-c101-ed82-2112ea011a88@arm.com>
Date:   Wed, 31 Jul 2019 14:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190731065755.5f5bd8a0@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiping,

(CC: +linux-arm-kernel)

On 31/07/2019 11:57, Steven Rostedt wrote:
> On Wed, 31 Jul 2019 17:04:37 +0800
> Jiping Ma <jiping.ma2@windriver.com> wrote:

> Note, the subject is not properly written, as it is missing the
> subsystem. In this case, it should start with "tracing: "
> 
> 
>> The PC of one the frame is matched to the next frame function, rather
>> than the function of his frame.
> 
> The above change log doesn't make sense. I have no idea what the actual
> problem is here. Why is this different for arm64 and no one else? Seems
> the bug is with the stack logic code in arm64 not here.

Please copy the mailing list for the arm64 arch code too.

Is this thing a recent change? arm64's stacktrace code gained some better protection for
loops at -rc2.


Thanks,

James


>> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
>> index 5d16f73898db..ed80b95abf06 100644
>> --- a/kernel/trace/trace_stack.c
>> +++ b/kernel/trace/trace_stack.c
>> @@ -40,16 +40,28 @@ static void print_max_stack(void)
>>  
>>  	pr_emerg("        Depth    Size   Location    (%d entries)\n"
>>  			   "        -----    ----   --------\n",
>> +#ifdef CONFIG_ARM64
> 
> We do not allow arch specific defines in generic code. Otherwise this
> would blow up and become unmaintainable. Not to mention it makes the
> code ugly and hard to follow.
> 
> Please explain the problem better. I'm sure there's much better ways to
> solve this than this patch.
> 
> Thanks,
> 
> -- Steve
> 
> 
> 
>> +			   stack_trace_nr_entries - 1);
>> +#else
>>  			   stack_trace_nr_entries);
>> -
>> +#endif
>> +#ifdef CONFIG_ARM64
>> +	for (i = 1; i < stack_trace_nr_entries; i++) {
>> +#else
>>  	for (i = 0; i < stack_trace_nr_entries; i++) {
>> +#endif
>>  		if (i + 1 == stack_trace_nr_entries)
>>  			size = stack_trace_index[i];
>>  		else
>>  			size = stack_trace_index[i] - stack_trace_index[i+1];
>>  
>> +#ifdef CONFIG_ARM64
>> +		pr_emerg("%3ld) %8d   %5d   %pS\n", i-1, stack_trace_index[i],
>> +				size, (void *)stack_dump_trace[i-1]);
>> +#else
>>  		pr_emerg("%3ld) %8d   %5d   %pS\n", i, stack_trace_index[i],
>>  				size, (void *)stack_dump_trace[i]);
>> +#endif
>>  	}
>>  }
>>  
>> @@ -324,8 +336,11 @@ static int t_show(struct seq_file *m, void *v)
>>  		seq_printf(m, "        Depth    Size   Location"
>>  			   "    (%d entries)\n"
>>  			   "        -----    ----   --------\n",
>> +#ifdef CONFIG_ARM64
>> +			   stack_trace_nr_entries - 1);
>> +#else
>>  			   stack_trace_nr_entries);
>> -
>> +#endif
>>  		if (!stack_tracer_enabled && !stack_trace_max_size)
>>  			print_disabled(m);
>>  
>> @@ -334,6 +349,10 @@ static int t_show(struct seq_file *m, void *v)
>>  
>>  	i = *(long *)v;
>>  
>> +#ifdef CONFIG_ARM64
>> +	if (i == 0)
>> +		return 0;
>> +#endif
>>  	if (i >= stack_trace_nr_entries)
>>  		return 0;
>>  
>> @@ -342,9 +361,14 @@ static int t_show(struct seq_file *m, void *v)
>>  	else
>>  		size = stack_trace_index[i] - stack_trace_index[i+1];
>>  
>> +#ifdef CONFIG_ARM64
>> +	seq_printf(m, "%3ld) %8d   %5d   ", i-1, stack_trace_index[i], size);
>> +	trace_lookup_stack(m, i-1);
>> +#else
>>  	seq_printf(m, "%3ld) %8d   %5d   ", i, stack_trace_index[i], size);
>>  
>>  	trace_lookup_stack(m, i);
>> +#endif
>>  
>>  	return 0;
>>  }
> 

