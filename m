Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32638C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD0C20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCHVte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:49:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46789 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCHVte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:49:34 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h2NMx-0001l1-Ty; Fri, 08 Mar 2019 22:49:31 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h2NMx-00008V-9s; Fri, 08 Mar 2019 22:49:31 +0100
Date:   Fri, 8 Mar 2019 22:49:31 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in
 img_pwm_config
Message-ID: <20190308214931.3uz5cgbtk6h3s25i@pengutronix.de>
References: <20190307223628.21270-1-natechancellor@gmail.com>
 <20190308085316.7eaynrb746o6xsz7@pengutronix.de>
 <CAKwvOdmA6=_-_uC8PAC8i+-mLA8FN6GOeY544139N2AsA8RbsQ@mail.gmail.com>
 <20190308211852.wnhivsnlwhr4kqn3@pengutronix.de>
 <CAKwvOd=W0MKF_bYtgCOz2hH+RvpZPJawcaBnR2YkcBTP_NZHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=W0MKF_bYtgCOz2hH+RvpZPJawcaBnR2YkcBTP_NZHuA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 01:23:41PM -0800, Nick Desaulniers wrote:
> On Fri, Mar 8, 2019 at 1:18 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Fri, Mar 08, 2019 at 10:38:11AM -0800, Nick Desaulniers wrote:
> > > On Fri, Mar 8, 2019 at 12:53 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> > > > > When building with -Wsometimes-uninitialized, Clang warns:
> > > > >
> > > > > drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> > > > > uninitialized whenever 'if' condition is false
> > > > > [-Werror,-Wsometimes-uninitialized]
> > > > >
> > > > > The final else if functions as an else; make that explicit so that Clang
> > > > > understands that timebase cannot be used uninitialized.
> > > > >
> > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/400
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > ---
> > > > >  drivers/pwm/pwm-img.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > > > > index 815f5333bb8f..1cc5fbe1e1d3 100644
> > > > > --- a/drivers/pwm/pwm-img.c
> > > > > +++ b/drivers/pwm/pwm-img.c
> > > > > @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > >       } else if (mul <= max_timebase * 512) {
> > > > >               div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
> > > > >               timebase = DIV_ROUND_UP(mul, 512);
> > > > > -     } else if (mul > max_timebase * 512) {
> > > > > +     } else {
> > > > >               dev_err(chip->dev,
> > > > >                       "failed to configure timebase steps/divider value\n");
> > > > >               return -EINVAL;
> > > >
> > > > This can even be simplified further.
> > > >
> > > > From the probe function we have:
> > > >
> > > >         pwm_chip->max_period_ns = NSEC_PER_SEC * 512 * max_timebase / input_clk_hz
> > >
> > > I had trouble verifying `input_clk_hz` in the above.  The divisor is
> > > `clk_get_rate(pwm->pwm_clk)`, but is it guaranteed to always be
> > > `input_clk_hz`? If so, where?
> >
> > In the probe function it's called "clk_rate". We have:
> >
> >         clk_rate = clk_get_rate(pwm->pwm_clk);
> >         ...
> >         val = (u64)NSEC_PER_SEC * 512 * pwm->data->max_timebase;
> >         do_div(val, clk_rate);
> >         pwm->max_period_ns = val;
> >
> > and in img_pwm_config we have:
> >
> >         input_clk_hz = clk_get_rate(pwm_chip->pwm_clk);
> >
> > I used the name used in img_pwm_config with the intention that my
> > reasoning is easier to understand, but obviously I failed.
> >
> > This by the way highlights another patch opportunity: Unify the names
> > that the same thing gets the same name in the different functions. This
> > doesn't only affect "clk_rate" vs "input_clk_hz", but also "pwm_chip"
> > vs. "pwm".
> 
> Sure, those seem like nice little cleanups that will help with
> maintainability.  Would you mind sending a patch for those, and I'll
> review? Otherwise Nathan's patch exists and is ready to go.

I don't mind. But I would prefer to get some input from Thierry about
how to round first. I also wonder if there is a publically available
manual for this piece of hardware.

Best regards
Uwe



	

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
