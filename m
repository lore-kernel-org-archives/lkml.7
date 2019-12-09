Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D4C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A73207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575908559;
	bh=NFR9xjx37aGBkQKpiYBPce9lAgSjo3GQb3otqko6kF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aQI5z1JP0eEqk7v0xdvmQf7E2Z7QZBoLiU5OHJXFtJkxDiQUyZzkokRWCo6AkREU7
	 xVCah8uAi0lXu1BZVGLaFfXrONJUPuXdkzdiPuawU7CGKbaiFbrdMCqCzZ+z1WLAhn
	 LYHK0MltRBTTzxcioMCTvw1WLCMeL4PV6zihMLgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLIQWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:22:38 -0500
Received: from foss.arm.com ([217.140.110.172]:37422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfLIQWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:22:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 909FF1FB;
        Mon,  9 Dec 2019 08:22:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5E63F718;
        Mon,  9 Dec 2019 08:22:35 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:22:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l32: add missed regulator_bulk_disable in
 remove
Message-ID: <20191209162234.GC5483@sirena.org.uk>
References: <20191206075146.18011-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <20191206075146.18011-1-hslester96@gmail.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 03:51:46PM +0800, Chuhong Yuan wrote:

> @@ -501,6 +501,8 @@ static int cs35l32_i2c_remove(struct i2c_client *i2c_=
client)
>  	/* Hold down reset */
>  	gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
> =20
> +	regulator_bulk_disable(ARRAY_SIZE(cs35l32->supplies),
> +			       cs35l32->supplies);

This is a similar situation to the one Charles pointed out - the driver
is using runtime PM to manage the regulators so unless the device is
active when removed the regulators won't be enabled.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3udMkACgkQJNaLcl1U
h9AU4Qf9H2kZfcwmeY5MnJNJT2wlY1Tz0Bn4avIuaWh6VHTc2FK9mHpLixpWBCeL
lviOMF4oPXUBhG28OeW33WoWQ2ZYPKyUFEZqRAmy/UYFFRhk8yJHjtrgwcD3GrGz
bFNKyeixLFD2s1a+P6mlTotWCHm3coCexdV3PnvdstSIIgyCPm/NmnRZ42jNhlQ/
7VA4R1z6bX5K8yux74SO+QH43m4Zveh+52BMT//oC72pspDAy6KwmgVnYDmfWiY4
wWTYSoH3R7Ol4BUcv0VqV5laqa8vZ/rcFpOOUPxFXbdRVPVCGyL6oJinOzd5t//I
40Zl4lBKeSRR15moeKPfk7fWu3R/cQ==
=FYnw
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
