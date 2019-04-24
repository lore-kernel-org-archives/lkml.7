Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968FAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61164218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfDXG15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:27:57 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38442 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDXG14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:27:56 -0400
Received: by mail-vs1-f67.google.com with SMTP id s2so9737954vsi.5;
        Tue, 23 Apr 2019 23:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qnkSY4xduiArI2tS4tmMzGVL+yMPgiXnb+jXIxR5tM=;
        b=QE4RREf8cImAvk4L02UwAr4GoyrayFZuup8Ds06q3LGkDtkXEGLysIcedWMGwdjEtJ
         H7uWiXFQ1Ha/R+h1nUfbSBSSXwqeIXF7NpPw5QZqyKSKvIvg7kbTZs9QkB3xVYWjtPek
         K/lvpEByY9NR4PgUsPnaF7su34FYaGTgSlLkHG46KTbwqxmr9pnKdX9GLxFyLG+rhUG8
         s+de8gSz2q6QteMFB6lq9OJIzsKAxErWFyHisOgO1pLFzAd1zMtGQXs8xjAJ7KanoQ1h
         X/TollzJMyPypnNi9l4WRJ+uQF/TYnG11hVg76gGB1xl3hgKB/ZgDMNTBuCV3i7AuVfH
         dxJQ==
X-Gm-Message-State: APjAAAWZ8gx0yEgG/eun+NHHXTR2CXPkFS+NE6iGoXvr5fxmI6vujsQc
        sfzvG3Gg0pq2zVz6Yem1G2OZoVaSEbUNMi/j2cc=
X-Google-Smtp-Source: APXvYqxXmkApL+KxkT75Omobc7Z3hpvgjkAeRk4028JERKGE/lwHXGXbQCR1Q8p3Dfzh2sBd0GaPQuvi3Js8kNAwS4w=
X-Received: by 2002:a05:6102:199:: with SMTP id r25mr15640979vsq.166.1556087274956;
 Tue, 23 Apr 2019 23:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190423202907.234180-1-ndesaulniers@google.com>
In-Reply-To: <20190423202907.234180-1-ndesaulniers@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Apr 2019 08:27:43 +0200
Message-ID: <CAMuHMdX9hKQHitf3b8861dnTt+aJOaOiytxqBzgprBdCPnL18Q@mail.gmail.com>
Subject: Re: [PATCH] sh: require --Wl,--hash-style=sysv
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirsky <luto@kernel.org>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Apr 23, 2019 at 10:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Towards the goal of removing cc-ldoption, prefer ld-option, or better
> yet, require --Wl,--hash-style=sysv since the selftest for vdso's
> requires DT_HASH.
>
> Cc: Andy Lutomirsky <luto@kernel.org>
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for your patch!

> --- a/arch/sh/kernel/vsyscall/Makefile
> +++ b/arch/sh/kernel/vsyscall/Makefile
> @@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
>
>  export CPPFLAGS_vsyscall.lds += -P -C -Ush
>
> -vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
> -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
>
>  SYSCFLAGS_vsyscall-trapa.so    = $(vsyscall-flags)

What impact does this have on the minimum binutils version needed to
compile the kernel?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
