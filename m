Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7391DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDB8206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfDAVjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:39:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55638 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAVja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:39:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B8F278084C; Mon,  1 Apr 2019 23:39:18 +0200 (CEST)
Date:   Mon, 1 Apr 2019 23:39:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Brian Masney <masneyb@onstation.org>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-ID: <20190401213926.GD14681@amd>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <20190401103034.21062-3-masneyb@onstation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-01 06:30:33, Brian Masney wrote:
> Add new backlight bindings for the TI LM3630A dual-string white LED.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../leds/backlight/lm3630a-backlight.yaml     | 112
++++++++++++++++++

What is that? Is it future of all the bindings?

Up to device tree people, I guess, but...

								Pavel


>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm36=
30a-backlight.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-bac=
klight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-back=
light.yaml
> new file mode 100644
> index 000000000000..42a8c59d237a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.=
yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3630A High-Efficiency Dual-String White LED
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Daniel Thompson <daniel.thompson@linaro.org>
> +  - Jingoo Han <jingoohan1@gmail.com>
> +
> +description: |
> +  The LM3630A is a current-mode boost converter which supplies the power=
 and
> +  controls the current in up to two strings of 10 LEDs per string.
> +  https://www.ti.com/product/LM3630A
> +
> +properties:
> +  compatible:
> +    const: ti,lm3630a
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,linear-mapping-mode:
> +    description: |
> +      Enable linear mapping mode. If disabled, then it will use exponent=
ial
> +      mapping mode in which the ramp up/down appears to have a more unif=
orm
> +      tranisiton to the human eye.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^led*$":
> +    type: object
> +    description: |
> +      Properties for a string of connected LEDs.
> +
> +    properties:
> +      label:
> +        description: |
> +          The label for this LED. If omitted, the label is taken from th=
e node
> +          name (excluding the unit address). It has to uniquely identify=
 a
> +          device, i.e. no other LED class device can be assigned the sam=
e label.
> +
> +      led-sources:
> +        description: |
> +          List of device current outputs the LED is connected to.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              minimum: 0
> +              maximum: 1
> +
> +      default-brightness:
> +        description: Default brightness level on boot.
> +        minimum: 0
> +        maximum: 255
> +
> +      max-brightness:
> +        description: Maximum brightness level on boot.
> +        minimum: 0
> +        maximum: 255
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible =3D "ti,lm3630a";
> +                status =3D "ok";
> +                reg =3D <0x38>;
> +
> +                led {
> +                        label =3D "main-lcd";
> +                        led-sources =3D <0 1>;
> +                        default-brightness =3D <200>;
> +                        max-brightness =3D <255>;
> +                };
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible =3D "ti,lm3630a";
> +                status =3D "ok";
> +                reg =3D <0x38>;
> +
> +                led-bank-a {
> +                        led-sources =3D <0>;
> +                        default-brightness =3D <150>;
> +                        ti,linear-mapping-mode;
> +                };
> +
> +                led-bank-b {
> +                        led-sources =3D <1>;
> +                        default-brightness =3D <225>;
> +                        ti,linear-mapping-mode;
> +                };
> +        };
> +    };

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyihQ4ACgkQMOfwapXb+vIfoQCfcCWyn261+00n1ZKQWmnRY17y
TXgAmwTgIztadic89rxpKLptExhxP5If
=/ISU
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
