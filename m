Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71297C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A1820883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfE1Fh3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:37:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53543 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfE1Fh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:37:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45CjKM0Ldgz9sB3;
        Tue, 28 May 2019 15:37:27 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 14/16] powerpc/32: implement fast entry for syscalls on BOOKE
In-Reply-To: <58f0e70f-ed9d-965e-e8d2-cc5d13a4c9eb@c-s.fr>
References: <cover.1556627571.git.christophe.leroy@c-s.fr> <3e254178a157e7eaeef48f983880f71f97d1f296.1556627571.git.christophe.leroy@c-s.fr> <20190523061427.GA19655@blackberry> <98bf5745-88ae-7f17-fcb9-7d06ba5b9e49@c-s.fr> <58f0e70f-ed9d-965e-e8d2-cc5d13a4c9eb@c-s.fr>
Date:   Tue, 28 May 2019 15:37:23 +1000
Message-ID: <87r28jp2b0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 23/05/2019 à 09:00, Christophe Leroy a écrit :
>
> [...]
>
>>> arch/powerpc/kernel/head_fsl_booke.o: In function `SystemCall':
>>> arch/powerpc/kernel/head_fsl_booke.S:416: undefined reference to 
>>> `kvmppc_handler_BOOKE_INTERRUPT_SYSCALL_SPRN_SRR1'
>>> Makefile:1052: recipe for target 'vmlinux' failed
>>>
>>>> +.macro SYSCALL_ENTRY trapno intno
>>>> +    mfspr    r10, SPRN_SPRG_THREAD
>>>> +#ifdef CONFIG_KVM_BOOKE_HV
>>>> +BEGIN_FTR_SECTION
>>>> +    mtspr    SPRN_SPRG_WSCRATCH0, r10
>>>> +    stw    r11, THREAD_NORMSAVE(0)(r10)
>>>> +    stw    r13, THREAD_NORMSAVE(2)(r10)
>>>> +    mfcr    r13            /* save CR in r13 for now       */
>>>> +    mfspr    r11, SPRN_SRR1
>>>> +    mtocrf    0x80, r11    /* check MSR[GS] without clobbering reg */
>>>> +    bf    3, 1975f
>>>> +    b    kvmppc_handler_BOOKE_INTERRUPT_\intno\()_SPRN_SRR1
>>>
>>> It seems to me that the "_SPRN_SRR1" on the end of this line
>>> isn't meant to be there...  However, it still fails to link with that
>>> removed.
>
> It looks like I missed the macro expansion.
>
> The called function should be kvmppc_handler_8_0x01B
>
> Seems like kisskb doesn't build any config like this.

I thought we did, ie:

http://kisskb.ellerman.id.au/kisskb/buildresult/13817941/

But clearly something is missing to trigger the bug.

cheers
