Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD699C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C622084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="bYt8f7gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfKUGOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:14:51 -0500
Received: from ozlabs.org ([203.11.71.1]:57627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUGOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:14:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47JTmm1znCz9sPL;
        Thu, 21 Nov 2019 17:14:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574316888;
        bh=jdKLsx29Q9L7/ElLtLnnBgAqSCKsEsGccFSh1cgYUzQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bYt8f7gvy84TtwIJFpoHoCsN1Ip6mXbPnA3PKhBuLT6ZDv9SABp/q+fdL2ju85J8S
         Unr/SuCxT0jHSOFG1/rcDMDoLCv+0isuRc/8vXUOH691JLFpbuto2U1K2pb7Qh8C9G
         phdT9SUlqtQWry5HZkg4RnA3bOCkoF47YbNzZjSy2hxyFP8W227en1MMQz4q7xziMr
         AKQMbY6db0esZNwhFtUvmIHVEFo7NoDB5Xz52x9RFVtTlcMboj5mdWneAeCHIMdudV
         fRoEK5FDmMUbxXJ9+adoXYs6ipY5sBDtp++6B3x4bWChN70af3/OfG3VvfwZPyBbGZ
         w4Hd8xt01XjLw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
In-Reply-To: <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr>
References: <f12fb9a6cc52d83ee9ddf15a36ee12ac77e6379f.1570684298.git.christophe.leroy@c-s.fr> <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr>
Date:   Thu, 21 Nov 2019 17:14:45 +1100
Message-ID: <877e3tbvsa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> call_do_irq() and call_do_softirq() are quite similar on PPC32 and
> PPC64 and are simple enough to be worth inlining.
>
> Inlining them avoids an mflr/mtlr pair plus a save/reload on stack.
>
> This is inspired from S390 arch. Several other arches do more or
> less the same. The way sparc arch does seems odd thought.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
>
> ---
> v2: no change.
> v3: no change.
> v4:
> - comment reminding the purpose of the inline asm block.
> - added r2 as clobbered reg

That breaks 64-bit with GCC9:

  arch/powerpc/kernel/irq.c: In function 'do_IRQ':
  arch/powerpc/kernel/irq.c:650:2: error: PIC register clobbered by 'r2' in 'asm'
    650 |  asm volatile(
        |  ^~~
  arch/powerpc/kernel/irq.c: In function 'do_softirq_own_stack':
  arch/powerpc/kernel/irq.c:711:2: error: PIC register clobbered by 'r2' in 'asm'
    711 |  asm volatile(
        |  ^~~


> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 04204be49577..d62fe18405a0 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -642,6 +642,22 @@ void __do_irq(struct pt_regs *regs)
>  	irq_exit();
>  }
>  
> +static inline void call_do_irq(struct pt_regs *regs, void *sp)
> +{
> +	register unsigned long r3 asm("r3") = (unsigned long)regs;
> +
> +	/* Temporarily switch r1 to sp, call __do_irq() then restore r1 */
> +	asm volatile(
> +		"	"PPC_STLU"	1, %2(%1);\n"
> +		"	mr		1, %1;\n"
> +		"	bl		%3;\n"
> +		"	"PPC_LL"	1, 0(1);\n" :
> +		"+r"(r3) :
> +		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_irq) :
> +		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
> +		"r0", "r2", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
> +}

If we add a nop after the bl, so the linker could insert a TOC restore,
then I don't think there's any circumstance under which we expect this
to actually clobber r2, is there?

cheers
