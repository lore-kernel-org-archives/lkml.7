Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732422084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcJrbvf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKSS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:18:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40997 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKSS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:18:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id d1so3797325plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tbvtzb59UBU9hOkXbwTmH64imtj8HoH7KYOqjahAO6U=;
        b=YcJrbvf2ZVrp1YDDWZHyYg+VQ1JzHnF1wPMfnTUWJEqqkatlbu47LJLQpuwY1hxAN0
         FVKmkUUId68H20e0OQXv6o86jaO8DxVLhW5e1jB3UkfY812mLhrJJDCZjXNGJNFRHnQq
         KrpoMyb92sjwlyXTwELRUh1/Zfb1PveqmYok2sC0rVOYlHtm44kH+tvHEKCtynX990Ah
         7fO58IUJr9pWv1JF5LWs/qkIkzNSl6b7BcBt7art8/2J2F7ecBr3cqeGdXR2jC5nF5gs
         YgXr11OaTDyVko402EHRUfKVCnyyvJF+YDFrmxjow0A4r1a0iPCy/QZApGCdsardFJxe
         8++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tbvtzb59UBU9hOkXbwTmH64imtj8HoH7KYOqjahAO6U=;
        b=NNq4Weqto9jAt68qOYTJbq9gQUnG264YaQvWjYiAdBEaOC2kaeTAr3pPYRFmdkTmIw
         8iovOrZaxLSdq6ydlR88Zc3EZpAsQMUICe5m+ach7TSSWJ+fPC7tRvSMGVxUhd4Pz5XJ
         MS8FYaDQSv+jvlmNNXNIJKrBJlBzfSu+XVKOtDTb2XgBj+DU9F7ou8Mh0qK2nSo3I0U7
         fLtzBrYylKlFYtm18aYpQkbhPzq3l3IuRDV22PCqPgPtPtIK8SMKkr8EbnNKXReQIvyJ
         DSuI2Np1md0emsu0nW2RYCb3Rlux2DmufmYiM5zg5+32spnAbIgaq885gBmUJ9gWsagv
         ftzQ==
X-Gm-Message-State: APjAAAXderllfs53c6dCkLiPPqVZuaAvfRSZ3B9w2IjxhHzfHd14lA/Z
        Ob723VigBaZzf6YwRQC0r4Ok4JncY/P6FER+zIisWQ==
X-Google-Smtp-Source: APXvYqw9yD2Zl+fUXXTYlECuIefEAlA39kywhNwWeTZeGs2KksLYUL/XoVnpSll2KhfRFzbKhuU9LGfz5JEmIP/ULNQ=
X-Received: by 2002:a17:902:8a8b:: with SMTP id p11mr51813461plo.227.1555006735627;
 Thu, 11 Apr 2019 11:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190411093015.6529-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190411093015.6529-1-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Apr 2019 11:18:44 -0700
Message-ID: <CAKwvOd=es2zG74T+BGbt_T8cHCPNATkmHBA4Hboyy_7=9Bgipg@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: use $(LD) instead of $(CC) to link VDSO
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 2:30 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We use $(LD) to link vmlinux, modules, decompressors, etc.
>
> VDSO is the only exceptional case where $(CC) is used as the linker
> driver, but I do not know why we need to do so. VDSO uses a special
> linker script, and does not link standard libraries at all.
>
> I changed the Makefile to use $(LD) rather than $(CC). I tested this,
> and VDSO worked for me.
>
> Users will be able to use their favorite linker (e.g. lld instead of
> of bfd) by passing LD= from the command line.
>
> My plan is to rewrite all VDSO Makefiles to use $(LD), then delete
> cc-ldoption.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm64/kernel/vdso/Makefile | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index a0af6bf6c11b..744b9dbaba03 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -12,17 +12,12 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>
> -ccflags-y := -shared -fno-common -fno-builtin

Thanks for the patch; in general LGTM. Just some small questions:

Looks like -shared and -fno-common are linker flags forwarded along,
but -fno-builtin is meant for the compiler, right? Do we want to keep
that in ccflags?  I'm not sure why it would have been added
intentionally; maybe Will knows?  Maybe it's ok to drop.

> -ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
> -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> +ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> +               $(call ld-option, --hash-style=sysv) -n -T

Forgive my ignorance, but the man page for ld makes it looks like the
-T argument requires a subsequent argument `scriptfile`.  Is that what
`$(real-prereqs)` was doing below? If so, is dropping it in this patch
intentional?

>
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
>
> -# Workaround for bare-metal (ELF) toolchains that neglect to pass -shared
> -# down to collect2, resulting in silent corruption of the vDSO image.
> -ccflags-y += -Wl,-shared
> -
>  obj-y += vdso.o
>  extra-y += vdso.lds
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
> @@ -32,7 +27,7 @@ $(obj)/vdso.o : $(obj)/vdso.so
>
>  # Link rule for the .so file, .lds has to be first
>  $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> -       $(call if_changed,vdsold)
> +       $(call if_changed,ld)
>
>  # Strip rule for the .so file
>  $(obj)/%.so: OBJCOPYFLAGS := -S
> @@ -52,8 +47,6 @@ $(obj-vdso): %.o: %.S FORCE
>         $(call if_changed_dep,vdsoas)
>
>  # Actual build commands
> -quiet_cmd_vdsold = VDSOL   $@
> -      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $(real-prereqs) -o $@
>  quiet_cmd_vdsoas = VDSOA   $@
>        cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
>
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
