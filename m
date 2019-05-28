Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49950C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286612075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfE1RDp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:03:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31366 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfE1RDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:03:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45D0YB2pz3z9tyRn;
        Tue, 28 May 2019 19:03:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zifMpZ7Ll3nN; Tue, 28 May 2019 19:03:42 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45D0YB21rQz9tyRm;
        Tue, 28 May 2019 19:03:42 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 0690589D; Tue, 28 May 2019 19:03:41 +0200 (CEST)
Received: from 37-170-84-163.coucou-networks.fr
 (37-170-84-163.coucou-networks.fr [37.170.84.163]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Tue, 28 May 2019 19:03:41 +0200
Date:   Tue, 28 May 2019 19:03:41 +0200
Message-ID: <20190528190341.Horde.nTXOule-IO2ReXFiNIqNbg8@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 14/16] powerpc/32: implement fast entry for syscalls
 on BOOKE
References: <cover.1556627571.git.christophe.leroy@c-s.fr>
 <3e254178a157e7eaeef48f983880f71f97d1f296.1556627571.git.christophe.leroy@c-s.fr>
 <20190523061427.GA19655@blackberry>
 <98bf5745-88ae-7f17-fcb9-7d06ba5b9e49@c-s.fr>
 <58f0e70f-ed9d-965e-e8d2-cc5d13a4c9eb@c-s.fr>
 <87r28jp2b0.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r28jp2b0.fsf@concordia.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 23/05/2019 à 09:00, Christophe Leroy a écrit :
>>
>> [...]
>>
>>>> arch/powerpc/kernel/head_fsl_booke.o: In function `SystemCall':
>>>> arch/powerpc/kernel/head_fsl_booke.S:416: undefined reference to
>>>> `kvmppc_handler_BOOKE_INTERRUPT_SYSCALL_SPRN_SRR1'
>>>> Makefile:1052: recipe for target 'vmlinux' failed
>>>>
>>>>> +.macro SYSCALL_ENTRY trapno intno
>>>>> +    mfspr    r10, SPRN_SPRG_THREAD
>>>>> +#ifdef CONFIG_KVM_BOOKE_HV
>>>>> +BEGIN_FTR_SECTION
>>>>> +    mtspr    SPRN_SPRG_WSCRATCH0, r10
>>>>> +    stw    r11, THREAD_NORMSAVE(0)(r10)
>>>>> +    stw    r13, THREAD_NORMSAVE(2)(r10)
>>>>> +    mfcr    r13            /* save CR in r13 for now       */
>>>>> +    mfspr    r11, SPRN_SRR1
>>>>> +    mtocrf    0x80, r11    /* check MSR[GS] without clobbering reg */
>>>>> +    bf    3, 1975f
>>>>> +    b    kvmppc_handler_BOOKE_INTERRUPT_\intno\()_SPRN_SRR1
>>>>
>>>> It seems to me that the "_SPRN_SRR1" on the end of this line
>>>> isn't meant to be there...  However, it still fails to link with that
>>>> removed.
>>
>> It looks like I missed the macro expansion.
>>
>> The called function should be kvmppc_handler_8_0x01B
>>
>> Seems like kisskb doesn't build any config like this.
>
> I thought we did, ie:
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/13817941/

That's a ppc64 config it seems. The problem was on booke32.

Christophe

>
> But clearly something is missing to trigger the bug.
>
> cheers


