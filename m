Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97017C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B94F215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqqt0ID8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfJBWoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:44:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34897 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBWoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:44:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so945258qtq.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P9vWiQXgrDlBXpnBxobaf+Tbpshfo8D3HLUgOjExiac=;
        b=sqqt0ID8gCQiXbjzMSa6aLUVclfyqYQRP50Sfgv4udwjTcoEVdUVy1VAyCHPZjlQNR
         FR+pC+Y9kSw/XxIN60oRsOb5r8HLDs620BgsuvoH0UkiUbRlFjF5AheQNB3Niqa8X5Qp
         9RfkSQhbNhMYEc7q5bN6c8KqhOJQOzVGSxN9nWEmkzIbbhf6plh5u6kp1qjbN7ZzG74L
         an9ACtSSW5kojxXhE2dhAygMq6HG5TEyfozuElF4a+f00F91iUeFKenQWPH8ckbuQ9Zd
         4e83I/hxIYCEfD7R6dRhB/ciEZzL+PoPtGbDKrVPdnvwgP/8w9sN3MaFcgChICnPceo7
         2XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P9vWiQXgrDlBXpnBxobaf+Tbpshfo8D3HLUgOjExiac=;
        b=GVp3nnTuJjD7SDCVBnL/uT4+s0+W9kiVdisQTFD3+zH7kdsOV41WkagiYrnL+Eh/jS
         VdK+ynyw4gE7d9OJ5uyA8UH+TNFQ1vXsAxjEQRByHxJGCAu0wPLswT096kVE1f2Fe2W/
         ZA1VX0hLog6CB/DrZkf+QlzT1GB4cxoPoRNOeQgjsWoJd2zWaOV9MWnpj7anqPJSo7gw
         1LOffc1Y2hg24GEiSUNkvq2/ZtU6/SdkeOlg9d7KHrBI1Uqiy7XDIuizGRF4bsiBlI57
         675Ge54rvRIf9C1IWFBFOMdc/Lt9lzlt86Lu/9X39LPhZN+UV/QJA4giELQWMaokNyN+
         L9qg==
X-Gm-Message-State: APjAAAVZ9y+V/irlD/H99gmGhjsTS6+bdfOY8vgQJNPh13kJIzzW4RtU
        AQtAqLXTT2zimUtpCL/wBNkPYsc=
X-Google-Smtp-Source: APXvYqxR9RLBS5l1e6kHEyN/Fq3F66/w3/6BWA1VEHTmqcDVOBVJfnE6rYQBpalaVu/ZpZF5/WIp9w==
X-Received: by 2002:ac8:36c7:: with SMTP id b7mr7003720qtc.275.1570056252604;
        Wed, 02 Oct 2019 15:44:12 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.179.41])
        by smtp.googlemail.com with ESMTPSA id m125sm359754qkd.3.2019.10.02.15.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 15:44:11 -0700 (PDT)
Subject: Re: [PATCH v7 4/4] ftrace: Add an option for tracing console
 latencies
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
 <20190920152219.12920-5-viktor.rosendahl@gmail.com>
 <20191002005244.GC161396@google.com>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <c34eb6e7-18c4-84b5-1fe5-74320dc36a25@gmail.com>
