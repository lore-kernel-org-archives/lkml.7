Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEF1214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="HD3joE1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfDAQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:57:08 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:13922 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfDAQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554137825;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=0rCwZG4Tj54+0SOJ1Efcwd8gRyoFVev+LJvpCb9lApg=;
        b=HD3joE1U4vORhXHXzW4xw8YEWuuAehahC+mJhvpz0DNEozbq4Q7x6jZuxnF9dNtQ3/
        9qYGDwaSgUty97fHW2wi2cSM0J2RSUCBAlS3DH+EXeBHoMVJv4NGsa7hbmGewE++8f1m
        hz2hNDvMdI4qIYkVNQ4wWbC680GqIxuMWnw3a4xjvuZRuyeQ5FEeCa50tnNPUDw/JjA3
        Xdvs9vKbxGGiU5O8O7bzatsW8i3bXldkEGXsbiadqUuk9HgWJYiEKbDSNH5yRiK9GGDq
        NCxzbhXLXf43OVY/qdnAHNkpqtN6hRVGLanYr/yOLn9XHSuUvTX1juH/EtPgcR1LxIux
        0kLw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCytSXx+xTv55Mr4wfVNE9oh5GZKX9cwIoXd1A5a"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:268d:9f00:4c7b:603c:d32e:111a]
        by smtp.strato.de (RZmta 44.18 AUTH)
        with ESMTPSA id K07648v31GuqdVX
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 1 Apr 2019 18:56:52 +0200 (CEST)
Subject: Re: [BUG/PATCH 1/4] DTS: GTA04: SPI / gpiolib: work around a regression that unhides a broken legacy handler, which makes the gta04 display inoperable
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190401164617.GH49658@atomide.com>
Date:   Mon, 1 Apr 2019 18:56:51 +0200
Cc:     =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <06C7464E-FAF2-4AA6-9FF4-629E9C97F86A@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com> <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com> <20190401164617.GH49658@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 01.04.2019 um 18:46 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> Hi,
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190331 10:08]:
>> This is an ugly workaround for a regression introduced into v5.1-rc1 =
by
>>=20
>> <c1c04cea13dc234ce9a4504879ddd36ea524d880>
>=20
> You should standardized commit references like this instead:
>=20
> c1c04cea13dc ("gpio: of: Fix logic inversion")
>=20
> Then please also include a proper Fixes tag.
>=20
> You can configure an alias for it to make things easier:
>=20
> git log --abbrev=3D12 --pretty=3Dformat:"%h (\"%s\")"
>=20
>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>> @@ -114,6 +114,7 @@
>> 		gpio-miso =3D <&gpio1 18 GPIO_ACTIVE_HIGH>;
>> 		gpio-mosi =3D <&gpio1 20 GPIO_ACTIVE_HIGH>;
>> 		cs-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
>> +		spi-cs-high;	/* make the legacy handler in gpiolib =
not intervene */
>> 		num-chipselects =3D <1>;
>>=20
>> 		/* lcd panel */
>> @@ -123,6 +124,7 @@
>> 			spi-max-frequency =3D <100000>;
>> 			spi-cpol;
>> 			spi-cpha;
>> +			spi-cs-high;	/* here is where it should be =
but this is ignored by a bug in the gpiolib handler */
>>=20
>> 			backlight=3D <&backlight>;
>> 			label =3D "lcd";
>=20
> So what's the plan with this fix? Add this for v5.2-rc cycle,
> then revert it later? I'd probably go directly for the proper
> fix if possible.

Well, I learned just some minutes ago that a new patch for gpiolib
came through 5.1-rc3 which does fix this.

It seems to check for "cs-gpios" and then disable the legacy handling.

This means that we do not need to patch the DTS at all.

BR and thanks,
Nikolaus

