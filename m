Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1131EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84762084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGfMpmdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCLMMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:12:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42365 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfCLMMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:12:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id o9so2412852wrv.9;
        Tue, 12 Mar 2019 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tlLiaO0QvUN+5U+pEOsUBgx0DXxj5SqSgUYXXck5DpM=;
        b=fGfMpmdo0TpskNHf7G4TYFxi5SMEHNd7uF71sJso5/bSmIrqd1X5hzmKec4aRfMV5p
         g5CmQi1lVCJMF7TSijib/wd4OGl46srNZvCbtQvUWbM83oanpyVGWR/202JDyneRUkzE
         DjrAk2sMlmHxCrDOYt2IfT01HBAZGI2Y6K6fnKbnwQmiT1p1K5zppDSdftg3wgnVhSpL
         t0toW2iQxXD94Y3EdXMzjuxf2ijBrmNAeYHjYvUvOtpZWPU4X6zfgMVaSFPoSQ6MCssJ
         Ghw0b5yvYs52i7EoghyyKzvd4Jt/a32LHpYfb/ogOmjbQn5XKCPG/bRXde/OSkUUxzWG
         ZNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tlLiaO0QvUN+5U+pEOsUBgx0DXxj5SqSgUYXXck5DpM=;
        b=uDC3fzkol9o59oNeGmE/mmYB3ef928ISE7D3N/zgdPcWEtDeF6L6QiUHNurrgeYVPG
         MVEf0LT7HtnLq8XUVLZ7/dc5gkqpYGSitfVF+9rjhvOh8iwramecOZ81w7eMZLA3izVZ
         ObZSdgJTpF7tVmXFYIF/88JYbKhdYGLxuqZ+asAyFqZUNQ9WP/klVqcco+m5fYCPwTgx
         cP1aLq5c54JJ65/1bMXDsP4xol1LsEDX8Gqy16bmDOC8ey8dZ1f2icT0qebM32JqXBNf
         CmkqtOLjjOj+AcBNM8l6LNBolRz5P11VY1jhfzXL0jr66Ugl1+mgw2Mj5nbeUeaLEPKG
         55NQ==
X-Gm-Message-State: APjAAAV9aKus+pqV2REjomJ70Qh24Ovep2mFLonRIc5q1khLjOXpRGBJ
        0FVTfHOUFyWzRsahfrffwRw=
X-Google-Smtp-Source: APXvYqxrAKBNz2i/pOugTU6pHA5OPbs5J1+101GxQuQCdDJ+GiRWcDF9yii/Q1nS7pFysGxioMuvvg==
X-Received: by 2002:adf:f089:: with SMTP id n9mr17515940wro.313.1552392740433;
        Tue, 12 Mar 2019 05:12:20 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id r6sm7103385wrx.48.2019.03.12.05.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 05:12:19 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:12:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Yash Shah <yash.shah@sifive.com>, palmer@sifive.com,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v9 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190312121218.GM31026@ulmo>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
 <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Content-Disposition: inline
In-Reply-To: <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 10:17:39AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> there are just a few minor things left I commented below.
>=20
> On Tue, Mar 12, 2019 at 01:41:29PM +0530, Yash Shah wrote:
> > +#define div_u64_round(a, b) \
> > +	({typeof(b) __b =3D b; div_u64((a) + __b / 2, __b); })
>=20
> Parenthesis around b please. I guess I didn't had them in my suggestion
> either, sorry for that.

We don't really need the parentheses here, do we? The only operator that
has lower priority than the assignment is the comma operator, and that's
not going to work in the macro anyway, unless you put it inside a pair
of parentheses, in which case, well, you have the parentheses already.