Date:   Thu, 3 Oct 2019 00:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002005244.GC161396@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 2:52 AM, Joel Fernandes wrote:
> On Fri, Sep 20, 2019 at 05:22:19PM +0200, Viktor Rosendahl (BMW) wrote:
>> This new trace option "console-latency" will enable the latency
>> tracers to trace the console latencies. Previously this has always been
>> implicitely disabled. I guess this is because they are considered
>> to be well known and unavoidable.
>>
>> However, for some organizations it may nevertheless be desirable to
>> trace them. Basically, we want to be able to tell that there are
>> latencies in the system under test because someone has incorrectly
>> enabled the serial console.
>>
>> Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
>> ---
>>   include/linux/irqflags.h     | 22 ++++++++++++++++++++++
>>   kernel/printk/printk.c       |  6 ++++--
>>   kernel/trace/trace.h         |  1 +
>>   kernel/trace/trace_irqsoff.c | 12 ++++++++++++
>>   4 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
>> index 21619c92c377..3de891723331 100644
>> --- a/include/linux/irqflags.h
>> +++ b/include/linux/irqflags.h
>> @@ -13,6 +13,7 @@
>>   #define _LINUX_TRACE_IRQFLAGS_H
>>   
>>   #include <linux/typecheck.h>
>> +#include <linux/types.h>
>>   #include <asm/irqflags.h>
>>   
>>   /* Currently trace_softirqs_on/off is used only by lockdep */
>> @@ -68,9 +69,30 @@ do {						\
>>   	defined(CONFIG_PREEMPT_TRACER)
>>    extern void stop_critical_timings(void);
>>    extern void start_critical_timings(void);
>> + extern bool console_tracing_disabled(void);
>> +
>> +# define console_stop_critical_timings(flag)		\
>> +	do {						\
>> +		typecheck(bool, flag);			\
>> +		flag = console_tracing_disabled();	\
>> +		if (flag)				\
>> +			stop_critical_timings();	\
>> +	} while (0)
>> +
>> +# define console_start_critical_timings(flag)		 \
>> +	do {						 \
>> +		typecheck(bool, flag);			 \
>> +		if (flag)				 \
>> +			start_critical_timings();	 \
>> +	} while (0)
>> +
>>   #else
>>   # define stop_critical_timings() do { } while (0)
>>   # define start_critical_timings() do { } while (0)
>> +# define console_stop_critical_timings(flag)	\
>> +	do { typecheck(bool, flag); } while (0)
>> +# define console_start_critical_timings(flag)	\
>> +	do { typecheck(bool, flag); } while (0)
>>   #endif
>>   
>>   /*
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 1888f6a3b694..036460a7e4cd 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2359,6 +2359,7 @@ void console_unlock(void)
>>   	static char ext_text[CONSOLE_EXT_LOG_MAX];
>>   	static char text[LOG_LINE_MAX + PREFIX_MAX];
>>   	unsigned long flags;
>> +	bool cflag;
>>   	bool do_cond_resched, retry;
>>   
>>   	if (console_suspended) {
>> @@ -2459,9 +2460,10 @@ void console_unlock(void)
>>   		 */
>>   		console_lock_spinning_enable();
>>   
>> -		stop_critical_timings();	/* don't trace print latency */
>> +		/* don't trace print latency if it's disabled */
>> +		console_stop_critical_timings(cflag);
>>   		call_console_drivers(ext_text, ext_len, text, len);
>> -		start_critical_timings();
>> +		console_start_critical_timings(cflag);
>>   
>>   		if (console_lock_spinning_disable_and_check()) {
>>   			printk_safe_exit_irqrestore(flags);
>> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
>> index 4913ed1138aa..93a8b82c27e4 100644
>> --- a/kernel/trace/trace.h
>> +++ b/kernel/trace/trace.h
>> @@ -1262,6 +1262,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>>   		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
>>   		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
>>   		C(LATENCY_FMT,		"latency-format"),	\
>> +		C(CONSOLE_LATENCY,	"console-latency"),	\
>>   		C(RECORD_CMD,		"record-cmd"),		\
>>   		C(RECORD_TGID,		"record-tgid"),		\
>>   		C(OVERWRITE,		"overwrite"),		\
>> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
>> index a745b0cee5d3..bc02be207a7a 100644
>> --- a/kernel/trace/trace_irqsoff.c
>> +++ b/kernel/trace/trace_irqsoff.c
>> @@ -456,6 +456,18 @@ void stop_critical_timings(void)
>>   EXPORT_SYMBOL_GPL(stop_critical_timings);
>>   NOKPROBE_SYMBOL(stop_critical_timings);
>>   
>> +bool console_tracing_disabled(void)
>> +{
>> +	struct trace_array *tr = irqsoff_trace;
>> +	int pc = preempt_count();
>> +
>> +	if (!preempt_trace(pc) && !irq_trace())
>> +		return false;
> 
> Why this condition here? Why not just make the call to
> stop_critical_timings() dependent on the new flag you are adding? Please
> explain it more and add some comments.
> 

It is a kind of optimization for the common case, i.e. that the tracer
is not enabled.

The idea is that if the preemptirqsoff tracing is disabled, then the
question of whether or not to trace console latencies is moot and by
telling the caller that it is not disabled, we will prevent the caller
from making the calls to stop_critical_timings() and
start_critical_timings(). These calls would only return without doing
anything if the condition "!preempt_trace(pc) && !irq_trace()" is true,
since they use the inverse condition "preempt_trace(pc) || irq_trace()"
to test whether or not they should do anything.

I have to admit that this may be a useless micro optimization that
makes the code harder to understand and maintain for a benefit that
is so small that it would be hard to measure.

I feel a bit unsure whether I should try to improve it by adding a
comment, and perhaps putting the condition into a macro that
could then also be used by the start/stop_critical_timings() functions,
or if I should just get rid of the optimization. I guess this console
code is not a particularly hot code path anyway.

Please let me know what you think.

best regards,

Viktor

> thanks,
> 
>   - Joel
> 
> 
>> +
>> +	return !(tr->trace_flags & TRACE_ITER_CONSOLE_LATENCY);
>> +}
>> +EXPORT_SYMBOL_GPL(console_tracing_disabled);
>> +
>>   #ifdef CONFIG_FUNCTION_TRACER
>>   static bool function_enabled;
>>   
>> -- 
>> 2.17.1
>>

