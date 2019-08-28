Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD630C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF68023403
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfH1Imi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:42:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51253 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH1Imi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:42:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 02B8782362; Wed, 28 Aug 2019 10:42:22 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:42:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: lm3532: Avoid potentially unpaired regulator calls
Message-ID: <20190828084235.GA2923@amd>
References: <20190827215205.59677-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20190827215205.59677-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We may currently get unpaired regulator calls when configuring the LED
> brightness via sysfs in case of regulator calls producing errors. Let's
> fix this by maintaining local state for enabled.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +++ b/drivers/leds/leds-lm3532.c
> @@ -127,6 +127,7 @@ struct lm3532_als_data {
>   * @num_leds - Number of LED strings are supported in this array
>   * @full_scale_current - The full-scale current setting for the current =
sink.
>   * @led_strings - The LED strings supported in this array
> + * @enabled - Enabled status
>   * @label - LED label
>   */
>  struct lm3532_led {
> @@ -138,6 +139,7 @@ struct lm3532_led {
>  	int ctrl_brt_pointer;
>  	int num_leds;
>  	int full_scale_current;
> +	int enabled:1;
>  	u32 led_strings[LM3532_MAX_CONTROL_BANKS];
>  	char label[LED_MAX_NAME_SIZE];
>  };

I'd do bool enabled, but this version is good, too.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1mPnsACgkQMOfwapXb+vISdACcD9PUur9GQedFWTo1hoxyghuV
f+YAnRELhy1q8FoKORsTbYCHO6jj8GI1
=1P7e
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
