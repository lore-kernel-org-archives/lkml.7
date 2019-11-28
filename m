Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC14C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FF821771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfsCJJoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfK1SMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 13:12:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35173 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1SMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 13:12:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so170506wro.2;
        Thu, 28 Nov 2019 10:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gOiN12bbCUO3RyXfDznIGhTVWbfXcZK6Qh/ggc0OYes=;
        b=JfsCJJoYOWVRUBanWqnaw6rbES9MvgO1W+VeDdTEsSXcudgctA8bu5oM7t5fkBGHiP
         pdo2qGWyRJDDwtSNtT91ZVJRxJz8wm6qKFVhDMKvkRj8RQ5wHw2J2Vtu77oZ+0khj87G
         YhF+q+Nq/UOAajz97vDvT3hrauJL3r81iVt38OllwKaweh+/S6qkCdE5Di0g2saDrOS2
         85hMXPcXLJvM5QgY68iDSAztbgNuG8cJLXIvDwck9J+IX7x/9y1WUus4y1IttY71AnXr
         86RXYTQ5jwPekVkozqp7hqLujCgBaRIUT0/9+8lTcxN5G4Wa1mTVN0SxBwpVTZ+n4EK7
         Irrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gOiN12bbCUO3RyXfDznIGhTVWbfXcZK6Qh/ggc0OYes=;
        b=HhWtXoJ1uwCTHrE+D2JjqNRvOiLrPUJ1BM/rgWdDI48RoUJqafPu/JS0bS+bj+1FGt
         bclFHo4Sakafv8g6EueyJTNyCQwKj/TDLemfyX0XSwd+dv2OeDwAs04FZBPwUqfVzZev
         SCuvT9ex3lQ54scML8uPliYhL80gzx/RahIoYqvOgDitUD80tO1P5dU7O+nARFgwJo+R
         XMKR+w0BWKDxfawi+zSiQl8n0NH5bw0zpxCCtVeWW4kscB4nYaOt08F2g3uQte0ag8c0
         z0ui0B4FilLox4vXO8NzvcO81OFEXVE6c5EXK2SluyRiIEc0N+P/r/BMNah7eI4TJG6E
         4q7w==
X-Gm-Message-State: APjAAAWfpA79gltih091u8xopV+O99hjjBxWpMufhnyqOGgPn186FGSX
        yVrD0FTiZ/70+Kxmq4VHb4QVvbQIYrHgxK/2NYs=
X-Google-Smtp-Source: APXvYqwLivrUDOFwotPgOHEdBgkJYkN93LcnVm661eNB9GJY535YkvcBDz5QvPETO4ggUrOTK7S3wX1myz1hApCqs2c=
X-Received: by 2002:adf:da52:: with SMTP id r18mr49789921wrl.167.1574964747263;
 Thu, 28 Nov 2019 10:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20191123132435.22093-1-peron.clem@gmail.com> <20191128174204.tbr5ldilkadw42gc@gilmour.lan>
In-Reply-To: <20191128174204.tbr5ldilkadw42gc@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 28 Nov 2019 19:12:16 +0100
Message-ID: <CAJiuCccY7AFsd22bOxKZW=BAne5YEG0vmnVmUNFamU9cpW_vNA@mail.gmail.com>
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

