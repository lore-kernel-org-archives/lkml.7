Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409DFC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E810207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfIZLn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:43:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44858 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfIZLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:43:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so1668439otj.11;
        Thu, 26 Sep 2019 04:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NJdVMhLCeR2qiK+ps5K2jQQOjDIRz/+T2QEFlJumLo=;
        b=ID9IoPJJTSGf5si0CLomZFSVVrRwR+mdL0qANNE3/Batj1CZJiqlbl7ViKb7S1YmAk
         Cp4J1i7oaVpKqmksPFEyjoPfo/ufSXidJtiT+KG+K1TfDIkaBbzKuC2f11Tfsw5caR6/
         Lxv6WVUmchDpw7ztr785bfYMItHvVQyGult5jH12UMOzyxFgCYr32sBvj7X2g9xyWyzb
         xU5NbiYGcT/7l6n2+lYBm1TVgByJv/X9AVZm+H7luChUScDpumgL3GXTj9CjR9gmYgO+
         v6ydzZlF96RYc75sABGbNMa3k19JUrS91dLCV6eKlCUgVZHIKGhzufyNKAAHGUcLe5VE
         jFcw==
X-Gm-Message-State: APjAAAWAiQVGhlmdUOlCMuOxLlfmbmom7R1eR78/oIc8m9jVnmrgwwPo
        b7CzxspEMssWShNIF+NnibKTNEzFF5aNwZXGVqvTSVQt
X-Google-Smtp-Source: APXvYqwrzHBwDdOQwaGyp+5fyfQIfQ0z97+Qu0pah+x251meUloMW93t4iddIxB6GsMhyGbNpuoyECgs8nMgvL16kGA=
X-Received: by 2002:a9d:193:: with SMTP id e19mr2139993ote.107.1569498208192;
 Thu, 26 Sep 2019 04:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190926101312.32218-1-geert@linux-m68k.org> <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
In-Reply-To: <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 13:43:16 +0200
Message-ID: <CAMuHMdU3T83z1iZ7O2-5eRkawdGm50Auw5o0K9+J5Q7+oev62g@mail.gmail.com>
Subject: Re: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Thu, Sep 26, 2019 at 12:45 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Thu, Sep 26, 2019 at 7:13 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > When the compiler decides not to inline the Chunky-to-Planar core
> > functions, the build fails with:
> >
> >     c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
> >     c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
> >     c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
> >     c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
> >
> > Fix this by marking the functions __always_inline.
> >
> > Reported-by: noreply@ellerman.id.au
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Fixes: 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
> >
> > As this is a patch in akpm's tree, the commit ID in the Fixes tag is not
> > stable.
>
> BTW, that Fixes tag is incorrect.
>
> Irrespective of 025f072e5823947c, you could manually enable
> CONFIG_OPTIMIZE_INLINING from menuconfig etc.

Merely enabling that doesn't help.
You also need CONFIG_CC_OPTIMIZE_FOR_SIZE=y, while the
default is CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y.
Which is why my all{mod,yes}config builds never caught that :-(

> So, this build error would have been found much earlier
> if somebody had been running randconfig tests on m68k.

It's been a while I did that...

BTW, does randconfig randomize choices these days?
I remember it didn't use to do that.

> It is impossible to detect this error on other architectures
> because the driver config options are guarded by
> 'depends on ATARI' or 'depends on AMIGA'.
>
> The correct tag is:
>
> Fixes: 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING")
>
> The commit id is stable.

Thanks, will update.

> As an additional work,
> depends on (AMIGA || COMPILE_TEST)
> would be nice unless this driver contains m68k-specific code.

The Amiga and Atari frame buffer drivers need <asm/{amiga,atari}hw.h>,
and the Atari driver contains inline asm.

The C2P code could be put behind its own Kconfig symbol, I guess.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
