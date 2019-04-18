Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B842F2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbfDRMpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:45:16 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57849 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:45:16 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CB1A6240004;
        Thu, 18 Apr 2019 12:45:12 +0000 (UTC)
Date:   Thu, 18 Apr 2019 14:45:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo =?utf-8?Q?Sebasti=C3=A1n?= Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/7] ARM: dts: sun8i: r40:
 bananapi-m2-ultra: Tie GMAC regulators to the PIO
Message-ID: <20190418124512.theixlxnsghidpjp@flea>
References: <1555492863-88860-1-git-send-email-pgreco@centosproject.org>
 <1555492863-88860-2-git-send-email-pgreco@centosproject.org>
 <20190417101757.traviffiulwnzr6x@flea>
 <666caeac-4297-17b0-065e-00b7fd9623b4@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zqgbvc2dvbkaqti4"
Content-Disposition: inline
In-Reply-To: <666caeac-4297-17b0-065e-00b7fd9623b4@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zqgbvc2dvbkaqti4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 18, 2019 at 09:25:19AM -0300, Pablo Sebasti=E1n Greco wrote:
> El 17/4/19 a las 07:17, Maxime Ripard escribi=F3:
> > On Wed, Apr 17, 2019 at 06:20:56AM -0300, Pablo Greco wrote:
> > > When the GMAC support was added to the bananapi-m2-ultra, regulators
> > > weren't tied to the pinctrl. Fix that.
> > >
> > > Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> > > ---
> > >   arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch=
/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > > index c488aaa..3da3598 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > > +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > > @@ -201,6 +201,8 @@
> > >   &pio {
> > >   	pinctrl-names =3D "default";
> > >   	pinctrl-0 =3D <&clk_out_a_pin>;
> > > +	vcc-pa-supply =3D <&reg_aldo2>;
> > You should list all the regulators that are needed for all the pin
> > banks to operate properly, not just PA
> Ok, I "think" I finally understand what you mean, so according to schemat=
ics
> in https://drive.google.com/file/d/0B4PAo2nW2KfndFpmZG1OOWJ5NEU/view, it
> should look like this
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index c488aaa..699579d 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -201,6 +201,12 @@
> =A0&pio {
> =A0=A0=A0=A0 pinctrl-names =3D "default";
> =A0=A0=A0=A0 pinctrl-0 =3D <&clk_out_a_pin>;
> +=A0=A0=A0 vcc-pa-supply =3D <&reg_aldo2>;
> +=A0=A0=A0 vcc-pc-supply =3D <&reg_dcdc1>;
> +=A0=A0=A0 vcc-pd-supply =3D <&reg_dcdc1>;
> +=A0=A0=A0 vcc-pe-supply =3D <&reg_eldo1>;
> +=A0=A0=A0 vcc-pf-supply =3D <&reg_dcdc1>;
> +=A0=A0=A0 vcc-pg-supply =3D <&reg_dldo1>;
> =A0};

That makes sense yep

> =A0&reg_aldo2 {
> --
>
> I couldn't find vcc-pb, vcc-ph or vcc-pi.

The R40 doesn't have them, so there's no suprise there :)

(if you ever want to find that info again in the future, the various
vcc-p* that you need to find are in the datasheet)

> If this is ok, I'll generate a v4 based on v2, and throw v3 in the trash
> where it belongs

Sounds good, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zqgbvc2dvbkaqti4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLhxWAAKCRDj7w1vZxhR
xYjxAP96S50pe+i0RxcXurVb6Gq6P3wILPZgfw2YZfFlBOqBVQD/Y3JUzQSgyTUg
sFcR27YRufsmqYO5Euh1nl5UpP4MDAE=
=6Yuo
-----END PGP SIGNATURE-----

--zqgbvc2dvbkaqti4--
