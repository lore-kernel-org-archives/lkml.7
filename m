Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F6C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C56721848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AjITiU4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfISFXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:23:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45766 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbfISFXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:23:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46YlcR0Mfhz9v4gb;
        Thu, 19 Sep 2019 07:23:19 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AjITiU4z; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id W0ZjiSo4UdoG; Thu, 19 Sep 2019 07:23:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46YlcQ6Qbkz9v4gY;
        Thu, 19 Sep 2019 07:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568870598; bh=U7o25f1gtEsBxQM8z6wcetUpJ35EiEndIk0n8Ib4tnA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AjITiU4z12BJw9kZqMy9qm6OfxEhLABIVX23Ntzy4PzVm9V3k5kgIdrT/EE1pFFxN
         XSee4lZqpXrFzjDWE8MH/8e8mqYyhe1DBSqNlThvuFHwkOHqOa1lexWcVUWxdD7K4q
         KtPbJzIlOEfrHp9Q+EbRVt024dLmQFDf6fxysRFM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B6FDE8B80B;
        Thu, 19 Sep 2019 07:23:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LHmi5fzDEdPX; Thu, 19 Sep 2019 07:23:19 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F0018B783;
        Thu, 19 Sep 2019 07:23:19 +0200 (CEST)
Subject: Re: [PATCH v3 2/2] powerpc/irq: inline call_do_irq() and
 call_do_softirq()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <d0b002c96cfc069a1bc7bafcac28defe5d7d3643.1568821668.git.christophe.leroy@c-s.fr>
 <5fb4aedadbd28b9849cf2fabe13392fb3b5cd3ed.1568821668.git.christophe.leroy@c-s.fr>
 <20190918163919.GH9749@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a7a46d1b-873c-1267-b8ca-615a7fabfd6b@c-s.fr>
Date:   Thu, 19 Sep 2019 07:23:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190918163919.GH9749@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/09/2019 à 18:39, Segher Boessenkool a écrit :
> Hi Christophe,
> 
> On Wed, Sep 18, 2019 at 03:48:20PM +0000, Christophe Leroy wrote:
>> call_do_irq() and call_do_softirq() are quite similar on PPC32 and
>> PPC64 and are simple enough to be worth inlining.
>>
>> Inlining them avoids an mflr/mtlr pair plus a save/reload on stack.
> 
> But you hardcode the calling sequence in inline asm, which for various
> reasons is not a great idea.
> 
>> +static inline void call_do_irq(struct pt_regs *regs, void *sp)
>> +{
>> +	register unsigned long r3 asm("r3") = (unsigned long)regs;
>> +
>> +	asm volatile(
>> +		"	"PPC_STLU"	1, %2(%1);\n"
>> +		"	mr		1, %1;\n"
>> +		"	bl		%3;\n"
>> +		"	"PPC_LL"	1, 0(1);\n" : "+r"(r3) :
>> +		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_irq) :
>> +		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
>> +		"r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
>> +}
> 
> I realise the original code had this...  Loading the old stack pointer
> value back from the stack creates a bottleneck (via the store->load
> forwarding it requires).  It could just use
>    addi 1,1,-(%2)
> here, which can also be written as
>    addi 1,1,%n2
> (that is portable to all architectures btw).

No, we switched stack before the bl call, we replaced r1 by r3 after 
saving r1 into r3 stack. Now we have to restore the original r1.

> 
> 
> Please write the  "+r"(r3)  on the next line?  Not on the same line as
> the multi-line template.  This make things more readable.
> 
> 
> I don't know if using functions as an "i" works properly...  It probably
> does, it's just not something that you see often :-)
> 
> 
> What about r2?  Various ABIs handle that differently.  This might make
> it impossible to share implementation between 32-bit and 64-bit for this.
> But we could add it to the clobber list worst case, that will always work.

Isn't r2 non-volatile on all ABIs ?

> 
> 
> So anyway, it looks to me like it will work.  Nice cleanup.  Would be
> better if you could do the call to __do_irq from C code, but maybe we
> cannot have everything ;-)

sparc do it the following way, is there no risk that GCC adds unwanted 
code inbetween that is not aware there the stack pointer has changed ?

void do_softirq_own_stack(void)
{
	void *orig_sp, *sp = softirq_stack[smp_processor_id()];

	sp += THREAD_SIZE - 192 - STACK_BIAS;

	__asm__ __volatile__("mov %%sp, %0\n\t"
			     "mov %1, %%sp"
			     : "=&r" (orig_sp)
			     : "r" (sp));
	__do_softirq();
	__asm__ __volatile__("mov %0, %%sp"
			     : : "r" (orig_sp));
}

If the above is no risk, then can we do the same on powerpc ?

> 
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks for the review.

Christophe
