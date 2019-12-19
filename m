Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F536222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hJIh69rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLSG52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:57:28 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59997 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfLSG52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:57:28 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47djP031Kbz9v02n;
        Thu, 19 Dec 2019 07:57:24 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hJIh69rg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4zsNDiTYkOWZ; Thu, 19 Dec 2019 07:57:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47djP01xGSz9v02k;
        Thu, 19 Dec 2019 07:57:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576738644; bh=MBZphaLvN7Y7xmwStybWkMj7P7KceZL2/izi15FLe2g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hJIh69rgLLxnthcBrxF/1T3c0JibNrCX6uPNuvFpD9JKNNTFiQ78GrSzXnDytU/K0
         /7Mg5YCcJule+LCPv+0KhJr3JKa9QA/Lg0A7glx6nveEy6UMuPgb99JBWJyfvyZxoI
         Ltss9EiGr/yr4PRRdkd7lg7xM3qM03AlU5gRdXlo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24BAF8B784;
        Thu, 19 Dec 2019 07:57:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1Y6LUm90Zee9; Thu, 19 Dec 2019 07:57:25 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B24F8B756;
        Thu, 19 Dec 2019 07:57:24 +0100 (CET)
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and
 call_do_softirq()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20191121101552.GR16031@gate.crashing.org>
 <87y2w49rgo.fsf@mpe.ellerman.id.au> <20191125142556.GU9491@gate.crashing.org>
 <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr>
 <20191127145958.GG9491@gate.crashing.org>
 <2072e066-1ffb-867e-60ec-04a6bb9075c1@c-s.fr>
 <20191129184658.GR9491@gate.crashing.org>
 <ebc67964-e5a9-acd0-0011-61ba23692f7e@c-s.fr>
 <20191206205953.GQ3152@gate.crashing.org>
 <2a22feca-d6d6-6cb0-6c76-035234fa8742@c-s.fr>
 <20191207174057.GY3152@gate.crashing.org> <878snlrcrs.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <4668c204-3064-0e9e-5216-e7853f732821@c-s.fr>
Date:   Thu, 19 Dec 2019 07:57:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <878snlrcrs.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/12/2019 à 11:53, Michael Ellerman a écrit :
> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> On Sat, Dec 07, 2019 at 10:42:28AM +0100, Christophe Leroy wrote:
>>> Le 06/12/2019 à 21:59, Segher Boessenkool a écrit :
>>>> If the compiler can see the callee wants the same TOC as the caller has,
>>>> it does not arrange to set (and restore) it, no.  If it sees it may be
>>>> different, it does arrange for that (and the linker then will check if
>>>> it actually needs to do anything, and do that if needed).
>>>>
>>>> In this case, the compiler cannot know the callee wants the same TOC,
>>>> which complicates thing a lot -- but it all works out.
>>>
>>> Do we have a way to make sure which TOC the functions are using ? Is
>>> there several TOC at all in kernel code ?
>>
>> Kernel modules have their own TOC, I think?
> 
> Yes.

Yes, this means that exported functions have to care about that, right ?
And that's the reason why exported assembly functions like copy_page() 
use _GLOBAL_TOC() and not _GLOBAL()

But main part of the kernel only has one TOC, so r2 can be assumed 
constant for non exported functions, can't it ?

> 
>>>> I think things can still go wrong if any of this is inlined into a kernel
>>>> module?  Is there anything that prevents this / can this not happen for
>>>> some fundamental reason I don't see?
>>>
>>> This can't happen can it ?
>>> do_softirq_own_stack() is an outline function, defined in powerpc irq.c
>>> Its only caller is do_softirq() which is an outline function defined in
>>> kernel/softirq.c
>>>
>>> That prevents inlining, doesn't it ?
>>
>> Hopefully, sure.  Would be nice if it was clearer that this works...  It
>> is too much like working by chance, the way it is :-(
> 
> There's no way any of that code can end up in a module. Or at least if
> there is, that's a bug.

That's my conclusion as well. So I guess we can consider r2 as constant 
over those functions.

> 
>>> Anyway, until we clarify all this I'll limit my patch to PPC32 which is
>>> where the real benefit is I guess.
>>>
>>> At the end, maybe the solution should be to switch to IRQ stack
>>> immediately in the exception entry as x86_64 do ?
> 
> Yeah that might be cleaner.
> 

I prepared a patch for that on PPC32, but it doesn't get rid of the IRQ 
stack switch completely because do_IRQ() is also called from other 
places like the timer interrupt.

And we will still have the switch for softirqs. We could move 
do_softirq_own_stack() to assembly and merge it with call_do_softirq(), 
but a find it cleaner to inline call_do_softirq() instead, now that we 
have demonstrated that r2 can't change.

Christophe
