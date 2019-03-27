Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F6FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33EE2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfC0Uil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:38:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44746 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC0Uik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:38:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id w5so20501249qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Su9RseQdKSewV9YmXza7lnUC3L3ZKBLunvImfxCavtI=;
        b=tzs61PM3JbnR1tmJF181pTEPyW6Xt8jjfYjcwLQdoeHdFjeYj6/pKDy+1Bk3hHO+T0
         90lFx1PpOqVbKaOefH49Z1Yxed7BcMJ3jgbHtbnnkrOci/JX7rc62NcPe41kKFEz3v7W
         2qllYoHK19kHS0XcsydtB4AlxJRqNQ9GQx4+HkuF1p3uNIJ7YFWrKcR5IALlH/wiFciK
         XclowjDBbAsQrF/hXxCdAgEbBUz5xt8C1Z8R6keZOtODDMw882q+6sIRiof3hUMwgjqn
         oc+UoxxsD3WSYtXDP8HuFMFuih27vjd0Lw0+oEhkhp/vhUv6Gj8HylyHdOUwfCV/vN/q
         tHlQ==
X-Gm-Message-State: APjAAAXahV8QI9MimeCn8UBNx/EwlJfK6lolcJn8DbLBOF1xhySOlMgx
        awzSaMku750gR1voEur0lSoivg==
X-Google-Smtp-Source: APXvYqzv0W9b8W96McIyTcgnuo5vmDQlwacampxTFQsaaLanWmk8JscZJlYI70MQxtUPOeHXepFLkg==
X-Received: by 2002:ac8:1b38:: with SMTP id y53mr32277602qtj.130.1553719119566;
        Wed, 27 Mar 2019 13:38:39 -0700 (PDT)
Received: from [10.150.73.190] (178.sub-174-227-146.myvzw.com. [174.227.146.178])
        by smtp.gmail.com with ESMTPSA id s17sm14863491qtc.15.2019.03.27.13.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 13:38:38 -0700 (PDT)
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
 <20190212194253.1951-2-mathieu.desnoyers@efficios.com>
 <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
 <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
 <20190327101608.77b0de6f@mschwideX1>
From:   Carlos O'Donell <codonell@redhat.com>
Message-ID: <4021516e-6a1e-166d-a4f6-e961e6f94cc4@redhat.com>
Date:   Wed, 27 Mar 2019 16:38:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190327101608.77b0de6f@mschwideX1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 5:16 AM, Martin Schwidefsky wrote:
> On Mon, 25 Mar 2019 11:54:32 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>>> +++ b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
>> [...]
>>>> +
>>>> +/* Signature required before each abort handler code.  */
>>>> +#define RSEQ_SIG 0x53053053
>>>
>>> Why not a s390 specific value here?
>>
>> s390 also has the abort handler in a __rseq_failure section:
>>
>> #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)             \
>>                  ".pushsection __rseq_failure, \"ax\"\n\t"               \
>>                  ".long " __rseq_str(RSEQ_SIG) "\n\t"                    \
>>                  __rseq_str(label) ":\n\t"                               \
>>                  teardown                                                \
>>                  "j %l[" __rseq_str(abort_label) "]\n\t"                 \
>>                  ".popsection\n\t"
>>
>> Same question applies as powerpc: since disassemblers will try to decode
>> that instruction, would it be better to define it as a valid one ?
>>
>> [...]
> 
> A 4-byte sequence starting with 0x53 is decoded as a "diebr" instruction.
> And please replace that "j %l[...]" with a "jg %l[...]", the branch target
> range of the "j" instruction is 64K, not enough for the general case.

Why was this particular operated selected?
  
So on s390 the RSEQ_SIG will show up as an unexpected "divide to integer"
instruction that can't be reached by any control flow?

Can we use a NOP with a unique value in an immediate operand?

The goal being to have something that won't confuse during a debug
session, or that the debugger can ignore (like constant pools on Arm)

-- 
Cheers,
Carlos.
