Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E59E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bi/Oc/HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfC0UBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:01:39 -0400
Received: from mail.efficios.com ([167.114.142.138]:35910 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfC0UBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:01:38 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C9F761CF5DE;
        Wed, 27 Mar 2019 16:01:36 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id VxIsyfO898Rq; Wed, 27 Mar 2019 16:01:36 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 436AA1CF5D7;
        Wed, 27 Mar 2019 16:01:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 436AA1CF5D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1553716896;
        bh=MMOGQL6I6bsjOhtezbnnfKPd6j/W5+XUqNTRZO0bJYo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bi/Oc/HU317Z5GRYrIQe0opRL23JrrDyYgRZ19TSLQRETYJNXKPgsPJLq7D4a2bKR
         T4h4oeZZ+JdJAgiwhFVwXkOjGUS5yVq+xHzp9UJ3v6iKqlzGIhx0uePG028eU7Rgfn
         JNQe6DEJqelFPKpX3ti7I4xUze8WjlXC5SoHIDOXzFEvOAZQ9Q4ci33wi+9Urm3+Tj
         2bqD5Dd47zCFhx2CeS16Mg01wsAmpsR0bmVY3WoFcynWgaNGY5MEvO7QpO1dYn7qfd
         IeNUcVrfh9AvsqUb89bSIPIibadnsTrNIZILGyDyHFyQDMZlftaajlpfQP4HTtTLTs
         ThUVYagbn3LgA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 5PFW4YnyG9ta; Wed, 27 Mar 2019 16:01:36 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1D28B1CF5CC;
        Wed, 27 Mar 2019 16:01:36 -0400 (EDT)
Date:   Wed, 27 Mar 2019 16:01:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     schwidefsky <schwidefsky@de.ibm.com>
Cc:     Carlos O'Donell <codonell@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
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
Message-ID: <1545235218.11875.1553716895944.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190327101608.77b0de6f@mschwideX1>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com> <20190212194253.1951-2-mathieu.desnoyers@efficios.com> <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com> <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com> <20190327101608.77b0de6f@mschwideX1>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup
 and thread creation (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF65 (Linux)/8.8.11_GA_3787)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v7)
Thread-Index: DXzEBM8ConRa/Mr9YLYm+xN5T4ziFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 27, 2019, at 5:16 AM, schwidefsky schwidefsky@de.ibm.com wrote:

> On Mon, 25 Mar 2019 11:54:32 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> >> +++ b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
>> [...]
>> >> +
>> >> +/* Signature required before each abort handler code.  */
>> >> +#define RSEQ_SIG 0x53053053
>> > 
>> > Why not a s390 specific value here?
>> 
>> s390 also has the abort handler in a __rseq_failure section:
>> 
>> #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)             \
>>                 ".pushsection __rseq_failure, \"ax\"\n\t"               \
>>                 ".long " __rseq_str(RSEQ_SIG) "\n\t"                    \
>>                 __rseq_str(label) ":\n\t"                               \
>>                 teardown                                                \
>>                 "j %l[" __rseq_str(abort_label) "]\n\t"                 \
>>                 ".popsection\n\t"
>> 
>> Same question applies as powerpc: since disassemblers will try to decode
>> that instruction, would it be better to define it as a valid one ?
>> 
>> [...]
> 
> A 4-byte sequence starting with 0x53 is decoded as a "diebr" instruction.

Based on the z/Architecture reference summary, it appears that the DIEBR
instruction's opcode is B353. So I suspect that just starting with 0x53 is
not sufficient to make it a valid opcode in the instruction set. Is it
something we should care about ?

> And please replace that "j %l[...]" with a "jg %l[...]", the branch target
> range of the "j" instruction is 64K, not enough for the general case.

I'll also need to use "jg" for RSEQ_ASM_DEFINE_CMPFAIL:

#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)         \
                ".pushsection __rseq_failure, \"ax\"\n\t"               \
                __rseq_str(label) ":\n\t"                               \
                teardown                                                \
                "jg %l[" __rseq_str(cmpfail_label) "]\n\t"              \
                ".popsection\n\t"

I'll prepare a fix for Linux selftests, and I already pushed a fix within
my librseq repository.

Thanks for pointing it out!

Mathieu

> 
> --
> blue skies,
>   Martin.
> 
> "Reality continues to ruin my life." - Calvin.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
