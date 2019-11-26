Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56742068E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBxzc7Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfKZRQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:16:21 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36805 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfKZRQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:16:21 -0500
Received: by mail-pj1-f67.google.com with SMTP id cq11so8596380pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/k92MKWWjFnPno4gnuWPGd3qNyBSvlefuqaP0mxb6E=;
        b=SBxzc7DilpSOZiDQCBR/Ge7LD0tBv3TjkQyNHzLi8F175BOiL4R/45UGpXm/Utzyvw
         6yS8gKtH9gmM6rXIuMDTJnipthfciJfhxMIIi4VqAav3R0aY9I1X9TXol9S5MMyim+el
         hhMqMRvzxiuLxKECfFlC4bOKZ7TUYxHRKxk/es8u51EzhjcFC3gBOupBk0igymn8xl20
         NYFYfDoQF863c6JHzyrlDA61jCXKZcKGK1NX/PwLP6LdOWtk+tqHwE96pEAYjhKn4JF1
         p0a2GyMS4wLBZrrjThb6gg84qvF8/8vQ5XSRKfNVtCjOb/KUHW7lrIrIp1XmYXH81uTT
         vDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/k92MKWWjFnPno4gnuWPGd3qNyBSvlefuqaP0mxb6E=;
        b=s2fXmnVIxTDczP3uxEuNUgW69lMAnadUPqAyy7twC/q119sDinow9TMamXwdcW/a4u
         bsigbgHuRjuhSK93UvX6iGdu0dIeMwGZRXGJ1gbe7Pr/ANJjubkQ3VIvMYtfxdQy2poa
         7iBYpsP7PxNwUJSbXln7QiddMwc495sOzUsJJ2b/UWt21gOrIJirGuLo/8jXY8PObtCD
         AnYG1xcN4sB9vghkyp8JMdEQNJCtvaP1Il8NluN9gfCep3WmfKGeZTwYZCQjFz98GCR1
         wk0SZkUfy3GuYjQJPOOvi/MwZU9wiW3n30YWteynx/qYCO2+VaY5UYf6jR94U4iYxvu8
         kiHA==
X-Gm-Message-State: APjAAAULGJ9EsYMa9JeUMIk0j14NCemB7fxiM1oO50ssVwdkjisyn5hJ
        PIsSsFD5JxvC1vECqfFoTwkdplriMUaoCaxEC2n3qw==
X-Google-Smtp-Source: APXvYqwQqJ/iVg/p7uJFiqjfaSOsUtNVxLIlkJY19uSPct4X6b/hp4USdMr3fzlKuOj5uq5RYglBdXZ37tJj8PYDlQY=
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr129343pja.134.1574788579737;
 Tue, 26 Nov 2019 09:16:19 -0800 (PST)
MIME-Version: 1.0
References: <20191118175223.GM6363@zn.tnic> <20191126144545.19354-1-ilie.halip@gmail.com>
In-Reply-To: <20191126144545.19354-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Nov 2019 09:16:08 -0800
Message-ID: <CAKwvOdn0x4jc0=25O+Xy5BsUisAPrz_hjzmBbMS0ubpfPMLgrg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/boot: discard .eh_frame sections
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Andy <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 6:46 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> When using GCC as compiler and LLVM's lld as linker, linking
> setup.elf fails:
>       LD      arch/x86/boot/setup.elf
>     ld.lld: error: init sections too big!
>
> This happens because GCC generates .eh_frame sections for most
> of the files in that directory, then ld.lld places the merged
> section before __end_init, triggering an assert in the linker
> script.
>
> Fix this by discarding the .eh_frame sections, as suggested by
> Boris. The kernel proper linker script discards them too.
>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> Link: https://lore.kernel.org/lkml/20191118175223.GM6363@zn.tnic/
> Link: https://github.com/ClangBuiltLinux/linux/issues/760
> Suggested-by: Borislav Petkov <bp@alien8.de>

Ilie, thanks for following up with a v3.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in V3:
>  * discard .eh_frame instead of placing it after .rodata
>
> Changes in V2:
>  * removed wildcard for input sections (.eh_frame* -> .eh_frame)
>
>  arch/x86/boot/setup.ld | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 0149e41d42c2..3da1c37c6dd5 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -51,7 +51,10 @@ SECTIONS
>         . = ALIGN(16);
>         _end = .;
>
> -       /DISCARD/ : { *(.note*) }
> +       /DISCARD/       : {
> +               *(.eh_frame)
> +               *(.note*)
> +       }
>
>         /*
>          * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
