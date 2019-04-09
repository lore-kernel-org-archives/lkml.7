Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CC9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6971A2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n1eAL6py"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDIPqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:46:01 -0400
Received: from mail.efficios.com ([167.114.142.138]:53232 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:46:00 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BC33D7D1E4;
        Tue,  9 Apr 2019 11:45:58 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id U5A2xorED2Hw; Tue,  9 Apr 2019 11:45:58 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3EA477D1D8;
        Tue,  9 Apr 2019 11:45:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3EA477D1D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554824758;
        bh=sjNg5ZBAe9z91QrKgyJm3S8+81jCLKWyAsZTO9QAxfU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=n1eAL6pymMOvenfqK8HCiwd39JAkqqBHS9YVcHqC2/52aNvStURbZdVsukVcYYB61
         YfBrpsnvFtLzxAG828vbnwrW8am8gazy1cs40axca3ZdEkwqYl4qT3nY2iTUI7vEJv
         Avhap69EpkeP5+d4Fyp8UGgyD6kgN8baOvwR9fmkOutG3VuBkQo8qL0rurj2KK9gZX
         uv9nZv5NM5OGuCahG87PB7HHDZOHWQF34dI33o8JK5PNl3saC8jFL2xGA7V88YAoTO
         AH6noigHFi1CCCK0gfum+NdpvjrBjqlzYFLi93q/YT5wVI9c4KIF62RTb/VldkS5uf
         VO1JXrTFZqweQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id UPJ7w6t10suF; Tue,  9 Apr 2019 11:45:58 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 15D7A7D1D1;
        Tue,  9 Apr 2019 11:45:58 -0400 (EDT)
Date:   Tue, 9 Apr 2019 11:45:57 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <codonell@redhat.com>
Cc:     Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>,
        Alan Modra <amodra@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Meissner <meissner@linux.ibm.com>,
        Peter Bergner <bergner@vnet.ibm.com>,
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
Message-ID: <71849794.2361.1554824757946.JavaMail.zimbra@efficios.com>
In-Reply-To: <86030de9-862d-3ef5-d372-1695af3c8204@redhat.com>
References: <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com> <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com> <877ec4pam2.fsf@linux.ibm.com> <ce9fbc66-5eb9-0fa9-99fa-5abfe00ddfc2@redhat.com> <877ec3yffq.fsf@concordia.ellerman.id.au> <20190409092948.GA14424@bubble.grove.modra.org> <871s2bp9f9.fsf@linux.ibm.com> <86030de9-862d-3ef5-d372-1695af3c8204@redhat.com>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup
 and thread creation (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v7)
Thread-Index: Tz25zrAv+9BxqpXd8DhPraA7WuWd/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 9, 2019, at 10:13 AM, Carlos O'Donell codonell@redhat.com wrote:

> On 4/9/19 9:58 AM, Tulio Magno Quites Machado Filho wrote:
>> Alan Modra <amodra@gmail.com> writes:
>>> Yes, looks fine to me, except that in VLE mode (do we care?)
>>> ".long 0x0fe50553" disassembles as
>>>     0:	0f e5       	se_cmphl r5,r30
>>>     2:	05 53       	se_mullw r3,r5
>>> No illegal/trap/privileged insn there.
>>>
>>> ".long 0x0fe5000b" might be better to cover VLE.
>> 
>> Looks good for me too.
> 
> The requirement that it be a valid instruction is simply to aid in the
> disassembly of rseq regions which may be hand written assembly with a
> thin veneer of CFI/DWARF information.
> 
> It has already been pointed out that POWER uses data in the instruction
> stream for jump tables to implement switch statements, but that specific
> use has compiler support and one presumes good debug information. So as
> Alan says, there is already data in the insn stream, though such things
> can't be good for performance (pollutes D-cache, problematic for
> speculative execution).
> 
>> Actually, it better fits what Carlos O'Donnell had requested:
>> 
>>>>> I think the order of preference is:
>>>>>
>>>>> 1.  An uncommon insn (with random immediate values), in a literal pool, that is
>>>>>       not a useful ROP/JOP sequence (very uncommon)
>>>>> 2a. A uncommon TRAP hopefully with some immediate data encoded (maybe uncommon)
>>>>> 2b. A NOP to avoid affecting speculative execution (maybe uncommon)
>>>>>
>>>>> With 2a/2b being roughly equivalent depending on speculative execution policy.
> 
> Yes, though "in a literal pool" is something that is not required, since
> users might not want literal pools and so we shouldn't require that
> feature (it also pollutes D-cache).
> 
> Keep in mind the insn will never execute.
> 
> If a trap insn calls out the nature of the signature more clearly then
> use that instead.

So based on the recent discussions, there are a few things we can conclude:

- Choosing a random value and relying on literal pools is a bad idea, because some
  compilation environments disable them entirely,
- We ideally want the signature to be a valid instruction in the instruction set
  so disassembler/emulator tools don't get confused and we don't hurt speculative
  execution.
- Best option is a trap with an unlikely immediate opcode, because it traps on the
  instruction in case the program try to execute it by mistake,
- Second best would be a no-op with an unlikely immediate opcode,
- We may want to stay away from privileged instructions because they can confuse
  emulators with may try to emulate them,
- Some architectures have big endian/little endian variants. We may need to carefully
  #ifdef each case so the numeric value matches actual instructions,
- Some architectures have extensions to their instruction set (e.g. ARM thumb, power
  VLE) which can be combined with the basic instruction set within the same program.
  We need to decide whether we care what those signatures look like in those
  instruction set extensions or not. Is it a best effort to match real instructions
  or a hard requirement ? If it's a hard requirement, we may need to extend the rseq
  system call with new flags to accept more than one signature.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
