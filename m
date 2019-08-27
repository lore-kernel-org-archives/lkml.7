Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F06321881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AXC0Iinr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfH0Rgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:36:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28536 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbfH0Rgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:36:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Hwz632mTz9tyrl;
        Tue, 27 Aug 2019 19:36:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AXC0Iinr; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id cuWs3_gLhMA1; Tue, 27 Aug 2019 19:36:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Hwz61y2Wz9tyrk;
        Tue, 27 Aug 2019 19:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566927394; bh=0gPnQpLf9Wqj7O9R7C4EIhWCHGiWw04JtalxldivfQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AXC0IinrG+UQC9iKNtf3Y2TOhFWGci8meumdvTe0uYdjywUrHHP3HE9a8vCiH+5Aj
         3RbPZCoxuN+ejy+t8PBTP+rdM+V/0AUAiLxZ3O1akQypiRVRu5QjhDGEddYo1+uBKT
         eBmTQWHlg9FW7z6rS4WgxFXP4x4e4B4Q6oJD7mnU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B9FC8B847;
        Tue, 27 Aug 2019 19:36:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bnlc51y8JHfR; Tue, 27 Aug 2019 19:36:35 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 778B58B842;
        Tue, 27 Aug 2019 19:36:35 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc: cleanup hw_irq.h
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <0f7e164afb5d1b022441559fe5a999bb6d3c0a23.1566893505.git.christophe.leroy@c-s.fr>
 <81f39fa06ae582f4a783d26abd2b310204eba8f4.1566893505.git.christophe.leroy@c-s.fr>
 <1566909844.x4jee1jjda.astroid@bobo.none>
 <20190827172909.GA31406@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1410046b-e1a3-b892-2add-6c1d353cb781@c-s.fr>
Date:   Tue, 27 Aug 2019 19:36:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827172909.GA31406@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/08/2019 à 19:29, Segher Boessenkool a écrit :
> On Tue, Aug 27, 2019 at 10:48:24PM +1000, Nicholas Piggin wrote:
>> Christophe Leroy's on August 27, 2019 6:13 pm:
>>> +#define wrtee(val)	asm volatile("wrtee %0" : : "r" (val) : "memory")
>>> +#define wrteei(val)	asm volatile("wrteei %0" : : "i" (val) : "memory")
>>
>> Can you implement just one macro that uses __builtin_constant_p to
>> select between the imm and reg versions? I forgot if there's some
>> corner cases that prevent that working with inline asm i constraints.
> 
> static inline void wrtee(long val)
> {
> 	asm volatile("wrtee%I0 %0" : : "n"(val) : "memory");
> }

Great, didn't know that possibility.

Can it be used with any insn, for instance with add/addi ?
Or with mr/li ?

> 
> (This output modifier goes back to the dark ages, some 2.4 or something).

Hope Clang support it ...

Christophe

> 
> 
> Segher
> 
