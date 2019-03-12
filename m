Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52795C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC66214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCLNRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:17:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54555 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfCLNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:17:20 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h3hHN-0004BE-Cq; Tue, 12 Mar 2019 14:17:13 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h3hHM-0006Qn-El; Tue, 12 Mar 2019 14:17:12 +0100
Date:   Tue, 12 Mar 2019 14:17:12 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Yash Shah <yash.shah@sifive.com>, palmer@sifive.com,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v9 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190312131712.rxiarnthcfrsgdqn@pengutronix.de>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
 <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
 <20190312121218.GM31026@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190312121218.GM31026@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:12:18PM +0100, Thierry Reding wrote:
> On Tue, Mar 12, 2019 at 10:17:39AM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > there are just a few minor things left I commented below.
> > 
> > On Tue, Mar 12, 2019 at 01:41:29PM +0530, Yash Shah wrote:
> > > +#define div_u64_round(a, b) \
> > > +	({typeof(b) __b = b; div_u64((a) + __b / 2, __b); })
> > 
> > Parenthesis around b please. I guess I didn't had them in my suggestion
> > either, sorry for that.
> 
> We don't really need the parentheses here, do we? The only operator that
> has lower priority than the assignment is the comma operator, and that's
> not going to work in the macro anyway, unless you put it inside a pair
> of parentheses, in which case, well, you have the parentheses already.

I thought that, too, but using parenthesis just always is a safe bet and
prevents people stumbling over this and spending time to come to the
conclusion that it is actually safe without them.

> > > +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> > > +{
> > > +	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
> > > +	int ret;
> > > +
> > > +	if (enable) {
> > > +		ret = clk_enable(pwm->clk);
> > > +		if (ret) {
> > > +			dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	if (!enable)
> > > +		clk_disable(pwm->clk);
> > > +
> > > +	return 0;
> > > +}
> > 
> > There is only a single caller for this function. I wonder if it is
> > trivial enough to fold it into pwm_sifive_apply.
> 
> I think this is fine. pwm_sifive_apply() is already fairly long at this
> point, so might as well split things up a little.

I don't have a strong opinion here, so keeping as is is fine for me.

> > There are a few other things that could be improved, but I think they
> > could be addressed later. For some of these I don't even know what to
> > suggest, for some Thierry might not agree it is worth fixing:
> > 
> >  - rounding
> >    how to round? When should a request declined, when is rounding ok?
> >    There is still "if (state->period != pwm->approx_period) return -EBUSY"
> >    in this driver. This is better than before, but if state-period ==
> >    pwm->approx_period + 1 the result (if accepted) might be the same as
> >    without the +1 and so returning -EBUSY for one case and accepting the
> >    other is strange.
> 
> Perhaps a good idea would be to reject a configuration only after we've
> determined that it is incompatible? If we're really going to end up with
> the same configuration within a given margin of period or duty cycle and
> we can't do much about it, there's little point in rejecting such
> configurations.

It seems we agree here. Is this important enough to delay taking this
driver further? Currently the driver rejects too broad so if it annoys
someone this can still be fixed later and there is only little harm
(assuming correct error handling in the consumers).

> >  - don't call PWM API functions designed for consumers (here: pwm_get_state)
> 
> Agreed. The driver can just access pwm_device.state directly.

I wouldn't do this either. IMHO the driver should only look into its
hardware registers instead of using framework interna (or consumer API
calls).

> >  - Move div_u64_round to include/linux/math64.h
> 
> Looks to me like DIV_ROUND_CLOSEST_ULL() is already pretty much this.
> The only difference that I can see is that the divisor is 32-bit, but
> since we pass in state->period, that already works fine.

num (i.e. the divident) should be a u64, but it isn't. This needs
fixing. But I agree that DIV_ROUND_CLOSEST_ULL should be good enough
then.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
