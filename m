Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837ACC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E20F2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwgK6Jo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfLBTp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:45:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37452 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfLBTp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:45:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so824823wmf.2;
        Mon, 02 Dec 2019 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q+cqCA3vFJBC2ze3sBubc6LgUvtvvPu900gSE3tdtbQ=;
        b=kwgK6Jo7GBxlhfYekLlesw9h9QR3xWr9IHus9m8cO1+2q9jty9chPEcNK0U+aNSzQN
         E28kwdeketz3GrQuMMuxCK7ju5Wik4JOzHJTLSBXqWrHAcQ1kbmtWdUMUdnKQw/sTGyk
         5GIbT53dgt4Z5Ro21lmPFO8MtJgxUKyeabY75btaPnoQD/QhycPREDOZbPyVMrguM2P1
         a8dm1O75hJPNCOOSn5DVrmuUkqn7nFz51SXtZHpT7n3TeUZYPQ2VvV05/pWfb13KODDn
         XJniHmXV/TVWlTPBpPkoOoPtuNPYaM8CyAszZ3mn+7VBiTjuTDpvPHwTfrySq1eB51f1
         A0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q+cqCA3vFJBC2ze3sBubc6LgUvtvvPu900gSE3tdtbQ=;
        b=Lvk/XQs+OWstvYbVTQmO6kiSHB1Fh5xjzgjAlvQRnQE8cyyg88RKjSd+BFUVCNehyu
         rKZE49PpyjsPBlAu7wujNLIadunco/mOrOpsh43jUGeq/QCyweOK1gEDx68ELR3IcfWu
         78R85fd+SFklQiFbNNEB3a7WUDQlpvF8rjUuL2jMbsWaCTkE6km1BDMC9t1dUnAtH+PG
         O9+rjzyZPqxLcm5fApxJ657b/TKThuPuh5QQizB8BJX5JYWwPAaQ2htv0fTHbV01uz3g
         BGbMOiW6+neqnUjIPxCMhxSfD3oX2Q6FTTVyBIkCJf892oZ0PlOlkqg2qBB2IcD5uJSO
         CIxw==
X-Gm-Message-State: APjAAAX0MrRVIUhFxRUhfzCVHtY8fKu5AxHJjnh7qJOdIdqpeABxBg1g
        aZ5pZmV2VqIAxgOBaA6fTpqGwwQvmvoPJTriPXLhBtLj
X-Google-Smtp-Source: APXvYqyr0g6hi3TjSjrCw51zPNFeO43OqoJHM+RJQ7FIuG8nWWCnCvSkX5tH08BNAKmt3b9Ab4BcmaLx7uxUPmEMrgY=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr9134099wml.138.1575315955894;
 Mon, 02 Dec 2019 11:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20191123132435.22093-1-peron.clem@gmail.com> <20191128174204.tbr5ldilkadw42gc@gilmour.lan>
 <CAJiuCccY7AFsd22bOxKZW=BAne5YEG0vmnVmUNFamU9cpW_vNA@mail.gmail.com> <20191202191205.2izimptezz5rf5kp@gilmour.lan>
