Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B7C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7A220665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="S/RZMMQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbfGXOWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:22:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38693 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGXOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:22:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so22059924plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TsvF6gMlarlMCvq4Ol72LgeUXJwNy8VMRhpgIz3/Ho4=;
        b=S/RZMMQT5J2NfDBmL2ZKpf3BuXyaqu+M2mejR2KVj/LTbDmS7sWyJ/KFkSJN0GOJvM
         Jo51eYbaQY89ZT6RsuTh7KI/HqJ+uZmqs3BGwdJgUuhUclW1yeHgWPoo09tHiGRC4E7a
         otxkE+hPKTXOhAL66F+SIrvvVMsTO6T6m3crSPO3mU9kGku+Z8nwifvMRs0XCEBEGNut
         IsHmo+PnPS6ugFLexahQAyNXhN2LPHvH2r0LkpY2xe8EDCI6QO1rXLwVaj2pw9S/Iw0h
         thx8BCsm+4ub65qs9MK+rIYCqg3w3CjxX+lhirCYQQVOow8lWQlTWRr+ynovMUd6VF1Q
         1bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TsvF6gMlarlMCvq4Ol72LgeUXJwNy8VMRhpgIz3/Ho4=;
        b=Vw9G2UMrIA/pUgM9hcQQXXaM/kz7zSzLLvYgNKVQYuuGsEZzlq1QtcT0dEE16kzIWR
         E1LBGvquiIk/737WAb6I8h0mnfu59sqUjPgDdnMkWNcvI14+thyDoI6+VONd7yiXLeWH
         AQTOv69y+4PIdpX5rCaAKVlncAD5elQmqUSYWFrJwEHQYTxlMSwAK2dYf+LxmYBu4j4X
         ratdg/sK6qVs6l/RtQHwRBEdftwGpSdLLeKeh0brXi7Tb42+DfGD4Eeh73XHOPx2LhUk
         AQibVFPj0lkJwsfS+HGhkm0c1Z2xH5mfmy7YMEH5Ckr0qmIrULSCyxm86vsR4XUCBeFx
         kWTg==
X-Gm-Message-State: APjAAAVRGnhjXrEwXdWAkcX4/+nyb3eezzwMwVUo2SUVftK59Cjj+LtY
        kGpr9GWJmyuIQNZ91+98ZsyL4rEzZbo=
X-Google-Smtp-Source: APXvYqyzpTeFD6mUN5tbsvb9OTguocp51aldoBULkkclWfbGIM2of9+cJaQMVN/OBorYzdl5LvXyqw==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr87031475plv.106.1563978124596;
        Wed, 24 Jul 2019 07:22:04 -0700 (PDT)
Received: from brauner.io ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id f6sm48434494pga.50.2019.07.24.07.22.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:22:03 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:21:57 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        asolokha@kb.kras.ru
Subject: Re: [PATCH v2] powerpc: Wire up clone3 syscall
Message-ID: <20190724142155.ybrchvuhybvr64hx@brauner.io>
References: <20190724140259.23554-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190724140259.23554-1-mpe@ellerman.id.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:02:59AM +1000, Michael Ellerman wrote:
> Wire up the new clone3 syscall added in commit 7f192e3cd316 ("fork:
> add clone3").
> 
> This requires a ppc_clone3 wrapper, in order to save the non-volatile
> GPRs before calling into the generic syscall code. Otherwise we hit
> the BUG_ON in CHECK_FULL_REGS in copy_thread().
> 
> Lightly tested using Christian's test code on a Power8 LE VM.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  arch/powerpc/include/asm/unistd.h        | 1 +
>  arch/powerpc/kernel/entry_32.S           | 8 ++++++++
>  arch/powerpc/kernel/entry_64.S           | 5 +++++
>  arch/powerpc/kernel/syscalls/syscall.tbl | 1 +
>  4 files changed, 15 insertions(+)
> 
> v2: Add the wrapper for 32-bit as well, don't allow SPU programs to call
>     clone3 (switch ABI to nospu).
> 
> v1: https://lore.kernel.org/r/20190722132231.10169-1-mpe@ellerman.id.au
> 
> diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
> index 68473c3c471c..b0720c7c3fcf 100644
> --- a/arch/powerpc/include/asm/unistd.h
> +++ b/arch/powerpc/include/asm/unistd.h
> @@ -49,6 +49,7 @@
>  #define __ARCH_WANT_SYS_FORK
>  #define __ARCH_WANT_SYS_VFORK
>  #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SYS_CLONE3
>  
>  #endif		/* __ASSEMBLY__ */
>  #endif /* _ASM_POWERPC_UNISTD_H_ */
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 85fdb6d879f1..54fab22c9a43 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -597,6 +597,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
>  	stw	r0,_TRAP(r1)		/* register set saved */
>  	b	sys_clone
>  
> +	.globl	ppc_clone3
> +ppc_clone3:
> +	SAVE_NVGPRS(r1)
> +	lwz	r0,_TRAP(r1)
> +	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
> +	stw	r0,_TRAP(r1)		/* register set saved */
> +	b	sys_clone3
> +
>  	.globl	ppc_swapcontext
>  ppc_swapcontext:
>  	SAVE_NVGPRS(r1)
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index d9105fcf4021..0a0b5310f54a 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -487,6 +487,11 @@ _GLOBAL(ppc_clone)
>  	bl	sys_clone
>  	b	.Lsyscall_exit
>  
> +_GLOBAL(ppc_clone3)
> +       bl      save_nvgprs
> +       bl      sys_clone3
> +       b       .Lsyscall_exit
> +
>  _GLOBAL(ppc32_swapcontext)
>  	bl	save_nvgprs
>  	bl	compat_sys_swapcontext
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index f2c3bda2d39f..43f736ed47f2 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -516,3 +516,4 @@
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
> +435	nospu	clone3				ppc_clone3
> -- 
> 2.20.1
> 
