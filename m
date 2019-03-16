Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA1AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 12:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F35E218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 12:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ZWbZ+xZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCPM3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 08:29:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42492 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 08:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552739367; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4ElCZ/x17j1Zec/QYwdCk9TXrYs2+vt4OJ6XPOZpiQ=;
        b=ZWbZ+xZadZ5v2IQgDyqZxR2SaCZ3H8NZKNKqQf2O1b4pbQmDfTX8TOer702ffaWV0ISxtn
        sKFrGtPCRQY169CLzPElmhQ4p0tRQJugcB7NdDb0UXF9o7DoJKSNxSYmbAqcVt45YincN8
        WpPeWh//iEwTgHT+73JoiOfu9XcRs9U=
Date:   Sat, 16 Mar 2019 13:29:23 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] dt-bindings: Add doc for the ingenic-drm driver
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1552739363.1562.0@crapouillou.net>
In-Reply-To: <20190315170701.29670-1-paul@crapouillou.net>
References: <20190315170701.29670-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven. 15 mars 2019 =E0 18:06, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Add documentation for the devicetree bindings of the DRM driver for=20
> the
> JZ47xx family of SoCs from Ingenic.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>     v2: Remove ingenic,panel property.
>=20
>  .../devicetree/bindings/display/ingenic,drm.txt    | 29=20
> ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/display/ingenic,drm.txt
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/display/ingenic,drm.txt=20
> b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> new file mode 100644
> index 000000000000..f57a4ae0f7ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> @@ -0,0 +1,29 @@
> +Ingenic JZ47xx DRM driver
> +
> +Required properties:
> +- compatible: one of:
> +  * ingenic,jz4740-drm
> +  * ingenic,jz4725b-drm

Ooops, I forgot to fix what Rob pointed out. Will do in V3.

-Paul

> +- reg: LCD registers location and length
> +- clocks: LCD pixclock and device clock specifiers.
> +	   The device clock is only required on the JZ4740.
> +- clock-names: "lcd_pclk" and "lcd"
> +- interrupts: Specifies the interrupt line the LCD controller is=20
> connected to.
> +
> +Optional properties:
> +- ingenic,lcd-mode: LCD mode to use with the display panel.
> +		    See <dt-bindings/display/ingenic,drm.h> for all the
> +		    possible values.
> +
> +Example:
> +
> +lcd: lcd-controller@13050000 {
> +	compatible =3D "ingenic,jz4725b-drm";
> +	reg =3D <0x13050000 0x1000>;
> +
> +	interrupt-parent =3D <&intc>;
> +	interrupts =3D <31>;
> +
> +	clocks =3D <&cgu JZ4725B_CLK_LCD>;
> +	clock-names =3D "lcd";
> +};
> --
> 2.11.0
>=20
=

