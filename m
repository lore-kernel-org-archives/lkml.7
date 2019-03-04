Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041CBC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9D4208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZPG923J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfCDMdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:33:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44948 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:33:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so5339741wrt.11;
        Mon, 04 Mar 2019 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZWCi/2TNqbnYURMDyPzqbasTv+6yXgoZo2OAimBe3BM=;
        b=cZPG923Js3q2MJV1lOTNqs+bcKerMON4lNxNoWTFR8xlonWq0Q2suI56cswsGhTAZR
         qw+sY+2uGrT0nuuknvYSrJ0V4rcsNpd8ZkK4XMVVzChwEaEgnRibxmvRWRE8HsUKWUCe
         7X0sO8wUWkwDp19FzIH2MstcIXlPY3QE+xcCvO/gmk6og0sUnZO7bxiz0h5679KLNTK4
         /oN/LV/hA5L7tFNCsU3i1bEq1ZDE+FLz61Obfbs/Vq1zqIoIIVsk0Z7++KZv1HzSBeX2
         6OwE5fY2exQ8VpIrIFRpUxVI4DIwg8fBRpN+BjmMEu54877myTRW9cwPp9sQQfcfymkB
         4QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZWCi/2TNqbnYURMDyPzqbasTv+6yXgoZo2OAimBe3BM=;
        b=MqrBtx7L1949hiMLanS1cBcE3ckO06CsqYHyxKPMffVSWA5FQ1Zl8nBT4LArU9k6rg
         k/PMgaGzwDvLkDOPnjWUtq2gcrCE//GLQYRhfMvydicXkCMwkPa591z7JMHrCq8c7Po2
         7OFspjctgoE93kZ60S1ajeF1BXlUbfG4MclZj3reW5DNcSFPIGadhdFO4Ay6qitkjFkX
         A+cJqBZGWtJakR1R3flsljZ4EvQ9MqPNlHcs4ldZYa4pt+Z375+YtJsNqSC1r9qB8dnY
         6p/PZOXwVRl0m5YKpK/96kAOLXXIkovoqE/kn939mwCmXKdAP6PCLqo12Vh7Bq/26eGf
         yHiQ==
X-Gm-Message-State: APjAAAVx2J2yUZdfMF4SYw2biGiH8fahgds6CBEnuaGcb4zBskzhoexi
        yatQOqHV2b/wRN3dqUFjBxQ=
X-Google-Smtp-Source: APXvYqxAZfRsx5WVBQsatq73V6t6NqMdYu0MCtWGl2YK/ZBgUHA988nxwcDvNdRVNlryCZwjGyAs7Q==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr12463696wrp.44.1551702794685;
        Mon, 04 Mar 2019 04:33:14 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id c15sm4877006wrv.69.2019.03.04.04.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 04:33:14 -0800 (PST)
Date:   Mon, 4 Mar 2019 13:33:13 +0100
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
Subject: Re: [PATCH v10 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
Message-ID: <20190304123313.GF9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-15-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:34:00PM -0300, Paul Cercueil wrote:
> The previous algorithm hardcoded details about how the TCU clocks work.
> The new algorithm will use clk_round_rate to find the perfect clock rate
> for the PWM channel.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v9: New patch
>    =20
>         v10: - New algorithm. Instead of starting with the maximum clock =
rate
>                and using clk_round_rate(rate - 1) to get the next (smalle=
r)
>     	   clock, we compute the maximum rate we can use before the
>     	   register overflows, and apply it with clk_set_max_rate.
>     	   Then we read the new clock rate and compute the register values
>     	   of the period and duty from that.
>     	 - Use NSEC_PER_SEC instead of magic 1000000000 value
>=20
>  drivers/pwm/pwm-jz4740.c | 49 ++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 33 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index c6136bd4434b..f497388fc818 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -110,24 +110,45 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>  	struct clk *clk =3D jz4740->clks[pwm->hwpwm],
>  		   *parent_clk =3D clk_get_parent(clk);
> -	unsigned long rate, period, duty;
> +	unsigned long rate, parent_rate, period, duty;
>  	unsigned long long tmp;
> -	unsigned int prescaler =3D 0;
> +	int ret;
> =20
> -	rate =3D clk_get_rate(parent_clk);
> -	tmp =3D (unsigned long long)rate * state->period;
> -	do_div(tmp, 1000000000);
> -	period =3D tmp;
> +	parent_rate =3D clk_get_rate(parent_clk);
> +
> +	jz4740_pwm_disable(chip, pwm);
> +
> +	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
> +	ret =3D clk_set_rate(clk, parent_rate);
> +	if (ret)
> +		return ret;
> =20
> -	while (period > 0xffff && prescaler < 6) {
> -		period >>=3D 2;
> -		rate >>=3D 2;
> -		++prescaler;
> +	/* Limit the clock to a maximum rate that still gives us a period value
> +	 * which fits in 16 bits.
> +	 */

Please use proper block-comment style.

> +	tmp =3D 0xffffull * NSEC_PER_SEC;
> +	do_div(tmp, state->period);
> +
> +	ret =3D clk_set_max_rate(clk, tmp);
> +	if (ret) {
> +		dev_err(chip->dev, "Unable to set max rate: %i\n", ret);
> +		return ret;
>  	}
> =20
> -	if (prescaler =3D=3D 6)
> -		return -EINVAL;
> +	/* Read back the clock rate, as it may have been modified by
> +	 * clk_set_max_rate()
> +	 */
> +	rate =3D clk_get_rate(clk);

That's a pretty neat trick. But also, please use proper block-comment
style.

Thierry

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9GwkACgkQ3SOs138+
s6GJgBAAnQvMOMCV6VZpxm0xDRxvZpCOPycq+4tWt69b30Ja/bcSGRxP0XHqZWWP
ndv7LtD9hTbBgHQNtMM1xV3dPhZ190ule9TsEmvWX8CNnU5fHAPLO0OvzNmUC/XZ
eftV62b3mHRvbZxB/CtFXHz7V+0TLGTG8k9Ft2mgH4Av2FVCjSQxLLL8kLcZs23o
hAGwFhen0QCnz70R72Biuz0Qr6DbEo1XCDCt5JPLrSuETC7t4VuGc/aLW08helen
Jc9/rMV93vnhw41TDlEaAeusDPNqLDBM96Nxs2xkuLx3o8AJFOHXx9b7dNzb7HMp
ywIbbW7e2o61nLkzNQvPPeSFljpxv+Np/x4UJZclyTLwbrcmRICfow1DaR6T1xSY
XckA95jtqrf1W57GrcxcpkhBRMC2EefFnr/Z6WV2+HYL24lG/rGkqE6GWN1ZFsay
77rnhZ4xx+z08OcSh4GG+7MPQcrs5iBVm5pXFS42XEfWCZfUkOm7XnqbVsztWiD0
e20FAbcRj0SG8ul1OZgVPNU2xb9W3iie0Wj9SqxCyH+U2wqnEC2KtgwCmVxGH54M
5SRabTKLq7leXkoekwZwiQkJrW2g8AJR0rqjwwG/LEPQpHaD4vZGf0+o0Oo0Z7KF
+X8XaQvWgZDtqmfc/B3Qum+FIPzFZNdVV3IwNwqZjSvsc3j+DIc=
=zQDM
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
