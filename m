Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F3C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5080722CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfHUMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:30:39 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:53047 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHUMai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:30:38 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B0B90100007;
        Wed, 21 Aug 2019 12:30:35 +0000 (UTC)
Date:   Wed, 21 Aug 2019 14:30:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/10] mailbox: sunxi-msgbox: Add a new mailbox driver
Message-ID: <20190821123035.tl4aakijjhw3bwbk@flea>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-5-samuel@sholland.org>
 <20190820111825.2w55fleehrnon27u@core.my.home>
 <bc09e14c-1cf5-8124-fc34-c651b78577ce@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mrpxrcur5riymvjn"
Content-Disposition: inline
In-Reply-To: <bc09e14c-1cf5-8124-fc34-c651b78577ce@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrpxrcur5riymvjn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 08:07:53AM -0500, Samuel Holland wrote:
> On 8/20/19 6:18 AM, Ond=C5=99ej Jirman wrote:
> >> +	reset =3D devm_reset_control_get(dev, NULL);
> >> +	if (IS_ERR(reset)) {
> >> +		ret =3D PTR_ERR(reset);
> >> +		dev_err(dev, "Failed to get reset control: %d\n", ret);
> >> +		goto err_disable_unprepare;
> >> +	}
> >> +
> >> +	ret =3D reset_control_deassert(reset);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to deassert reset: %d\n", ret);
> >> +		goto err_disable_unprepare;
> >> +	}
> >
> > You need to assert the reset again from now on, in error paths. devm
> > will not do that for you.
>
> I know, and that's intentional. This same message box device is used for =
ATF to
> communicate with SCP firmware (on a different channel). This could be hap=
pening
> on a different core while Linux is running. So Linux is not allowed to de=
assert
> the reset. clk_disable_unprepare() is only okay because the clock is mark=
ed as
> critical.

I agree with Ondrej that since this is clearly not the standard use of
the API, this must have a big comment explaining why we're doing it
this way.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mrpxrcur5riymvjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV05awAKCRDj7w1vZxhR
xbIJAP9yrpmQb5VASu0xwjQKiF8z6Qkk63ohQogxkr2k66hwcAEAulMS7ROeVRrO
iA0Lo17qVmuTaZnBbSFPofjTOChqgAQ=
=0XW2
-----END PGP SIGNATURE-----

--mrpxrcur5riymvjn--
