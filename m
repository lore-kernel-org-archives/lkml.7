Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C844C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD539217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="iVojalTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfG3Buz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:50:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41555 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730919AbfG3Bul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so28957537pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4EhdFwippgleeTOyya13CwUwTiFgK0z253A18LHfFSg=;
        b=iVojalTN95us32HDVWEwr4iCvnDoMN//gfoNYxQgzZJIjMnYji9ozYswnP6ZCcPKcM
         TZMmxMoj6PVai8SZyLPAAKjHobCpBfp1IhyMPn92nTjJrF7u7GVVz9ZhFooYkIRQt8s1
         qKRbpl6q6FX4cL7WJE6nLFJdm7P3NJ/xS9XpQE8nbZZNRVTI69fbj4RQ3XgVeO4rO09Y
         NT23fddYxeTSotfCGa9FfyCB3TWznzZAgKk4eywJQWTq67llQ5Un6WMv3DaSytVoPVlU
         L00hHLRuZjD1WbEMVUBKg1me3+un60NDI0uV/ecrySg7NbiltBtetHf6F5DviGUkHI+Q
         7egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4EhdFwippgleeTOyya13CwUwTiFgK0z253A18LHfFSg=;
        b=Fnyvp4fsaL5UJTiLdDqvQNr6IGY/R/LBzNnAO/W10MCZfd1NKAMKSoH7Y5D5TX1yOX
         6ug2J9ru7XvHdiRJr4ZDQ5+4b2/HZIVGd6Lsl0mchUkuCBq9/uLKPPCxkUNEstCSU5e/
         LIYUz4KPuXSItGYjtJg2JWquIvHuq5C2aqpp8wTq66tkrBoNjAYAlmtIPAOTouGW3ss2
         RpxVoJEgQUrBAfHEbkigM64IsrcNo4H5gNadk0ZOgsKv/XsLCYzXRl6Z8Yjxr+7kXzS8
         R5q08Ru2XuPUwcPpYbodJoBXFDMn7AUsKITfFBOl8tLoYvn3F1Kut977Pnuxe1Fo1x5W
         XlbQ==
X-Gm-Message-State: APjAAAV9pnRYd/Hvq14OJ3GBdFFpmXMPGTzb538+sHxuA5dnux4NMGKj
        WFBDJE6YzxqlV8qMpom86C2H6w1d
X-Google-Smtp-Source: APXvYqzsMQ+gb5kRj6chqqBoJFEH4zE9s3b6AJI1hNrr/GZTM7gwBAfgX82GtR3f4KjegGXF7E3xLQ==
X-Received: by 2002:a65:64c6:: with SMTP id t6mr108936703pgv.323.1564451440596;
        Mon, 29 Jul 2019 18:50:40 -0700 (PDT)
Received: from etsukata.local (fs76eecbcd.tkyc008.ap.nuro.jp. [118.238.203.205])
        by smtp.gmail.com with ESMTPSA id g2sm79048069pfb.95.2019.07.29.18.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 18:50:39 -0700 (PDT)
