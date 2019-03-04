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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0500C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00DB2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZG5S3f9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCDMfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:35:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44096 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:35:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so5345561wrt.11;
        Mon, 04 Mar 2019 04:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LgPdbTiPfqSCbOMpqcHezDufRGXfU2W7+3meyv7VIqc=;
        b=TZG5S3f99RKjTjVmeW1jHWQ99fPNZY2xUI7YYgOBZSoK3N3HQzVtHkwRiB8Vc7H6Hz
         EkBVdj+af8GV4rU7Ov6dV8fWm0MyjDPQ7B33oZjLPsOaedhQ4XCZW42zDA3WfhJwPtMj
         LCNPMUYMOxIbKWL3l4EsXIIrOaGFcQr+bQUHkpZyJq6HXvn2v9RXoV966/Fc1VuE05z4
         7Ks4UkhCCWwpywuFVvpja2oja2W54XFX5mQphzJ0oVf4snx+gBo3ZP6pIRS1M8QVZlBQ
         OhW/HBfzdZmm9RtFrleGF/OMOTbmPG2hFOJ9D1UHMOWS7YOLeA2zxuH+PyLU8dnwBfq6
         W/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LgPdbTiPfqSCbOMpqcHezDufRGXfU2W7+3meyv7VIqc=;
        b=sCG6XMsH9IiWdGJquGZhQR5NJSXblXS4Zar3Wo90MxZAW0mvG0Di0/3DXSbsGe4Wop
         LLbzfKVn2R1N4tlJmgBEmrvBz00K1kX1+456iRRbOhjfI3XkdSImqfFTETBKK7U5EO//
         zeILg82DAiP7JEawNKntZtlJp9z6cczqMvfjS5M8NK0IDu0VBpQST8DFaPgC89RIYmzK
         jACxcblernBCaPT3j6ZAYx0W2PH4GvpLTx/tAiBEY/IafiXf4rW5LX9Tn1cTySARJ7Kt
         LOAaUE3Ei/zQepprTp2HmfpLYN2NuqKiMbiz0D8UHtRNcbMGDTmmItZ7hDw1bh7V8QtK
         BXWg==
X-Gm-Message-State: APjAAAUvfzJjijn8D5MiIUt/UDg5esLb7Xw+bL4Ao+Kul/1lERPLpwD1
        ogyLzq5MTfLlVtFdNcGuxU0=
X-Google-Smtp-Source: APXvYqwtxVh6JMFAbTXGfcYmt8rl8I0vq/rAvfmF2mY4RyPwWPAMMdyzg2gXmq/nai1f9rlXgA5ELw==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr12927657wrx.32.1551702898291;
        Mon, 04 Mar 2019 04:34:58 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id x11sm16273917wrt.27.2019.03.04.04.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 04:34:57 -0800 (PST)
Date:   Mon, 4 Mar 2019 13:34:56 +0100
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
Subject: Re: [PATCH v10 15/27] pwm: jz4740: Allow selection of PWM channels 0
 and 1
Message-ID: <20190304123456.GG9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-16-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-16-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:34:01PM -0300, Paul Cercueil wrote:
> The TCU channels 0 and 1 were previously reserved for system tasks, and
> thus unavailable for PWM.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v6: New patch
>    =20
>          v7: No change
>    =20
>          v8: ingenic_tcu_[request,release]_channel are dropped. We now use
>              the memory resources provided to the driver to detect whether
>     	 or not we are allowed to use the TCU channel.
>    =20
>          v9: Drop previous system. Call a API function provided by the
>              clocksource driver to know if we can use the channel as PWM.
>    =20
>          v10: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index f497388fc818..c914589d547b 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -44,11 +44,7 @@ static int jz4740_pwm_request(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	char clk_name[16];
>  	int ret;
> =20
> -	/*
> -	 * Timers 0 and 1 are used for system tasks, so they are unavailable
> -	 * for use as PWMs.
> -	 */
> -	if (pwm->hwpwm < 2)
> +	if (!ingenic_tcu_pwm_can_use_chn(pwm->hwpwm))
>  		return -EBUSY;

Like I said earlier, I think this would be nicer to take a parameter to
a struct device * to remove the need for a global variable (at least for
this particular case).

Thierry

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9G3AACgkQ3SOs138+
s6GsoBAAlgsmxh5F3erzL0YSoFLi9YUFWsXW2ac2aWNG727Q8nKu59W9ZYGGimxk
os1XIwKsey4CI/zaAId1lIc74rTrOBooY5AjWApD9+HjU5xeePuSKTzmQkAs38DV
ZUCw7icfbeWIaNtSZmXPwxzbQIgyLJkkdO7CXKzTg5Hj1Ty9Fcn7xa850dKLKbpv
MOlS7msP6FhY8HVDgjt/Wn2yxEoUWPncdZROBwhYH6W3NNXgI6zU++xTgDIYOWHm
YIlxgo2QUmRGChruJuxtnN8GniJdSnqemBZevLdWFsCOs6hH+HTXTO1Arb0yttGI
QDKMUfilZ0BnNfoZJ7qopbC2D856bHvkQBvOw5hsTHZqgs/P9TKxDjDRtnBvMMHk
KPSlscjq2sKR+9BK7FOR1ikkzDVvQpq28yWfw93Fh2yJTvUndk29f+EjLOADg/lE
UbSU/+7dpS4n2lVv4z4vl3xFBWWUCIW7Rmu0K0UFv9lzY90mI6aEH0qe32lO8lhK
FIsofG/ifAkNgJI1SiR6IV4KA61mqCMeVs4v6Oaj7sFluz1Izq9SPCaHhmkJY1jC
YfRgu2GJpnG5dSa2gRwxFIh2HeLvqKBQhIwRQitiSVUJQHwcIKJGqnDgf0SABuea
fplDG6LMvlKjk6QGXy1jrDhYpaDasxtwV+Ur2I/yc/qlBCd/P1E=
=ACVI
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
