Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693682084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfCZKyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:54:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38553 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCZKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:54:19 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8jiY-0007ou-IS; Tue, 26 Mar 2019 11:54:06 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8jiY-0000yG-1I; Tue, 26 Mar 2019 11:54:06 +0100
Date:   Tue, 26 Mar 2019 11:54:06 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        thierry.reding@gmail.com, jbrunet@baylibre.com,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Message-ID: <20190326105405.p5appmjs2qdygkz3@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
 <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
 <ec428b82-f7d9-0f14-363c-a40d14ce4414@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec428b82-f7d9-0f14-363c-a40d14ce4414@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 26, 2019 at 10:06:31AM +0100, Neil Armstrong wrote:
> On 25/03/2019 18:41, Martin Blumenstingl wrote:
> > On Mon, Mar 25, 2019 at 9:41 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> >> On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
> >>> Back in January a "BUG: scheduling while atomic" error showed up during
> >>> boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
> >>> The call trace comes down to:
> >>>   __mutex_lock
> >>>   clk_prepare_lock
> >>>   clk_core_get_rate
> >>>   meson_pwm_apply
> >>>   ..
> >>>   dev_pm_opp_set_rate
> >>>   ..
> >>>
> >>> Jerome has also seen the same problem but from pwm-leds (instead of a
> >>> pwm-regulator). He posted a patch which replaces the spinlock with a
> >>> mutex. That works. I believe we can optimize this by reducing the time
> >>> where the lock is held - that also allows to keep the spin-lock.
> >>>
> >>> Analyzing this issue helped me understand the pwm-meson driver better.
> >>> My plan is to send some cleanups (with the goal of re-using more of the
> >>> goodies from the PWM core in the pwm-meson driver) after this single fix
> >>> is merged (they can be found here: [1]).
> >>
> >> I didn't look over these in detail, but I see an issue that according
> >> to the shortlogs isn't addressed: In the .apply callback there is
> >> (simplified):
> >>
> >>         if (!state->enabled) {
> >>                 meson_pwm_disable(meson, pwm->hwpwm);
> >>                 return;
> >>         }
> >>
> >> This results in the wrong output after:
> >>
> >>         pwm_apply_state(pwm, { .enabled = true, .polarity = PWM_POLARITY_NORMAL, ...});
> >>         pwm_apply_state(pwm, { .enabled = false, .polarity = PWM_POLARITY_INVERTED, ...});
> >>
> >> because the polarity isn't checked.
> > let me rephrase this to make sure I understand this correctly:
> > - applying a PWM state with .enabled = true and PWM_POLARITY_NORMAL
> > will enable the PWM output
> > - applying a PWM state with .enabled = false and PWM_POLARITY_NORMAL
> > will disable the PWM output
> > - applying a PWM state with .enabled = true and PWM_POLARITY_INVERTED
> > will disable the PWM output
> > - applying a PWM state with .enabled = false and PWM_POLARITY_INVERTED
> > will enable the PWM output
> > 
> > in other words: the polarity doesn't only apply to period and
> > duty_cycle but also to the enabled state.
> 
> Sorry I don't understand your point.
> If the apply state is disable, well we disable the PWM output, I don't see why
> the polarity changes the enable state.

Martin's summary was at least misleading, I didn't understand what he
meant.

The relevant point is: When the PWM is disabled (either by pwm_disable
or equivalent by pwm_apply_state(pwm, { .enabled = false, ... })) the
expectation is that the output becomes "inactive". That means "constant
low" for a normal PWM and "constant high" for an inverted PWM.

Then as meson_pwm_apply doesn't check for state->polarity if
state->enabled == false there is a bug.

> I'd like to point out the architecture of the PWM.
> The PWM is only a set of Gates, Dividers and Counters.
> 
> We achieve a PWM output by calculating a clock that permits us to calculate
> 2 periods (low and high) and we set the counter to switch after N cycles
> for the first half period.
> 
> We do not have an explicit "polarity" setting, we simply reverse the period
> cycles (the low length is inversed with the high length).
> 
> To apply the dividers and counters, we need to disable the PWM input clock
> gate, set the dividers and counter and release the input gate.
> 
> So yes, we should maybe stop disabling the PWM for a long period of time
> when we calculate the new settings, it can be fixed easily by calculating
> the settings and applying in a separate code path.

If the hardware supports it the counter should not be stopped---most
other PWMs in my bubble can at least change the duty cycle as required.
(That is, complete the currently running period and that without delay
start a new period with the new settings.)
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
