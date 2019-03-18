Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F158AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A477220863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3VGzC/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCRPa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:30:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40874 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:30:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so17555073wri.7;
        Mon, 18 Mar 2019 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e4KYeyzJTf3JDvucyoY+YxrNGuHFUoo5oypAC+Khcgg=;
        b=h3VGzC/j6rWJigMH3fWu0hUzWdmIvMosFHXggJJ5b38imIb+bhCxH6aBOfHtQzn7iz
         WYAqSU9WhoXHCHEr3ZpK6r71G9j9BEBq4P3cyANp/aLt5a6ynUmbzTnb5hmT41TGeJis
         lvpjeXE5RBO5d7z3JBkYYBo8tgl2yPLh1EjjDPhlodLQTIb3ll+fT90HIMO3gPuVkJL3
         T0YcMWxV8Sy9WDu7kUQk/8gkDz5qu/+l2XxySxMgLGy+ma2hg9B/u5Kw2XVj50ACGQkM
         gjyGL6UPl4nzfB7LuFO6kCIW4XgPd03NYr+nBg47UtLfMFaNAi7Pnv6vEtM2To3py/lf
         yIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e4KYeyzJTf3JDvucyoY+YxrNGuHFUoo5oypAC+Khcgg=;
        b=W7XzKeImW43ylz/b+VrGWsxwjtVHviZpl4rMaa5kZDjFEi7+ngr9PuFn6ihDRFO/Rh
         3q2wKw0J1lwUBI3iYLjUTncNaMOND8S4llPu+PsJWJBsUo2HdMcoFYAcXrvygLqcmICT
         bSqKbiWQn0wxPHlQcOGP7V0bgMoVmPhoNVHadu8swGE+vOoNIOVhmO2a4RbWZVN6top+
         O1JUlX+rNGgjysmQqyK52ZEs6QHD6BTiij2L5FixyV23LZHs5mpmi5HmsmEJDIq+MWY5
         boL0xLMN8gzJfg8EwMLQRdUzB24+FvX0a5bYBs6b0ypWwao5mmlUr4ruNOanGRxgjl9Y
         jz+A==
X-Gm-Message-State: APjAAAWAG10dwPnOLks1+GlxCNMIedvRPxBszmHBkx2TW6fBCxIWTF6l
        jesWtYVyR4pz1ZGlhBEexqQ=
X-Google-Smtp-Source: APXvYqyf923WujB1w4MVjmhISnxsYTxWPAqpl7KkNjWEXxHshq1fjNFlgUhZQ2oAZcOmXYdEXPqkEQ==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr12395206wro.216.1552923054297;
        Mon, 18 Mar 2019 08:30:54 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id 16sm38366876wrb.19.2019.03.18.08.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 08:30:52 -0700 (PDT)
Date:   Mon, 18 Mar 2019 16:30:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190318153051.GA31929@ulmo>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
 <1552894581-3391-3-git-send-email-Anson.Huang@nxp.com>
 <20190318102740.GE17565@ulmo>
 <DB3PR0402MB39169937B4A02D70FB72FB8DF5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39169937B4A02D70FB72FB8DF5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 11:33:33AM +0000, Anson Huang wrote:
