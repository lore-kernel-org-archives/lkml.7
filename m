Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8428C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFCA2173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="B4Ep/8ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLGJmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 04:42:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:35778 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGJmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 04:42:32 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47VPd03HwBz9vBLg;
        Sat,  7 Dec 2019 10:42:28 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=B4Ep/8ml; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id d_3RGbKnWPcz; Sat,  7 Dec 2019 10:42:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47VPd027Lcz9vBLf;
        Sat,  7 Dec 2019 10:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575711748; bh=XekAfQfjCrsOIBBGQUXM3t/8DTqHJcf7rK4qwVwGkME=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B4Ep/8mlsCxcmhyeUXCBLWwGr/ZSEuYoZufAfYBtWK91vaLbzrErBJKrSIGB1GH1e
         gfQSjzg7/jS3+wyCwaBq84lZBp7c2YhrS0E2bKy6E0buonXdXdnpSRr6LGV4ni82lC
         atAYAwGRwE+R3pE8rTxveWeJWFU+dmhQZCXpgLeo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62C398B797;
        Sat,  7 Dec 2019 10:42:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2Q_804NQ_ZmY; Sat,  7 Dec 2019 10:42:29 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E3688B772;
        Sat,  7 Dec 2019 10:42:28 +0100 (CET)
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and
 call_do_softirq()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr>
 <877e3tbvsa.fsf@mpe.ellerman.id.au>
 <20191121101552.GR16031@gate.crashing.org>
 <87y2w49rgo.fsf@mpe.ellerman.id.au> <20191125142556.GU9491@gate.crashing.org>
 <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr>
 <20191127145958.GG9491@gate.crashing.org>
 <2072e066-1ffb-867e-60ec-04a6bb9075c1@c-s.fr>
 <20191129184658.GR9491@gate.crashing.org>
 <ebc67964-e5a9-acd0-0011-61ba23692f7e@c-s.fr>
 <20191206205953.GQ3152@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2a22feca-d6d6-6cb0-6c76-035234fa8742@c-s.fr>
Date:   Sat, 7 Dec 2019 10:42:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191206205953.GQ3152@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/12/2019 à 21:59, Segher Boessenkool a écrit :
> On Wed, Dec 04, 2019 at 05:32:54AM +0100, Christophe Leroy wrote:
>> Le 29/11/2019 à 19:46, Segher Boessenkool a écrit :
>>> The existing call_do_irq isn't C code.  It doesn't do anything with r2,
>>> as far as I can see; __do_irq just gets whatever the caller of call_do_irq
>>> has.
>>>
>>> So I guess all the callers of call_do_irq have the correct r2 value always
>>> already?  In that case everything Just Works.
>>
>> Indeed, there is only one caller for call_do_irq() which is do_IRQ().
>> And do_IRQ() is also calling __do_irq() directly (when the stack pointer
>> is already set to IRQ stack). do_IRQ() and __do_irq() are both in
>> arch/powerpc/kernel/irq.c
>>
>> As far as I can see when replacing the call to call_do_irq() by a call
>> to __do_irq(), the compiler doesn't do anything special with r2, and
>> doesn't add any nop after the bl either, whereas for all calls outside
>> irq.c, there is a nop added. So I guess that's ok ?
> 
> If the compiler can see the callee wants the same TOC as the caller has,
> it does not arrange to set (and restore) it, no.  If it sees it may be
> different, it does arrange for that (and the linker then will check if
> it actually needs to do anything, and do that if needed).
> 
> In this case, the compiler cannot know the callee wants the same TOC,
> which complicates thing a lot -- but it all works out.

Do we have a way to make sure which TOC the functions are using ? Is 
there several TOC at all in kernel code ?

> 
>> Now that call_do_irq() is inlined, we can even define __do_irq() as static.
>>
>> And that's the same for do_softirq_own_stack(), it is only called from
>> do_softirq() which is defined in the same file as __do_softirq()
>> (kernel/softirq.c)
> 
> I think things can still go wrong if any of this is inlined into a kernel
> module?  Is there anything that prevents this / can this not happen for
> some fundamental reason I don't see?

This can't happen can it ?
do_softirq_own_stack() is an outline function, defined in powerpc irq.c
Its only caller is do_softirq() which is an outline function defined in 
kernel/softirq.c

That prevents inlining, doesn't it ?


Anyway, until we clarify all this I'll limit my patch to PPC32 which is 
where the real benefit is I guess.

At the end, maybe the solution should be to switch to IRQ stack 
immediately in the exception entry as x86_64 do ?

And do_softirq_own_stack() could be entirely written in assembly like 
x86_64 as well ?

Christophe
