Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D36C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EF4218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfDXOEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:04:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56850 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfDXOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:04:21 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 95AA4807E7; Wed, 24 Apr 2019 16:04:09 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:04:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 24/26] leds: gpio: Use generic support for composing
 LED names
Message-ID: <20190424140417.GE14360@amd>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-25-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-25-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-17 22:54:37, Jacek Anaszewski wrote:
> Switch to using generic LED support for composing LED class
> device name.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/leds/leds-gpio.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index b26cf78993d1..60fb3c85cf05 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -77,11 +77,11 @@ static int gpio_blink_set(struct led_classdev *led_cd=
ev,
> =20
>  static int create_gpio_led(const struct gpio_led *template,
>  	struct gpio_led_data *led_dat, struct device *parent,
> -	struct device_node *np, gpio_blink_set_t blink_set)
> +	struct fwnode_handle *fwnode, gpio_blink_set_t blink_set)
>  {
> +	struct led_init_data init_data =3D {};
>  	int ret, state;
> =20
> -	led_dat->cdev.name =3D template->name;
>  	led_dat->cdev.default_trigger =3D template->default_trigger;
>  	led_dat->can_sleep =3D gpiod_cansleep(led_dat->gpiod);
>  	if (!led_dat->can_sleep)
> @@ -112,7 +112,13 @@ static int create_gpio_led(const struct gpio_led *te=
mplate,
>  	if (ret < 0)
>  		return ret;
> =20
> -	return devm_led_classdev_register(parent, &led_dat->cdev);
> +	if (template->name)
> +		led_dat->cdev.name =3D template->name;
> +	else
> +		init_data.fwnode =3D fwnode;
> +
> +	return devm_led_classdev_register_ext(parent, &led_dat->cdev,
> +					      &init_data);

Won't register_ext() overwrite template->name?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAbOEACgkQMOfwapXb+vIgpgCgvGx71t3YniNRoAyQcibBFCRD
FxkAoMRwBe9KhXB++Dl2qZE1RYbxCXjr
=BLw0
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