Subject: Re: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190729010734.3352-1-devel@etsukata.com>
 <CALCETrVavLdQ8Rp+6fmTd7kJJwvRKdaEnudaiMAu8g9ZXuNfWA@mail.gmail.com>
 <20190729102948.GY31381@hirez.programming.kicks-ass.net>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 mQINBFydxe0BEAC2IUPqvxwzh0TS8DvqmjU+pycCq4xToLnCTy9gfmHd/mJWGykQJ7SXXFg2
 bTAp8XcITVEDvhMUc0G4l+RBYkArwkaMHO5iM4a7+Gnn6beV1CL/dk9Wu5gkThgL11bhyKmQ
 Ub1duuVkX3fN2cRW2DrHsTp+Bxd/pq5rrKAbA/LIFmF4Oipapgr69I5wUeYywpzPFuaVkoZc
 oLdAscwEvPImSOAAJN0sesBW9sBAH34P+xaW2/Mug5aNUm/K6whApeFV/qz2UuOGjzY4fbYw
 AjK1ALIK8rdeAPxvp2e1dXrj29YrIZ2DkzdR0Y9O8Lfz1Pp5aQ+pwUQzn2vWA3R45IItVtV5
 8v04N/F7rc/1OHFpgFtzgAO2M51XiIPdbSmF/WuWPsdEHWgpVW3H/I8amstfH519Xb/AOKYQ
 7a14/3EESVuqXyyfCdTVnBNRRY0qXJ7mA0oParMD8XKMOVLj6Nlvs2Zh2LjNJhUDsssKNBg+
 sMKiaeSV8dtcbH2XCc2GDKsYbrIKG3cu5nZl8xjlM3WdtdvqWpuHj6KTYBQgsXngBA7TDZWT
 /ccYyEQpUdtCqPwV0BPho6pr8Ug6J99b1KyZKd/z3iQNHYYh3Iy08wIfUHEXoFiYhMtbfKtW
 21B/27EABXMHYnvekhJkVA9E4sfGlDZypU7hWEoiGnAZLCkr2QARAQABtCNFaWljaGkgVHN1
 a2F0YSA8ZGV2ZWxAZXRzdWthdGEuY29tPokCVAQTAQgAPhYhBKeOigYiCRnByygZ7IOzEG5q
 Kr5hBQJcncXtAhsjBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIOzEG5qKr5h
 UvMP/RIo3iIID+XjPPQOjX26wfLrAapgKkBF2KlenVXpEua8UUY0NV4l1l796TrMWtlRS0B1
 ikGKDcsbP4eQFLrmguaNMihr89YQzM2rwFlloSH8R3bTkub2if/5RCJj2kPXEjgwCb7tofDN
 Hz7hjZOQUYNo3yiyeED/mtJGR05+twMJzedehBHxoEFb3cWXT/aD2fsYdZzRqw74rBAdlTnD
 q0aaJJ/WOP7zSwodQLwTjTxF4WorDY31Q1EqqJun6jErHviWu7mYfSSRc4q8tzh8XfIP7WZV
 O9jB+gYTZxhbgXdxZurV3hiwHgKPgC6Q2bSP6vRgSbzNhvS+jc05JWCWMnpe8kdRyViHKIfm
 y0Kap32OwRP5x+t0y52jLryxvBfUF3xGI78Qx9f8L5l56GQlGkgBH5X2u109XvqD+aed5aPk
 mUSsvO94Mv6ABoGe3Im0nfI07oxwIp79etG1kBE9q4kGiWQ8/7Uhc2JR6a/vIceCVJDyagll
 D7UvNITbFvhsTh6KaDnZQYiGMja2FxXN6sCvjyr+hrya/sqBZPQqXzpvfBq5nLm1rAvJojqM
 7HA9742wG3GmdwogdbUrcAv6x3mpon12D0guT+4bz5LTCfFFTCBdPLv7OsQEhphsxChGsdt2
 +rFD48wXU6E8XNDcWxbGH0/tJ05ozhqyipAWNrImuQINBFydxe0BEAC6RXbHZqOo8+AL/smo
 2ft3vqoaE3Za3XHRzNEkLPXCDNjeUKq3/APd9/yVKN6pdkQHdwvOaTu7wwCyc/sgQn8toN1g
 tVTYltW9AbqluHDkzTpsQ+KQUTNVBFtcTM4sMQlEscVds4AcJFlc+LRpcKdVBWHD0BZiZEKM
 /yojmJNN9nr+rp1bkfTnSes8tquUU3JSKLJ01IUlxVMtHPRTT/RBRkujSOCk0wcXh1DmWmgs
 y9qxLtbV8dIh2e8TQIxb3wgTeOEJYhLkFcVoEYPUajHNyNork5fpHNEBoWGIY9VqsA38BNH6
 TZLQjA/6ERvjzDXm+lY7L11ErKpqbHkajliL/J/bYqIebKaQNCO14iT62qsYh/hWTPsEEK5S
 m8T92IDapRCge/hQMuWOzpVyp3ubN0M98PC9MF+tYXQg3kuNoEa/8isArhuv/kQWD0odW4aH
 3VaUufI+Gy5YmjRQckSHrG5sTTnh13EI5coVIo+HFLBSRBqTkrRjfcnPHvDamcteuzKFkk+m
 uGO4xa6/vacR8cZB/GJ7bLJqNdaJSVDDXc+UYXiN1AITMtUYQoP6fEtw1tKjVbv3gc52kHG6
 Q71FFJU0f08/S3VnyCCjQMy4alQVan3DSjykYNC8ND0lovMtgmSCf4PmGlxCbninP5OU+4y3
 MRo74kGnhqpc9/djiQARAQABiQI8BBgBCAAmFiEEp46KBiIJGcHLKBnsg7MQbmoqvmEFAlyd
 xe0CGwwFCQlmAYAACgkQg7MQbmoqvmGAUA/+P1OdZ6bAnodkAuFmR9h3Tyl+29X5tQ6CCQfp
 RRMqn9y7e1s2Sq5lBKS85YPZpLJ0mkk9CovJb6pVxU2fv5VfL1XMKGmnaD9RGTgsxSoRsRtc
 kB+sdbi5YDsjqOd4NfHvHDpPLcB6dW0BAC3tUOKClMmIFy2RZGz5r/6sWwoDWzJE0YTe63ig
 h64atJYiVqPo4Bt928xC/WEmgWiYoG+TqTFqaK3RbbgNCyyEEW6eJhmKQh1gP0Y9udnjFoaB
 oJGweB++KV1u6eDqjgCmrN603ZIg1Jo2cmJoQK59SNHy/C+g462NF5OTO/hGEYJMRMH+Fmi2
 LyGDIRHkhnZxS12suGxka1Gll0tNyOXA88T2Z9wjOsSHxenGTDv2kP5uNDw+gCZynBvKMnW4
 8rI3fWjNe5s1rK9a/z/K3Bhk/ojDEJHSeXEr3siS2/6E4UhDNXd/ZGZi5fRI2lo8Cp+oTS0Q
 m6FIxqnoPWVCsi1XJdSSQtTMxU0qesAjRXTPE76lMdUQkYZ/Ux1rbzYAgWFatvx4aUntR+1N
 2aCDuAIID8CNIhx40fGfdxVa4Rf7vfZ1e7/mK5lDZVnWwTOJFNouvlILKLcDPNO51R5XKsc1
 zxZwI+P1sTpSBI/KtFfphfaN93H3dLiy26D1P8ShFz6IEfTgK4OVWhqCaOe9oTXTwwNzBQ4=
