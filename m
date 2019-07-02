Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720F221479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="hVFwOXXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGBOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:52:10 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:59328 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:52:10 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 10:52:08 EDT
Received: from localhost (unknown [IPv6:2001:718:1:2c:b88f:a570:7aec:4192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 29D02400066;
        Tue,  2 Jul 2019 16:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1562078663;
        bh=qW1FNQVp0z6X5XtOPtt+yydz6FyGhgdAlTaFXUsn36I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hVFwOXXv5dSaG5A0OecsMLG4o/9VEBvb1xXmz2XJFiyCjy+FTFTY8PX10MNntWPhw
         hBb5OHUEQ2cFfcNUwYC5gvhTyf1NC9sxPwUn9A8yAiQR1jEXEPocCALb1Reqgd5akb
         ZWQs/PjkpPkcDUH9j4lEDuTnSky1x3y4Nf+Y+yvg=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     =?iso-8859-1?Q?Myl=E8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v1] tty: serial: max310x: Add optional reset gpio
Date:   Tue, 02 Jul 2019 16:44:20 +0200
MIME-Version: 1.0
Message-ID: <d9ac1295-e780-409d-b7de-b4c2db586e58@cesnet.cz>
In-Reply-To: <20190614141112.29962-1-mylene.josserand@bootlin.com>
References: <20190614141112.29962-1-mylene.josserand@bootlin.com>
Organization: CESNET
User-Agent: Trojita/v0.7-402-g68ee77c9; Qt/5.13.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On p=C3=A1tek 14. =C4=8Dervna 2019 16:11:12 CEST, Myl=C3=A8ne Josserand wrote=
:
> --- a/Documentation/devicetree/bindings/serial/maxim,max310x.txt
> +++ b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
> @@ -15,6 +15,7 @@ Required properties:
>    "osc" if an external clock source is used.
> =20
>  Optional properties:
> +- reset-gpios: Gpio to use for reset.

"GPIO", not "Gpio", for consistency.

>  =09if (spi->dev.of_node) {
> +=09=09struct gpio_desc *reset_gpio;
>  =09=09const struct of_device_id *of_id =3D
>  =09=09=09of_match_device(max310x_dt_ids, &spi->dev);
>  =09=09if (!of_id)
>  =09=09=09return -ENODEV;
> =20
>  =09=09devtype =3D (struct max310x_devtype *)of_id->data;
> +=09=09reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset",
> +=09=09=09=09=09=09     GPIOD_OUT_HIGH);
> +=09=09if (IS_ERR(reset_gpio))
> +=09=09=09return PTR_ERR(reset_gpio);
> +=09=09gpiod_set_value_cansleep(reset_gpio, 0);
>  =09} else {

The RST signal is active-low on the chip, but the code initializes the=20
output to GPIOD_OUT_HIGH. Are you perhaps relying on a DT binding setting=20
an ACTIVE_LOW flag on the reset GPIO lane? This should be documented.

Assuming that this polarity inversion works, the code first asserts the=20
reset, then it performs no explicit waiting, and then it clears the RST=20
signal. I checked MAX14830's datasheet, and there's no minimal reset=20
duration, so perhaps this is safe, but it looks a bit odd to me.

With kind regards,
Jan
