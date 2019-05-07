Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A04C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B9D2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="DaJtWWko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfEGQxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:53:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12678 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfEGQxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:53:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44z5K61W3Cz9tyhg;
        Tue,  7 May 2019 18:53:30 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=DaJtWWko; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OaKjzUDVVKym; Tue,  7 May 2019 18:53:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44z5K60SSPz9tycB;
        Tue,  7 May 2019 18:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557248010; bh=WprILXdm/abE/MEzyylSE7b5a084BNrypeqdWUqRY4c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DaJtWWkoS3t7AQul3FXtkjh6BnenaYM73Y6WLeliWA/9Qc/6HGyTYOGn3uiEqWgNU
         avZnC5MsawFt2k0j1cV+VNsf3QFyd0Mx1cV5TyD2kJ9JR9Ejkyk5MoTv0epBmxNXRW
         ARaY3YDe2G0lsBYelezWXO/ZeQZ605N8Rzanjoak=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA77E8B932;
        Tue,  7 May 2019 18:53:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FpuzyaJjCwg8; Tue,  7 May 2019 18:53:31 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B91D8B8CB;
        Tue,  7 May 2019 18:53:31 +0200 (CEST)
Subject: Re: [PATCH] powerpc: slightly improve cache helpers
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <0b460a85319fb89dab2c5d1200ac69a3e1b7c1ef.1557235807.git.christophe.leroy@c-s.fr>
 <20190507151030.GF8599@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <720e7c77-3f5c-83f3-6013-36b265c1ba73@c-s.fr>
Date:   Tue, 7 May 2019 18:53:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507151030.GF8599@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/05/2019 à 17:10, Segher Boessenkool a écrit :
> Hi Christophe,
> 
> On Tue, May 07, 2019 at 01:31:39PM +0000, Christophe Leroy wrote:
>> Cache instructions (dcbz, dcbi, dcbf and dcbst) take two registers
>> that are summed to obtain the target address. Using '%y0' argument
>> gives GCC the opportunity to use both registers instead of only one
>> with the second being forced to 0.
> 
> That's not quite right.  Sorry if I didn't explain it properly.
> 
> "m" allows all memory.  But this instruction only allows reg,reg and
> 0,reg addressing.  For that you need to use constraint "Z".

But gcc help 
(https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints) 
says it is better to use 'm':

Z

     Memory operand that is an indexed or indirect from a register (it 
is usually better to use ‘m’ or ‘es’ in asm statements)

That's the reason why I used 'm', I thought it was equivalent.

Christophe

> 
> The output modifier "%y0" just makes [reg] (i.e. simple indirect addressing)
> print as "0,reg" instead of "0(reg)" as it would by default (for just "%0").
> 
> 
> Segher
> 
