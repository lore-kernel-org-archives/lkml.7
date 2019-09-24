Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014EFC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02002054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOP5zBgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407377AbfIXQ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:58:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38445 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410414AbfIXQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:47:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so1710128pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eg3k9f7VurRwzf46jcAwPnzOmV7EyviW3zf+/O2RKTw=;
        b=vOP5zBgVX1pzcnG4/sH4K1pjbBqpnVYfSbP4/qi5UweyHcgj2vklkeP2uyHN8OsDnx
         01xi0g12DQXBFoHEG6N04ShMB8Tb3g6zWU0DCT1aDpOKn8ckPw5jKCulw2FqTnD+K45T
         1bhEzo2/lVTkbGTE85pEV7JL1+UyRODSsjjnIRIKk3n0Rj+r2WK+VA+R80PeZCHpwIAr
         ++JYKYeUXHQCJa/scCSxC9La632MXbzdbvxhXToajlbTHsoV+A6dmh6e9JlCsFS9vHAV
         rYuLmWMJFNvEWCB1M5KeFNJGOIr7YwWVvG8/Kog4ROjXe/TvPiMBayjV1/m4fTjLc/D5
         xk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eg3k9f7VurRwzf46jcAwPnzOmV7EyviW3zf+/O2RKTw=;
        b=W3eaQaWHkbxc1qfwC9oGk3GDMx9mFYRe/iSDNQEU5BwJYt0RQ7y2kg2+FJ7k/YES4J
         0q1/LIE0Av2IcqMomNgzkVQuWD9TNdU+o91iOIK66KdNWqOS20kiVN1O+Es+fi/l0Ndp
         qL+itSS4Uhr945wxGt50Lscku90sndz6bS35JbG4ok45z3gXV7mHJZlz95o4JoUIBeEN
         W3j/yX/t/YXDZFG6cuPZewUwpWs7ozFKsDMG9KNL4cww8LEHkS1clp1S5yqdUAqTOeWW
         fTrO8613pFWaL7wVvH1AsHL/4CWSSht8n1O4d63nhnc/gLC5bdOAg/nXKzH+Ohp2Nngc
         Ns0Q==
X-Gm-Message-State: APjAAAUnmua7kiN0tuh7U6jS7CEQDg81VVQGVTMRzZjaHA/HW65KML7c
        d7Z1hSKEnW71mENQVEMRilE0mO8+2lepKbnT8m0Yng==
X-Google-Smtp-Source: APXvYqzHQL7f14LNZsEHgTkF79WPuoGKOhn296bYISGkx7n4picFyC3Il0HPjOJxT0GsWDx9sLojnGag0Yvg6RxPVZs=
X-Received: by 2002:a63:d908:: with SMTP id r8mr4073008pgg.263.1569343667548;
 Tue, 24 Sep 2019 09:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190921064954.11196-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190921064954.11196-1-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Sep 2019 09:47:36 -0700
Message-ID: <CAKwvOdnmYCbZiFKrvzwjJWmhzn5X+rKSs2GQZC4Dy-7VmKyntw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove ar-option and KBUILD_ARFLAGS
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 9:38 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 40df759e2b9e ("kbuild: Fix build with binutils <= 2.19")
> introduced ar-option and KBUILD_ARFLAGS to cope with old binutils.
>
> According to Documentation/process/changes.rst, the current minimal
> supported version of binutils is 2.21 so you can assume the 'D' option
> is always supported. Not only GNU ar but also llvm-ar supports it.

Yep, a nice cleanup. Thanks for the patch and I appreciate checking llvm-ar.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> With the 'D' option hard-coded, there is no more user of ar-option
> or KBUILD_ARFLAGS.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  Documentation/kbuild/makefiles.rst | 5 -----
>  Makefile                           | 4 ----
>  arch/powerpc/boot/Makefile         | 2 +-
>  scripts/Kbuild.include             | 5 -----
>  scripts/Makefile.build             | 2 +-
>  scripts/Makefile.lib               | 2 +-
>  6 files changed, 3 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 6ba9d5365ff3..b89c88168d6a 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -954,11 +954,6 @@ When kbuild executes, the following steps are followed (roughly):
>
>         From commandline LDFLAGS_MODULE shall be used (see kbuild.txt).
>
> -    KBUILD_ARFLAGS   Options for $(AR) when creating archives
> -
> -       $(KBUILD_ARFLAGS) set by the top level Makefile to "D" (deterministic
> -       mode) if this option is supported by $(AR).
> -
>      KBUILD_LDS
>
>         The linker script with full path. Assigned by the top-level Makefile.
> diff --git a/Makefile b/Makefile
> index 656a8c95789d..88b180b2cb64 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -498,7 +498,6 @@ export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
>  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
>  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
> -export KBUILD_ARFLAGS
>
>  # Files to ignore in find ... statements
>
> @@ -914,9 +913,6 @@ ifdef CONFIG_RETPOLINE
>  KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
>  endif
>
> -# use the deterministic mode of AR if available
> -KBUILD_ARFLAGS := $(call ar-option,D)
> -
>  include scripts/Makefile.kasan
>  include scripts/Makefile.extrawarn
>  include scripts/Makefile.ubsan
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 6841bd52738b..dfbd7f22eef5 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -50,7 +50,7 @@ endif
>
>  BOOTAFLAGS     := -D__ASSEMBLY__ $(BOOTCFLAGS) -nostdinc
>
> -BOOTARFLAGS    := -cr$(KBUILD_ARFLAGS)
> +BOOTARFLAGS    := -crD
>
>  ifdef CONFIG_CC_IS_CLANG
>  BOOTCFLAGS += $(CLANG_FLAGS)
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index e31fd6a8b2a3..956668239ef5 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -143,11 +143,6 @@ cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || e
>  # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
>  ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
>
> -# ar-option
> -# Usage: KBUILD_ARFLAGS := $(call ar-option,D)
> -# Important: no spaces around options
> -ar-option = $(call try-run, $(AR) rc$(1) "$$TMP",$(1),$(2))
> -
>  # ld-version
>  # Note this is mainly for HJ Lu's 3 number binutil versions
>  ld-version = $(shell $(LD) --version | $(srctree)/scripts/ld-version.sh)
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 611bda95ac5e..f199341f04eb 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -395,7 +395,7 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
>  ifdef builtin-target
>
>  quiet_cmd_ar_builtin = AR      $@
> -      cmd_ar_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> +      cmd_ar_builtin = rm -f $@; $(AR) cDPrST $@ $(real-prereqs)
>
>  $(builtin-target): $(real-obj-y) FORCE
>         $(call if_changed,ar_builtin)
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 23e524027740..15895fd4ef9f 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -238,7 +238,7 @@ quiet_cmd_ld = LD      $@
>  # ---------------------------------------------------------------------------
>
>  quiet_cmd_ar = AR      $@
> -      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> +      cmd_ar = rm -f $@; $(AR) cDPrsT $@ $(real-prereqs)
>
>  # Objcopy
>  # ---------------------------------------------------------------------------
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190921064954.11196-1-yamada.masahiro%40socionext.com.



-- 
Thanks,
~Nick Desaulniers
