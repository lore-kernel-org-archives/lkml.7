Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C494C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF29205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfH0LbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:31:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34856 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfH0LbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:31:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 354FD82386; Tue, 27 Aug 2019 13:31:00 +0200 (CEST)
Date:   Tue, 27 Aug 2019 13:31:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] leds: Replace {devm_}led_classdev_register() macros with
 inlines
Message-ID: <20190827113112.GA18218@amd>
References: <20190826210219.22597-1-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20190826210219.22597-1-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-08-26 23:02:19, Jacek Anaszewski wrote:
> Replace preprocessor macro aliases for legacy LED registration helpers
> with inline functions. It will allow to avoid misleading compiler error
> messages about missing symbol that actually wasn't explicitly used
> in the code. It used to occur when CONFIG_LEDS_CLASS was undefined
> and legacy (non-ext) function had been used in the code.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  include/linux/leds.h | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index d101fd13e18e..b8df71193329 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -157,18 +157,39 @@ struct led_classdev {
>   * @led_cdev: the led_classdev structure for this device
>   * @init_data: the LED class device initialization data
>   *
> + * Register a new object of LED class, with name derived from init_data.
> + *
>   * Returns: 0 on success or negative error value on failure
>   */
>  extern int led_classdev_register_ext(struct device *parent,
>  				     struct led_classdev *led_cdev,
>  				     struct led_init_data *init_data);
> -#define led_classdev_register(parent, led_cdev)			\
> -	led_classdev_register_ext(parent, led_cdev, NULL)
> +
> +/**
> + * led_classdev_register - register a new object of LED class
> + * @parent: LED controller device this LED is driven by
> + * @led_cdev: the led_classdev structure for this device
> + *
> + * Register a new object of LED class, with name derived from the name p=
roperty
> + * of passed led_cdev argument.
> + *
> + * Returns: 0 on success or negative error value on failure
> + */
> +static inline int led_classdev_register(struct device *parent,
> +					struct led_classdev *led_cdev)
> +{
> +	return led_classdev_register_ext(parent, led_cdev, NULL);
> +}
> +
>  extern int devm_led_classdev_register_ext(struct device *parent,
>  					  struct led_classdev *led_cdev,
>  					  struct led_init_data *init_data);
> -#define devm_led_classdev_register(parent, led_cdev)		\
> -	devm_led_classdev_register_ext(parent, led_cdev, NULL)
> +
> +static inline int devm_led_classdev_register(struct device *parent,
> +					     struct led_classdev *led_cdev)
> +{
> +	return devm_led_classdev_register_ext(parent, led_cdev, NULL);
> +}
>  extern void led_classdev_unregister(struct led_classdev *led_cdev);
>  extern void devm_led_classdev_unregister(struct device *parent,
>  					 struct led_classdev *led_cdev);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1lFIAACgkQMOfwapXb+vKxagCfV2R0QnLNC+KUp0RJpfVwpT4C
d4oAn2SazXFK9X4wI8yR992OQfyZdG4r
=zWL0
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