On Thu, 28 Nov 2019 at 18:42, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi Clement,
>
> Sorry for the pretty slow answer
>
> On Sat, Nov 23, 2019 at 02:24:35PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Move the SPDX-License-Identifier lines to the top and drop the
> > license splat.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >
> > Hi,
> >
> > This the same logic that what has be done on Amlogic.
> >
> > Commit: ARM64: dts: amlogic: Convert to new-style SPDX license identifi=
ers
> > https://lore.kernel.org/patchwork/patch/890455/
>
> So there's a bunch of different things that should be addressed in
> separate patches here I believe.
>
> >  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 39 +----------------
> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 39 +----------------
> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 39 +----------------
> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 39 +----------------
> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 39 +----------------
> >  .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  3 +-
> >  .../dts/allwinner/sun50i-a64-pine64-plus.dts  | 39 +----------------
> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 39 +----------------
> >  .../dts/allwinner/sun50i-a64-pinebook.dts     |  1 -
> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 42 +------------------
> >  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi | 42 +------------------
> >  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  3 +-
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +----------------
> >  .../sun50i-h5-bananapi-m2-plus-v1.2.dts       |  4 +-
> >  .../allwinner/sun50i-h5-bananapi-m2-plus.dts  |  4 +-
> >  .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 39 +----------------
> >  .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 39 +----------------
> >  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 39 +----------------
> >  .../allwinner/sun50i-h5-orangepi-prime.dts    | 42 +------------------
> >  .../sun50i-h5-orangepi-zero-plus.dts          |  3 +-
> >  .../sun50i-h5-orangepi-zero-plus2.dts         | 39 +----------------
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 39 +----------------
> >  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  2 +-
> >  .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  2 +-
> >  .../allwinner/sun50i-h6-orangepi-lite2.dts    |  2 +-
> >  .../allwinner/sun50i-h6-orangepi-one-plus.dts |  2 +-
> >  .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  2 +-
> >  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  2 +-
> >  .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  2 +-
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  2 +-
> >  30 files changed, 33 insertions(+), 634 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boo=
t/dts/allwinner/axp803.dtsi
> > index f0349ef4bfdd..f4f2c70fde5c 100644
> > --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> > @@ -1,43 +1,6 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >  /*
> >   * Copyright 2017 Icenowy Zheng <icenowy@aosc.xyz>
> > - *
> > - * This file is dual-licensed: you can use it either under the terms
> > - * of the GPL or the X11 license, at your option. Note that this dual
> > - * licensing only applies to this file, and not this project as a
> > - * whole.
> > - *
> > - *  a) This file is free software; you can redistribute it and/or
> > - *     modify it under the terms of the GNU General Public License as
> > - *     published by the Free Software Foundation; either version 2 of =
the
> > - *     License, or (at your option) any later version.
> > - *
> > - *     This file is distributed in the hope that it will be useful,
> > - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *     GNU General Public License for more details.
> > - *
> > - * Or, alternatively,
> > - *
> > - *  b) Permission is hereby granted, free of charge, to any person
> > - *     obtaining a copy of this software and associated documentation
> > - *     files (the "Software"), to deal in the Software without
> > - *     restriction, including without limitation the rights to use,
> > - *     copy, modify, merge, publish, distribute, sublicense, and/or
> > - *     sell copies of the Software, and to permit persons to whom the
> > - *     Software is furnished to do so, subject to the following
> > - *     conditions:
> > - *
> > - *     The above copyright notice and this permission notice shall be
> > - *     included in all copies or substantial portions of the Software.
> > - *
> > - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > - *     OTHER DEALINGS IN THE SOFTWARE.
> >   */
>
> So this is the first, obvious, one that you talk about in your commit
> log. While the license says that it's X11, SPDX reports that it's now
> MIT, can you clarify this?

As far as I know X11 and MIT are similar and MIT is preferred in Linux.
see: LICENSES/preferred.
So I have converted the X11 to MIT but it can be an explicit commit.
This is done implicitly in the Amlogic commit.

>
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> > index 72d6961dc312..2ca36580436c 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> > @@ -1,6 +1,5 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >  /*
> > - * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > - *
> >   * Copyright (c) 2018 ARM Ltd.
> >   */
>
> This is another kind of changes though. The SPDX identifier is there,
> but under the wrong format and you're fixing it.
>
> That being said, I'm not a super fan of mixing the two comment styles
> for two lines.
>
> What about using only // style comments for the header?

Most of the other dts use this style for the header so I would like to
keep this kind of style.
Except if DT maintainers want explicity to move to another style.
Having a coherency in all dts is better and we can move to another
style with a simple script.

>
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v=
1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
> > index 2e2b14c0ae75..a61d58c4db24 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
> > @@ -1,5 +1,7 @@
> >  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > -// Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
> > +/*
> > + * Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
> > + */
>
> Here you change the comment style. And based on the comment above that
> wouldn't be necessary.

Ok, if we agree on the style.

>
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > index f335f7482a73..84b7e9936300 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >  /*
> >   * Copyright (C) 2019 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >   */
>
> And I'm not sure what this one (and the next) is?

The license expressions in dual licensed files is wrong here, "OR"
should be uppercase.
I can move it to a separate commit if you like.

Regards,
Cl=C3=A9ment

>
> Thanks!
> Maxime
