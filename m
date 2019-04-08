Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DBEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D45C2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDHVpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:45:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42800 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDHVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:45:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id b74so8984309qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2zaUFGJiVT0h2qCE8y5ZwT8dSn4viR1ixiXbVYzLBaI=;
        b=djqTKy+pbRkziGcRfkGnggYRg9a5JUVfZKk4AIY6yt1k4+yKHSuLDizchm+B/RtajK
         YmQiUPkfNX3ef77jTSLfKI+5z8WvJUQbwDDsc1DREljyTw6ADW9OSoSDQVCBvE0jbjgT
         0dzNlIayDQShK/hVPkZXZ3C6BA2sFQ+bDXVAbECqdOR1G8FB6MGm+if4aLKnl4mfJnX8
         lVefTbor4/uCubjGhELC9JAxLCjxO8QDFD+j+85vPSPVQmPDBdb9gvt92TiIErpkTBKc
         Wv6PmHRD2Oq5YC7t14XqUUqJE0sZFtfd8YFPL4OK6Yg8ZOfoeEkESUBjIdYBrSTm8fiK
         6lzg==
X-Gm-Message-State: APjAAAXfo9e2gdrjjUXDdlLRnAM37msoxmfZd5MYfLaNhJpOQA52FMS/
        C43l2+CMmYaiMs0kTfMBm73vAw==
X-Google-Smtp-Source: APXvYqx/JYhS1eEyaHBYQpteZ76X8ALGUOK/KBmJI9Ck2YFxFZs0ajwJRzI9R/QSVnhiL+mykUJ54w==
X-Received: by 2002:ae9:e012:: with SMTP id m18mr24697300qkk.267.1554759946685;
        Mon, 08 Apr 2019 14:45:46 -0700 (PDT)
Received: from [10.150.73.190] (214.sub-174-240-132.myvzw.com. [174.240.132.214])
        by smtp.gmail.com with ESMTPSA id y6sm16996602qka.69.2019.04.08.14.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:45:45 -0700 (PDT)
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
To:     Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Meissner <meissner@linux.ibm.com>,
        Alan Modra <amodra@gmail.com>,
        Peter Bergner <bergner@vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, carlos <carlos@redhat.com>,
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
 <87lg0tosfz.fsf@concordia.ellerman.id.au>
 <87pnq4zxyj.fsf@oldenburg2.str.redhat.com>
 <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com>
 <87y34o4xt3.fsf@oldenburg2.str.redhat.com>
 <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com>
 <877ec4pam2.fsf@linux.ibm.com>
From:   Carlos O'Donell <codonell@redhat.com>
Message-ID: <ce9fbc66-5eb9-0fa9-99fa-5abfe00ddfc2@redhat.com>
Date:   Mon, 8 Apr 2019 17:45:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <877ec4pam2.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 3:20 PM, Tulio Magno Quites Machado Filho wrote:
> Carlos O'Donell <codonell@redhat.com> writes:
> 
>> On 4/5/19 5:16 AM, Florian Weimer wrote:
>>> * Carlos O'Donell:
>>>> It is valuable that it be a trap, particularly for constant pools because
>>>> it means that a jump into the constant pool will trap.
>>>
>>> Sorry, I don't understand why this matters in this context.  Would you
>>> please elaborate?
>>
>> Sorry, I wasn't very clear.
>>
>> My point is only that any accidental jumps, either with off-by-one (like you
>> fixed in gcc/glibc's signal unwinding most recently), result in a process fault
>> rather than executing RSEQ_SIG as a valid instruction *and then* continuing
>> onwards to the handler.
>>
>> A process fault is achieved either by a trap, or an invalid instruction, or
>> a privileged insn (like suggested for MIPS in this thread).
> 
> In that case, mtmsr (Move to Machine State Register) seems a good candidate.
> 
> mtmsr is available both on 32 and 64 bits since their first implementations.
> 
> It's a privileged instruction and should never appear in userspace
> code (causes SIGILL).
> 
> Any comments?
  
That seems good to me.

Mathieu,

What's required to move this forward for POWER?

-- 
Cheers,
Carlos.
