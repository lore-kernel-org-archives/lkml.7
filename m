Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417E4C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D6D204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WYfoZ9wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfEWIKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:10:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6386 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfEWIKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:10:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 458hyX4xfVz9ty20;
        Thu, 23 May 2019 10:10:44 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WYfoZ9wX; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zj566mV9uPRn; Thu, 23 May 2019 10:10:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 458hyX3nmdz9ty1y;
        Thu, 23 May 2019 10:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558599044; bh=htOA7A7o8Wi6zLAJA9t7xk2NyPWEHzRDYWW5icgzEWw=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=WYfoZ9wXEi9c9wELKQjVpGLFo19AD+4x2oUqSwfOByliYQ1YqJnY/cKTd9NGmXq9Z
         34od+gBJaFvTP9w/sXWsoj0bMRsX/mrIXF/80Yl5K8BmAYm71PLd/6lTckK+oKj2u5
         AkU9ezqmXBB1/poEiDFUHNWtHECDO+e2aRLPUyWk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 90F1A8B781;
        Thu, 23 May 2019 10:10:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fX5nDcjC2Yuv; Thu, 23 May 2019 10:10:45 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 395578B77D;
        Thu, 23 May 2019 10:10:45 +0200 (CEST)
Subject: Re: [PATCH v3 14/16] powerpc/32: implement fast entry for syscalls on
 BOOKE
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
References: <cover.1556627571.git.christophe.leroy@c-s.fr>
 <3e254178a157e7eaeef48f983880f71f97d1f296.1556627571.git.christophe.leroy@c-s.fr>
 <20190523061427.GA19655@blackberry>
 <98bf5745-88ae-7f17-fcb9-7d06ba5b9e49@c-s.fr>
Message-ID: <58f0e70f-ed9d-965e-e8d2-cc5d13a4c9eb@c-s.fr>
Date:   Thu, 23 May 2019 10:10:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <98bf5745-88ae-7f17-fcb9-7d06ba5b9e49@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/05/2019 à 09:00, Christophe Leroy a écrit :

[...]


> 
>>
>> arch/powerpc/kernel/head_fsl_booke.o: In function `SystemCall':
>> arch/powerpc/kernel/head_fsl_booke.S:416: undefined reference to 
>> `kvmppc_handler_BOOKE_INTERRUPT_SYSCALL_SPRN_SRR1'
>> Makefile:1052: recipe for target 'vmlinux' failed
>>
>>> +.macro SYSCALL_ENTRY trapno intno
>>> +    mfspr    r10, SPRN_SPRG_THREAD
>>> +#ifdef CONFIG_KVM_BOOKE_HV
>>> +BEGIN_FTR_SECTION
>>> +    mtspr    SPRN_SPRG_WSCRATCH0, r10
>>> +    stw    r11, THREAD_NORMSAVE(0)(r10)
>>> +    stw    r13, THREAD_NORMSAVE(2)(r10)
>>> +    mfcr    r13            /* save CR in r13 for now       */
>>> +    mfspr    r11, SPRN_SRR1
>>> +    mtocrf    0x80, r11    /* check MSR[GS] without clobbering reg */
>>> +    bf    3, 1975f
>>> +    b    kvmppc_handler_BOOKE_INTERRUPT_\intno\()_SPRN_SRR1
>>
>> It seems to me that the "_SPRN_SRR1" on the end of this line
>> isn't meant to be there...  However, it still fails to link with that
>> removed.

It looks like I missed the macro expansion.

The called function should be kvmppc_handler_8_0x01B

Seems like kisskb doesn't build any config like this.

Christophe

> 
> This SYSCALL_ENTRY macro is a slimmed version of NORMAL_EXCEPTION_PROLOG()
> 
> In NORMAL_EXCEPTION_PROLOG(), we have:
>      DO_KVM    BOOKE_INTERRUPT_##intno SPRN_SRR1;
> 
> The _SPRN_SRR1 comes from there
> 
> 
> Then in /arch/powerpc/include/asm/kvm_booke_hv_asm.h:
> 
> .macro DO_KVM intno srr1
> #ifdef CONFIG_KVM_BOOKE_HV
> BEGIN_FTR_SECTION
>      mtocrf    0x80, r11    /* check MSR[GS] without clobbering reg */
>      bf    3, 1975f
>      b    kvmppc_handler_\intno\()_\srr1
> 1975:
> END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
> #endif
> .endm
> 
> 
> Christophe
