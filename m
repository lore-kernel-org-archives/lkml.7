Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08DEC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B237121911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Sq5mZQtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfGVNhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:37:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35352 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGVNhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:37:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so39483922wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G+ee5z/udz98mpIWHmoiqwVolL/BB5iZ0zMxw+XvsZU=;
        b=Sq5mZQtKCd02zpB5GMq8UlqdCMCn44R31o3uvz8PqURSpo3xHrO5Wsy9F1/1PwzLUD
         XQ4GsW5DMoST9UCpxH3jpdCGH2r5gvxv2ojKeKRfRiQ1dgcTUF4tOhMY7cxy67VzGJ3T
         up1NIhnuO15UsA62wi2kXhzAEJ6XLZeUMnTuq442CZclG+Ap6X+zvziKN4qIRX5y+Rrh
         ymSNzDEhwEmpmObptc0CYQ4RB12Ld4lZZ0I4q4ZpSfk5Q12pHAFUOaB9rZ77d+QRydF5
         qPW+r2IkHHg/Ajg7rXcBOJYyXD/ZFR3lLe1Wbr+PoLy+03KJ3ig9A1ghvGtnEQDyPCp/
         W4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G+ee5z/udz98mpIWHmoiqwVolL/BB5iZ0zMxw+XvsZU=;
        b=hn3XehELWUT754BVpHOB/r6JuwFMEGVzqIXwSqG0neLr58n76wirUvx3yKMRZGnEiw
         rOKSbreorI5mMCasnmZKL+d0m8wDCp3y+BOhwWN1kijcx630EnnpVQCmRsjSn9r2kgfp
         ZagdV+GV/U8/XJ9LXWnGhbut+/pcXl2heJjvhHzYb90F8Z7RLLbAbldTacAn+K1S20dm
         7ff2bgdeqJ4U282meL3nRZCq8uPGMGKB3s0r+AZyryAG1B4uoCFGRs4tgykcq38mbQvB
         aVNJJh1tbnnwtjK1rk5BMD/exXbcQpFe/HNJ7Ns2GDKO2ov4bjuhdE5b4qKJlaqTsfh1
         M6gQ==
X-Gm-Message-State: APjAAAXwbbY8x07LvIrXvIcLb4QfQKtUe8D9js0rlu0iiNTMTd1G0w78
        tKRweTvu1PpMHogR2PeSEZBhh870sTw=
X-Google-Smtp-Source: APXvYqzJhfE8EvBrpbkoFUobwg2Lx87mEQnfE+2OVykFMcOs+cLD4+tU3KpIRwMfVKVQ/o9VIdRhzA==
X-Received: by 2002:adf:f246:: with SMTP id b6mr47557307wrp.92.1563802624016;
        Mon, 22 Jul 2019 06:37:04 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id a8sm30742274wma.31.2019.07.22.06.37.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:37:03 -0700 (PDT)
Date:   Mon, 22 Jul 2019 15:37:02 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Wire up clone3 syscall
Message-ID: <20190722133701.g3w5g4crogqb7oi5@brauner.io>
References: <20190722132231.10169-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722132231.10169-1-mpe@ellerman.id.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:22:31PM +1000, Michael Ellerman wrote:
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

Thank you, Michael!

One comment below, otherwise:

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  arch/powerpc/include/asm/unistd.h        | 1 +
>  arch/powerpc/kernel/entry_64.S           | 5 +++++
>  arch/powerpc/kernel/syscalls/syscall.tbl | 1 +
>  3 files changed, 7 insertions(+)
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
> index f2c3bda2d39f..6886ecb590d5 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -516,3 +516,4 @@
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
> +435	common	clone3				ppc_clone3

Note that in v5.3-rc1 there's now a comment that 435 is reserved in
there. So this will likely cause a merge conflict. You might want to
base your change off of v5.3-rc1 instead to avoid that. :)

So basically:

From 10b2e4176d712e45c7cb22af4aed4ce09818785c Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 22 Jul 2019 23:22:31 +1000
Subject: [PATCH] powerpc: Wire up clone3 syscall

Wire up the new clone3 syscall added in commit 7f192e3cd316 ("fork:
add clone3").

This requires a ppc_clone3 wrapper, in order to save the non-volatile
GPRs before calling into the generic syscall code. Otherwise we hit
the BUG_ON in CHECK_FULL_REGS in copy_thread().

Lightly tested using Christian's test code on a Power8 LE VM.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Christian Brauner <christian@brauner.io>
Link: https://lore.kernel.org/r/20190722132231.10169-1-mpe@ellerman.id.au
---
 arch/powerpc/include/asm/unistd.h        | 1 +
 arch/powerpc/kernel/entry_64.S           | 5 +++++
 arch/powerpc/kernel/syscalls/syscall.tbl | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 68473c3c471c..b0720c7c3fcf 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -49,6 +49,7 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 
 #endif		/* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d9105fcf4021..0a0b5310f54a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -487,6 +487,11 @@ _GLOBAL(ppc_clone)
 	bl	sys_clone
 	b	.Lsyscall_exit
 
+_GLOBAL(ppc_clone3)
+       bl      save_nvgprs
+       bl      sys_clone3
+       b       .Lsyscall_exit
+
 _GLOBAL(ppc32_swapcontext)
 	bl	save_nvgprs
 	bl	compat_sys_swapcontext
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 3331749aab20..6886ecb590d5 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -516,4 +516,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
-# 435 reserved for clone3
+435	common	clone3				ppc_clone3
-- 
2.22.0

