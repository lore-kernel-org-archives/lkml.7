Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791DAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC2C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfDDUP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:15:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39027 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfDDUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:15:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id c189so2492358qke.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o1wJwNYRnXpup2bxqQH9bKI+mZDLraoSrDs4UAHrt/E=;
        b=Hq7lJXf4tjECrbu0mOQWq7p2eTz1WBr9DL1BZdfoQSnI1co/34EXWk7IDba0f2I4cr
         Q8DkRbTlLjLcgJB4tPQpaYl3FcLvq2z7ShNOcoXZZEn8viYYU5fxG0SZgKRgwWZsmmSA
         QppIV0fhCQ1Tesv1tYtQ9b/OTu5+3fCss5lkujwbLrBM6aS7uQcpZP1/4L7yVeGkcUyO
         fTZY6vq7aEP521u26pLSh/tsuyfO9CmtqO+2BkeGI14I5FmZhRf1iNq/Bd3tX1NglsTm
         tWqON6+vAjdj9diNhEzFqw92tCVwkHFg6C85GgcP+ZajvcPfpMRSt5DQK6DsrzPdBf+A
         ExqA==
X-Gm-Message-State: APjAAAVV+VYiYVq2nKNf+/9/4bFrTnuhgSoBJ81Jbd8ARwMk5FT7ci8v
        YjRa9UpZAXRDNMti61feCmcJLA==
X-Google-Smtp-Source: APXvYqx1G+bM0abZwXvYPx9BcRif8CbdcSRmcGL9T520xre12OxHTgD5GgimHiuQGI2/POXtNMiTUw==
X-Received: by 2002:ae9:c310:: with SMTP id n16mr7060466qkg.8.1554408958536;
        Thu, 04 Apr 2019 13:15:58 -0700 (PDT)
Received: from [10.150.73.190] (214.sub-174-240-132.myvzw.com. [174.240.132.214])
        by smtp.gmail.com with ESMTPSA id r31sm12388496qtj.17.2019.04.04.13.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 13:15:57 -0700 (PDT)
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
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
From:   Carlos O'Donell <codonell@redhat.com>
Message-ID: <7412087f-5ef4-0670-503e-f8de6ca3b0bb@redhat.com>
Date:   Thu, 4 Apr 2019 16:15:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87lg0tosfz.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 2:02 AM, Michael Ellerman wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
>> Hi Carlos,
>>
>> ----- On Mar 22, 2019, at 4:09 PM, Carlos O'Donell codonell@redhat.com wrote:
> ...
>>
>> [...]
>>>> +++ b/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h
>> [...]
>>>> +/* Signature required before each abort handler code.  */
>>>> +#define RSEQ_SIG 0x53053053
>>>
>>> Why isn't this an opcode specific to power?
>>
>> On powerpc 32/64, the abort is placed in a __rseq_failure executable section:
>>
>> #define RSEQ_ASM_DEFINE_ABORT(label, abort_label)                               \
>>                  ".pushsection __rseq_failure, \"ax\"\n\t"                       \
>>                  ".long " __rseq_str(RSEQ_SIG) "\n\t"                            \
>>                  __rseq_str(label) ":\n\t"                                       \
>>                  "b %l[" __rseq_str(abort_label) "]\n\t"                         \
>>                  ".popsection\n\t"
>>
>> That section only contains snippets of those trampolines. Arguably, it would be
>> good if disassemblers could find valid instructions there. Boqun Feng could perhaps
>> shed some light on this signature choice ? Now would be a good time to decide
>> once and for all whether a valid instruction would be a better choice.
> 
> I'm a bit vague on what we're trying to do here.
> 
> But it seems like you want some sort of "eye catcher" prior to the branch?
> 
> That value is a valid instruction on current CPUs (rlwimi.
> r5,r24,6,1,9), and even if it wasn't it could become one in future.
> 
> If you change it to 0x8053530 that is both a valid instruction and is a
> nop (conditional trap immediate but with no conditions set).

The s390 IBM team needs to respond to this and I want to make sure they ACK
the NOP being used here because it impacts them directly.

I'd like to see Martin's opinion on this.

-- 
Cheers,
Carlos.
