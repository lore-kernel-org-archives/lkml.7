Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE132084A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfFDKM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:12:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42997 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfFDKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:12:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so8050316wrj.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 03:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=um8w67w6LCCsT/DE9snQkkvxxZYU83IofxVrJcLAJG0=;
        b=dj4jGaaRWKIYULybOblXCZOtUr7fy2Vq1eHI6heDrbSkqaTsRFC/G+DE9a7AJSZUB6
         EAHXLNffMIiy1t8ysusi8A0hpey1Q7AkUDtqtwGzA6UqRq4VGalN8E7sMiHoq0PUjs0T
         dcbR5WGr9lAl6g0rwxdnG1uT3wFgR76dvXKN0/LoF77GW3bZTmrBaoKvkKiTmNMC+ezi
         oNvrPVUrEoHADSSqRBUPs0ITpw2NGLSR9JqaeH1FSgLTqH7ZCS4keb9AmbJQvP/2V8c8
         PLjnXI3aEud42KAindupvSP/JEffX8r7mucGND+BXKHOKcVue81PwsenAPTCtlYhxDtR
         ePcQ==
X-Gm-Message-State: APjAAAXwBofidnZpN48GOEide0vROBLXv13repp6snalU22AbohbUjAS
        6vim9hGgMikgttxkjU5HevtO/Q==
X-Google-Smtp-Source: APXvYqysysYFV8pNSuW6aoEX5F5E5f6lPRUrjBSYHLBZXWplX7+pNvtU7Q3yZEBCXKa37b0Vt63Q6Q==
X-Received: by 2002:adf:ee0e:: with SMTP id y14mr18755685wrn.275.1559643172203;
        Tue, 04 Jun 2019 03:12:52 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([5.170.68.106])
        by smtp.gmail.com with ESMTPSA id h21sm14765898wmb.47.2019.06.04.03.12.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 03:12:51 -0700 (PDT)
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping due
 to a preempt_counter change
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
 <20190529083357.GF2623@hirez.programming.kicks-ass.net>
 <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
 <20190531074729.GA153831@google.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <3a17724b-f903-bc18-1a35-84efd3ea90c9@redhat.com>
Date:   Tue, 4 Jun 2019 12:12:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531074729.GA153831@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2019 09:47, Joel Fernandes wrote:
> On Wed, May 29, 2019 at 11:40:34AM +0200, Daniel Bristot de Oliveira wrote:
>> On 29/05/2019 10:33, Peter Zijlstra wrote:
>>> On Tue, May 28, 2019 at 05:16:23PM +0200, Daniel Bristot de Oliveira wrote:
>>>> The preempt_disable/enable tracepoint only traces in the disable <-> enable
>>>> case, which is correct. But think about this case:
>>>>
>>>> ---------------------------- %< ------------------------------
>>>> 	THREAD					IRQ
>>>> 	   |					 |
>>>> preempt_disable() {
>>>>     __preempt_count_add(1)
>>>> 	------->	    smp_apic_timer_interrupt() {
>>>> 				preempt_disable()
>>>> 				    do not trace (preempt count >= 1)
>>>> 				    ....
>>>> 				preempt_enable()
>>>> 				    do not trace (preempt count >= 1)
>>>> 			    }
>>>>     trace_preempt_disable();
>>>> }
>>>> ---------------------------- >% ------------------------------
>>>>
>>>> The tracepoint will be skipped.
>>>
>>> .... for the IRQ. But IRQs are not preemptible anyway, so what the
>>> problem?
>>
>>
>> right, they are.
>>
>> exposing my problem in a more specific way:
>>
>> To show in a model that an event always takes place with preemption disabled,
>> but not necessarily with IRQs disabled, it is worth having the preemption
>> disable events separated from IRQ disable ones.
>>
>> The main reason is that, although IRQs disabled postpone the execution of the
>> scheduler, it is more pessimistic, as it also delays IRQs. So the more precise
>> the model is, the less pessimistic the analysis will be.
>>
>> But there are other use-cases, for instance:
>>
>> (Steve, correct me if I am wrong)
>>
>> The preempt_tracer will not notice a "preempt disabled" section in an IRQ
>> handler if the problem above happens.
>>
>> (Yeah, I know these problems are very specific... but...)
> 
> I agree with the problem. I think Daniel does not want to miss the preemption
> disabled event caused by the IRQ disabling.

Hi Joel!

Correct, but ... look bellow.

>>>> To avoid skipping the trace, the change in the counter should be "atomic"
>>>> with the start/stop, w.r.t the interrupts.
>>>>
>>>> Disable interrupts while the adding/starting stopping/subtracting.
>>>
>>>> +static inline void preempt_add_start_latency(int val)
>>>> +{
>>>> +	unsigned long flags;
>>>> +
>>>> +	raw_local_irq_save(flags);
>>>> +	__preempt_count_add(val);
>>>> +	preempt_latency_start(val);
>>>> +	raw_local_irq_restore(flags);
>>>> +}
>>>
>>>> +static inline void preempt_sub_stop_latency(int val)
>>>> +{
>>>> +	unsigned long flags;
>>>> +
>>>> +	raw_local_irq_save(flags);
>>>> +	preempt_latency_stop(val);
>>>> +	__preempt_count_sub(val);
>>>> +	raw_local_irq_restore(flags);
>>>> +}
>>>
>>> That is hideously expensive :/
>>
>> Yeah... :-( Is there another way to provide such "atomicity"?
>>
>> Can I use the argument "if one has these tracepoints enabled, they are not
>> considering it as a hot-path?"
> 
> The only addition here seems to  the raw_local_irq_{save,restore} around the
> calls to increment the preempt counter and start the latency tracking.
> 
> Is there any performance data with the tracepoint enabled and with/without
> this patch? Like with hackbench?

I discussed this with Steve at the Summit on the Summit (the reason why I did
not reply this email earlier is because I was in the conf/traveling), and he
also agrees with peterz, disabling and (mainly) re-enabling IRQs costs too much.

We need to find another way to resolve this problem (or mitigate the cost).... :-(.

Ideas?

Thanks!!

-- Daniel
