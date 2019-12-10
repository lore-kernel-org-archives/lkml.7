Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C0D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yneg9xPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLJPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:03:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39325 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:03:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id d5so2018614wmb.4;
        Tue, 10 Dec 2019 07:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P+ZsUNL/y2u1OQUqoT9Jt+rQhvtloBYS2x5ThkHTunQ=;
        b=Yneg9xPSRZHDcb+NWskA4LXjnBnezcmDF8bxXG5RmlhRjMeFGdkligslCTg27edhKA
         g9bftXjCrEXMczPAVqnP1iPvKKZ43yvPrIeZWRUBhZHl8rWFVxTfR0kRxV56ibwnMxEV
         Luvupsr1hNfQpkSM1XuQQ7aU53m0K0wmHJyiJQv1Zu3NoYM75NpYZDh3LmQl0pCFYWxD
         JgnwiER30lTyMLg9AP/Xj2zTiQ7aJ/BzNpY+HSoL5sSDAQ/SKaQw1QMbKegKa59WgLay
         5qPzwMrguH18vmdxQ/DnXHFzA6d26vJNzi88Z9wMwcEi8yQYdrA6UhMZyFYSvLWIpMOD
         e+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P+ZsUNL/y2u1OQUqoT9Jt+rQhvtloBYS2x5ThkHTunQ=;
        b=YrSvXBFeLCwXL9roeIfX7kmEibq+0oAbPiZhUnhGhoYdxJ1N4MVyQKhALU+aPvzWFZ
         ntu64DEV3y2huNnVfv410tmFwU8rD4bsExs9BmBy10nyAvEipZH1VwELQk+OD+Um4nYd
         A0sSD6u3pFR9mvSVYwRbrYztRSPslQCjwYWvcFAJQdJ5or5pzsDXNiHF3pbHauSXSyp5
         BNZ0+yUgwbQZQjRyPuXUE4o4TR1JcFcAua5Jh2XjJs6NJMT2XlG3TtZS4V4EU3gzMNDh
         hdO9hEOa/4ckdp9XsJfZXLciFBdwBp/SGnDGnhMD8SD1AgFdRLvKz0o9ZX+CmkReIrPf
         ZeRg==
X-Gm-Message-State: APjAAAVtojvmM17EV9h9WB0+59YobELkbPRpLDgZMDMtpyUqtGw4Z2vI
        jBZA9YmOTf9AaDRcF856d4tMH9Efjw4DyWPoGcc=
X-Google-Smtp-Source: APXvYqzkXjsaYAifLbwc79RkgYYsp7dChnUi0vR1wWqDGo/VWSDuysPo4WSKmR3Gsy2OPQFPtzWA/rYF88tNkbE0CJo=
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr5940038wmi.1.1575990181829;
 Tue, 10 Dec 2019 07:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20191209182024.20509-1-peron.clem@gmail.com> <20191209182024.20509-2-peron.clem@gmail.com>
 <20191210093843.qoypomttr4b7kbep@gilmour.lan>
In-Reply-To: <20191210093843.qoypomttr4b7kbep@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 10 Dec 2019 16:02:50 +0100
Message-ID: <CAJiuCcd7hO=xY9io_+CZW9ybAVZeH5TsfS0Hfjr+LtCXh11vrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: Convert license to SPDX identifier
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

On Tue, 10 Dec 2019 at 10:38, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi Cl=C3=A9ment,
>
> On Mon, Dec 09, 2019 at 07:20:23PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Use a shorter SPDX identifier instead of pasting the
> > whole license.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 39 +------------------
> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 39 +------------------
> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 39 +------------------
> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 39 +------------------
> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 39 +------------------
> >  .../dts/allwinner/sun50i-a64-pine64-plus.dts  | 39 +------------------
> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 39 +------------------
> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 39 +------------------
> >  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi | 39 +------------------
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +------------------
> >  .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 39 +------------------
> >  .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 39 +------------------
> >  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 39 +------------------
> >  .../allwinner/sun50i-h5-orangepi-prime.dts    | 39 +------------------
> >  .../sun50i-h5-orangepi-zero-plus2.dts         | 39 +------------------
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 39 +------------------
> >  16 files changed, 16 insertions(+), 608 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boo=
t/dts/allwinner/axp803.dtsi
> > index f0349ef4bfdd..0e13e75132ac 100644
> > --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> > @@ -1,43 +1,6 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
> Thanks for sending a new iteration of this. I had a look at the
> licenses texts associated to the SPDX tag in the LICENSES folder, and
> it turns out that the tag we should be using for that text is
> MIT. While we mention X11 in the header, the text associated to the
> X11 license isn't the one we have in our headers.

Yes you're right text associated is the MIT License.

>
> I guess we should make very clear in the commit log that even though
> the tag now reports MIT, this maps to the same license text and is not
> therefore a license change.

Ok I will add this to the commit log

Regards,
Cl=C3=A9ment
>
> Thanks!
> Maxime
