Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3488C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00EA206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbfG2Pl1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:41:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39521 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbfG2Pl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:41:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so9211160wrt.6;
        Mon, 29 Jul 2019 08:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xxQXIw3jvl/S1k9A2H6zSUmpyqWCq7mlSHIXxho7oz4=;
        b=cLBiBB40wi15LCSyOkN9cF8lZffAAzx9m/5n26T8h9MOFkL4LF04Gi42I3MrHHyxch
         But74+nQtwtiBBax4hTo5MA+noIEm7lI9Ni4G6/DJDzQzpFeNs2+TPUCLrfwV5mCK6sW
         S5nAO5j1AlTuNdZ+tMZ/0Mxq0EV6dE8w+eTXLxc0R3+Dpr0VEDOp/VRC3+bpc0ym3R7U
         ZZMnJP+XxTuXbFj5fH/Hv6DctA8frBlDY0MXbJGC880P7bhVJNQXK9jKs7sEbRmd+m7d
         Gbx5z0dZliydleMO0jLCdNfS5FaEKf1p863Gte38nwg46AOoPzkpj0sSkA4WmaJS2XxG
         ZjYQ==
X-Gm-Message-State: APjAAAXP01NX2WaoecJBnp8efumObjIJDnmv/hA+DdhfHoNueHyLtHR9
        SDt2cKE4VqkSydXQe2mT4WMJRmiIa6BL3l7ZXIM=
X-Google-Smtp-Source: APXvYqzBEqFSoJ1b9bepaHXMbEjq8XzMAZPHCa1KyWJ5zIgkVHJt4qD8XzWJwRTNIsQa/rLsiut1qhGf43oicKWImwQ=
X-Received: by 2002:adf:f08f:: with SMTP id n15mr37064306wro.213.1564414883303;
 Mon, 29 Jul 2019 08:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190725180825.31508-1-max@enpas.org> <CAMuHMdURm-9nazOBTL8uRH8WMt7gi=QUYy0qr9kaxzczCr+ujg@mail.gmail.com>
 <9cde6e79-52da-e0c0-f452-6afc2e5fa5ee@enpas.org> <CAMuHMdUGsfzQg8xy2OqWfuo09MxwZ5OJz=t5CARJp+A1ZVtqaA@mail.gmail.com>
 <b7473bd6-650d-f0b6-0d30-99e3b6b942b5@enpas.org> <CAMuHMdXVzX6cm4uTe7OipAuR4viye32yKuHWJBzuLpR_wqyRhQ@mail.gmail.com>
 <7a6f887f-b674-4db7-a09a-a028219ebce0@enpas.org>
In-Reply-To: <7a6f887f-b674-4db7-a09a-a028219ebce0@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 17:41:11 +0200
Message-ID: <CAMuHMdXwWHz9pkOKf4NiPF=GXS-vTU20Hu9QNni9ZWVds2bWGw@mail.gmail.com>
Subject: Re: [PATCH v3] ata/pata_buddha: Probe via modalias instead of initcall
To:     Max <max@enpas.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Mon, Jul 29, 2019 at 5:38 PM Max <max@enpas.org> wrote:
> On 07/29/2019 05:26 PM, Geert Uytterhoeven wrote:
> >> We *could* also temporarily split off a pata_buddha_xsurf driver: pata_buddha would be auto-probed by the new framework, and pata_buddha_xsurf would do the old module_init() dance.
> >> That is, until the MFD conversion happens.
> >
> > Or add temporarily a late_initcall() to find all X-Surf boards using
> > zorro_find_device(), create fake zorro_device_id entries, and pass both
> > to pata_buddha_probe()?  A big ugly, but that should work.
>
> Sounds good, and it replaces modile_init() at the same time. I'll implement this.

Thanks!

> >>> Your single Buddha should be sufficient to convert pata_buddha.c from
> >>> a plain Zorro driver to an MFD cell driver, and test it.
> >>> I expect the buddha-mfd.c MFD driver from my zorro-mfd branch to
> >>> work as-is, or with very minor changes.
> >>>
> >>> However, to keep X-Surf working, this needs to be synchronized with
> >>> a Zorro MFD conversion of the zorro8390 driver, too.
> >>
> >> Yeah, this second part is where I get caught up. I'd really like to test this with a real X-Surf, or have someone test it, before sending it upstream.
> >
> > Of course it should be tested ;-)
> > Converting zorro8390.c from a zorro driver to an MFD cell driver should
> > not require that many changes, most bugs should be caught by code review.
> > I already have a skeleton 8390-cell.c driver in my zorro-mfd branch.
>
> Honestly, at this point I'd rather do the hack above and keep the MFD stuff for later. Let's take it step by step. I'd prefer not to touch 8390 for now, unless I can get my hands on an X-Surf. I'd like to help with the MFD stuff as a way to enable the clockport and my SilverSurfer on it, but for the moment I'd rather move that further down the road.

OK, fine for me, of course.

> >>> Yes, the clockport could be added as an extra MFD cell.  Later, drivers can
> >>> be written to bind against the clockport cell.
> >>
> >> Yes, but how can we assign specific drivers to specific clockports? As they are non-enumerable (are they?), we can't auto-probe them.
> >
> > That's something the user has to configure.
> > The Buddha MFD driver registers an "a1200-clockport" cell, which is
> > really a separate platform device.
> > The user writes the name of the actual driver to use to the device's
> > driver_override file in sysfs, after which the driver is bound
> > automatically.  See Documentation/ABI/testing/sysfs-bus-platform,
>
> That sounds just like what I was hoping for, thanks.

I'm happy you like it ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