In-Reply-To: <20191202191205.2izimptezz5rf5kp@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 2 Dec 2019 20:45:44 +0100
Message-ID: <CAJiuCcdKi9vedvCWz1BvCS8B0h9rEX1oafZzdok9noFsnvg1NA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Convert to new-style SPDX license identifiers
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 2 Dec 2019 at 20:12, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Nov 28, 2019 at 07:12:16PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Thu, 28 Nov 2019 at 18:42, Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Hi Clement,
> > >
> > > Sorry for the pretty slow answer
> > >
> > > On Sat, Nov 23, 2019 at 02:24:35PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > Move the SPDX-License-Identifier lines to the top and drop the
> > > > license splat.
> > > >
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >
> > > > Hi,
> > > >
> > > > This the same logic that what has be done on Amlogic.
> > > >
> > > > Commit: ARM64: dts: amlogic: Convert to new-style SPDX license iden=
tifiers
> > > > https://lore.kernel.org/patchwork/patch/890455/
> > >
> > > So there's a bunch of different things that should be addressed in
> > > separate patches here I believe.
> > >
> > > >  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  3 +-
> > > >  .../dts/allwinner/sun50i-a64-pine64-plus.dts  | 39 +--------------=
--
> > > >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-a64-pinebook.dts     |  1 -
> > > >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 42 +--------------=
----
> > > >  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi | 42 +--------------=
----
> > > >  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  3 +-
> > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +--------------=
--
> > > >  .../sun50i-h5-bananapi-m2-plus-v1.2.dts       |  4 +-
> > > >  .../allwinner/sun50i-h5-bananapi-m2-plus.dts  |  4 +-
> > > >  .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 39 +--------------=
--
> > > >  .../allwinner/sun50i-h5-orangepi-prime.dts    | 42 +--------------=
----
> > > >  .../sun50i-h5-orangepi-zero-plus.dts          |  3 +-
> > > >  .../sun50i-h5-orangepi-zero-plus2.dts         | 39 +--------------=
--
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 39 +--------------=
--
> > > >  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  2 +-
> > > >  .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  2 +-
> > > >  .../allwinner/sun50i-h6-orangepi-lite2.dts    |  2 +-
> > > >  .../allwinner/sun50i-h6-orangepi-one-plus.dts |  2 +-
> > > >  .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  2 +-
> > > >  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  2 +-
> > > >  .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  2 +-
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  2 +-
> > > >  30 files changed, 33 insertions(+), 634 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64=
/boot/dts/allwinner/axp803.dtsi
> > > > index f0349ef4bfdd..f4f2c70fde5c 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> > > > @@ -1,43 +1,6 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > >  /*
> > > >   * Copyright 2017 Icenowy Zheng <icenowy@aosc.xyz>
> > > > - *
> > > > - * This file is dual-licensed: you can use it either under the ter=
ms
> > > > - * of the GPL or the X11 license, at your option. Note that this d=
ual
> > > > - * licensing only applies to this file, and not this project as a
> > > > - * whole.
> > > > - *
> > > > - *  a) This file is free software; you can redistribute it and/or
> > > > - *     modify it under the terms of the GNU General Public License=
 as
> > > > - *     published by the Free Software Foundation; either version 2=
 of the
> > > > - *     License, or (at your option) any later version.
> > > > - *
> > > > - *     This file is distributed in the hope that it will be useful=
,
> > > > - *     but WITHOUT ANY WARRANTY; without even the implied warranty=
 of
> > > > - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See t=
he
> > > > - *     GNU General Public License for more details.
> > > > - *
> > > > - * Or, alternatively,
> > > > - *
> > > > - *  b) Permission is hereby granted, free of charge, to any person
> > > > - *     obtaining a copy of this software and associated documentat=
ion
> > > > - *     files (the "Software"), to deal in the Software without
> > > > - *     restriction, including without limitation the rights to use=
,
> > > > - *     copy, modify, merge, publish, distribute, sublicense, and/o=
r
> > > > - *     sell copies of the Software, and to permit persons to whom =
the
> > > > - *     Software is furnished to do so, subject to the following
> > > > - *     conditions:
> > > > - *
> > > > - *     The above copyright notice and this permission notice shall=
 be
> > > > - *     included in all copies or substantial portions of the Softw=
are.
> > > > - *
> > > > - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY K=
IND,
> > > > - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRAN=
TIES
> > > > - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > > > - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > > > - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY=
,
> > > > - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISIN=
G
> > > > - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> > > > - *     OTHER DEALINGS IN THE SOFTWARE.
> > > >   */
> > >
> > > So this is the first, obvious, one that you talk about in your commit
> > > log. While the license says that it's X11, SPDX reports that it's now
> > > MIT, can you clarify this?
> >
> > As far as I know X11 and MIT are similar and MIT is preferred in Linux.
> > see: LICENSES/preferred.
> > So I have converted the X11 to MIT but it can be an explicit commit.
> > This is done implicitly in the Amlogic commit.
>
> It's not really my main concern, it's more that if it's a license
> change, then you need the agreement of all the authors, so basically
> anyone that touched all those DT.
OK

>
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> > > > index 72d6961dc312..2ca36580436c 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> > > > @@ -1,6 +1,5 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > >  /*
> > > > - * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > - *
> > > >   * Copyright (c) 2018 ARM Ltd.
> > > >   */
> > >
> > > This is another kind of changes though. The SPDX identifier is there,
> > > but under the wrong format and you're fixing it.
> > >
> > > That being said, I'm not a super fan of mixing the two comment styles
> > > for two lines.
> > >
> > > What about using only // style comments for the header?
> >
> > Most of the other dts use this style for the header so I would like to
> > keep this kind of style.
> > Except if DT maintainers want explicity to move to another style.
> > Having a coherency in all dts is better and we can move to another
> > style with a simple script.
>
> Some drivers already use the // comment for their copyright notice,
> the coding style allows it for single line comment and our DTs already
> use it, so it's the cleanest solution imho.
Ok, I will go for this style.

>
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > index f335f7482a73..84b7e9936300 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > @@ -1,4 +1,4 @@
> > > > -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > >  /*
> > > >   * Copyright (C) 2019 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.co=
m>
> > > >   */
> > >
> > > And I'm not sure what this one (and the next) is?
> >
> > The license expressions in dual licensed files is wrong here, "OR"
> > should be uppercase.
> > I can move it to a separate commit if you like.
>
> Ah, right, indeed, this should be in a separate patch.
So how many patch do you recommend here ?

1 for the or -> OR style fix.
1 to change to SPDX.
and 1 to use the same // style everywhere ?

Regards,
Clement

>
> Thanks!
> Maxime
