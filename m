Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E698C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046BC218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmTcpBqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCOVbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:31:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45680 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCOVbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:31:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id 125so7282346pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SftavF4SjKs7uaTaufFsPjfhMFzKpeU6qXdWt7twiY=;
        b=nmTcpBqO67zaIRvQrvvqUChJysBmQnOdx0prCZhc6E6rIyDA8lynlcIp+GnI5GL5Nl
         /4sRv+go7Fj1CatfQdSjvV9tGQEl/ZH8BoxwtSQqSilTxXoCNZOuyqdebvTmXBayyUAd
         zr+14vl3/kKb/5GJI7rEveWa2kzLXxBgvpryhW6Qz9NXZ3G7hIfoyrCC2xRGKxGj6IHo
         H816EpzuGe11fIEXSQlTX1mtsGY4+OZudsXa3vde803ag8dYYZT9WueIFjWCDlySHHhG
         YZgk6KiGLOBY8x2/hwO4gf2hl0cTZFC9eOoG2REWD6HkP2pNuTSmvCT+UAPuoZh9iWIF
         H/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SftavF4SjKs7uaTaufFsPjfhMFzKpeU6qXdWt7twiY=;
        b=ZJm4vyJUOYUzyPuFx7awWaWu05QBDoOB9I0awcSRZfQ0CI5DqoWt0iAnVhHBH6JLu+
         pIpUuM5MKQSbqT0L1n2IkqehOxwQoomV7YvAZtRAlyW5+0TwaEN5ms95r+sm1Nz3ncou
         4V6sWbMZS1vPItu+RezhGV2e38ia23HiZQMHm2cw3WSL6QREcmvluVYA/Bphl8ioatOv
         abDLKoYQruzUc2tIDgUwTK4dnidERBcvIH5Mkds/mwuOBogdHrkTXgpata84YnZFLMha
         of/bzNzlPnmB1V9PXxCb21aAGzFIbpQPjJUg//1SRPoF8Zl77MqQRvUeNgZfdh88GBRe
         LllA==
X-Gm-Message-State: APjAAAUbk0YgOpkDsixDfWHt9qATYVHVA6RgmXZA8dm23mde3gGVdxTD
        2c1JjsAkeKTJopwrsTOKH1EvQgNLldmE46IoCaoy+A==
X-Google-Smtp-Source: APXvYqxzszdtaKM11OX57qqpbvln0sB+pJGoRt+SHnmJqce+frLS25yUacOImRdKdbkH7JmbjreLzrOX0asqkOUt1+4=
X-Received: by 2002:a63:c511:: with SMTP id f17mr5476141pgd.202.1552685480717;
 Fri, 15 Mar 2019 14:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
In-Reply-To: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Mar 2019 14:31:09 -0700
Message-ID: <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:54 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Building the 32-bit vDSO with a recent clang version fails due
> to undefined symbols:
>
> arch/x86/entry/vdso/vdso32.so.dbg: undefined symbols found
>
> The undefined symbol in this case is __lshrdi3, which is part of
> the compiler runtime library, however the vDSO isn't linked against
> this library.
>
> Include the kernel version of __lshrdi3 in the 32-bit vDSO build.

__lshrdi3 is used for "logical shift right double-word by int" (best
guess), so anywhere there's a right shift of a u64.  Looks like
there's a few of these in arch/x86/entry/vdso/, so it's legal for the
compiler to emit this libcall.  Do you know which function
specifically in the .so has a relocation referencing __lshrdi3
specifically?

Is there a config I can set to reproduce this, in order to help test?

>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/x86/entry/vdso/Makefile | 7 ++++++-
>  lib/lshrdi3.c                | 4 +++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 5bfe2243a08f..7517cd87e10b 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -144,6 +144,7 @@ KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
>  KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
>  KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
>  KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
> +KBUILD_CFLAGS_32 += -DBUILD_VDSO
>
>  ifdef CONFIG_RETPOLINE
>  ifneq ($(RETPOLINE_VDSO_CFLAGS),)
> @@ -153,12 +154,16 @@ endif
>
>  $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
>
> +$(obj)/vdso32/lshrdi3.o: $(srctree)/lib/lshrdi3.c FORCE
> +       $(call if_changed_rule,cc_o_c)

+ Masahiro to help look at this part (I don't understand this part of kbuild).

> +
>  $(obj)/vdso32.so.dbg: FORCE \
>                       $(obj)/vdso32/vdso32.lds \
>                       $(obj)/vdso32/vclock_gettime.o \
>                       $(obj)/vdso32/note.o \
>                       $(obj)/vdso32/system_call.o \
> -                     $(obj)/vdso32/sigreturn.o
> +                     $(obj)/vdso32/sigreturn.o \
> +                     $(obj)/vdso32/lshrdi3.o
>         $(call if_changed,vdso)
>
>  #
> diff --git a/lib/lshrdi3.c b/lib/lshrdi3.c
> index 99cfa5721f2d..8a4fc6bcf3a4 100644
> --- a/lib/lshrdi3.c
> +++ b/lib/lshrdi3.c
> @@ -16,7 +16,7 @@
>   * to the Free Software Foundation, Inc.
>   */
>
> -#include <linux/module.h>
> +#include <linux/export.h>

Is this a simple cleanup, or?

>  #include <linux/libgcc.h>
>
>  long long notrace __lshrdi3(long long u, word_type b)
> @@ -42,4 +42,6 @@ long long notrace __lshrdi3(long long u, word_type b)
>
>         return w.ll;
>  }
> +#ifndef BUILD_VDSO
>  EXPORT_SYMBOL(__lshrdi3);
> +#endif
> --
> 2.21.0.360.g471c308f928-goog

Compilers (GCC and Clang) will always assume their runtime has these
helper functions; whether or not they emit libcalls vs inline routines
is implementation defined.  So I agree with this patch; I just would
like to help confirm/test it.
-- 
Thanks,
~Nick Desaulniers
