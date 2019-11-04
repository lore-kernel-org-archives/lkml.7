Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7881DCA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592752190F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfKDHnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:43:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43730 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:43:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id u4so2628654otq.10;
        Sun, 03 Nov 2019 23:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnN2X+Z56m8inPVIEyg78tY9xFg8wm5xX3rrWjSXm00=;
        b=Zs+asvGapBjCMN1e7WYqb7tZs1Ov7yAqLSp32wMWodWJ2u3LV8jwfW2hGfUxzqHpJa
         Jt2f9qv0hHfUPuQLUr7B5KEzNKlaSQc47e/Cz5TLKYRpwnvE2PQKOx15ka9x9D71fgjp
         Qj7/W5gbvtRie9BlwvJDsU2rrpqbQR0y/Sx88qLi9YxdStjqSnYIr4GAWGjTGXdOtaEB
         oFJZ4Hgw1y6b7jOYIINC4Mb4RhW0ih6Se3p3vsOvmZ86bedY1mLSI22CHkMxJS1IsTJQ
         M0c6NENOOazhR41B8MnwMtWbHD1CK2bMm1OlKxQ0lTgA32oiPdCYUFH+ulE4FIYwWkPk
         +wKA==
X-Gm-Message-State: APjAAAV41P5CRZvgjNjnucG5FBq4f62ppA/3GsFCggZr1Xt+mYyy4wZm
        EhNHnAcDGo/5aZqF34onCOUzTFOLT8xfn4tOHqc=
X-Google-Smtp-Source: APXvYqym9VCu2o7HdGZJ4onW/M0U57nIZAzdSu2nWmiH9jlxJelFjPY7QurfIWeAM7vQ6DoHtaIviAs1Q+0ScdiDkkI=
X-Received: by 2002:a05:6830:210e:: with SMTP id i14mr3502735otc.250.1572853399036;
 Sun, 03 Nov 2019 23:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20190927094708.11563-1-geert@linux-m68k.org>
In-Reply-To: <20190927094708.11563-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 08:43:07 +0100
Message-ID: <CAMuHMdW7fkPjqppQYESDf4ZLKcCrxhMUyCn0=tm6kxPSxf5mGA@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: c2p: Fix link failure on non-inlining
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej, Andrew,

On Fri, Sep 27, 2019 at 11:47 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> When the compiler decides not to inline the Chunky-to-Planar core
> functions, the build fails with:
>
>     c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
>     c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
>     c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
>     c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
>
> Fix this by marking the functions __always_inline.
>
> While this could be triggered before by manually enabling both
> CONFIG_OPTIMIZE_INLINING and CONFIG_CC_OPTIMIZE_FOR_SIZE, it was exposed
> in the m68k defconfig by commit ac7c3e4ff401b304 ("compiler: enable
> CONFIG_OPTIMIZE_INLINING forcibly").
>
> Fixes: 9012d011660ea5cf ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> This is a fix for v5.4-rc1.

Can you please apply this for v5.4?
This is one of the 4 remaining build regressions, compared to v5.3.

Thanks!

> v2:
>   - Add Reviewed-by,
>   - Fix Fixes,
>   - Add more explanation.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
