Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6990FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2972147C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfDBJeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:34:03 -0400
Received: from sauhun.de ([88.99.104.3]:38402 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfDBJeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:34:03 -0400
Received: from localhost (p5486CD10.dip0.t-ipconnect.de [84.134.205.16])
        by pokefinder.org (Postfix) with ESMTPSA id 24F252CF606;
        Tue,  2 Apr 2019 11:34:00 +0200 (CEST)
Date:   Tue, 2 Apr 2019 11:33:59 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190402093359.GB2960@kunai>
References: <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai>
 <20190401185346.GP3430@piout.net>
 <20190401193424.sqnapthocznhjqok@ninjato>
 <20190402085325.GT3430@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20190402085325.GT3430@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

> I had a look at the driver and I guess you have a 9063AD while Steve
> uses another model.
>=20
> That explains why you need the uie_unsupported flag. The 9063AD can only
> do alarms on a minute boundary.

Bingo! Nice catch. I was on the wrong track because we have an early
boot quirk handling for the DA on this platform and I was searching
there for side effects. Makes all sense now. Thanks a lot for your help!

> Since the move to hr_timer, the uie are done using the classic alarm or
> they are emulated by the core. This improved the situation for many RTCs
> that don't have a separate UIE but this made it worse for a few (and
> this is an example). I have plan to work on this but didn't have the
> time yet.

I understand. That explains why my RTC knowledge from a few years ago
feels so outdated :)

> I suggest the following patch:
>=20
> =3D=3D=3D
>=20
> From 37b2ab7d537e76e42bde64cf4b57701b0ed8e8cd Mon Sep 17 00:00:00 2001
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Date: Tue, 2 Apr 2019 10:06:46 +0200
> Subject: [PATCH] rtc: da9063: set uie_unsupported when relevant
>=20
> The DA9063AD doesn't support alarms on any seconds and its granularity is
> the minute. Set uie_unsupported in that case.
>=20
> Reported-by: Wolfram Sang <wsa@the-dreams.de>

Please use this address:

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

And probably Geert wants his "+renesas" address, too:

Geert Uytterhoeven <geert+renesas@glider.be>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-da9063.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
> index 1b792bcea3c7..53e690b0f3a2 100644
> --- a/drivers/rtc/rtc-da9063.c
> +++ b/drivers/rtc/rtc-da9063.c
> @@ -475,6 +475,9 @@ static int da9063_rtc_probe(struct platform_device *p=
dev)
>  	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
>  	rtc->rtc_sync =3D false;
> =20
> +	if (config->rtc_data_start !=3D RTC_SEC)
> +		rtc->rtc_dev->uie_unsupported =3D 1;
> +

I think we should have a comment here, like:

/* FIXME: Make use of the TICK interrupt once the RTC core supports it */

So, this helps the UIE test:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

And I guess we have to live with two of the alarm tests failing because
of the minute granularity?

Regards,

   Wolfram


--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjLIMACgkQFA3kzBSg
KbakIhAAgNdylqV8UUYc8TwyiFxpv7BBiF7M+7q2VYl6IiaPLn6vEh/kGrvR4Kc4
N5gjinPwaBKhFSTRd3rKKI7qOMHe+vKSLrshdXD55F8/mnWo7zuJnI0SadBYFPW2
cWNaY8ef74DjmuoCexhi6/62JHsvV14SbrASiC7/U5YKC7AyGzCI6Zd81h7jvPky
kV//ToGUVP+ok+3ikVWi+ZfFoy5ObeFm0+aYIfXcCBXwCHKgvZVut/WBG6S4Frpw
2UT/TgYFHuJzFcXLmLH53Zpn9X4KMEoAkOLlVS+Rd8bm2VT6WagbvjE3FicwI68j
4Ej2oJQ8xwXfc6jbWB3uVgnwaqXRzIQDbHlUq+S9M3Hr7XEOQF+RIzRGu8vNLS7W
eCx/boTViJ1AiaiJm8wJlZL/OzrYFA9a6GXC9/upO6UzJPgwxiGh1YA32pJ9IE/R
CVK0sR4ZZnzFPBSgEIwWXT0VuZqN1+DUzBvbkJepYXyENAuNxKXxa4jLgfvXcMCd
xILLYZiWNNO3Gx0XKdR0CJafsjZcy3nYN/IatXN3qMCmIwGOzOXkqYbHj6XJ5HIM
smmFT9NhLCaaur2VetDts2KUUWBj4nrmnhqid1YqXJzkmtRdrrza3feZdlRf2S1u
vJbIq8poUVb1xxHpyAcnjN1CR44AOiOAzGETJpcMMk0uszZu7RU=
=prjQ
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
