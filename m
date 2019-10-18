Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85399CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCF0222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2GrSm+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505543AbfJRRcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:32:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43105 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfJRRce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:32:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so4291748pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUCkDiO1QUpPk5cl+dZgUeLa1d4lsLLAG2MEy31ElWU=;
        b=Q2GrSm+Odfy9jVEDqMmfnpv1JF6tDvJ9iXYBvf5rjH3en0ATo4AgQjw2pQDojlKoaS
         9fBS4aMFJ5dZwD9OigzTjU849InPSdBgGRC+uZEt3xD+a4RKHVALWELFRgwg2SA4Hrzq
         zb2RgQ0REmeyvR9a4FeSiZ73kVsr69wvb6c31MRdP3Bvd2XsEJze6gbRaEFiobpWXpeP
         Jy5YplzkCXmKDyVKqgUBpRu2Xoxis9XWxkxStyjOq8Q2jrPByqwE/lIB22HRWbIoxhAw
         w2b9PGOjxqmyIOBybNGNqSsdSOP6Tyg2PirfWZOi7lJ8gecCO3g1JCJKWpU8SIivdJr/
         RIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUCkDiO1QUpPk5cl+dZgUeLa1d4lsLLAG2MEy31ElWU=;
        b=m7kn+2MZp1Ww0Sekyl5VFZoPz6bEorh2H2I61DxdmGqhQZtkgvvdVjSgOhfgbg2P4y
         1D74g4lPkAKSMz1TkBzLtPuV6IqPxZ0NL77HSsATs6nOrQ9N2EisFU8Qj7hnldrOgtMo
         91ijKH7U2Ui/9Zwa07a7ANQQCHvhdKF/+Hh0uqEUNTiOuFlzRKI4EEmuLUnJZqy1DkHj
         z9L6UkqK3JsiC/IWYgvRA0PxU6rt6SUXQV6ScpebavGT1SzPjaDLVyJALVfunZsR37VA
         +jtJAA2jmxlgOp/m0wKUZn0PCMUkPbi6czmidNrLdTFxIBFFYccNZxHW/Pj8gjEiNppX
         T0gQ==
X-Gm-Message-State: APjAAAVCe/JBILHSEmXdYSPr2dFstJeKwgaSIMJo7xSUSVvlFrF1psuA
        oCyoic0jWG9HhQBT8X4rJ2bsl1MReq6paS8cM/7rPA==
X-Google-Smtp-Source: APXvYqyiP1Zzh4FMjPyyDPFh7Wpil1drk2/6fs3Sl6Id4xkJb/P7azXpHLFJ3B/tWIF35J82NWyTkkF5okrslIJan50=
X-Received: by 2002:a63:5448:: with SMTP id e8mr11186188pgm.10.1571419951879;
 Fri, 18 Oct 2019 10:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-6-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-6-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Oct 2019 10:32:20 -0700
Message-ID: <CAKwvOd=SZ+f6hiLb3_-jytcKMPDZ77otFzNDvbwpOSsNMnifSg@mail.gmail.com>
Subject: Re: [PATCH 05/18] arm64: kbuild: reserve reg x18 from general
 allocation by the compiler
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 9:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Before we can start using register x18 for a special purpose (as permitted
> by the AAPCS64 ABI), we need to tell the compiler that it is off limits
> for general allocation. So tag it as 'fixed',

yep, but...

> and remove the mention from
> the LL/SC compiler flag override.

was that cut/dropped from this patch?

>
> Link: https://patchwork.kernel.org/patch/9836881/

^ Looks like it. Maybe it doesn't matter, but if sending a V2, maybe
the commit message to be updated?

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

If sending a V2 with the above cleaned up, you may also include:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I like how this does not conditionally reserve it based on the CONFIG
for SCS.  Hopefully later patches don't wrap it, but I haven't looked
through all of them yet.

> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 2c0238ce0551..1c7b276bc7c5 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -55,7 +55,7 @@ endif
>
>  KBUILD_CFLAGS  += -mgeneral-regs-only $(lseinstr) $(brokengasinst)     \
>                    $(compat_vdso) $(cc_has_k_constraint)
> -KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
> +KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables -ffixed-x18
>  KBUILD_CFLAGS  += $(call cc-disable-warning, psabi)
>  KBUILD_AFLAGS  += $(lseinstr) $(brokengasinst) $(compat_vdso)
>
> --
> 2.23.0.866.gb869b98d4c-goog
>


-- 
Thanks,
~Nick Desaulniers
