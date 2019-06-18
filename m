Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A398BC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9D620679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="n36fD+f8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfFRMoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:44:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2131 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:44:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Snnt4lwTz9tyqH;
        Tue, 18 Jun 2019 14:44:02 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=n36fD+f8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nbcFWjQId3Oz; Tue, 18 Jun 2019 14:44:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Snnt3jXQz9tyqF;
        Tue, 18 Jun 2019 14:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560861842; bh=PPGY0wzKrjpG/skXEgA6qaUxme8C35MPyZr+/HeM9oE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n36fD+f80hVDyGSeJHi3msRfk1FDLx2PFiNYGR9SCRR4TK+UOAJTcn8MUxK3gfFm5
         bpR37iwIxh2lzWcPYg4lUUVeos+okdbcJSv32eVdIOYxn1wQODcEiHWvace5St9lDy
         FB4IDUr/CCcRLkWPM34aXzKAIwJFAcync8a4NPuY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EFDC8B8AA;
        Tue, 18 Jun 2019 14:44:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6TmhG7-Z5gS9; Tue, 18 Jun 2019 14:44:02 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EC678B872;
        Tue, 18 Jun 2019 14:44:02 +0200 (CEST)
Subject: Re: [PATCH] powerpc/32s: fix initial setup of segment registers on
 secondary CPU
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, erhard_f@mailbox.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <be07403806abc56ec027f6d47468411876e18bb5.1560267983.git.christophe.leroy@c-s.fr>
 <b60946f5-dc70-61ce-e266-af91890cb702@c-s.fr>
 <87h88noz1d.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <81d8101a-c0b6-a316-5844-e0901300e4e4@c-s.fr>
Date:   Tue, 18 Jun 2019 14:44:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <87h88noz1d.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/06/2019 à 14:31, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 11/06/2019 à 17:47, Christophe Leroy a écrit :
>>> The patch referenced below moved the loading of segment registers
>>> out of load_up_mmu() in order to do it earlier in the boot sequence.
>>> However, the secondary CPU still needs it to be done when loading up
>>> the MMU.
>>>
>>> Reported-by: Erhard F. <erhard_f@mailbox.org>
>>> Fixes: 215b823707ce ("powerpc/32s: set up an early static hash table for KASAN")
>>
>> Cc: stable@vger.kernel.org
> 
> Sorry patchwork didn't pick that up and I missed it. The AUTOSEL bot
> will probably pick it up anyway though.

Don't worry, this was unneeded because we added KASAN in 5.2.
My mistake.
Christophe

> 
> cheers
> 
>>> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
>>> index 1d5f1bd0dacd..f255e22184b4 100644
>>> --- a/arch/powerpc/kernel/head_32.S
>>> +++ b/arch/powerpc/kernel/head_32.S
>>> @@ -752,6 +752,7 @@ __secondary_start:
>>>    	stw	r0,0(r3)
>>>    
>>>    	/* load up the MMU */
>>> +	bl	load_segment_registers
>>>    	bl	load_up_mmu
>>>    
>>>    	/* ptr to phys current thread */
>>>
