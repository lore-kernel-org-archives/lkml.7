Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC8C20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfCYImH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:42:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46779 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbfCYImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:42:07 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8LB4-0000Dm-Ks; Mon, 25 Mar 2019 09:41:54 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8LB3-0005Ss-Rx; Mon, 25 Mar 2019 09:41:53 +0100
Date:   Mon, 25 Mar 2019 09:41:53 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     thierry.reding@gmail.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Message-ID: <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
> Back in January a "BUG: scheduling while atomic" error showed up during
> boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
> The call trace comes down to:
>   __mutex_lock
>   clk_prepare_lock
>   clk_core_get_rate
>   meson_pwm_apply
>   ..
>   dev_pm_opp_set_rate
>   ..
> 
> Jerome has also seen the same problem but from pwm-leds (instead of a
> pwm-regulator). He posted a patch which replaces the spinlock with a
> mutex. That works. I believe we can optimize this by reducing the time
> where the lock is held - that also allows to keep the spin-lock.
> 
> Analyzing this issue helped me understand the pwm-meson driver better.
> My plan is to send some cleanups (with the goal of re-using more of the
> goodies from the PWM core in the pwm-meson driver) after this single fix
> is merged (they can be found here: [1]).

I didn't look over these in detail, but I see an issue that according
to the shortlogs isn't addressed: In the .apply callback there is
(simplified):

	if (!state->enabled) {
		meson_pwm_disable(meson, pwm->hwpwm);
		return;
	}

This results in the wrong output after:

	pwm_apply_state(pwm, { .enabled = true, .polarity = PWM_POLARITY_NORMAL, ...});
	pwm_apply_state(pwm, { .enabled = false, .polarity = PWM_POLARITY_INVERTED, ...});

because the polarity isn't checked.

If you want to implement further cleanups, my questions and propositions
are:

 - Is there a publicly available manual for this hardware? If yes, you
   can add a link to it in the header of the driver.

 - Why do you handle reparenting of the PWM's clk in .request? Wouldn't
   this be more suitable in .apply?

 - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
   register) freeze the output, or is the currently running period
   completed first? (The latter is the right behaviour.)

 - Please point out in the header that for changing period/duty
   cycle/polarity the hardware must be stopped. (I suggest to apply the
   style used in https://www.spinics.net/lists/linux-pwm/msg09262.html
   for some consistency.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
