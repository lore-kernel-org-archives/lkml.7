Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AFFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA33A206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RElQVMX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfK0PPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:15:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3691 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfK0PPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:15:18 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NPTZ5Z5sz9v0vn;
        Wed, 27 Nov 2019 16:15:14 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=RElQVMX9; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eEa3dEyy4enE; Wed, 27 Nov 2019 16:15:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NPTZ4Wzmz9v0vj;
        Wed, 27 Nov 2019 16:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574867714; bh=xDzqAuKpsMI0fM1Nu2APkhHGF83sjAZj+b2lNk9mmCU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RElQVMX9+cCEQ78l0/J1L3DVbJxFsc0NztZpgSERF3y/OySvGhO+jQzlTNdzWyb64
         f+vTAMnbV/x1zA7L+63FgChsJ6lc31ydvuTMVMObuv0zcJFM8zhorlNmr3lRheuJgs
         VEUpw+GHSuU0PQLV6/W/oj5hu5sjavTHhRdzLf0o=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 253978B868;
        Wed, 27 Nov 2019 16:15:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TiWizM8GxlXJ; Wed, 27 Nov 2019 16:15:16 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 806FA8B85A;
        Wed, 27 Nov 2019 16:15:15 +0100 (CET)
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and
 call_do_softirq()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f12fb9a6cc52d83ee9ddf15a36ee12ac77e6379f.1570684298.git.christophe.leroy@c-s.fr>
 <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr>
 <877e3tbvsa.fsf@mpe.ellerman.id.au>
 <20191121101552.GR16031@gate.crashing.org>
 <87y2w49rgo.fsf@mpe.ellerman.id.au> <20191125142556.GU9491@gate.crashing.org>
 <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr>
 <20191127145958.GG9491@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2072e066-1ffb-867e-60ec-04a6bb9075c1@c-s.fr>
Date:   Wed, 27 Nov 2019 16:15:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191127145958.GG9491@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/11/2019 à 15:59, Segher Boessenkool a écrit :
> On Wed, Nov 27, 2019 at 02:50:30PM +0100, Christophe Leroy wrote:
>> So what do we do ? We just drop the "r2" clobber ?
> 
> You have to make sure your asm code works for all ABIs.  This is quite
> involved if you do a call to an external function.  The compiler does
> *not* see this call, so you will have to make sure that all that the
> compiler and linker do will work, or prevent some of those things (say,
> inlining of the function containing the call).

But the whole purpose of the patch is to inline the call to __do_irq() 
in order to avoid the trampoline function.

> 
>> Otherwise, to be on the safe side we can just save r2 in a local var
>> before the bl and restore it after. I guess it won't collapse CPU time
>> on a performant PPC64.
> 
> That does not fix everything.  The called function requires a specific
> value in r2 on entry.

Euh ... but there is nothing like that when using existing 
call_do_irq(). How does GCC know that call_do_irq() has same TOC as 
__do_irq() ?

> 
> So all this needs verification.  Hopefully you can get away with just
> not clobbering r2 (and not adding a nop after the bl), sure.  But this
> needs to be checked.
> 
> Changing control flow inside inline assembler always is problematic.
> Another problem in this case (on all ABIs) is that the compiler does
> not see you call __do_irq.  Again, you can probably get away with that
> too, but :-)

Anyway it sees I reference it, as it is in input arguments. Isn't it 
enough ?

Christophe
