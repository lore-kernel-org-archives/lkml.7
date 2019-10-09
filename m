Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D2ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81367206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfJIOoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:44:54 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:32881 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfJIOoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:44:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46pH766N2kz1rlwx;
        Wed,  9 Oct 2019 16:44:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46pH7658gNz1qqkL;
        Wed,  9 Oct 2019 16:44:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id njJVUYx2-9tB; Wed,  9 Oct 2019 16:44:49 +0200 (CEST)
X-Auth-Info: z1TweS5tguld1s5i/vfefCuk4NRnGzI/S+uxnMWYpT0=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  9 Oct 2019 16:44:49 +0200 (CEST)
Date:   Wed, 9 Oct 2019 16:44:42 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dts: Disable DMA support on the BK4 vf610 device's
 fsl_lpuart driver
Message-ID: <20191009164442.51f27b9d@jawa>
In-Reply-To: <b39b6860-9e9b-5cee-a07e-7b430c2e5119@arm.com>
References: <20191009143032.9261-1-lukma@denx.de>
        <b39b6860-9e9b-5cee-a07e-7b430c2e5119@arm.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/Di/jFXAOICs3QlZsnoXzE2z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Di/jFXAOICs3QlZsnoXzE2z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Robin,

> On 09/10/2019 15:30, Lukasz Majewski wrote:
> > This change disables the DMA support (RX/TX) on the NXP's fsl_lpuart
> > driver - the PIO mode is used instead. This change is necessary for
> > better robustness of BK4's device use cases with many potentially
> > interrupted short serial transfers.
> >=20
> > Without it the driver hangs when some distortion happens on UART
> > lines.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >   arch/arm/boot/dts/vf610-bk4.dts | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/vf610-bk4.dts
> > b/arch/arm/boot/dts/vf610-bk4.dts index 0f3870d3b099..ad20f3442d40
> > 100644 --- a/arch/arm/boot/dts/vf610-bk4.dts
> > +++ b/arch/arm/boot/dts/vf610-bk4.dts
> > @@ -259,24 +259,28 @@
> >   &uart0 {
> >   	pinctrl-names =3D "default";
> >   	pinctrl-0 =3D <&pinctrl_uart0>;
> > +	dma-names =3D "",""; =20
>=20
> This looks like a horrible hack - is there any reason not to just
> strip things at compile-time, i.e. "/delete-property/ dmas;"?

I don't want to strip the dma-names property globally. I just want to
adjust this particular driver mode from DMA to PIO.

For my use cases - as written in the commit message - the PIO mode is
more suitable (and reliable).=20

>=20
> Robin.
>=20
> >   	status =3D "okay";
> >   };
> >  =20
> >   &uart1 {
> >   	pinctrl-names =3D "default";
> >   	pinctrl-0 =3D <&pinctrl_uart1>;
> > +	dma-names =3D "","";
> >   	status =3D "okay";
> >   };
> >  =20
> >   &uart2 {
> >   	pinctrl-names =3D "default";
> >   	pinctrl-0 =3D <&pinctrl_uart2>;
> > +	dma-names =3D "","";
> >   	status =3D "okay";
> >   };
> >  =20
> >   &uart3 {
> >   	pinctrl-names =3D "default";
> >   	pinctrl-0 =3D <&pinctrl_uart3>;
> > +	dma-names =3D "","";
> >   	status =3D "okay";
> >   };
> >  =20
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Di/jFXAOICs3QlZsnoXzE2z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2d8loACgkQAR8vZIA0
zr2WHggAttPRl8kp+yb/oZQOEp8vg1iZdn55DoxHq2LWuWy8RIoAUnOUy9TapDZ5
ZBQKgfDBYcD0Yawqlk9uOev6Uhe9roJRyVSdWjdPMcGdK0viwBagw8sYWxWD2TrY
MljhCRJfoStaA/ZKClfGb2w5KddgXTgz2jqRs8CNps7aFBbjhKFtwJoKkdCjI/kl
ADmw46QWkNmN6axoy3NKIDeP31lOfWpMcfcYw0MrLCn0+s/tfRpKqH9eRGC5vjJt
SblR8SeFNB4oUOO1rFN9rKANzgxfqF4n06rCPORZBOK8mV5YIAA5vx7L6VOUxioj
U57i4+VhXSCzlyh3HBGKN3//lb0xIA==
=PTiE
-----END PGP SIGNATURE-----

--Sig_/Di/jFXAOICs3QlZsnoXzE2z--
