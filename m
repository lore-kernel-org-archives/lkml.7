Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CB6C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498BE21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDFJqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 05:46:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49232 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 05:46:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A468480547; Sat,  6 Apr 2019 11:46:20 +0200 (CEST)
Date:   Sat, 6 Apr 2019 11:46:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 00/25] Add generic support for composing LED class
 device name
Message-ID: <20190406094632.GA7546@amd>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190404132157.GB6124@xo-6d-61-c0.localdomain>
 <c1ebb90a-2474-d279-0600-0f6707a7b1a6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <c1ebb90a-2474-d279-0600-0f6707a7b1a6@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >I have not yet gone through the series in great detail.
> >
> >This will change the userland ABI, right? Now, I understand that old ABI=
 is bad, but
> >will it break someone's code?
>=20
> It will not break anyone since the generic support for composing
> LED names is used only if struct init_data is provided. Otherwise
> led_cdev->name property is taken as is for the LED class device name.
>=20
> Moreover, it is safe to switch many of existing DT (or fwnode in
> general) based drivers to using generic mechanism.
> If the DT provides label property it will be concatenated with the
> led_hw_name provided by the driver. The problem would be only with
> the drivers whose bindings erroneously require devicename section
> in the label. They will need to be left intact.

Ok. Plus it seems series causes some compile issues:

 924     kbuild tes [j.anaszewski-leds:led_naming_v3 13/37]
 drivers/leds/leds-pwm.c:117:8: error:
  925 N   kbuild tes [j.anaszewski-leds:led_naming_v3 17/37]
 drivers/leds/led-core.o:undefined ref
  926 N   kbuild tes [j.anaszewski-leds:led_naming_v3 13/37]
 drivers/leds/leds-pwm.c:117:44: spars
  927 N   kbuild tes [j.anaszewski-leds:led_naming_v3 13/37]
 drivers/leds/leds-pwm.c:117:8: error:

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyodXgACgkQMOfwapXb+vLduACZAUC3jlCyOGd4yZnVufp2RXu7
FZ0AniSe5nX+hTDEIQHu4oIEZUN6iCSu
=26MZ
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
