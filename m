Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68534C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB4D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+69uO0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfDHVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:20:46 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37012 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfDHVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:20:45 -0400
Received: by mail-yb1-f196.google.com with SMTP id p134so5052064ybc.4;
        Mon, 08 Apr 2019 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EgjDHNt3KKGFSiwX2uzJIyENBhS++dKaSb7wC06GBj4=;
        b=m+69uO0wiwwC54tZHySxMBGET657OZ58eZzWiWOtRgIsePVo+Q6/CAPoDfOFN1QMpo
         KMm1beXIHLgYYjZjAFSjtNw4SxH06czkyO24cYJgB2TruikNVWyWASAs2R+itIWrY8TE
         YCDk5XKGKeoa+Qhx7vjp8F1aJHUcLfdpWzyvf4rov5C5waKnBkvl64GjMijxxj20pBVT
         PveAE8VEJaxpp9cr16Ipox9U/M8slFJFEJf6urs3QxZnBqyawLAAScfGHejCJOultiJQ
         L/buh49UQrD1nttYZwOvkG3w824/x7Yj2E6k6o1p0PAeMHuJohdqDOJK90DQeBlrFeVf
         CFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EgjDHNt3KKGFSiwX2uzJIyENBhS++dKaSb7wC06GBj4=;
        b=Two2en9kQ7+FAyGoEVh4XBH/DVzuehEtbAg5xEc5sOdh/CM3zeq9J8w9M0Cq38PQPE
         FdN6by0QZo4kY20sKniTab8eiwBTh4HP/G2MhibmZ+SeQ0+PJDk2gVOkB8Obj8prwVXi
         HBGDL7rvsos2uifqdrYRnNP6hpkXhWRjhG/DwNODGHWR49tg0leAYrL+I9Gh9gkCknwm
         zjGHZPtA/PrTgweO7CghyW4SRyxg5XHfM/qM6RP/zSY2NbMgTo+0K7nZmxtm/5l37yKD
         FytcBC1jFyPXtqJ+8m0M10fCcpMjxT7YF1yNGjrJM70xl4GPMmUjEEU4uTZaXtQdsnPS
         Z7Tw==
X-Gm-Message-State: APjAAAXvR+TU4z4X8i2y384/C3DisA2sXzS5PvsItLZ/e6JhPshZ3nkf
        /pIYfJl+ShDIckOqQ46bSeEaxwsy5sRZi4LwlEpYMmtA
X-Google-Smtp-Source: APXvYqw3/0XEeDAWoRNHptKIM3d67hwz58qrwImchgxzu2PzpT5gtrkjsUdUtpKkjeqGExWHOPMSuM3/nXwtC9N13bo=
X-Received: by 2002:a25:2b87:: with SMTP id r129mr8569294ybr.23.1554758444488;
 Mon, 08 Apr 2019 14:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190404135736.8491-1-peron.clem@gmail.com> <20190404135736.8491-2-peron.clem@gmail.com>
 <20190405090236.e7vnyjzxmzfke3d6@flea> <CAGb2v65wcEAUTwRhC42iRkPaWXLGX1CJeq+TSzHVTOrT+L=8vA@mail.gmail.com>
 <20190405145005.jmmwsvbateqssbyq@flea> <CAGb2v66cv7dVwj7oyRaHT5Q2XCbNqzuS-Uk9hdNJbVv57QOmUg@mail.gmail.com>
 <20190405150810.zjwtu6crzaz6ufhx@flea> <CAJiuCccfmwxAqK1mTJ3eLO0RggV8sZTTKRy=fxFFenxn1hATvQ@mail.gmail.com>
 <CAJiuCcc5_tkmSM8sV2enG7t5=eU21ZrzcCVLUzF+c=8MiZhdFA@mail.gmail.com> <20190408081635.dlcppclakavwip6v@flea>
In-Reply-To: <20190408081635.dlcppclakavwip6v@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 8 Apr 2019 23:23:26 +0200
Message-ID: <CAJiuCcefqtFoSTGRR2J2M0er-d+7+P5oKzDn2shxDustCLdAVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: h6: Add watchdog node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 at 10:16, Maxime Ripard <maxime.ripard@bootlin.com> wrot=
e:
>
> On Sun, Apr 07, 2019 at 04:27:36PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > On Fri, 5 Apr 2019 at 18:24, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.=
com> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, 5 Apr 2019 at 17:08, Maxime Ripard <maxime.ripard@bootlin.com=
> wrote:
> > > >
> > > > On Fri, Apr 05, 2019 at 10:59:35PM +0800, Chen-Yu Tsai wrote:
> > > > > On Fri, Apr 5, 2019 at 10:50 PM Maxime Ripard <maxime.ripard@boot=
lin.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 05, 2019 at 10:35:08PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Fri, Apr 5, 2019 at 5:02 PM Maxime Ripard <maxime.ripard@b=
ootlin.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Apr 04, 2019 at 03:57:36PM +0200, Cl=C3=A9ment P=C3=
=A9ron wrote:
> > > > > > > > > Allwinner H6 has a watchog compatible with A31.
> > > > > > > > >
> > > > > > > > > Declare it in the device tree.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.=
com>
> > > > > > > >
> > > > > > > > Applied both, thanks!
> > > > > > > > Maxime
> > > > > > >
> > > > > > > IIRC there are 3 watchdogs on the H6. One is the trusted watc=
hdog,
> > > > > > > which should be reserved for underlying firmware.
> > > > > > >
> > > > > > > The other two are the normal and R-block watchdog. Although t=
hey
> > > > > > > look the same, the "normal" one can't reset the system. :(
> > > > > > > That one is actually the one ATF currently uses. So reboot do=
esn't
> > > > > > > work on the H6.
> > >
> > > Some users report that the reboot on the PineH64 actually works.
> > >
> > > Clement
> > >
> > > > > >
> > > > > > So that patch will not do anything then?
> >
> > Did some test and only interrupts are working right now. If the WDOG
> > is configured to make the board reboot the system will be stuck :S
> > Maybe better to disabled it for now and leave a comment.
>
> I dropped the two patches
What do you think about having it but disabled with a comment ?

I have tested the r_watchdog and this one is functionnal.

Clement

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
