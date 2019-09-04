Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1EF21881
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzBRjN/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfIDWTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:19:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33984 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIDWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:19:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id r12so293641pfh.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAKv5eY0ztO3m4xAEUNoNojMwgMq+ljdxAZW09mQ/Sg=;
        b=dzBRjN/ucSOV3jwvHQwMfI/0wj070a5lY8VIXgT8XfjPx2PzY+GtPjQmZbWdly8vy3
         /SSFqcbOTU4au8bMFh7njPTZpqmPbvl5uhr1nubZucFgsr8InizNpH5S/6nTVfMA6dS4
         SIN20VVWC+QBMDvBBhmsoPP74za2Dmz67gvPG0QEskSDtu1QnEt3+/kusHQDzLVmQrRX
         yQ+xJVRiIkFLOrnZCcG7ioHGi4NQk8W5U8CEi5H2xJEbtIXZaVCPaVsH8KFH9b6O10KM
         xRHtIsnz1hddG2ACGGgwCX0QVqfDVoRS7rL1O6D1Jx2Rp8e6lkrC1VxUhE3zHUV6T/4C
         9+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAKv5eY0ztO3m4xAEUNoNojMwgMq+ljdxAZW09mQ/Sg=;
        b=NcKurwVE6lpeiBSRYVIiAtHQxwPjwc4HeFtcxxR4SGvtrw43xs1v/M3V48ouZNR2Ux
         7v94kXXtNwF3Dc4Xhq+iyyohFvCatwy4xSV9B7ZF3ZqwdJq0m0oUVMrfrNwhFbZwF+54
         FK2w9MQnrSdJZsCUp9AB0x4PNrkCd7Ci2k6CjynnNgDtvKkPAZZLv2ORCx+qY/DXpk2u
         U1NjN8U/LioW+pXa/H8JukXS8AU8iq72X2ez1e2Fw1MyKnvSEA6EHbBDgVf95ial5eIx
         +jC1t693pbYZ9Wt1V6t8l/Ss4qFu2LorV9hDhN/zaTFAjeirq+xPI1ypud+TXxhm03qI
         6Vbg==
X-Gm-Message-State: APjAAAVFWpc8eK+qLgqMGHem8mkUrUaEmwsdN97QzMkhJU4DBymp+o3w
        wEBEWotfvrigFPl0VyEOh9ucLcrxNAOHH3V5BL2FEQ==
X-Google-Smtp-Source: APXvYqxn0dC4df7ySz7Ign/zQhGvKksuZ4RTZDiYA2wh5Pk0C2bIUhxSQVO7SYNkZAPaVOc1+D6wFljCKKYwPigrgOE=
X-Received: by 2002:a62:cec4:: with SMTP id y187mr9962pfg.84.1567635550318;
 Wed, 04 Sep 2019 15:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190904214505.GA15093@swahl-linux>
In-Reply-To: <20190904214505.GA15093@swahl-linux>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Sep 2019 15:18:58 -0700
Message-ID: <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
To:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ (folks recommended by ./scripts/get_maintainer.pl <patchfile>)
(See also, step 7:
https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/)

On Wed, Sep 4, 2019 at 2:45 PM Steve Wahl <steve.wahl@hpe.com> wrote:
>
> The last change to this Makefile caused relocation errors when loading

It's good to add a fixes tag like below when a patch fixes a
regression, so that stable backports the fix as far back as the
regression:
Fixes: b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
reset KBUILD_CFLAGS")

> a kdump kernel.  This change restores the appropriate flags, without
> reverting to the former practice of resetting KBUILD_CFLAGS.
>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  arch/x86/purgatory/Makefile | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 8901a1f89cf5..9f0bfef1f5db 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -18,37 +18,40 @@ targets += purgatory.ro
>  KASAN_SANITIZE := n
>  KCOV_INSTRUMENT := n
>
> +# These are adjustments to the compiler flags used for objects that
> +# make up the standalone porgatory.ro
> +
> +PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss

Thanks for confirming the fix.  While it sounds like -mcmodel=large is
the only necessary change, I don't object to -ffreestanding of
-fno-zero-initialized-in-bss being readded, especially since I think
what you've done with PURGATORY_CFLAGS_REMOVE is more concise.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Vaibhav, do you still have an environment setup to quickly test this
again w/ Clang builds?
Tglx, we'll likely want to get this into 5.3 if it's not too late (I
saw Miguel Ojeda mention there might be an -rc8)?

> +
>  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
>  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
>  # sure how to relocate those.
>  ifdef CONFIG_FUNCTION_TRACER
> -CFLAGS_REMOVE_sha256.o         += $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_purgatory.o      += $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_string.o         += $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_kexec-purgatory.o        += $(CC_FLAGS_FTRACE)
> +PURGATORY_CFLAGS_REMOVE                += $(CC_FLAGS_FTRACE)
>  endif
>
>  ifdef CONFIG_STACKPROTECTOR
> -CFLAGS_REMOVE_sha256.o         += -fstack-protector
> -CFLAGS_REMOVE_purgatory.o      += -fstack-protector
> -CFLAGS_REMOVE_string.o         += -fstack-protector
> -CFLAGS_REMOVE_kexec-purgatory.o        += -fstack-protector
> +PURGATORY_CFLAGS_REMOVE                += -fstack-protector
>  endif
>
>  ifdef CONFIG_STACKPROTECTOR_STRONG
> -CFLAGS_REMOVE_sha256.o         += -fstack-protector-strong
> -CFLAGS_REMOVE_purgatory.o      += -fstack-protector-strong
> -CFLAGS_REMOVE_string.o         += -fstack-protector-strong
> -CFLAGS_REMOVE_kexec-purgatory.o        += -fstack-protector-strong
> +PURGATORY_CFLAGS_REMOVE                += -fstack-protector-strong
>  endif
>
>  ifdef CONFIG_RETPOLINE
> -CFLAGS_REMOVE_sha256.o         += $(RETPOLINE_CFLAGS)
> -CFLAGS_REMOVE_purgatory.o      += $(RETPOLINE_CFLAGS)
> -CFLAGS_REMOVE_string.o         += $(RETPOLINE_CFLAGS)
> -CFLAGS_REMOVE_kexec-purgatory.o        += $(RETPOLINE_CFLAGS)
> +PURGATORY_CFLAGS_REMOVE                += $(RETPOLINE_CFLAGS)
>  endif
>
> +CFLAGS_REMOVE_purgatory.o      += $(PURGATORY_CFLAGS_REMOVE)
> +CFLAGS_purgatory.o             += $(PURGATORY_CFLAGS)
> +
> +CFLAGS_REMOVE_sha256.o         += $(PURGATORY_CFLAGS_REMOVE)
> +CFLAGS_sha256.o                        += $(PURGATORY_CFLAGS)
> +
> +CFLAGS_REMOVE_string.o         += $(PURGATORY_CFLAGS_REMOVE)
> +CFLAGS_string.o                        += $(PURGATORY_CFLAGS)
> +
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>                 $(call if_changed,ld)
>
> --
> 2.12.3
>


-- 
Thanks,
~Nick Desaulniers
