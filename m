Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935F0218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AIeAB/VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfDXPFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:05:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:54858 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfDXPFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:05:45 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 857B41D9C92;
        Wed, 24 Apr 2019 11:05:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id XWz1UxIaRdFA; Wed, 24 Apr 2019 11:05:42 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D256B1D9C8D;
        Wed, 24 Apr 2019 11:05:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D256B1D9C8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556118342;
        bh=vRHyAKZsUbc+CKDKMbdkJIHSA9WpHMut7TkZM7B2J1U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AIeAB/VQ+cDiiSeNVGuQIHcyccnPbOtg58lzAJPcKjA3Ro/JCB5GY9HGrlIB/GIkW
         rB0pbSJ4LHtcigKyzohnsN7bpIHCDN5lZzpIvd/suHLLIMfV0yDwxMS7yf8iONCWjo
         sjW0rAeXjTfZC5hEOSfNC8YdgybY9yEXL8UvbYACH6iav/qnm+nAJ6dJYdVa8LvwDB
         9SnWYJBQpTcqGNyhj0XCTyEbudmvuR51nAwGZBqIowIQo0COkihiYDhUa+ezMnkQqE
         P1ugviJhF2cqAHFz7evx95hVMOn4bNb2i/35nr8US73xuFHRRLS0e6ONAsOa6uCt+Z
         buSe+AHardvig==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 241tTS0s2E05; Wed, 24 Apr 2019 11:05:42 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B019E1D9C80;
        Wed, 24 Apr 2019 11:05:42 -0400 (EDT)
Date:   Wed, 24 Apr 2019 11:05:42 -0400 (EDT)
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
Message-ID: <1103046939.521.1556118342613.JavaMail.zimbra@efficios.com>
In-Reply-To: <1031613720.1496.1555613900993.JavaMail.zimbra@efficios.com>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com> <20190212194253.1951-2-mathieu.desnoyers@efficios.com> <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com> <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com> <602718e0-7375-deb7-b6e6-2d17022173c5@redhat.com> <20190404214151.6ogrm34dok52az4h@pburton-laptop> <1031613720.1496.1555613900993.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup
 and thread creation (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v7)
Thread-Index: 7m11ofhkxzIm+Ccm0xLpdzhlit83GM7rDAkAgAAOc4Dxk0rRpnhaLnMD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 18, 2019, at 2:58 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 4, 2019, at 5:41 PM, Paul Burton paul.burton@mips.com wrote:
> [...]
> 
>>> 2a. A uncommon TRAP hopefully with some immediate data encoded (maybe uncommon)
>> 
>> Our break instruction has a 19b immediate in nanoMIPS (20b for microMIPS
>> & classic MIPS) so that could be something like:
>> 
>>  break 0x7273       # ASCII 'rs'
>> 
> 
> Hi Paul,
> 
> I like this uncommon break instruction as signature choice.
> 
> However, if I try to compile assembler with a break 0x7273 instruction
> with mips64 and mips32 toolchains (gcc version 8.2.0 (Ubuntu
> 8.2.0-1ubuntu2~18.04))
> I get:
> 
> /tmp/ccVh9F7T.s: Assembler messages:
> /tmp/ccVh9F7T.s:24: Error: operand 1 out of range `break 0x7273'
> 
> It works up to the value 0x3FF, which seems to use the top 10
> code bits:
> 
>   a:	03ff 0007 	break	0x3ff
> 
> Would a "break 0x350" be a good choice as well ?
> 
> Any idea why 0x7273 is not accepted by my assembler ?
> 
> I also tried crafting the assembler with values between 0x3FF and 0x7273
> in the 20 code bits. It seems fine from an objdump perspective:
> 
> ".long 0x03FFFC7\n\t"
> 
> generates:
> 
>  10:	003f ffc7 	break	0x3f,0x3ff
> 
> What I don't understand is why the instruction generated by my
> toolchain ends with the last 6 bits "000111", whereas the mips32
> instruction set specifies break as ending with "001101" [1].
> What am I missing ?
> 
> Also, the nanomips break code [2] has a completely different
> instruction layout. Should we use a different signature when
> compiling for nanomips ? What #ifdef should we use ? Do I
> need a special toolchain to generate nanomips binaries ?

Hi Paul, I'm still waiting for feedback on the MIPS front.

Meanwhile, I plan to use #define RSEQ_SIG 0x0350000d which maps to:

   0350000d 	break	0x350

and use RSEQ_SIG in assembly with:

   ".word " __rseq_str(RSEQ_SIG) "\n\t"

on big and little endian MIPS, for MIPS32 and MIPS64, based on
code generated with gcc version 8.2.0 (Ubuntu 8.2.0-1ubuntu2~18.04).

Let me know if it needs to be tweaked.

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 
> [1]
> http://hades.mech.northwestern.edu/images/1/16/MIPS32_Architecture_Volume_II-A_Instruction_Set.pdf
> [2]
> https://s3-eu-west-1.amazonaws.com/downloads-mips/I7200/I7200+product+launch/MIPS_nanomips32_ISA_TRM_01_01_MD01247.pdf
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
