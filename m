Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76831206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfG2Lac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:30:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39224 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbfG2Lac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:30:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so42773532wmc.4;
        Mon, 29 Jul 2019 04:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYgTCADguDanxFOEAPrmobWhF2N2XCa1x0cKc1vynOs=;
        b=r5F5lq4yaHC3gSbNRzVFesm6pheoa1cmO7sbzThyM3fT7JDySssZx2XFq/WZLTISHD
         xA/hY/vGccR9Qwed9daWO0P4Ztjjd/W6EAGaRyFtvpmeFHsow08cgaFVLiUnszobt1sV
         mRZC9GF7naLS2waW5ulIqqwsPdKdWKNDg67TCq6W6z3pjLDQ6bMoVQW0ZugU9O789H5N
         8G5aPUSYOCGutGFeOXTpDXThYl2s/Ixew1qs6k/7p7inzyOpiK5oDOCHK1OSnMuDIJ11
         YhwOxND3biSE2V0uRfcUbxfk2KppFigKhCXZrvyyrwVDqR0qWIkWEdY0OKY+X+9GJE6X
         sO2w==
X-Gm-Message-State: APjAAAWFZcpY+DxZ/6cr7FrVu2K5JLI7qWTxsf6HZzSF/yATIeVLUDb0
        cAlHW1S7rSLdAWjuSgB97lAh8v/VeHs4a8dq+ThbiSuE
X-Google-Smtp-Source: APXvYqwDEPOHPZ3E0KgxisZBB6lCwoAfdCHOdH5TFR4vuced9FNVTwhHtpMIWIn+X32IlCaCma6G7CGcZjlSmETYarA=
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr100793795wme.146.1564399829718;
 Mon, 29 Jul 2019 04:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190725180825.31508-1-max@enpas.org> <CAMuHMdURm-9nazOBTL8uRH8WMt7gi=QUYy0qr9kaxzczCr+ujg@mail.gmail.com>
 <9cde6e79-52da-e0c0-f452-6afc2e5fa5ee@enpas.org>
In-Reply-To: <9cde6e79-52da-e0c0-f452-6afc2e5fa5ee@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 13:30:17 +0200
Message-ID: <CAMuHMdUGsfzQg8xy2OqWfuo09MxwZ5OJz=t5CARJp+A1ZVtqaA@mail.gmail.com>
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

On Mon, Jul 29, 2019 at 1:10 PM Max Staudt <max@enpas.org> wrote:
> On 07/29/2019 11:05 AM, Geert Uytterhoeven wrote:
> >> --- a/drivers/ata/pata_buddha.c
> >> +++ b/drivers/ata/pata_buddha.c
> >
> >> +static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
> >> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, },
> >> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, },
> >> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },
> >
> > drivers/net/ethernet/8390/zorro8390.c also matches against
> > ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, while only
> > a single zorro_driver can bind to it.  Hence you can no longer use both
> > IDE and Ethernet on X-Surf :-(
> > Before, this worked, as the IDE driver just walked the list of devices.
>
> Okay, now this gets dirty.
>
> The reason why I've submitted this patch is to allow pata_buddha to be built into the kernel at all. Without this patch, its initcall would be called before the Zorro structures are initialised, hence not finding any boards.

IC. I wasn't aware of the new pata_buddha.c driver not working at all
when builtin.

> That means that not only would the previous driver only make sense as a module that is manually ensured to be loaded after Zorro has started, but the X-Surf IDE support was a really ugly hack to begin with.

Right. Please note that most drivers for Zorro boards predate the device
driver framework, and thus all started life using zorro_find_device().
But this did have the advantage of supporting multi-function cards
out-of-the-box.
Later, several drivers were converted to the new driver framework.
but not all of them, due to multi-function cards.

> > I think the proper solution is to create MFD devices for Zorro boards
> > with multiple functions, and bind against the individual MFD cells.
> > That would also get rid of the nr_ports loop in the IDE driver, as each
> > instance would have its own cell.
> >
> > I played with this a long time ago, but never finished it.
> > It worked fine for my Ariadne Ethernet card.
> > Last state at
> > https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd
> >
> > Oh, seems I wrote up most of this before in
> > https://lore.kernel.org/lkml/CAMuHMdVe1KgQWYZ_BfBkSo3zr0c+TenLMEw3T=BLEQNoZ6ex7A@mail.gmail.com/
>
> This looks great!
>
> Unfortunately, I don't have any MFD hardware other than a single
> Buddha to test this with. I especially don't have an X-Surf, hence no
> good way of testing this other than the two IDE channels on my Buddha.
> WinUAE doesn't seem to emulate the IDE controller either.
>
> What shall I do? Maybe as a stop-gap measure, we could hard-code a
> module_init() again, just for X-Surf? It's been good enough until a
> few weeks ago, so what could go wrong ;)

In the short run: keep on using drivers/ide/buddha.c?

Your single Buddha should be sufficient to convert pata_buddha.c from
a plain Zorro driver to an MFD cell driver, and test it.
I expect the buddha-mfd.c MFD driver from my zorro-mfd branch to
work as-is, or with very minor changes.

However, to keep X-Surf working, this needs to be synchronized with
a Zorro MFD conversion of the zorro8390 driver, too.

> On another note: Maybe your MFD idea could be used to expose the
> clockports on the Buddhas as well? That wouldn't solve the issue of
> clockport *expansions* being fundamentally non-enumerable, but maybe
> you can think of a reasonable way to attach a driver?

Yes, the clockport could be added as an extra MFD cell.  Later, drivers can
be written to bind against the clockport cell.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