> > +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> > +{
> > +	struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +	int ret;
> > +
> > +	if (enable) {
> > +		ret =3D clk_enable(pwm->clk);
> > +		if (ret) {
> > +			dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (!enable)
> > +		clk_disable(pwm->clk);
> > +
> > +	return 0;
> > +}
>=20
> There is only a single caller for this function. I wonder if it is
> trivial enough to fold it into pwm_sifive_apply.

I think this is fine. pwm_sifive_apply() is already fairly long at this
point, so might as well split things up a little.

> > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *=
dev,
> > +			    struct pwm_state *state)
> > +{
> > +	struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +	unsigned int duty_cycle;
> > +	u32 frac;
> > +	struct pwm_state cur_state;
> > +	bool enabled;
> > +	int ret =3D 0;
> > +	unsigned long num;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +		return -EINVAL;
> > +
> > +	ret =3D clk_enable(pwm->clk);
> > +	if (ret) {
> > +		dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	mutex_lock(&pwm->lock);
> > +	pwm_get_state(dev, &cur_state);
> > +
> > +	enabled =3D cur_state.enabled;
> > +
> > +	if (state->period !=3D pwm->approx_period) {
> > +		if (pwm->user_count !=3D 1) {
> > +			ret =3D -EBUSY;
> > +			goto exit;
> > +		}
> > +		pwm->approx_period =3D state->period;
> > +		pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> > +	}
> > +
> > +	duty_cycle =3D state->duty_cycle;
> > +	if (!state->enabled)
> > +		duty_cycle =3D 0;
> > +
> > +	num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> > +	frac =3D div_u64_round(num, state->period);
> > +	/* The hardware cannot generate a 100% duty cycle */
> > +	frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > +
> > +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 +
> > +	       dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +	if (state->enabled !=3D enabled) {
> > +		ret =3D pwm_sifive_enable(chip, state->enabled);
> > +		if (ret)
> > +			goto exit;
>=20
> This goto is a noop.
>=20
> > +	}
> > +
> > +exit:
> > +	clk_disable(pwm->clk);
> > +	mutex_unlock(&pwm->lock);
> > +	return ret;
> > +}
>=20
> There are a few other things that could be improved, but I think they
> could be addressed later. For some of these I don't even know what to
> suggest, for some Thierry might not agree it is worth fixing:
>=20
>  - rounding
>    how to round? When should a request declined, when is rounding ok?
>    There is still "if (state->period !=3D pwm->approx_period) return -EBU=
SY"
>    in this driver. This is better than before, but if state-period =3D=3D
>    pwm->approx_period + 1 the result (if accepted) might be the same as
>    without the +1 and so returning -EBUSY for one case and accepting the
>    other is strange.

Perhaps a good idea would be to reject a configuration only after we've
determined that it is incompatible? If we're really going to end up with
the same configuration within a given margin of period or duty cycle and
we can't do much about it, there's little point in rejecting such
configurations.

>  - don't call PWM API functions designed for consumers (here: pwm_get_sta=
te)

Agreed. The driver can just access pwm_device.state directly.

>  - Move div_u64_round to include/linux/math64.h

Looks to me like DIV_ROUND_CLOSEST_ULL() is already pretty much this.
The only difference that I can see is that the divisor is 32-bit, but
since we pass in state->period, that already works fine.

Thierry

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHoh8ACgkQ3SOs138+
s6E7lw/8CwEa+SQ6iOIiC0QTSowiTzEaVGxw+bbwyxGkg7BXfvg6iLEzK+ZhsIU4
NyA0Q2/u8dP6lFawnP5kzMcjzYeKDbBq5hpfjv+JVGaLOo4KdCfVI5rNyrtv68Cz
Gp0J8SxekNcqGwXp19oYLy5HyaIxZupDAPGkdKmVQn4Khxj2wee4kBj3BoSDRCyh
/deUWdxme4U5RurMMiDTeS6MMiXubCZjS/ITjzDCvrroVlWzC10ATPZObZ1jJPI4
UljScKJgZwCHLfuZN8X+dXQGCHHJ25kLmnXpouPM84JsypKqKqhmN3ngwdVdg9Vn
YOrGOXoemgKXMpuKAKDg3Oc+Ys+1kmODm7PnrxAOX8Q6Vb+C7H9KMIKVBZpIcbfX
jJwYrXcDxwW+5bA+mPDUBLQxUdxcEq0FheOLDjHQefnQGWu1NZoyLeHGITIS72/D
KcKVqijEMR5SoGyIFLdq1Ua03YFfYl2b4WOuWRFd3KxcqZ+rdenC9uzCw57JFF28
n35rUWNpTbuQYdhTzkNcdP2Tf2joG0cPvN8+5adW7SwAHSUQgAipFFOt/2ldL0+c
tay4eC7LxSZ5sBqxPdIbH3P1iAsVtbxlpL/640lg5U5eBawVH5ewpOe7hVBtEoKn
Rn2nfqndVJHWZg1YxZsC8RIx0ylD1/YhnP+tRJhvZOEwjf4dq2Q=
=iW8+
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--
