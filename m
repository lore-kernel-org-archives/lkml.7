Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7711C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B9C21721
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TgaYf8ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDLBjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:39:37 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:27241 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfDLBjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:39:36 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x3C1dEhH018200;
        Fri, 12 Apr 2019 10:39:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x3C1dEhH018200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555033155;
        bh=wED/bPdbA4GxkGl8E0KKrdQFhvPzZe9DgYeDFMFx+cY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TgaYf8ejAkSb+KcUStxfixqZ4UReRUqq/bzp2Cjh+zp22RycuccAElfyUL7UoXC21
         5fsi2lBn760a7KnfVDPY1N77hg+BPGD9AwhpjaqLdBmiOU/wxuFp3O2ChrcPQCQCRl
         TkyuC+Og2LkBoP6vx8gpXcbILjQDMev4t+rPsSwRmfiysBlQbT1h/zIAiSQVQpFZ11
         y2L496iki86kzInRBL2pc7598Xzf0oZaa+dAhhlvoig6/pwS6UP1yVqXRnoRVYPrH9
         pgN6vMz/1bIUvNHVOhof8kpj0AgIqEGYFNfboxcHVMM6PDCG4oLSeH01GqvvmuTIpa
         CXp6k8obUAPmA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id g127so4633405vsd.6;
        Thu, 11 Apr 2019 18:39:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVmFF8gfhBG+fqVcz3mKgYeeEN/gTX3zOdeoxI+2aciiE928nnQ
        u4H2jf+uQZHv070IM07r1phYQvKywI6/4wdvtuc=
X-Google-Smtp-Source: APXvYqzuIcmmeUmYieAjqYfeKyA0pf4Fn6zr/VSr5x9fr6yqFMF+I4zPHx0BE6r9Ag5OIixPhB6rDIr0E8Mk64/rJYo=
X-Received: by 2002:a67:818e:: with SMTP id c136mr30122229vsd.65.1555033154146;
 Thu, 11 Apr 2019 18:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190411180117.27704-1-keescook@chromium.org> <20190411180117.27704-2-keescook@chromium.org>
In-Reply-To: <20190411180117.27704-2-keescook@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Apr 2019 10:38:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvNJprA94Qypfub2rpbEEJkAeV3yqVyuk2aNEraDKZ6w@mail.gmail.com>
Message-ID: <CAK7LNATvNJprA94Qypfub2rpbEEJkAeV3yqVyuk2aNEraDKZ6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] security: Create "kernel hardening" config area
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        James Morris <jmorris@namei.org>,
        Alexander Popov <alex.popov@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 3:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> Right now kernel hardening options are scattered around various Kconfig
> files. This can be a central place to collect these kinds of options
> going forward. This is initially populated with the memory initialization
> options from the gcc-plugins.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/gcc-plugins/Kconfig | 74 +++--------------------------
>  security/Kconfig            |  2 +
>  security/Kconfig.hardening  | 93 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+), 67 deletions(-)
>  create mode 100644 security/Kconfig.hardening
>
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index 74271dba4f94..84d471dea2b7 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -13,10 +13,11 @@ config HAVE_GCC_PLUGINS
>           An arch should select this symbol if it supports building with
>           GCC plugins.
>
> -menuconfig GCC_PLUGINS
> -       bool "GCC plugins"
> +config GCC_PLUGINS
> +       bool
>         depends on HAVE_GCC_PLUGINS
>         depends on PLUGIN_HOSTCC != ""
> +       default y
>         help
>           GCC plugins are loadable modules that provide extra features to the
>           compiler. They are useful for runtime instrumentation and static analysis.
> @@ -25,6 +26,8 @@ menuconfig GCC_PLUGINS
>
>  if GCC_PLUGINS
>
> +menu "GCC plugins"
> +



Just a tip to save "if" ... "endif" block.


If you like, you can write like follows:


menu "GCC plugins"
          depends on GCC_PLUGINS

  <menu body>

endmenu



instead of



if GCC_PLUGINS

menu "GCC plugins"

 <menu body>

endmenu

fi




> +menu "Memory initialization"
> +
> +choice
> +       prompt "Initialize kernel stack variables at function entry"
> +       depends on GCC_PLUGINS

On second thought,
this 'depends on' is unnecessary
because INIT_STACK_NONE should be always visible.


> +       default INIT_STACK_NONE
> +       help
> +         This option enables initialization of stack variables at
> +         function entry time. This has the possibility to have the
> +         greatest coverage (since all functions can have their
> +         variables initialized), but the performance impact depends
> +         on the function calling complexity of a given workload's
> +         syscalls.
> +
> +         This chooses the level of coverage over classes of potentially
> +         uninitialized variables. The selected class will be
> +         initialized before use in a function.
> +
> +       config INIT_STACK_NONE
> +               bool "no automatic initialization (weakest)"
> +               help
> +                 Disable automatic stack variable initialization.
> +                 This leaves the kernel vulnerable to the standard
> +                 classes of uninitialized stack variable exploits
> +                 and information exposures.
> +
> +       config GCC_PLUGIN_STRUCTLEAK_USER
> +               bool "zero-init structs marked for userspace (weak)"
> +               depends on GCC_PLUGINS
> +               select GCC_PLUGIN_STRUCTLEAK
> +               help
> +                 Zero-initialize any structures on the stack containing
> +                 a __user attribute. This can prevent some classes of
> +                 uninitialized stack variable exploits and information
> +                 exposures, like CVE-2013-2141:
> +                 https://git.kernel.org/linus/b9e146d8eb3b9eca
> +
> +       config GCC_PLUGIN_STRUCTLEAK_BYREF
> +               bool "zero-init structs passed by reference (strong)"
> +               depends on GCC_PLUGINS
> +               select GCC_PLUGIN_STRUCTLEAK
> +               help
> +                 Zero-initialize any structures on the stack that may
> +                 be passed by reference and had not already been
> +                 explicitly initialized. This can prevent most classes
> +                 of uninitialized stack variable exploits and information
> +                 exposures, like CVE-2017-1000410:
> +                 https://git.kernel.org/linus/06e7e776ca4d3654
> +
> +       config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> +               bool "zero-init anything passed by reference (very strong)"
> +               depends on GCC_PLUGINS
> +               select GCC_PLUGIN_STRUCTLEAK
> +               help
> +                 Zero-initialize any stack variables that may be passed
> +                 by reference and had not already been explicitly
> +                 initialized. This is intended to eliminate all classes
> +                 of uninitialized stack variable exploits and information
> +                 exposures.
> +
> +endchoice



Another behavior change is
GCC_PLUGIN_STRUCTLEAK was previously enabled by all{yes,mod}config,
and in the compile-test coverage.

It will be disabled for all{yes,mod}config with this patch.

This is up to you. Just FYI.


-- 
Best Regards
Masahiro Yamada
