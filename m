Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8984EC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6026C21900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzmrcvvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfGVWKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:10:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37400 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfGVWKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:10:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so18028705pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krTygS594B1FZs0zxHGIhwRvOWSOgPOCJ7d+lzUap1c=;
        b=dzmrcvvdXqjOOH2iH+12XcZSKksebydFb2ZYxT9GbodnuOF9BpqJp4n5j/loQphpRI
         HRmUqha1rPX4GIAsOG5ImqmEboaBmiQgjZch3HR9H6BSbOMMhPrqIb6oU+Pn1nUIrnHc
         3mf1VzZNZFQ/8rHIdepI5IkRKI0GpLDBO4sZraLNkvMg/W7J74U8tKaeYUjrtLpQ3ls1
         hCufw3bRSGl2a19r8jW4qqy9nk3oMrB0pE8kJLyDD4B+MIcmjTTCCV7D/pOc0Bs42x4g
         h/0AsU2iK6XXjcEEwQMK87YBdya+yV8Vo40BgY4mtxAYPyNhful5BcgHWMMCxsf6hmVR
         SfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krTygS594B1FZs0zxHGIhwRvOWSOgPOCJ7d+lzUap1c=;
        b=pRsEQHpSwV0qCwFtGgpgl5xH83v3eGdUFb7NQzL1JU3WbCpWSH7zmNh0NBv2nRCRUs
         XvtRazRfu2e7Fivz+eULi/atZbsi4rhnuML+aU+9EI9P4mcnqYIHtxYU9Qq19CkFQ3wF
         8TfYW/X0wROY3OsjFu1cCoKYjtoHiNYBmFPHYPQOPTdquPDqkUE53QhZ4BnLHYmbJ6Hc
         YygdPt9yxESBNQs30ADt2Q9Zbu/l9w9wMBybDYG9T8/BY0nv70DPWvvk5EOE8fGiI5yd
         VUsXvgS/HiFJh1zNT+tVLw/14UpBM6iophfX4MwN9TURtN8SWxnUcAB4QwBjuFIPVO1b
         qDwA==
X-Gm-Message-State: APjAAAVOQ+dexBWDpHg/XFJSi67UXuLikUhybKYBHseMMRmQFsDvScJg
        7Rs48ZR37jnmAO9PuoEzHPZlojOG2MjDwN/ywkbgOA==
X-Google-Smtp-Source: APXvYqxR9EUEWNXq2fRAuEbPPTig4DQkkKBPn6wENv5CgBwcupXvKCniFQ9yZi4UKqPKZy6GPfSl+HH0fefdyQD1W04=
X-Received: by 2002:a65:5687:: with SMTP id v7mr74903566pgs.263.1563833415147;
 Mon, 22 Jul 2019 15:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190722213250.238685-1-ndesaulniers@google.com> <20190722213250.238685-2-ndesaulniers@google.com>
In-Reply-To: <20190722213250.238685-2-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jul 2019 15:10:04 -0700
Message-ID: <CAKwvOdm3iyeJfuivhQJqXB9FfC0zHgrfgoN_qW4poEyfcw3C9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 2:33 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> KBUILD_CFLAGS is very carefully built up in the top level Makefile,
> particularly when cross compiling or using different build tools.
> Resetting KBUILD_CFLAGS via := assignment is an antipattern.
>
> The comment above the reset mentions that -pg is problematic.  Other
> Makefiles like arch/x86/xen/vdso/Makefile use
> `CFLAGS_REMOVE_file.o = -pg` when CONFIG_FUNCTION_TRACER is set. Prefer
> that pattern to wiping out all of the important KBUILD_CFLAGS then
> manually having to re-add them.
>
> Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
> Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Rather than manually add -mno-sse, -mno-mmx, -mno-sse2, prefer to filter
> -pg flags.
>
>  arch/x86/purgatory/Makefile | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 91ef244026d2..56bcabca283f 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -20,11 +20,13 @@ KCOV_INSTRUMENT := n
>
>  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
>  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
> -# sure how to relocate those. Like kexec-tools, use custom flags.
> -
> -KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
> -KBUILD_CFLAGS += -m$(BITS)

Is purgatory/kexec supported for CONFIG_X86_32?  Should I be keeping
`-m$(BITS)`?  arch/x86/purgatory/Makefile mentions
`setup-x86_$(BITS).o` which I assume is broken as there is no
arch/x86/purgatory/setup-x86_32.S?

> -KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
> +# sure how to relocate those.
> +ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_sha256.o = -pg
> +CFLAGS_REMOVE_purgatory.o = -pg
> +CFLAGS_REMOVE_string.o = -pg
> +CFLAGS_REMOVE_kexec-purgatory.o = -pg
> +endif
>
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>                 $(call if_changed,ld)
> --
> 2.22.0.657.g960e92d24f-goog
>


-- 
Thanks,
~Nick Desaulniers
