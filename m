Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8041EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5479B208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWpdWTEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEMT6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:58:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41832 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMT6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:58:22 -0400
Received: by mail-io1-f67.google.com with SMTP id a17so11097192iot.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8E2lp8jVprsIWJDs3aj1G6BOEVXUF319INMkMLGaQPQ=;
        b=uWpdWTEnUT7BTgsJQWf5pKdud4DbPSFbUIIXg+p6wqy1tzhB9pKrPRFV470b2FWst2
         ZdnelJWwFio2yavTWMioXedAoUY40VFFpYjyh45NXBxDrQEZj987e4GCA0gNm4yvggBA
         t3EJCHtc6Yo9LMOHT7sR+8a5XqcfaeyL58/ieMmMoASsDM7UG6y8tX8gJpD2LiozdiUj
         cBBGsnQQlXUZDEeKdkCzGYatPDEvRhrKRMyCbSjHNu/bHuLScNN++9GcR4MCq8fucHo4
         KxGBY90rc8IUEN4WDxLsuz3OgCb+11/8R2PWR17srWGFtHo+o6RL5rxuv1hMGX0JBTyQ
         SC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8E2lp8jVprsIWJDs3aj1G6BOEVXUF319INMkMLGaQPQ=;
        b=dzNC2ebVy4jtIQy2QqYZxHchByAxZkCqeC+VqTakUEhosSzkzB0byxHjHxp3NrHWEP
         6riDpw3WpzJTEUnLmJvMWGfIa1iE02E6Wcsl+WsWF5aYnah4vUs0Pg3z72DdG8NGgpFq
         GGqqgQPPfRuOFASeoP+meAVjJhnd+z3Oz7Of5L0F40+uso6ixhCaki7m+SVa6zOXI9Ty
         GffthZlZPiosQjyaTcNeNLU9T0r5U6NQgP0UYqySCgLB7K2X47XRjHVbPC37VbsXXF3w
         19yDMuyiYiiru7RLW2lVDwFDUc2nlmHmfRgPQVyAi+QuUFWYlbi/1Z+flVqq8XOBK3gR
         jrvg==
X-Gm-Message-State: APjAAAWodMErOQn1RWbQ5gVAWtLTcvlWQIcJUFZHbojMYf6qoVY0HM/C
        6HdOoSqGLNNFX9jjU6bO07H1hovVTQB7BTybsux0e0SqIS8=
X-Google-Smtp-Source: APXvYqxhy6RVX8SCv3UxFKo30Lo9SicUvdQXI4VmMLRILDRKbsDfy5vwl6x8wMZOVD8ur7XVSYXIaGkaaagjru51cxk=
X-Received: by 2002:a6b:b212:: with SMTP id b18mr1073091iof.15.1557777501840;
 Mon, 13 May 2019 12:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190513035909.30460-1-andrew.smirnov@gmail.com>
 <20190513035909.30460-2-andrew.smirnov@gmail.com> <CAOMZO5Dkv_g-+GjYfrRP8h0bmRMws1iETRJiGmTBx7tfM_HwyA@mail.gmail.com>
In-Reply-To: <CAOMZO5Dkv_g-+GjYfrRP8h0bmRMws1iETRJiGmTBx7tfM_HwyA@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 13 May 2019 12:58:10 -0700
Message-ID: <CAHQ1cqFK=ro++GtTOisQtgSqHm4jNdSCfMDbHXaOVcbMj5eX6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: vf610-zii-dev: Add QSPI node
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 5:15 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Mon, May 13, 2019 at 12:59 AM Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > +&qspi0 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_qspi0>;
> > +       status =3D "okay";
> > +
> > +       /*
> > +        * Attached MT25QL02 can go up to 90Mhz in DTR and 166 in SDR
> > +        * modes, so we limit spi-max-frequency to 90Mhz
>
> Nit: It is MHz, not Mhz.
>
> MT25QL02 datasheet refers to DTR and STR (not SDR).
>

Sure, will fix.

> Also, the public datasheet I can see online lists these limits differentl=
y:
>
> "=E2=80=A2 Clock frequency =E2=80=93 133 MHz (MAX) for all protocols in S=
TR =E2=80=93 66 MHz
> (MAX) for all protocols in DTR"

Here's the datasheet I got those numbers from:

https://www.micron.com/-/media/client/global/documents/products/data-sheet/=
nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_02g_cbb_0.pdf

Thanks,
Andrey Smirnov
