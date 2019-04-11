Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87622C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB32083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RtC9Gz+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDKIGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:06:06 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:56244 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfDKIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:06:05 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x3B85ovK022788;
        Thu, 11 Apr 2019 17:05:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x3B85ovK022788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554969951;
        bh=ciNPnS0mdPi1pbiTIWn3ElqaMPzLQNgxCZgHkKyshe8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RtC9Gz+gGYbAqNpYhvsY6sbJF/VjrV+HEaJoy87oE8BqdZCpcNpF9qPC3EZDNxS+z
         tmbyoSZ6pZ45LplIaYa6hhd7wUC0h3jRb7XLSVy7GdN2ifp25Sg5iS38vpa9WNl+ty
         K4fCX/ArriGVUg9kVO5sWn8Qyko07uLsA00tP8/pR9/AKHxlL2gRY7Q3r36jQpqiCn
         9oRGnv6wTbSa2DSsZ+vJ2y+MkdiHSMY/6HqOobgJxY/w9a5JbScDITcIG5F7SIu5+t
         WqoTYM5bjfFF0IbgngU3wxAHO+Ax9EJkQXZJSjGoCsz+kqn1aTbJBs0F74yCqleFd5
         AbiN+QTMKudTA==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id s2so2967153vsi.5;
        Thu, 11 Apr 2019 01:05:50 -0700 (PDT)
X-Gm-Message-State: APjAAAU7i5ae0sB8cPYMuOm7ogXT6WdL/19t2sHmCR2gPPqQvYNyv7GW
        pxP55Rnob7VBo55A/mtA6iYvzmWMpQrIlz67GSE=
X-Google-Smtp-Source: APXvYqwsrysQssdws/LDnBZNjjb62k09lbKrnBPY0ouJLKzdRwMHQBLQtj0SL4X3ySFwDsf9B1WSDqdLZRu2LWEcZKM=
X-Received: by 2002:a67:fbcc:: with SMTP id o12mr28190778vsr.60.1554969949739;
 Thu, 11 Apr 2019 01:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190410161612.18545-1-keescook@chromium.org> <20190410161612.18545-4-keescook@chromium.org>
In-Reply-To: <20190410161612.18545-4-keescook@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 17:05:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpm5Tz_Fo0rSq00emB7BLnfYB-+mwXd9GiMKAqKCfkrA@mail.gmail.com>
Message-ID: <CAK7LNAQpm5Tz_Fo0rSq00emB7BLnfYB-+mwXd9GiMKAqKCfkrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: Implement Clang's stack initialization
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 1:16 AM Kees Cook <keescook@chromium.org> wrote:
>
> CONFIG_INIT_STACK_ALL turns on stack initialization based on
> -ftrivial-auto-var-init in Clang builds and on
> -fplugin-arg-structleak_plugin-byref-all in GCC builds.

Is CONFIG_INIT_STACK_ALL wired up to GCC plugin in any way?
I could not understand it from the code.


>
> -ftrivial-auto-var-init is a Clang flag that provides trivial
> initializers for uninitialized local variables, variable fields and
> padding.
>
> It has three possible values:
>   pattern - uninitialized locals are filled with a fixed pattern
>     (mostly 0xAA on 64-bit platforms, see https://reviews.llvm.org/D54604
>     for more details) likely to cause crashes when uninitialized value is
>     used;
>   zero (it's still debated whether this flag makes it to the official
>     Clang release) - uninitialized locals are filled with zeroes;
>   uninitialized (default) - uninitialized locals are left intact.
>
> The proposed config builds the kernel with
> -ftrivial-auto-var-init=pattern when selected.
>
> Developers have the possibility to opt-out of this feature on a
> per-variable basis by using __attribute__((uninitialized)).
>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Makefile                   |  5 +++++
>  security/Kconfig.hardening | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index c0a34064c574..a7d9c6cd0267 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -745,6 +745,11 @@ KBUILD_CFLAGS      += -fomit-frame-pointer
>  endif
>  endif
>
> +# Initialize all stack variables with a pattern, if desired.
> +ifdef CONFIG_INIT_STACK_ALL
> +KBUILD_CFLAGS  += -ftrivial-auto-var-init=pattern
> +endif
> +
>  DEBUG_CFLAGS   := $(call cc-option, -fno-var-tracking-assignments)
>
>  ifdef CONFIG_DEBUG_INFO
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 9942d9869864..d744e20140b4 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -19,9 +19,13 @@ config GCC_PLUGIN_STRUCTLEAK
>
>  menu "Memory initialization"
>
> +config CC_HAS_AUTO_VAR_INIT
> +       def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
> +
>  choice
>         prompt "Initialize kernel stack variables at function entry"
>         depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS
> +       default INIT_STACK_ALL if CC_HAS_AUTO_VAR_INIT

Why should this be enabled by default?
Ins't it a performance regression
since it inserts instructions in function prologue?





-- 
Best Regards
Masahiro Yamada
