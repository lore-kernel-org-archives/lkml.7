Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8DDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1223620693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IjS6y+Mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDIQeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:34:00 -0400
Received: from mail.efficios.com ([167.114.142.138]:58470 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfDIQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:33:58 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 64A687DF57;
        Tue,  9 Apr 2019 12:33:56 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id qXZLlziju8RG; Tue,  9 Apr 2019 12:33:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7CE917DF49;
        Tue,  9 Apr 2019 12:33:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7CE917DF49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554827635;
        bh=qPXvFPfTXo3Ea40Y3DmioLG+Jpl2PjYBIH4EiCJs/tY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IjS6y+MwULg725EZl3slz3DiDAUKI62K4TMjb6/xSjsWcGVXlC/EH3nJrNCqGultU
         oQZUQFAadV/uB6Bzv4T/cMbvz3FAOMtt/cxr2mF2N3nF6ed19J9lm3BxrhISLKB2q1
         ccqeJrjn6kYt+6LOZc65sF7+7tSpox8fwQE6TXlaxUjkY6kyAOQ4St5OrXAQX9j6Mv
         bfDys0GOqfcqiZxEQ9y/AOTVaOwm5wZzuojEsJ8tCfh3HL+/kRsRp2BVMA3fY9Pd3w
         E4Aa2f60VVPKuEKaBO7aTVAkguTUHZnj9XQiGOV0WF0T5fF+3gpVRAviqpX2B4wRMx
         aW9cTA/0HAcbw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id XM31I509c4YG; Tue,  9 Apr 2019 12:33:55 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 524F87DF42;
        Tue,  9 Apr 2019 12:33:55 -0400 (EDT)
Date:   Tue, 9 Apr 2019 12:33:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <codonell@redhat.com>
Cc:     Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Meissner <meissner@linux.ibm.com>,
        Alan Modra <amodra@gmail.com>,
        Peter Bergner <bergner@vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>, schwidefsky <schwidefsky@de.ibm.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
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
Message-ID: <1123305370.2393.1554827635212.JavaMail.zimbra@efficios.com>
In-Reply-To: <ce9fbc66-5eb9-0fa9-99fa-5abfe00ddfc2@redhat.com>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com> <87lg0tosfz.fsf@concordia.ellerman.id.au> <87pnq4zxyj.fsf@oldenburg2.str.redhat.com> <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com> <87y34o4xt3.fsf@oldenburg2.str.redhat.com> <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com> <877ec4pam2.fsf@linux.ibm.com> <ce9fbc66-5eb9-0fa9-99fa-5abfe00ddfc2@redhat.com>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup
 and thread creation (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v7)
Thread-Index: J2XqyIUDhpUe1NEMKehcWX4TtsVXIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 8, 2019, at 5:45 PM, Carlos O'Donell codonell@redhat.com wrote:

> On 4/8/19 3:20 PM, Tulio Magno Quites Machado Filho wrote:
>> Carlos O'Donell <codonell@redhat.com> writes:
>> 
>>> On 4/5/19 5:16 AM, Florian Weimer wrote:
>>>> * Carlos O'Donell:
>>>>> It is valuable that it be a trap, particularly for constant pools because
>>>>> it means that a jump into the constant pool will trap.
>>>>
>>>> Sorry, I don't understand why this matters in this context.  Would you
>>>> please elaborate?
>>>
>>> Sorry, I wasn't very clear.
>>>
>>> My point is only that any accidental jumps, either with off-by-one (like you
>>> fixed in gcc/glibc's signal unwinding most recently), result in a process fault
>>> rather than executing RSEQ_SIG as a valid instruction *and then* continuing
>>> onwards to the handler.
>>>
>>> A process fault is achieved either by a trap, or an invalid instruction, or
>>> a privileged insn (like suggested for MIPS in this thread).
>> 
>> In that case, mtmsr (Move to Machine State Register) seems a good candidate.
>> 
>> mtmsr is available both on 32 and 64 bits since their first implementations.
>> 
>> It's a privileged instruction and should never appear in userspace
>> code (causes SIGILL).
>> 
>> Any comments?
>  
> That seems good to me.
> 
> Mathieu,
> 
> What's required to move this forward for POWER?

First, we need to decide whether we need rseq to support more than
one signature per process to cover the VLE extension. If so, we'd
need to extend rseq with a new flag for future kernels.

Then, ideally, we'd need a patch on top of the Linux kernel
tools/testing/selftests/rseq/rseq-ppc.h file that updates
the signature value. I think the current discussion leads us
towards a trap:

/*
 * TODO: document instruction objdump output on each architecture and VLE
 * instruction sets.
 */
#define RSEQ_SIG 0x0fe5000b

Should we do anything specific for big/little endian ? Is the byte order
of the instruction encoding the same as data ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