> Hi, Thierry
>=20
> Best Regards!
> Anson Huang
>=20
> > -----Original Message-----
> > From: Thierry Reding [mailto:thierry.reding@gmail.com]
> > Sent: 2019=E5=B9=B43=E6=9C=8818=E6=97=A5 18:28
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux@armlinux.org.uk; otavio@ossystems.com.br; stefan@agner.ch;
> > Leonard Crestez <leonard.crestez@nxp.com>; Robin Gong
> > <yibin.gong@nxp.com>; jan.tuerk@emtrion.com; linux-
> > pwm@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; u.kleine-
> > koenig@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH V5 2/5] pwm: Add i.MX TPM PWM driver support
> >=20
> > On Mon, Mar 18, 2019 at 07:41:42AM +0000, Anson Huang wrote:
[...]
> > > +static void pwm_imx_tpm_config(struct pwm_chip *chip,
> > > +			       struct pwm_device *pwm,
> > > +			       u32 period,
> > > +			       u32 duty_cycle,
> > > +			       enum pwm_polarity polarity) {
> > > +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> > > +	u32 duty_cnt, val;
> > > +	u64 tmp;
> > > +
> > > +	/* set duty counter */
> > > +	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD) &
> > PWM_IMX_TPM_MOD_MOD;
> > > +	tmp *=3D duty_cycle;
> > > +	duty_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, period);
> > > +	writel(duty_cnt & PWM_IMX_TPM_MOD_MOD,
> > > +	       tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> > > +
> > > +	/*
> > > +	 * set polarity (for edge-aligned PWM modes)
> > > +	 *
> > > +	 * CPWMS  MSB:MSA  ELSB:ELSA  Mode  Configuration
> > > +	 * 0	  10	   10	      PWM   High-true pulse
> > > +	 * 0	  10	   00	      PWM   Reserved
> > > +	 * 0	  10	   01	      PWM   Low-true pulse
> > > +	 * 0	  10	   11	      PWM   Reserved
> > > +	 *
> > > +	 * High-true pulse: clear output on counter match, set output on
> > > +	 * counter reload, set output when counter first enabled or paused.
> > > +	 *
> > > +	 * Low-true pulse: set output on counter match, clear output on
> > > +	 * counter reload, clear output when counter first enabled or pause=
d.
> > > +	 */
> > > +
> > > +	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > > +	val &=3D ~(PWM_IMX_TPM_CnSC_ELSB | PWM_IMX_TPM_CnSC_ELSA
> > |
> > > +		 PWM_IMX_TPM_CnSC_MSA);
> > > +	val |=3D PWM_IMX_TPM_CnSC_MSB;
> > > +	val |=3D (polarity =3D=3D PWM_POLARITY_NORMAL) ?
> > > +		PWM_IMX_TPM_CnSC_ELSB : PWM_IMX_TPM_CnSC_ELSA;
> > > +	/*
> > > +	 * polarity settings will enabled/disable output status
> > > +	 * immediately, so here ONLY save the config and write
> > > +	 * it into register when channel is enabled/disabled.
> > > +	 */
> > > +	tpm->chn_config[pwm->hwpwm] =3D val;
> > > +}
> > > +
> > > +/*
> > > + * When a channel's polarity is configured, the polarity settings
> > > + * will be saved and ONLY write into the register when the channel
> > > + * is enabled.
> > > + *
> > > + * When a channel is disabled, its polarity settings will be saved
> > > + * and its output will be disabled by clearing polarity settings.
> > > + *
> > > + * when a channel is enabled, its polarity settings will be restored
> >=20
> > "when" -> "When".
>=20
> Will fix it.
>=20
> >=20
> > > + * and output will be enabled again.
> > > + */
> > > +static void pwm_imx_tpm_enable(struct pwm_chip *chip,
> > > +			       struct pwm_device *pwm,
> > > +			       bool enable)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> > > +	u32 val;
> > > +
> > > +	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
> > > +	if (enable) {
> > > +		/* restore channel config */
> > > +		writel(tpm->chn_config[pwm->hwpwm],
> > > +		       tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > > +
> > > +		if (++tpm->enable_count =3D=3D 1) {
> > > +			/* start TPM counter */
> > > +			val |=3D PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> > > +			writel(val, tpm->base + PWM_IMX_TPM_SC);
> > > +		}
> > > +	} else {
> > > +		/* disable channel */
> > > +		val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm-
> > >hwpwm));
> > > +		val &=3D ~(PWM_IMX_TPM_CnSC_MSA |
> > PWM_IMX_TPM_CnSC_MSB |
> > > +			 PWM_IMX_TPM_CnSC_ELSB |
> > PWM_IMX_TPM_CnSC_ELSA);
> > > +		writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm-
> > >hwpwm));
> > > +
> > > +		if (--tpm->enable_count =3D=3D 0) {
> > > +			/* stop TPM counter since all channels are disabled
> > */
> > > +			val &=3D ~PWM_IMX_TPM_SC_CMOD;
> > > +			writel(val, tpm->base + PWM_IMX_TPM_SC);
> > > +		}
> > > +	}
> > > +
> > > +	/* update channel status */
> > > +	tpm->chn_status[pwm->hwpwm] =3D enable; }
> > > +
> > > +static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
> > > +				  struct pwm_device *pwm,
> > > +				  struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> > > +	u64 tmp;
> > > +	u32 val, rate;
> > > +
> > > +	/* get period */
> > > +	rate =3D clk_get_rate(tpm->clk);
> > > +	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD);
> > > +	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
> > > +	val &=3D PWM_IMX_TPM_SC_PS;
> > > +	tmp *=3D (1 << val) * NSEC_PER_SEC;
> > > +	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
> > > +
> > > +	/* get duty cycle */
> > > +	tmp =3D readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> > > +	tmp *=3D (1 << val) * NSEC_PER_SEC;
> > > +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
> > > +
> > > +	/* get polarity */
> > > +	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > > +	if (val & PWM_IMX_TPM_CnSC_ELSA)
> > > +		state->polarity =3D PWM_POLARITY_INVERSED;
> > > +	else
> > > +		state->polarity =3D PWM_POLARITY_NORMAL;
> > > +
> > > +	/* get channel status */
> > > +	state->enabled =3D tpm->chn_status[pwm->hwpwm] ? true : false; }
> > > +
> > > +static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device
> > *pwm,
> > > +			     struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> > > +	struct pwm_state curstate;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&tpm->lock);
> > > +
> > > +	pwm_imx_tpm_get_state(chip, pwm, &curstate);
> > > +
> > > +	if (state->period !=3D curstate.period) {
> > > +		/*
> > > +		 * TPM counter is shared by multiple channels, so
> > > +		 * prescale and period can NOT be modified when
> > > +		 * there are multiple channels in use.
> > > +		 */
> > > +		if (tpm->user_count !=3D 1)
> > > +			return -EBUSY;
> > > +		ret =3D pwm_imx_tpm_config_counter(chip, state->period);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	if (state->enabled =3D=3D false) {
> > > +		/*
> > > +		 * if eventually the PWM output is LOW, either
> > > +		 * duty cycle is 0 or status is disabled, need
> > > +		 * to make sure the output pin is LOW.
> > > +		 */
> > > +		pwm_imx_tpm_config(chip, pwm, state->period,
> > > +				   0, state->polarity);
> > > +		if (curstate.enabled)
> > > +			pwm_imx_tpm_enable(chip, pwm, false);
> > > +	} else {
> > > +		pwm_imx_tpm_config(chip, pwm, state->period,
> > > +				   state->duty_cycle, state->polarity);
> > > +		if (!curstate.enabled)
> > > +			pwm_imx_tpm_enable(chip, pwm, true);
> >=20
> > Doesn't this mean that you won't be applying changes to the polarity wh=
ile a
> > PWM is enabled? That seems wrong. Granted, you may usually not run into
> > that, but if you can't support it I think you should at least return an=
 error if
> > you detect that the user wants to change polarity while the PWM is enab=
led.
>=20
> I thought below function call already set the polarity? No matter its sta=
tus is enabled
> or disabled, the polarity setting will be always applied.
> =20
> 		pwm_imx_tpm_config(chip, pwm, state->period,
> 				   state->duty_cycle, state->polarity);

That's not what it seems to do. In fact there's a comment that explains
why it doesn't do that. Quoting here:

> > > +	/*
> > > +	 * polarity settings will enabled/disable output status
> > > +	 * immediately, so here ONLY save the config and write
> > > +	 * it into register when channel is enabled/disabled.
> > > +	 */
> > > +	tpm->chn_config[pwm->hwpwm] =3D val;

Looks to me like that only stores the value for that register so that it
can be applied at a later point. Or am I missing something?

> > > +				ret);
> > > +	}
> > > +
> > > +	return ret;
> > > +};
> >=20
> > Your handling of the clock seems strange here. Basically in the above y=
ou
> > always keep the clock on and you only disable it if there are no users =
and
> > you're going to suspend.
> >=20
> > Why do you need to keep an extra reference count anyway? Or why keep the
> > clock on all the time? Can't you just do a clk_prepare_enable() every t=
ime
> > somebody enables the PWM? The CCF already has built-in reference
> > counting, so I'm not sure you really need to duplicate that here.
>=20
> Keeping clock always ON since driver probe is because, many TMP registers'
> write needs clock to be ON for sync into register hardware, just enable t=
he clock
> before writing register and disable the clock immediately does NOT work, =
unless
> we keep reading the register value until the register value is what we wa=
nt to write,
> but that makes code much more complicated, and the PWM clock normally is =
=66rom
> OSC which does NOT consume too much power, so I keep the clock always on =
and ONLY
> disable it after suspend.

