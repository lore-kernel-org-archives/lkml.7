Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045D3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CB42173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfJHOeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:34:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35023 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfJHOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:34:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHqZN-0008Ug-CK; Tue, 08 Oct 2019 16:34:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHqZM-0001bw-44; Tue, 08 Oct 2019 16:34:32 +0200
Date:   Tue, 8 Oct 2019 16:34:32 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        heiko@sntech.de, dianders@chromium.org, mka@chromium.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the
 last applied state
Message-ID: <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
References: <20191008105417.16132-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008105417.16132-1-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Enric,

On Tue, Oct 08, 2019 at 12:54:17PM +0200, Enric Balletbo i Serra wrote:
> @@ -117,17 +122,28 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
>  	int ret;
>  
> -	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
> -		return;
> +	/*
> +	 * As there is no way for this hardware to separate the concept of
> +	 * duty cycle and enabled, but the PWM API does, let return the last
> +	 * applied state when the PWM is disabled and only return the real
> +	 * hardware value when the PWM is enabled. Otherwise, a user of this
> +	 * driver, can get confused because won't be able to program a duty
> +	 * cycle while the PWM is disabled.
> +	 */
> +	state->enabled = ec_pwm->state.enabled;

> +	if (state->enabled) {

As part of registration of the pwm .get_state is called. In this case
.apply wasn't called before and so state->enabled is probably 0. So this
breaks reporting the initial state ...

> +		ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "error getting initial duty: %d\n",
> +				ret);
> +			return;
> +		}
> +		state->duty_cycle = ret;
> +	} else {
> +		state->duty_cycle = ec_pwm->state.duty_cycle;
>  	}
>  
> -	state->enabled = (ret > 0);
>  	state->period = EC_PWM_MAX_DUTY;
> -
> -	/* Note that "disabled" and "duty cycle == 0" are treated the same */
> -	state->duty_cycle = ret;

A few thoughts to your approach here ...:

 - Would it make sense to only store duty_cycle and enabled in the
   driver struct?

 - Which driver is the consumer of your pwm? If I understand correctly
   the following sequence is the bad one:

	state.period = P;
	state.duty_cycle = D;
	state.enabled = 0;
   	pwm_apply_state(pwm, &state);

	...

	pwm_get_state(pwm, &state);
	state.enabled = 1;
   	pwm_apply_state(pwm, &state);

   Before my patch there was an implicit promise in the PWM framework
   that the last pwm_apply_state has .duty_cycle = D (and .period = P).
   Is this worthwile, or should we instead declare this as
   non-guaranteed and fix the caller?

 - If this is a more or less common property that hardware doesn't know
   the concept of "disabled" maybe it would make sense to drop this from
   the PWM framework, too. (This is a question that I discussed some
   time ago already with Thierry, but without an result. The key
   question is: What is the difference between "disabled" and
   "duty_cycle = 0" in general and does any consumer care about it.)

 - A softer variant of the above: Should pwm_get_state() anticipate that
   with .enabled = 0 the duty_cycle (and maybe also period) is
   unreliable and cache that for callers?

Unrelated to the patch in question I noticed that the cros-ec-pwm driver
doesn't handle polarity. We need

	state->polarity = PWM_POLARITY_NORMAL;

in cros_ec_pwm_get_state() and

	if (state->polarity != PWM_POLARITY_NORMAL)
		return -ERANGE;

in cros_ec_pwm_apply(). (Not sure -ERANGE is the right value, I think
there is no global rule in force that tells the right value though.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
