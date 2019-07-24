Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D339CC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6D921880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JE6IcczQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbfGXXt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:49:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34711 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfGXXt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:49:29 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so93411097iot.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJ1aMEs74UNhuCKOoREVlxCR5HtwdPtwGYYolQWtluU=;
        b=JE6IcczQ5f/hbM3+uOk5DeF3km0i6S1v2qMN2hLOmzWuIMvRmmkzxoUyYuIRqOqJcj
         4n9clhqmquxRucZo683IIpTaTRlqTT2vpQC3jw0mNe3WuL/gdTVK5AY1fFm4NDN36ggu
         DOwapZjU5ow4QNQkazEqvMBksYoS88ckhmbKFzPFmJpLJ4dWSKmg1+LnaSBHEEBQApYa
         4yXdBCL+OiNRV6A5YFSJuAhNnWWPW3q3JeoHeKx6VarHPJR2PvjOjs6K4mUh+NzH7+cX
         f+cub60d8J0eSSbBy7u+mUwCPgeuB+IHJUH5/N62c3EdssLAXUegH/t5Gs2fP2T1ZGWO
         yG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJ1aMEs74UNhuCKOoREVlxCR5HtwdPtwGYYolQWtluU=;
        b=Mm+mRnuJV2TvcL280XX7IuA6t+po4VTtZI4j8Ii6DsX9ERgBtiyL06xU+pMnDgTAqW
         WwOuU7Kn6cCRl9S1B/IKznDd55P7yEzDzk05ED9KfkTyP3YRQQHi/HUTUSQN4lX/ffwY
         unx+knOIplCg57E0lZZCsrWBzuslnUVrO1GsM2Abzvzgzufarbbst/raKIiXB5Q24u/k
         eZbeD81kDjcAobRSYZ40lW0mprf5te4UZsK9kIVEUsJ+6XIoH8rKJdYL0XF5ANWmfUrp
         vyjeVUKmV2Ij5i4qEgzSAkLbkSx32SQpv7/3k337yOvfyTdtPopdeF/Xl4qwPXMnWN80
         8TvQ==
X-Gm-Message-State: APjAAAU72brZRgThOJbJkAjyKdi6N9HX3Nh8FZf/7Qns5U3tWUKeYoJk
        sJx5vf3y64239CKSZRG6hsd/EsAEimL4jmRTA53SyQ==
X-Google-Smtp-Source: APXvYqy1+fcxQkXA20RVRVcjJIYV7Fvs9RqiUJH7cbfv7SCurHmz51LfgVrIsY7cjoftF3TVV2MeQjq9H0cY1ggRSrk=
X-Received: by 2002:a5d:8b52:: with SMTP id c18mr14203913iot.89.1564012167930;
 Wed, 24 Jul 2019 16:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190723212418.36379-1-ndesaulniers@google.com> <20190723212418.36379-2-ndesaulniers@google.com>
In-Reply-To: <20190723212418.36379-2-ndesaulniers@google.com>
From:   Vaibhav Rustagi <vaibhavrustagi@google.com>
Date:   Wed, 24 Jul 2019 16:49:16 -0700
Message-ID: <CAMVonLggcXdcScZSi3ZXZUyRnkHGK7Jv5sED43hHpGmXnKQfWA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        yamada.masahiro@socionext.com, stable@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 2:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> KBUILD_CFLAGS is very carefully built up in the top level Makefile,
> particularly when cross compiling or using different build tools.
> Resetting KBUILD_CFLAGS via := assignment is an antipattern.
>
> The comment above the reset mentions that -pg is problematic.  Other
> Makefiles use `CFLAGS_REMOVE_file.o = $(CC_FLAGS_FTRACE)` when
> CONFIG_FUNCTION_TRACER is set. Prefer that pattern to wiping out all of
> the important KBUILD_CFLAGS then manually having to re-add them. Seems
> also that __stack_chk_fail references are generated when using
> CONFIG_STACKPROTECTOR or CONFIG_STACKPROTECTOR_STRONG.
>
> Cc: stable@vger.kernel.org
> Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
> Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Alternatively, we could put these in all in one variable and remove it
> without any conditional checks (I think that's ok to do so with
> CFLAGS_REMOVE).
>
> Changes v2 -> v3:
> * Prefer $(CC_FLAGS_FTRACE) which is exported to -pg.
> * Also check CONFIG_STACKPROTECTOR and CONFIG_STACKPROTECTOR_STRONG.
> * Cc stable.
> Changes v1 -> v2:
> Rather than manually add -mno-sse, -mno-mmx, -mno-sse2, prefer to filter
> -pg flags.
>
>  arch/x86/purgatory/Makefile | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 91ef244026d2..6ef0ced59b9c 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -20,11 +20,27 @@ KCOV_INSTRUMENT := n
>
>  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
>  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
> -# sure how to relocate those. Like kexec-tools, use custom flags.
> -
> -KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
> -KBUILD_CFLAGS += -m$(BITS)
> -KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
> +# sure how to relocate those.
> +ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_sha256.o += $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_purgatory.o += $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_string.o += $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_kexec-purgatory.o += $(CC_FLAGS_FTRACE)
> +endif
> +
> +ifdef CONFIG_STACKPROTECTOR
> +CFLAGS_REMOVE_sha256.o += -fstack-protector
> +CFLAGS_REMOVE_purgatory.o += -fstack-protector
> +CFLAGS_REMOVE_string.o += -fstack-protector
> +CFLAGS_REMOVE_kexec-purgatory.o += -fstack-protector
> +endif
> +
> +ifdef CONFIG_STACKPROTECTOR_STRONG
> +CFLAGS_REMOVE_sha256.o += -fstack-protector-strong
> +CFLAGS_REMOVE_purgatory.o += -fstack-protector-strong
> +CFLAGS_REMOVE_string.o += -fstack-protector-strong
> +CFLAGS_REMOVE_kexec-purgatory.o += -fstack-protector-strong
> +endif
>
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>                 $(call if_changed,ld)
> --
> 2.22.0.709.g102302147b-goog
>

Tested-by: Vaibhav Rustagi <vaibhavrustagi@google.com>

I tested the v3 patch series with clang compiled kernel for below
scenarios:

1. kexec'ing into a new kernel.
2. Purposely crashing the running kernel to generate kdump logs.

Thanks,
Vaibhav
