Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560F2C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C9C206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbfG2P05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:26:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54184 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfG2P04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:26:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so54261972wmj.3;
        Mon, 29 Jul 2019 08:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3v6lk4nz7xmxQehYsUuyOGWbU8x5GIX01n8BFdw2Z4=;
        b=VKe1qpeA+UlWV5iViiDzkxEU/hAsEOxGA4W37SYmuW066QeGmBH7Ftj13ZsNThqqOz
         WKbLaITDNS4cUwwflXUlUGnJ+fnvO76xAcehJcHT3+fD49gMxeII/7ZY8bZkRALeTkL3
         4SWfEkKmF8KbE7eGLKGKmwr6wDlDqi0dDYZJCcOO4tzhO9Ok7tmd/RAV6l+RR1dPwu0R
         PZtqQD/J29DNjWgmWIGMLLYjMa+sHNq7S0U1RZyR8r8z5myGfTCQgNlAIB4Ao/oYffmx
         ziUeIDJxMt3Eig1tzBP5l6f0dpvWIE2GhawaHXtmuYe5pcetBwzewX0x6mE6zTGrOEar
         w2QQ==
X-Gm-Message-State: APjAAAXePPw2fFAa1lkFMmUXosDK26pieggK9GboV7fELII1phdxugxJ
        Znj1wX4eRKFxjIoVJqTXxXYXdzHCWCiVnLV9wd4=
X-Google-Smtp-Source: APXvYqzoFWBjVuyBjGiLlM1oJmTeTsa/GcXaIJpupx+7yFhLhTr1TDU48haCkkU7jUy+emNGB7oDkYlgILxpSZmTkQY=
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr93401915wma.171.1564414013538;
 Mon, 29 Jul 2019 08:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190725180825.31508-1-max@enpas.org> <CAMuHMdURm-9nazOBTL8uRH8WMt7gi=QUYy0qr9kaxzczCr+ujg@mail.gmail.com>
 <9cde6e79-52da-e0c0-f452-6afc2e5fa5ee@enpas.org> <CAMuHMdUGsfzQg8xy2OqWfuo09MxwZ5OJz=t5CARJp+A1ZVtqaA@mail.gmail.com>
 <b7473bd6-650d-f0b6-0d30-99e3b6b942b5@enpas.org>
In-Reply-To: <b7473bd6-650d-f0b6-0d30-99e3b6b942b5@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 17:26:41 +0200
Message-ID: <CAMuHMdXVzX6cm4uTe7OipAuR4viye32yKuHWJBzuLpR_wqyRhQ@mail.gmail.com>
Subject: Re: [PATCH v3] ata/pata_buddha: Probe via modalias instead of initcall
To:     Max Staudt <max@enpas.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Mon, Jul 29, 2019 at 4:31 PM Max Staudt <max@enpas.org> wrote:
> On 07/29/2019 01:30 PM, Geert Uytterhoeven wrote:
> >> What shall I do? Maybe as a stop-gap measure, we could hard-code a
> >> module_init() again, just for X-Surf? It's been good enough until a
> >> few weeks ago, so what could go wrong ;)
> >
> > In the short run: keep on using drivers/ide/buddha.c?
>
> See Bartlomiej's reply to your email: It suffers from the same problem. Building it in will result in the Buddha not being recognised, as the IDE driver scans for it before Zorro si initialised.

Thanks for the confirmation.

> @Bartlomiej: You're not missing anything, the problem has gone unnoticed for ages ;)
> However, using ide/buddha would work exactly as it has before: When loaded as a module after Zorro has been initialised, it works just fine.
>
> We *could* also temporarily split off a pata_buddha_xsurf driver: pata_buddha would be auto-probed by the new framework, and pata_buddha_xsurf would do the old module_init() dance.
> That is, until the MFD conversion happens.

Or add temporarily a late_initcall() to find all X-Surf boards using
zorro_find_device(), create fake zorro_device_id entries, and pass both
to pata_buddha_probe()?  A big ugly, but that should work.

> > Your single Buddha should be sufficient to convert pata_buddha.c from
> > a plain Zorro driver to an MFD cell driver, and test it.
> > I expect the buddha-mfd.c MFD driver from my zorro-mfd branch to
> > work as-is, or with very minor changes.
> >
> > However, to keep X-Surf working, this needs to be synchronized with
> > a Zorro MFD conversion of the zorro8390 driver, too.
>
> Yeah, this second part is where I get caught up. I'd really like to test this with a real X-Surf, or have someone test it, before sending it upstream.

Of course it should be tested ;-)
Converting zorro8390.c from a zorro driver to an MFD cell driver should
not require that many changes, most bugs should be caught by code review.
I already have a skeleton 8390-cell.c driver in my zorro-mfd branch.

> > Yes, the clockport could be added as an extra MFD cell.  Later, drivers can
> > be written to bind against the clockport cell.
>
> Yes, but how can we assign specific drivers to specific clockports? As they are non-enumerable (are they?), we can't auto-probe them.

That's something the user has to configure.
The Buddha MFD driver registers an "a1200-clockport" cell, which is
really a separate platform device.
The user writes the name of the actual driver to use to the device's
driver_override file in sysfs, after which the driver is bound
automatically.  See Documentation/ABI/testing/sysfs-bus-platform,

The alternative would be to have multiple drivers matching against
"a1200-clockport", and the user modprobe'ing the correct one to use.
But that won't work with http://wiki.icomp.de/wiki/A500/A1000_clockport
and plugging in two different clock port boards.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
