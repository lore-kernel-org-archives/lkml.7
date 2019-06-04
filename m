Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C40C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C89E207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfFDKUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:20:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50742 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfFDKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:20:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so10250305wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 03:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iU0l8vwA6DdSYI8mz2NljjXu7nMKs0q13kn5AwEerD8=;
        b=k7R2bcZIYlH8kKQKAhqSm73CX9B7zRyAHzP0xtSPS1bKLTrcTG0j6Jn863fNbsEJtd
         iryHFe0frswuAZc4c5BcFtFmC/im1K1CwEKbJ/ZsQk3tvrmfmFkCPejXKnS0lovBDh54
         SGPtY9w0FfuNdf/SE9FmBDDtRtS7c2WpT1LZVo9/Y3PgYvt+bLNeA/iQlBLnoVAja93E
         RL4jckqnPdBh8/ZDSliH83kx8VihPge08XLYwa+6NSFReeCm7pxPxLIM7zBBCpCPBXT6
         FrWewjqjxf02liDwmOS7fvF7lDu2eh83sd6HtpQEj/z5l1vZ0eB/bWEIedHCPL/UsNAH
         wVfg==
X-Gm-Message-State: APjAAAXD//Wf5qoxjlslVk/Srj9GEH3gFovoSRm/UPWRGJOxjL5vZD4x
        oSUsDt18PU+1YWHQci9VyXoIOA==
X-Google-Smtp-Source: APXvYqy+i37B1jRZPK7OZPVrw6iHEB6MIYkUbhzEQj9zo3xW0SHtwco1uSJQMltwP37qXU8rl0Y0xw==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr18312161wmk.67.1559643610549;
        Tue, 04 Jun 2019 03:20:10 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([5.170.68.106])
        by smtp.gmail.com with ESMTPSA id v10sm16083679wml.27.2019.06.04.03.20.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 03:20:09 -0700 (PDT)
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
 <94669b5a-06dd-e9bf-cfb6-b5d507a90946@redhat.com>
 <20190529182142.GF2623@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <9e7850fa-2be5-1dfc-914c-77c9bc9e8c48@redhat.com>
Date:   Tue, 4 Jun 2019 12:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529182142.GF2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2019 20:21, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 03:51:31PM +0200, Daniel Bristot de Oliveira wrote:
>> On 29/05/2019 12:20, Peter Zijlstra wrote:
> 
>>> I'm not sure I follow, IRQs disabled fully implies !preemptible. I don't
>>> see how the model would be more pessimistic than reality if it were to
>>> use this knowledge.
>>
>> Maybe I did not expressed myself well... and the example was not good either.
>>
>> "IRQs disabled fully implies !preemptible" is a "to big" step. In modeling (or
>> mathematical reasoning?), a good practice is to break the properties into small
>> piece, and then build more complex reasoning/implications using these "small
>> properties."
>>
>> Doing "big steps" makes you prone "miss interpretations", creating ambiguity.
>> Then, -RT people are prone to be pessimist, non-RT optimistic, and so on... and
>> that is what models try to avoid.
> 
> You already construct the big model out of small generators, this is
> just one more of those little generators.

Yes, we can take that way too...

>> For instance, explaining this using words is contradictory:>
>>> Any !0 preempt_count(), which very much includes (Hard)IRQ and SoftIRQ
>>> counts, means non-preemptible.
>>
>> One might argue that, the preemption of a thread always takes place with
>> preempt_count() != 0, because __schedule() is always called with preemption
>> disabled, so the preemption takes place while in non-preemptive.
> 
> Yeah, I know about that one; you've used it in your talks. Also, you've
> modeled the schedule preempt disable as a special state. If you want we
> can actually make it a special bit in the preempt_count word too, the
> patch shouldn't be too hard, although it would make no practical
> difference.

Good to know! I am trying not to change the code or abstractions. In the
user-space version I was using the caller address to figure out if it was a call
in the scheduler or not. In the kernel version I am planing to use a
is_sched_function() like approach. But if nothing of that works, I will explore
this possibility, thanks for the suggestion.

>> - WAIT But you (daniel) wants to fake the atomicity between preempt_disable and
>> its tracepoint!
>>
>> Yes, I do, but this is a very straightforward step/assumption: the atomicity is
>> about the real-event and the tracepoint that notifies it. It is not about two
>> different events.
>>
>> That is why it is worth letting the modeling rules to clarify the behavior of
>> system, without doing non-obvious implication in the code part, so we can have a
>> model that fits better in the Linux actions/events to avoid ambiguity.
> 
> You can easily build a little shim betwen the model and the tracehooks
> that fix this up if you don't want to stick it in the model proper.
> 
> All the information is there. Heck you can even do that 3/3 thing
> internally I think.
> 

Ack, let's see what I can came up.

Thanks!

-- Daniel
