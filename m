Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF0EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ED42070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfE2Jko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:40:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43681 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2Jkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:40:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id l17so1209588wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0hlqpO7DoKf0qS7cy3GbaeQGV5MXFN+9TtToWsTFR4=;
        b=Uo1WZSoyhUVGRj2+3MOJxfJXM+P7v0LSEDHlcQSFGEhHHPCaoqk1454kY5k+dzExg9
         us2AtiZjrMNOPDi64X95de+ylMMtOL6qNtz3pQUP52aPgOW94RuGLiVmLDp8+g0VPYAh
         6Mi0M2qTjKFeF6Mfc8gdi0Cp75PrGNfrrNxS0MNa5laFBesch2XEdoI2trSj8VP9p+kU
         DU/WPlQ5+bPV907ofgyW8fIOLZXl5I8bF1IQGA8sxmXbXEH87c1yJVE+GFIF20Ga0kT5
         RQn5VL2hIaKWCJhqeCJJYdMd9e1Ub8ulDQbynjSwcboBJ/xCCoA9If0IeDnHej8BR0R7
         uqDQ==
X-Gm-Message-State: APjAAAUUrheAjiwhxS16IxaXvZTLvFr6FO5P76B85ln41J/bWULnRTc/
        Eawrys8po8JYBvfpIY+eaYEN8A==
X-Google-Smtp-Source: APXvYqyRIrS086KqDZkfV5shjvt8JPfS49t4cis64k1qznhZfvFuYib2I/GTimQKUmJBe4apkmsFfQ==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr6276933wrp.6.1559122836612;
        Wed, 29 May 2019 02:40:36 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id f3sm2461336wre.93.2019.05.29.02.40.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:40:35 -0700 (PDT)
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping due
 to a preempt_counter change
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
 <20190529083357.GF2623@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
Date:   Wed, 29 May 2019 11:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529083357.GF2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2019 10:33, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 05:16:23PM +0200, Daniel Bristot de Oliveira wrote:
>> The preempt_disable/enable tracepoint only traces in the disable <-> enable
>> case, which is correct. But think about this case:
>>
>> ---------------------------- %< ------------------------------
>> 	THREAD					IRQ
>> 	   |					 |
>> preempt_disable() {
>>     __preempt_count_add(1)
>> 	------->	    smp_apic_timer_interrupt() {
>> 				preempt_disable()
>> 				    do not trace (preempt count >= 1)
>> 				    ....
>> 				preempt_enable()
>> 				    do not trace (preempt count >= 1)
>> 			    }
>>     trace_preempt_disable();
>> }
>> ---------------------------- >% ------------------------------
>>
>> The tracepoint will be skipped.
> 
> .... for the IRQ. But IRQs are not preemptible anyway, so what the
> problem?


right, they are.

exposing my problem in a more specific way:

To show in a model that an event always takes place with preemption disabled,
but not necessarily with IRQs disabled, it is worth having the preemption
disable events separated from IRQ disable ones.

The main reason is that, although IRQs disabled postpone the execution of the
scheduler, it is more pessimistic, as it also delays IRQs. So the more precise
the model is, the less pessimistic the analysis will be.

But there are other use-cases, for instance:

(Steve, correct me if I am wrong)

The preempt_tracer will not notice a "preempt disabled" section in an IRQ
handler if the problem above happens.

(Yeah, I know these problems are very specific... but...)

>> To avoid skipping the trace, the change in the counter should be "atomic"
>> with the start/stop, w.r.t the interrupts.
>>
>> Disable interrupts while the adding/starting stopping/subtracting.
> 
>> +static inline void preempt_add_start_latency(int val)
>> +{
>> +	unsigned long flags;
>> +
>> +	raw_local_irq_save(flags);
>> +	__preempt_count_add(val);
>> +	preempt_latency_start(val);
>> +	raw_local_irq_restore(flags);
>> +}
> 
>> +static inline void preempt_sub_stop_latency(int val)
>> +{
>> +	unsigned long flags;
>> +
>> +	raw_local_irq_save(flags);
>> +	preempt_latency_stop(val);
>> +	__preempt_count_sub(val);
>> +	raw_local_irq_restore(flags);
>> +}
> 
> That is hideously expensive :/

Yeah... :-( Is there another way to provide such "atomicity"?

Can I use the argument "if one has these tracepoints enabled, they are not
considering it as a hot-path?"

-- Daniel
