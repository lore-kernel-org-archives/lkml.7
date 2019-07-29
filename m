Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B45206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfG2IWo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:22:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46027 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2IWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:22:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so60749816wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NRW+7eX1EamfMQ1j+7nziAgPDBExPLIJt9EL33UvSvA=;
        b=nLdHcvw29iYz6szI4b9qUbCkm8VZ3p3aEkee7a9j5MwUIf9t+1B0G94ve0y+fH9A35
         Cxm2IH8RExcTVj4YjuDB3UnEuauKQCG/VFXUL6SlsBGjamYtUVcSql91IwO9v1BlwpP1
         Qrmd1Oeup5+SvzeM6LzRk4C0xsNki8q+E9ncjZpcvnNso6esNCjuGerwFyJxaCTcfC0M
         VnRqMXIpGxZ/D2P1VT5zrIB+cPlqJYcJKiuP5/mRKeSUjXEFc9gQ12lIhtGZVO9sc0G7
         9uSTyOIiEPKmPBFmurhHLmTg6CXs0lH3MWT31QLfjCIIZf6iRSKiLs68jivS+rgxoLYo
         um3g==
X-Gm-Message-State: APjAAAUGpAqA8Th679ccVZ8rH6YW0leaSgYtIViEmFVVDiTZa2gB0VIy
        D07W2EJ+t2dBXrG4g7KysW/7TNPhmuVW0H4xfEs=
X-Google-Smtp-Source: APXvYqwRd0NjKwuKsNQrhF/AofoCE6s79F/LxnezbkGgBQ9n8GYJ1SXbHX67MoW7rslVqa+H6NnYI2S15C+ysz3TrBo=
X-Received: by 2002:adf:cd81:: with SMTP id q1mr117016959wrj.16.1564388561650;
 Mon, 29 Jul 2019 01:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190728135826.GA10262@roeck-us.net> <a0e789dd-5244-6af3-56c2-970b03d264a8@embeddedor.com>
In-Reply-To: <a0e789dd-5244-6af3-56c2-970b03d264a8@embeddedor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 10:22:29 +0200
Message-ID: <CAMuHMdXJWUK8Y1f1+LA9ro6HvLmtOHbSOrvqhVpzo0KgvaCMfQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Globally enable fall-through warning
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Sun, Jul 28, 2019 at 6:44 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 7/28/19 8:58 AM, Guenter Roeck wrote:
> > On Thu, Jun 06, 2019 at 07:46:17PM -0500, Gustavo A. R. Silva wrote:
> >> Now that all the fall-through warnings have been addressed in the
> >> kernel, enable the fall-through warning globally.
> >>
> >
> > Not really "all".
> >
> > powerpc:85xx/sbc8548_defconfig:
> >
> > arch/powerpc/kernel/align.c: In function ‘emulate_spe’:
> > arch/powerpc/kernel/align.c:178:8: error: this statement may fall through
> >
> > Plus many more similar errors in the same file.
> >
> > All sh builds:
> >
> > arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
> > arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
> >
> > Again, this is seen in several places.
> >
> > mips:cavium_octeon_defconfig:
> >
> > arch/mips/cavium-octeon/octeon-usb.c: In function 'dwc3_octeon_clocks_start':
> > include/linux/device.h:1499:2: error: this statement may fall through
> >
> > None of those are from recent changes. And this is just from my small
> > subset of test builds.
> >
>
> Thank you for letting me know about this. I don't have access to build
> infrastructure like yours.
>
> My build infrastructure is similar to that of Linus.
>
> But if you send me all of those I can create a patch and send it back
> to you to make sure what you see is addressed. If we can coordinate for
> this it'd be great for everybody. :)
>

More to be found in
https://lore.kernel.org/lkml/20190729081727.6094-1-geert@linux-m68k.org/

and I saw the following in my local builds (not detected above due to
kisskb using an older compiler for m68k builds):

arch/m68k/include/asm/amigahw.h: warning: this statement may fall
through [-Wimplicit-fallthrough=]:  => 42:50
drivers/block/ataflop.c: warning: this statement may fall through
[-Wimplicit-fallthrough=]:  => 1728:3
drivers/net/arcnet/com20020-isa.c: warning: this statement may fall
through [-Wimplicit-fallthrough=]:  => 205:13, 203:10, 209:7, 201:11,
207:8
drivers/scsi/sun3_scsi.c: warning: this statement may fall through
[-Wimplicit-fallthrough=]:  => 399:9, 403:9
sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
through [-Wimplicit-fallthrough=]:  => 1449:24

Thanks for fixing ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
