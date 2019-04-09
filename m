Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8DE2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nMJMSoyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDIQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:40:35 -0400
Received: from mail.efficios.com ([167.114.142.138]:58812 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:40:35 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4D65B7D18E;
        Tue,  9 Apr 2019 12:40:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id I_J-ieZMQGxX; Tue,  9 Apr 2019 12:40:31 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B4C797D186;
        Tue,  9 Apr 2019 12:40:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B4C797D186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554828031;
        bh=PxcmcmLMtwLrf+79sMs61KL1Cdsf5Z49BKLPudyVOZM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nMJMSoyPQ1nhNs7vZw/dRH5oA37rw5LdK+CEap8GEGqY2FmzuahYqep4VjA5nkO0V
         PM9/VwEv16fZwoFdXMUD3mcvxyecp4LPbFnZ16NaxXhF1C32NqJMvSauVx+WWQgV3p
         dpbdDD7Gp7RsxGIILDu77qEJU+m8HZqpeeV36/SjE8AhYPHaIN/4q5kTBcpVHtbyOT
         t7hIG7cMgu8oVBOfYJpLavu4doaGvokVEAeEkTjkaB2CWQ5l4EV72hDG7poQSFv+WQ
         Qk4asoAc6+ONR/m5qtNW2rSzSJmtOaq+uzkTXYUDV41Ydw6s9wj9+XegYLyl20bLXt
         IeM7EZOgW2gdw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id DExBj-kL-AT7; Tue,  9 Apr 2019 12:40:31 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 8D6C97D179;
        Tue,  9 Apr 2019 12:40:31 -0400 (EDT)
Date:   Tue, 9 Apr 2019 12:40:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Carlos O'Donell <codonell@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>, schwidefsky <schwidefsky@de.ibm.com>,
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
Message-ID: <1788266905.2400.1554828031463.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190404214151.6ogrm34dok52az4h@pburton-laptop>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com> <20190212194253.1951-2-mathieu.desnoyers@efficios.com> <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com> <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com> <602718e0-7375-deb7-b6e6-2d17022173c5@redhat.com> <20190404214151.6ogrm34dok52az4h@pburton-laptop>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup
 and thread creation (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v7)
Thread-Index: 7m11ofhkxzIm+Ccm0xLpdzhlit83GM7rDAkAgAAOc4D1QSG1QA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 4, 2019, at 5:41 PM, Paul Burton paul.burton@mips.com wrote:

> Hi Carlos / all,
> 
> On Thu, Apr 04, 2019 at 04:50:08PM -0400, Carlos O'Donell wrote:
>> > > > +/* Signature required before each abort handler code.  */
>> > > > +#define RSEQ_SIG 0x53053053
>> > > 
>> > > Why isn't this a mips-specific op code?
>> > 
>> > MIPS also has a literal pool just before the abort handler, and it
>> > jumps over it. My understanding is that we can use any signature value
>> > we want, and it does not need to be a valid instruction, similarly to ARM:
>> > 
>> > #define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, \
>> >                                  abort_label, version, flags, \
>> >                                  start_ip, post_commit_offset, abort_ip) \
>> >                  ".balign 32\n\t" \
>> >                  __rseq_str(table_label) ":\n\t" \
>> >                  ".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
>> >                  LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
>> >                  LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "\n\t" \
>> >                  LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t" \
>> >                  ".word " __rseq_str(RSEQ_SIG) "\n\t" \
>> >                  __rseq_str(label) ":\n\t" \
>> >                  teardown \
>> >                  "b %l[" __rseq_str(abort_label) "]\n\t"
>> > 
>> > Perhaps Paul Burton can confirm this ?
>> 
>> Yes please.
>> 
>> You also want to avoid the value being a valid MIPS insn that's common.
>> 
>> Did you check that?
> 
> This does not decode as a standard MIPS instruction, though it does
> decode for both the microMIPS (ori) & nanoMIPS (lwxs; sll) ISAs.
> 
> I imagine I copied the value from another architecture when porting, and
> since it doesn't get executed it seemed fine.
> 
> One maybe nicer option along the same lines would be 0x72736571 or
> 0x71657372 (ASCII 'rseq') neither of which decode as a MIPS instruction.
> 
>> I think the order of preference is:
>> 
>> 1.  An uncommon insn (with random immediate values), in a literal pool, that is
>>     not a useful ROP/JOP sequence (very uncommon)
> 
> For that option on MIPS we could do something like:
> 
>  sll $0, $0, 31     # effectively a nop, but looks weird
> 
>> 2a. A uncommon TRAP hopefully with some immediate data encoded (maybe uncommon)
> 
> Our break instruction has a 19b immediate in nanoMIPS (20b for microMIPS
> & classic MIPS) so that could be something like:
> 
>  break 0x7273       # ASCII 'rs'
> 
> That's pretty unlikely to be seen in normal code, or the teq instruction
> has a rarely used code field (4b in microMIPS, 5b in nanoMIPS, 10b in
> classic MIPS) that's meaningless to hardware so something like this
> would be possible:
> 
>  teq $0, $0, 0x8    # ASCII backspace
> 
>> 2b. A NOP to avoid affecting speculative execution (maybe uncommon)
>> 
>> With 2a/2b being roughly equivalent depending on speculative execution policy.
> 
> There are a bunch of potential odd looking nops possible, one of which
> would be the sll I mentioned above.
> 
> Another option would be to use a priveleged instruction which userland
> code can't execute & should normally never contain. That would decode as
> a valid instruction & effectively behave like a trap instruction but
> look very odd to anyone reading disassembled code. eg:
> 
>  mfc0 $0, 13        # Try to read the cause register; take SIGILL
> 
> In order to handle MIPS vs microMIPS vs nanoMIPS differences I'm
> thinking it may be best to switch to one of these real instructions that
> looks strange. The ugly part would be the nest of #ifdef's to deal with
> endianness & ISA when defining it as a number...

Note that we can have different signatures for each sub-architecture, as
long as they don't have to co-exist within the same process.

Ideally we'd need a patch on top of the Linux kernel
tools/testing/selftests/rseq/rseq-mips.h file that updates
the signature value. I think the current discussion leads us
towards a trap with unlikely immediate operand. Note that we
can special-case with #ifdef for each sub-architecture and endianness
if need be.

/*
 * TODO: document trap instruction objdump output on each sub-architecture
 * instruction sets.
 */
#define RSEQ_SIG 0x########

Should we do anything specific for big/little endian ? Is the byte order
of the instruction encoding the same as data ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
