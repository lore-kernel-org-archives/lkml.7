Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184BEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AA8216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OjJQYTl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfETThB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:37:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34361 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfETThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:37:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id l17so14127662otq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVji6EW7+3Muo/zfup6MVTf/3d/utIq25qSjoZ1JLts=;
        b=OjJQYTl5xqc9g9jBo9P61CScZaOFd89JYM+lXP+wWpwnM5V85ht/CH5QBwe3G6xum/
         NQacpr0MMdVXwY77pd9fHReGdHexG8HnZY9OPu0ByLOaJkfRoOWt5rSZX0LQ3T5LEBwr
         JNO9ZzQCC4Ft8SIiXHjQIUjPl6wGB78mKQw9jXsyQp0kRZYTwbGU15l7UTVqVAQJePUR
         woyvknrDveua2kKithc9BI89DXCEoU2ghvohNcAT3ZUhr1qdIeU/ZRJlgEHpLoTtQ6Gt
         yTHm3Kc9d0Mhy/F8gIAjHwX5U8l7KCmlcTzq1mTQnwMgp9+gadfZ9EjixHDrVt5FWj4M
         ENSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVji6EW7+3Muo/zfup6MVTf/3d/utIq25qSjoZ1JLts=;
        b=mcQOoPlVtpX73Yw/m0+KivtVjAoIJWp99mTeVSY4CpDXCVaBy3c18VgYCHpePGBefK
         6M/mVlhW4hksrBOBtSAYMoe0y0LuM9dhcNPDDXnvvMgGw7unVl2VyzRTYOdM3N2cVFPE
         UPcAZ4eADja/SuJceQw35bvPna2oVZ5F/KWq7saHJ2SgGpl2C41CKUvJRaCb4/knEoeZ
         rU+qbMUYB85N/1/SCkhPS42ZdeDLEESv7Rx8HmZbjZ6cqVtz/q3vE05cF5+rMZUgWv0V
         Jy2S85iBOOps1xWmmlf3u/VZMp9g9IPMZl6loQqT0Y/+e0U6SkLDmAkEIoPzxv+cLEoa
         f3qw==
X-Gm-Message-State: APjAAAXTmBoKoLWgBNBp9h5p1Rqg63Ik/wQUbR9dlz/fetzYnYAPegGL
        nDl2bMT+ML6Dl34I6atKM2SAuJlR0LSuoDsbbsCoj+QBj9g=
X-Google-Smtp-Source: APXvYqy9xz0BM+Jt3/1MqM1Qd0gyzmKhktCKQkV64no6FtpQKOWujanY15J3MAYELu3Ppdok5fMkBGK/kEKzFRI2cWg=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr46812783oto.6.1558381020106;
 Mon, 20 May 2019 12:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
 <CAHStOZ5Pe9LvDk4cKAVB4SS5wgFcK-bweFTqU_mnEhOAyZKHuA@mail.gmail.com>
 <CAFBinCD4OnBbU0YR5P5cAhut==XXUxdHSxHQkBVm28DHZWkbAw@mail.gmail.com> <CAHStOZ4O=sdHaKrY_DwkhDHVBsa_Dg4xWEBrS77LHG-WbZ6-Cw@mail.gmail.com>
In-Reply-To: <CAHStOZ4O=sdHaKrY_DwkhDHVBsa_Dg4xWEBrS77LHG-WbZ6-Cw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 21:36:49 +0200
Message-ID: <CAFBinCBKK7+dvkTwa=b7uBCAxLimzLnnvOSo4VD+5AVRiuynug@mail.gmail.com>
Subject: Re: [PATCH 0/3] 32-bit Meson: add the canvas module
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Cc:     linux-amlogic <linux-amlogic@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>, mjourdan@baylibre.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, May 20, 2019 at 9:21 PM Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
>
> Hey Martin, so sorry for forgetting about this.
>
> On Thu, Apr 18, 2019 at 9:50 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Maxime,
> >
> > On Sat, Apr 13, 2019 at 8:54 PM Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
> > >
> > > Hi Martin,
> > > On Sat, Apr 13, 2019 at 7:15 PM Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com> wrote:
> > > >
> > > > This adds the canvas module on Meson8, Meson8b and Meson8m2. The canvas
> > > > IP is used by the video decoder hardware as well as the VPU (video
> > > > output) hardware.
> > > >
> > > > Neither the VPU nor the video decoder driver support the 32-bit SoCs
> > > > yet. However, we can still add the canvas module to have it available
> > > > once these drivers gain support for the older SoCs.
> > > >
> > > > I have tested this on my Meson8m2 board by hacking the VPU driver to
> > > > not re-initialize the VPU (and to use the configuration set by u-boot).
> > > > With that hack I could get some image out of the CVBS connector. No
> > > > changes to the canvas driver were required.
> > > >
> > > > Due to lack of hardware I could not test Meson8, but I'm following (as
> > > > always) what the Amlogic 3.10 vendor kernel uses.
> > > > Meson8b is also not tested because u-boot of my EC-100 doesn't have
> > > > video output enabled (so I couldn't use the same hack I used on my
> > > > Meson8m2 board).
> > > >
> > > > This series meant to be applied on top of "Meson8b: add support for the
> > > > RTC on EC-100 and Odroid-C1" from [0]
> > > >
> > > >
> > >
> > > The series looks good to me, however I wonder if we should maybe add a
> > > new compatible ?
> > >
> > > The canvas IP before the GX* generation does not handle what Amlogic
> > > calls "endianness", the field that allows doing some byte-switching to
> > > get proper NV12/NV21. So the following defines are unusable:
> > >
> > > #define MESON_CANVAS_ENDIAN_SWAP16 0x1
> > > #define MESON_CANVAS_ENDIAN_SWAP32 0x3
> > > #define MESON_CANVAS_ENDIAN_SWAP64 0x7
> > > #define MESON_CANVAS_ENDIAN_SWAP128 0xf
> > I didn't know about this - thank you for pointing this out.
> >
> > your suggestions to add new compatible strings is a good idea for that case.
> > Amlogic uses different defines for Meson8 and Meson8m2 in their vendor
> > kernel and they keep Meson8b different.
> > I will add three new compatibles, one for each SoC (Meson8, Meson8b,
> > Meson8m2) just to be on the safe side if we discover differences in
> > the canvas IP on these SoCs.
> >
> > what do you think?
> >
>
> Sure thing. Keep an eye out for any hints regarding the amount of
> canvases as well, I *think* I remember some old SoCs having only 192
> but I haven't been able to find it again.
Meson6 and older are limited to 192, Meson8 and newer already support
256. source: [0]

> > > It wouldn't change much functionally, but we could have e.g a warning
> > > if a m8 canvas user tries to set endianness even though it does
> > > nothing.
> > this is a good idea, that will make it easier to spot why something
> > doesn't work.
> > we can also return -EINVAL, like you already do for the case where the
> > canvas ID is already used.
> >
>
> Yes, returning an error is a good idea.
OK, I'll send an updated series later.


Martin


[0] https://github.com/endlessm/linux-meson/blob/5cb4882cdda584878a29132aeb9a90497a121df9/drivers/amlogic/canvas/canvas.c#L41
