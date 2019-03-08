Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D4EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EDD20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCHIxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:53:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50519 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCHIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:53:20 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h2BFl-0000Ux-Of; Fri, 08 Mar 2019 09:53:17 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h2BFk-0000s1-Pn; Fri, 08 Mar 2019 09:53:16 +0100
Date:   Fri, 8 Mar 2019 09:53:16 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in
 img_pwm_config
Message-ID: <20190308085316.7eaynrb746o6xsz7@pengutronix.de>
References: <20190307223628.21270-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307223628.21270-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
> 
> The final else if functions as an else; make that explicit so that Clang
> understands that timebase cannot be used uninitialized.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/400
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pwm/pwm-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index 815f5333bb8f..1cc5fbe1e1d3 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	} else if (mul <= max_timebase * 512) {
>  		div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
>  		timebase = DIV_ROUND_UP(mul, 512);
> -	} else if (mul > max_timebase * 512) {
> +	} else {
>  		dev_err(chip->dev,
>  			"failed to configure timebase steps/divider value\n");
>  		return -EINVAL;

This can even be simplified further.

From the probe function we have:

	pwm_chip->max_period_ns = NSEC_PER_SEC * 512 * max_timebase / input_clk_hz

Then in img_pwm_config there is:

	mul = ⎡ input_clk_hz / ⎡ NSEC_PER_SEC / period_ns⎤⎤

(Not sure this term is the best we can come up with. The rounding
strategy looks strange because the first DIV_ROUND_UP makes mul smaller
while the second makes it bigger. This is similar to

	⎡ input_clk_hz * period_ns / NSEC_PER_SEC ⎤

which is probably more exact and cheaper to calculate.)

If we now had

	mul > max_timebase * 512

this results in (apart from rounding errors):

	input_clk_hz * period_ns / NSEC_PER_SEC > max_timebase * 512
 <=>    period_ns > max_timebase * 512 * NSEC_PER_SEC / input_clk_hz
 <=>    period_ns > pwm_chip->max_period_ns

This however is already ruled out by the first check in
img_pwm_config().

So if the rounding would be fixed, the else is a dead branch and could
be dropped completely.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
