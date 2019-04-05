Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B67DC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A55A21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhw6cGdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfDEQjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:39:00 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43376 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:39:00 -0400
Received: by mail-yw1-f67.google.com with SMTP id j66so2522051ywc.10;
        Fri, 05 Apr 2019 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EaFTLz3Df/RsEJgJoXR4FLEpu4tPIcSpK3McOBuHvwA=;
        b=mhw6cGdh3e8Rt7u0g8jAL0/2EZP4NNCnCMO+qHmYD5HkzBxuKN7z+5HnHlkY7VSncT
         2Ng3dnkFhe5AZEbU8Ah7Uce6bnNkXC68vWzz6x6jdiUKWpYPWRz8jEOP6hfuS76NAfCa
         VOddrcW4B72MO8gBfdJYsja52RaWS6OQJgAjZgbHZ/Zw38yxBmrlmz4YjjYeHwXxNDrv
         99jFyqs8fw9Nf8fqatpQhgfGLsPPDI2xg4k1yDZKztvl7tyVtWO+hZde7utHnFDjtucn
         BncaVnerxjdfiDc7rl7tcruAXMNyHHKhSPnNVG/GDR8286S7n4AQFmB2FLHHp9wcjbrI
         vCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EaFTLz3Df/RsEJgJoXR4FLEpu4tPIcSpK3McOBuHvwA=;
        b=RGd2KrmB4xEjiJI5LWUccHfM3KpFszae+q3xfcnVkjAasuFeX49ZJt9oRg0cggeasl
         GITvdLd8AKnAmloZJToKjOy36ly0C32rpN2jDM+uOnRM1Jwu7EoQk44z9UcWp/OIFqvU
         3ucMc2ON9d1LjpnwlygSm+s1K73WMB9oLMf9k57bFn0kpJWOP2VRR4dDP+iLKsCauvL2
         XGQ+rIfxPB9U1I5WVVyfi7tDa1w8uM8xXFfsU97mHFhegj10LwHaAS4B8AT2+fLItfQg
         3/OZpAcgSm01YdKL/Bk+O3lgxuIfq1mARcKiLRyENJYd2iLR07OiOuqAbGRvX1+R4gD4
         thRw==
X-Gm-Message-State: APjAAAWXqgwH9Z3otnLQXP4FoAu9Zu4VrVbhVqqR5uyzs+DYZbpekEhw
        P/oJCkpGtXbcz6NqJO9gxN+RTkCYGxRLaz4HUtI=
X-Google-Smtp-Source: APXvYqyFBSCyux5xCAwyr0AFo7eC9w4xTQRCuo0XMEOV4Vv89zKv1/bX/3Uu1xBrC5mSTln6ZeMUntiBYpMe24Q3sSA=
X-Received: by 2002:a81:7895:: with SMTP id t143mr11278742ywc.156.1554482338951;
 Fri, 05 Apr 2019 09:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190405122446.2101-1-peron.clem@gmail.com> <20190405122446.2101-5-peron.clem@gmail.com>
 <CAJiuCcfbnR+Jfj8Je_4HwgycCBEe92sx6zqwqgXpeiMe2jKL-Q@mail.gmail.com> <20190405151100.jjjg55z7sg35ijxw@flea>
In-Reply-To: <20190405151100.jjjg55z7sg35ijxw@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 5 Apr 2019 18:40:23 +0200
Message-ID: <CAJiuCcdVsiKRxLFKnmAPnApi2EJANbuQf9WUESGE+LBP8zpD+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: sun50i: h6: Introduce Beelink GS1 board
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Apr 2019 at 17:11, Maxime Ripard <maxime.ripard@bootlin.com> wrot=
e:
>
> On Fri, Apr 05, 2019 at 02:53:35PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > Adding this r_pio regulators make a new error in the bootlog :
> >
> > [    0.346843] sun50i-h6-r-pinctrl 7022000.pinctrl: Couldn't get bank
> > PL regulator
> > [    0.346853] sun50i-h6-r-pinctrl 7022000.pinctrl: request() failed fo=
r pin 352
> > [    0.346862] sun50i-h6-r-pinctrl 7022000.pinctrl: pin-352
> > (7081400.i2c) status -517
> > [    0.346871] sun50i-h6-r-pinctrl 7022000.pinctrl: could not request
> > pin 352 (PL0) from group PL0  on device 7022000.pinctrl
> > [    0.346878] mv64xxx_i2c 7081400.i2c: Error applying setting,
> > reverse things back
> >
> > PL0 and PL1 are SCK/SDA for the PMIC :(
>
> How was this DT tested then?

There was a mistake when I tested the patch v2 and only saw this after
posting the patch.

Can I submit a V3 without pio / r_pio regulators ? (+ the yaml patch separa=
ted)

Thanks,

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
