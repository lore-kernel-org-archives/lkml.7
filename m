Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049CAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF83204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfETTV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:21:59 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:29627 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:21:58 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170])
        by mwinf5d48 with ME
        id EjMv2000F3gswE903jMwHW; Mon, 20 May 2019 21:21:56 +0200
X-ME-Helo: mail-qt1-f170.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Mon, 20 May 2019 21:21:56 +0200
X-ME-IP: 209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id h1so17719306qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:21:56 -0700 (PDT)
X-Gm-Message-State: APjAAAUjJrxYF9EoJOdQKfjL7mPwFttEQB2h7mv1fjLnsEB/oTBGZNXJ
        Fhr2Hh7dw7WKTxp4dHbjIqlH6eqzjvw4/i9Akng=
X-Google-Smtp-Source: APXvYqwWx9jKotKEBSYAh/ox+pJ7V+Mptux6Q++uPZ/syBhzl2tV/VKpkDxPtgnqjvrayCPxYj5WzDuOzvpzYmMWHCQ=
X-Received: by 2002:a0c:d941:: with SMTP id t1mr61382342qvj.204.1558380115291;
 Mon, 20 May 2019 12:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
 <CAHStOZ5Pe9LvDk4cKAVB4SS5wgFcK-bweFTqU_mnEhOAyZKHuA@mail.gmail.com> <CAFBinCD4OnBbU0YR5P5cAhut==XXUxdHSxHQkBVm28DHZWkbAw@mail.gmail.com>
In-Reply-To: <CAFBinCD4OnBbU0YR5P5cAhut==XXUxdHSxHQkBVm28DHZWkbAw@mail.gmail.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Mon, 20 May 2019 21:21:43 +0200
X-Gmail-Original-Message-ID: <CAHStOZ4O=sdHaKrY_DwkhDHVBsa_Dg4xWEBrS77LHG-WbZ6-Cw@mail.gmail.com>
Message-ID: <CAHStOZ4O=sdHaKrY_DwkhDHVBsa_Dg4xWEBrS77LHG-WbZ6-Cw@mail.gmail.com>
Subject: Re: [PATCH 0/3] 32-bit Meson: add the canvas module
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>, mjourdan@baylibre.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Martin, so sorry for forgetting about this.

On Thu, Apr 18, 2019 at 9:50 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Maxime,
>
> On Sat, Apr 13, 2019 at 8:54 PM Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
> >
> > Hi Martin,
> > On Sat, Apr 13, 2019 at 7:15 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > This adds the canvas module on Meson8, Meson8b and Meson8m2. The canvas
> > > IP is used by the video decoder hardware as well as the VPU (video
> > > output) hardware.
> > >
> > > Neither the VPU nor the video decoder driver support the 32-bit SoCs
> > > yet. However, we can still add the canvas module to have it available
> > > once these drivers gain support for the older SoCs.
> > >
> > > I have tested this on my Meson8m2 board by hacking the VPU driver to
> > > not re-initialize the VPU (and to use the configuration set by u-boot).
> > > With that hack I could get some image out of the CVBS connector. No
> > > changes to the canvas driver were required.
> > >
> > > Due to lack of hardware I could not test Meson8, but I'm following (as
> > > always) what the Amlogic 3.10 vendor kernel uses.
> > > Meson8b is also not tested because u-boot of my EC-100 doesn't have
> > > video output enabled (so I couldn't use the same hack I used on my
> > > Meson8m2 board).
> > >
> > > This series meant to be applied on top of "Meson8b: add support for the
> > > RTC on EC-100 and Odroid-C1" from [0]
> > >
> > >
> >
> > The series looks good to me, however I wonder if we should maybe add a
> > new compatible ?
> >
> > The canvas IP before the GX* generation does not handle what Amlogic
> > calls "endianness", the field that allows doing some byte-switching to
> > get proper NV12/NV21. So the following defines are unusable:
> >
> > #define MESON_CANVAS_ENDIAN_SWAP16 0x1
> > #define MESON_CANVAS_ENDIAN_SWAP32 0x3
> > #define MESON_CANVAS_ENDIAN_SWAP64 0x7
> > #define MESON_CANVAS_ENDIAN_SWAP128 0xf
> I didn't know about this - thank you for pointing this out.
>
> your suggestions to add new compatible strings is a good idea for that case.
> Amlogic uses different defines for Meson8 and Meson8m2 in their vendor
> kernel and they keep Meson8b different.
> I will add three new compatibles, one for each SoC (Meson8, Meson8b,
> Meson8m2) just to be on the safe side if we discover differences in
> the canvas IP on these SoCs.
>
> what do you think?
>

Sure thing. Keep an eye out for any hints regarding the amount of
canvases as well, I *think* I remember some old SoCs having only 192
but I haven't been able to find it again.

> > It wouldn't change much functionally, but we could have e.g a warning
> > if a m8 canvas user tries to set endianness even though it does
> > nothing.
> this is a good idea, that will make it easier to spot why something
> doesn't work.
> we can also return -EINVAL, like you already do for the case where the
> canvas ID is already used.
>

Yes, returning an error is a good idea.

Maxime

>
> Martin