Message-ID: <d8384113-a5a7-4370-e7fb-a6c4b88325e1@etsukata.com>
Date:   Tue, 30 Jul 2019 10:50:36 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729102948.GY31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for comments.

On 2019/07/29 19:29, Peter Zijlstra wrote:
> On Sun, Jul 28, 2019 at 09:25:58PM -0700, Andy Lutomirski wrote:
>> On Sun, Jul 28, 2019 at 6:08 PM Eiichi Tsukata <devel@etsukata.com> wrote:
> 
>>> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
>>> index 4d8e99fdbbbe..031b51cb94d0 100644
>>> --- a/kernel/trace/trace_preemptirq.c
>>> +++ b/kernel/trace/trace_preemptirq.c
>>> @@ -10,6 +10,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/ftrace.h>
>>>  #include <linux/kprobes.h>
>>> +#include <linux/context_tracking.h>
>>>  #include "trace.h"
>>>
>>>  #define CREATE_TRACE_POINTS
>>> @@ -49,9 +50,14 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
>>>
>>>  __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
>>>  {
>>> +       enum ctx_state prev_state;
>>> +
>>>         if (this_cpu_read(tracing_irq_cpu)) {
>>> -               if (!in_nmi())
>>> +               if (!in_nmi()) {
>>> +                       prev_state = exception_enter();
>>>                         trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
>>> +                       exception_exit(prev_state);
>>> +               }
>>>                 tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
>>>                 this_cpu_write(tracing_irq_cpu, 0);
>>>         }
>>
>> This seems a bit distressing.  Now we're going to do a whole bunch of
>> context tracking transitions for each kernel entry.  Would a better>> fix me to change trace_hardirqs_on_caller to skip the trace event if
>> the previous state was already IRQs on and, more importantly, to skip
>> tracing IRQs off if IRQs were already off?  The x86 code is very
>> careful to avoid ever having IRQs on and CONTEXT_USER at the same
>> time.
> 
> I think they already (try to) do that; see 'tracing_irq_cpu'.
> 

Or you mean something like this?
As for trace_hardirqs_off_caller:

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 4d8e99fdbbbe..d39478bcf0f2 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -66,7 +66,7 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
        if (!this_cpu_read(tracing_irq_cpu)) {
                this_cpu_write(tracing_irq_cpu, 1);
                tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
-               if (!in_nmi())
+               if (!in_nmi() && !irqs_disabled())
                        trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
        }

Or

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 4d8e99fdbbbe..e08c5c6ff2b3 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -66,8 +66,6 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
        if (!this_cpu_read(tracing_irq_cpu)) {
                this_cpu_write(tracing_irq_cpu, 1);
                tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
-               if (!in_nmi())
-                       trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
        }


As for trace_hardirqs_on_caller, it is called when IRQs off and CONTEXT_USER.
So even though we skipped the trace event if the previous state was already IRQs on,
we will fall into the same situation.
