Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D554EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFF420674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JjS7Yv8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfK0Nud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:50:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34507 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfK0Nud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:50:33 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NMbp056Yz9v0wq;
        Wed, 27 Nov 2019 14:50:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=JjS7Yv8C; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bJT7dAplImvV; Wed, 27 Nov 2019 14:50:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NMbn68C4z9v0wn;
        Wed, 27 Nov 2019 14:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574862629; bh=rc+q1YoGmH8a8vOMoySCGs9Lx4sR0OvYwsYXLQE8hK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JjS7Yv8CRT6AYv05rwiqTYrHkvuMAoCYFRbvpXPD/IhW2BKTP2ebY27gNskuXOzfs
         K5u5woB4w0I4IrEw3jKEHlc2J0kep7WnIXAXNATcpXktTNT5jxxEfSeSPFw71Ta/tI
         QunQAsQzWMZ2CYxGQVqlfspDAllEa8g7CrQsIKXU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 466118B861;
        Wed, 27 Nov 2019 14:50:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gHllTL7Lgrj0; Wed, 27 Nov 2019 14:50:31 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CCC198B85A;
        Wed, 27 Nov 2019 14:50:30 +0100 (CET)
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and
 call_do_softirq()
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f12fb9a6cc52d83ee9ddf15a36ee12ac77e6379f.1570684298.git.christophe.leroy@c-s.fr>
 <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr>
 <877e3tbvsa.fsf@mpe.ellerman.id.au>
 <20191121101552.GR16031@gate.crashing.org>
 <87y2w49rgo.fsf@mpe.ellerman.id.au> <20191125142556.GU9491@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr>
Date:   Wed, 27 Nov 2019 14:50:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191125142556.GU9491@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/11/2019 à 15:25, Segher Boessenkool a écrit :
> On Mon, Nov 25, 2019 at 09:32:23PM +1100, Michael Ellerman wrote:
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>>>>> +static inline void call_do_irq(struct pt_regs *regs, void *sp)
>>>>> +{
>>>>> +	register unsigned long r3 asm("r3") = (unsigned long)regs;
>>>>> +
>>>>> +	/* Temporarily switch r1 to sp, call __do_irq() then restore r1 */
>>>>> +	asm volatile(
>>>>> +		"	"PPC_STLU"	1, %2(%1);\n"
>>>>> +		"	mr		1, %1;\n"
>>>>> +		"	bl		%3;\n"
>>>>> +		"	"PPC_LL"	1, 0(1);\n" :
>>>>> +		"+r"(r3) :
>>>>> +		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_irq) :
>>>>> +		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
>>>>> +		"r0", "r2", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
>>>>> +}
>>>>
>>>> If we add a nop after the bl, so the linker could insert a TOC restore,
>>>> then I don't think there's any circumstance under which we expect this
>>>> to actually clobber r2, is there?
>>>
>>> That is mostly correct.
>>
>> That's the standard I aspire to :P
>>
>>> If call_do_irq was a no-inline function, there would not be problems.
>>>
>>> What TOC does __do_irq require in r2 on entry, and what will be there
>>> when it returns?
>>
>> The kernel TOC, and also the kernel TOC, unless something's gone wrong
>> or I'm missing something.
> 
> If that is the case, we can just do the bl, no nop at all?  And that works
> for all of our ABIs.
> 
> If we can be certain that we have the kernel TOC in r2 on entry to
> call_do_irq, that is!  (Or it establishes it itself).

So what do we do ? We just drop the "r2" clobber ?

Otherwise, to be on the safe side we can just save r2 in a local var 
before the bl and restore it after. I guess it won't collapse CPU time 
on a performant PPC64.

Christophe
