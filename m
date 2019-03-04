Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282532070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAbFoAeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCDMaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:30:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCDMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:30:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id w6so5336996wrs.4;
        Mon, 04 Mar 2019 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zXHPKP9zQlvXSxtlZom9E6I6CKCKFHOnsPMKe/55/2k=;
        b=OAbFoAeSVJlbAWYU/uJ99O3wCGj5+yIquvzZKaNcp2Nk0YUvnVEsTnkVOdT/CC1ygJ
         qXy7s/rIg1gMWKVvM3VJyGdZIp+hqtaAi9/NKMCvrMnlLAIWAoOR7uw3i3CGCZygb56G
         y2+1Gy2GCvWNLuOZ3VBOtdBAoRyyyKOLDiKJYCL+wN5RJsC5DklhRTVw4Xqku/ouVDkx
         4+y6t5nvoXpl2j43JA//YyaqXWDup/Q19rtrzwL45IdTWfdkMEewyDbaauKC0WBy1DMw
         OYScMepoeywThNgvnK7QgavtM+ZZ0pUrsm01QZGg+IjPe5MEvBq+/52xMXBk8yqs8yPM
         +jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zXHPKP9zQlvXSxtlZom9E6I6CKCKFHOnsPMKe/55/2k=;
        b=GdbaUYRADY0X74lQFWvfkH9pLenr9rLYMQnmNfJqgSPYLmPgS/nyA4w+L+foMriWkE
         bGFzDzoPOAK4EwKEFbVh+w+tKhQaCHAarprEuMZF524SBAuQBPInIf3t8bt06dG+Wn05
         nlXf3sJPdF1pG0CJZJ2IjSz7DDwKA0Zc4pOX5zEwdPWshJQT8JHDQT5bo1XpP9TBlbFd
         8xLD3BrtI2XRD1Jc4V2/nA9w1Ni3+hUB4sFRHKA6+oF5E2ryfs38xMKFem5zHGKzTrwa
         Jk3MXzG7jO1dKF4Jms6GKPnWNbLwtCdAj+aRXlXEFMxve11qVjbIj/rpWvSyWcLsm/g2
         e8/w==
X-Gm-Message-State: APjAAAUNgaCxvDjaxzq6RT407bhHQ31pS8ImyU1pI85redJZ5knZmj1B
        et471P0NsR6iIbmU4XlyYqc=
X-Google-Smtp-Source: APXvYqwUHHfHyAhdH385ErRrN3rOT1yQnD6BhXphzX5JgaS2W2sdJ0stHkN8SfHX7iFJSFOXqMKZbg==
X-Received: by 2002:adf:c543:: with SMTP id s3mr11839111wrf.192.1551702605251;
        Mon, 04 Mar 2019 04:30:05 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id b10sm6806657wru.92.2019.03.04.04.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 04:30:04 -0800 (PST)
Date:   Mon, 4 Mar 2019 13:30:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 13/27] pwm: jz4740: Use clocks from TCU driver
Message-ID: <20190304123003.GE9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-14-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-14-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:33:59PM -0300, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with clocks, that can be
> (un)gated, reparented or reclocked from devicetree, instead of having
> these settings hardcoded in this driver.
>=20
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
>=20
> Note that the "select REGMAP" has been dropped because it's
> already enabled by the "select INGENIC_TIMER".
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v9: New patch
>    =20
>          v10: Explain in commit message why "select REGMAP" was dropped
>=20
>  drivers/pwm/Kconfig      |  3 ++-
>  drivers/pwm/pwm-jz4740.c | 39 ++++++++++++++++++++++++++-------------
>  2 files changed, 28 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index ace8ea4b6247..4e201e970509 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -204,7 +204,8 @@ config PWM_IMX
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> -	select REGMAP
> +	depends on COMMON_CLK
> +	select INGENIC_TIMER

Okay... sounds like this would be okay. I'm assuming you go through that
extra step of selecting REGMAP in the prior patch and dropping it here
again so that you keep the series bisectible?

>  	help
>  	  Generic PWM framework driver for Ingenic JZ47xx based
>  	  machines.
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 8dfac5ffd71c..c6136bd4434b 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -28,7 +28,7 @@
> =20
>  struct jz4740_pwm_chip {
>  	struct pwm_chip chip;
> -	struct clk *clk;
> +	struct clk *clks[NUM_PWM];
>  	struct regmap *map;
>  };
> =20
> @@ -40,6 +40,9 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct =
pwm_chip *chip)
>  static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *=
pwm)
>  {
>  	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
> +	struct clk *clk;
> +	char clk_name[16];
> +	int ret;
> =20
>  	/*
>  	 * Timers 0 and 1 are used for system tasks, so they are unavailable
> @@ -48,16 +51,29 @@ static int jz4740_pwm_request(struct pwm_chip *chip, =
struct pwm_device *pwm)
>  	if (pwm->hwpwm < 2)
>  		return -EBUSY;
> =20
> -	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
> +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
> =20
> +	clk =3D clk_get(chip->dev, clk_name);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret =3D clk_prepare_enable(clk);
> +	if (ret) {
> +		clk_put(clk);
> +		return ret;
> +	}
> +
> +	jz->clks[pwm->hwpwm] =3D clk;
>  	return 0;
>  }

Since you're already using ->request(), why not add a per-PWM structure
that tracks the clock? There are a number of other PWMs that already do
something similar. You can use pwm_{set,get}_chip_data() to associate
chip-specific extra data with a PWM.

Thierry

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9GksACgkQ3SOs138+
s6E+TBAAjG0S5ESNTVw1dLBpuxfE/NmCtzdpNdd7R9KmrD0XWaRkU6yNYjTX7LeQ
8httkW5MfGJW2KK2I5Z5E565idf5/HnlbioDq8Nw9a9ENYgaCDn6VvQE+Ua+u8gN
TZvMXZKy9ltzlV3Tfql4G+7OZ/FA97kKhA1BYyMn/T+bOFuUoGA8jUXTIjX0uSXS
aNfBlzgB52/a1BEXzPqTP0fdQC2+HonK3nY6UteIS6qK7Qgdp8RoiIwWVT8+bXSf
adzq4fT1IK5rTS5PexZ4pMraYZdckyNoQJuaBaG4j/gjkcNTFhNEON3LBVFggKFX
e0jvl4e6eknc9zEuaJ6G6FB9SAYIzi7vgXCguNm+6woJIx+mprU58hnSBuASxowy
U0gZ6fvcMu90q38q0rmRrFGRT5RbULDfpNPBhI/VeCrE/4hkw5/0ZsEMxDjmC9aG
p/Op5ym9x56XUsRx2pCg6zrKQUM9bpES7t6vIOpeVWRSVCPF47vtDIM/fmJhX/ZH
C+1D/Af2xA/vD0y3Qn5MqePW/pU34CsLGdS2DM5MX1V+hqqdrZerOleXdCxhIS3I
RU7wj4bY1wUvECx3hW1XydtghqHeLIiVadmusimZyTPT50UJBgzENWQ+p2msj2dh
0YaMWC6A08/g5NUdRn1gYORT9Gifk6aFTAvAbYOblC+ozjusUbc=
=HjwR
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
