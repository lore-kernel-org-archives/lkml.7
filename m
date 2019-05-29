Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A28C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3F822CD8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfE2Nvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:51:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50496 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfE2Nvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:51:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so1762072wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vg/VvyKLqoxgWb4CKGH7WmZ7Vk6qZmGWeyTHvk5Cqfg=;
        b=aItx+y+tgpWuFJTYHslFVHJmOJGY/MxdkIG0TCw20AOO4iq7Wkz1IME0zGwDuoSx9i
         91bJpvFRbKq5ieotVKbMj5PNlldIOhrcrMVSHQYBc6lRA6XQMyW0p1n4lkFZSAnLrKaM
         XfKQlIYrOTUGNSd+h/CfHP7nc3X63VtXlcZsKOwNuTDgUyS0Yc2D/kVZ3edoRaiuozSX
         vEKCFPKK3fjCIi2H+Gq5BzRflnmzdCKFup8cy4mT3HqtFfmFQWby73iA5ek7xuSPiq7T
         4xYIRG6k0UYsMFXiJaTBC/eb5GJg6MazfWaRbEuNhNpMNMz5AC4XOw/oOiyfFX/u2rKt
         Ly7w==
X-Gm-Message-State: APjAAAUqqrfnSSSlBljefQzVCiMogscfEwVsQAP0KI89z3OBP6TuBEAv
        /2R7K8PrxQamjWYnzX0PqWq8Wy1bFTE3yA==
X-Google-Smtp-Source: APXvYqy9PbaGnUE8PDR1PmNtaft2S9NelIh7ul179KU7wKCm1z3BqvGKJl5oOPGz7P3CTP2BWdU/wQ==
X-Received: by 2002:a1c:701a:: with SMTP id l26mr6704028wmc.32.1559137893136;
        Wed, 29 May 2019 06:51:33 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id w185sm6891106wma.39.2019.05.29.06.51.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:51:32 -0700 (PDT)
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
 <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
 <20190529102038.GO2623@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <94669b5a-06dd-e9bf-cfb6-b5d507a90946@redhat.com>
Date:   Wed, 29 May 2019 15:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529102038.GO2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2019 12:20, Peter Zijlstra wrote:
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
> 
> I'm not sure I follow, IRQs disabled fully implies !preemptible. I don't
> see how the model would be more pessimistic than reality if it were to
> use this knowledge.

Maybe I did not expressed myself well... and the example was not good either.

"IRQs disabled fully implies !preemptible" is a "to big" step. In modeling (or
mathematical reasoning?), a good practice is to break the properties into small
piece, and then build more complex reasoning/implications using these "small
properties."

Doing "big steps" makes you prone "miss interpretations", creating ambiguity.
Then, -RT people are prone to be pessimist, non-RT optimistic, and so on... and
that is what models try to avoid.

For instance, explaining this using words is contradictory:>
> Any !0 preempt_count(), which very much includes (Hard)IRQ and SoftIRQ
> counts, means non-preemptible.

One might argue that, the preemption of a thread always takes place with
preempt_count() != 0, because __schedule() is always called with preemption
disabled, so the preemption takes place while in non-preemptive.

A more elaborated example:

------------------ %< --------------------------
Thread A is running, and goes to sleep waiting for a timer...
	schedule() {
		preempt_disable();
		__schedule() {
			smp_apic_timer_interrupt() {
				sched_wakeup (Thread A);
				sched_wakeup (Thread B: highest prio) {
					sched_set_need_resched();
				}
			}
			local_irq_disable()
			context switch to B, A leaves in state=R.
------------------ %< --------------------------

In this case, the thread A suffered a "preemption" with "!0 preempt_count()"

The fact is, Linux does not fit straight in the "well known terminology" of
academic papers because many of those terminology bases in the fact that
operations are atomic. But they are not and Linux has some behaviors that
desires new terminology/interpretation...

- WAIT But you (daniel) wants to fake the atomicity between preempt_disable and
its tracepoint!

Yes, I do, but this is a very straightforward step/assumption: the atomicity is
about the real-event and the tracepoint that notifies it. It is not about two
different events.

That is why it is worth letting the modeling rules to clarify the behavior of
system, without doing non-obvious implication in the code part, so we can have a
model that fits better in the Linux actions/events to avoid ambiguity.

[ note 1: the tracepoint is only enabled if CONFIG_PREEMPTIRQ_TRACEPOINTS=y
 which is not enabled by default ]

[ note 2: I just saw that Steven replied while I was writing this email... I
will read them now... sorry for some repetitive topic here ]

-- Daniel