Why do you bother with keeping the enable reference count, then? Can't
you just enable the clock on probe, then on suspend disable it, enable
it again on resume and on remove you also disable it? Why does it need
to be dependent on whether there are any active PWMs or not?

Thierry

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyPuacACgkQ3SOs138+
s6H9Vw/9EpjiP7x6maJyjU7MldmX3QCsQ4I+HPOaMu4e39mOE/kt2VJG1fIVi3eb
jRuen2P+uH/cB76It4CUTYrMachZSooKzbwBGlh1Im2CpgYf6/L5TPgocBaLtATq
JddcM2WGes66e7Ry0lnkCbvKWe4NkMn6Qanbg+jsOSbirRi6bu/3Hi978n3YAvAw
870E++4OjxeyfAB5HY+n/VZ88jGmsQobELAc9BbtnabUg6Dli6WdWRypbO4h/+9d
L4G7FxQMPKFFfCg5b40GYi31K5o3YYL4P8H3Q/4yMSP3hUqa9K6y4Y+7c9m6w8yj
wm1PXGjAeTvb4x1vo4TI8XhZWW9EwZLoQ3vYvE6jxMFNfbEaow1ZVIT/vO9QagOj
2Zil24HYgffixv3JaPshCGzvEOLZnL6twmbbEBpwLSdKJX6ZGZ0t7gU9J3A9k0w2
lhOwi87RxWXUFwhd0UL2SwKfwmNuZssURQhBWlEJ61phg+6QmRFMtMG7i/1WV40J
4MqEfxnZrdaE7X4a/mxJR0y0aZrZyYYqnBB+fXYzITp9qMsDalsnVF9yXoyU/eip
SobQEOZKhG320OQYpS+YjxKaJIc4mwJJsfZdDM0KzCm2GW8U5ALeBB3vsyYBYjX8
n6F9Mht40O1u0pxeFO4d+OSrHlJfRisQvdghPWVhWs4Lob4DuOM=
=psPO
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
