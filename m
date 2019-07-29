Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F709C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6D82067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfG2QOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:14:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59135 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG2QOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:14:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hs8IG-0007Bj-LI; Mon, 29 Jul 2019 18:14:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hs8IF-0005n0-HF; Mon, 29 Jul 2019 18:14:35 +0200
Date:   Mon, 29 Jul 2019 18:14:35 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Message-ID: <20190729161435.5bnj3ikocsyep4dd@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-4-jernej.skrabec@siol.net>
 <20190729063825.wxfky6nswcru26g7@pengutronix.de>
 <4022372.WfP88Fa4Lu@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4022372.WfP88Fa4Lu@jernej-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jernej,

On Mon, Jul 29, 2019 at 05:48:36PM +0200, Jernej Škrabec wrote:
> Dne ponedeljek, 29. julij 2019 ob 08:38:25 CEST je Uwe Kleine-König 
> napisal(a):
> > Hello,
> > 
> > On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> > > H6 PWM core needs bus clock to be enabled in order to work.
> > > 
> > > Add a quirk for it.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > index 1b7be8fbde86..7d3ac3f2dc3f 100644
> > > --- a/drivers/pwm/pwm-sun4i.c
> > > +++ b/drivers/pwm/pwm-sun4i.c
> > > @@ -72,6 +72,7 @@ static const u32 prescaler_table[] = {
> > > 
> > >  };
> > >  
> > >  struct sun4i_pwm_data {
> > > 
> > > +	bool has_bus_clock;
> > > 
> > >  	bool has_prescaler_bypass;
> > >  	bool has_reset;
> > >  	unsigned int npwm;
> > > 
> > > @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
> > > 
> > >  struct sun4i_pwm_chip {
> > >  
> > >  	struct pwm_chip chip;
> > > 
> > > +	struct clk *bus_clk;
> > > 
> > >  	struct clk *clk;
> > >  	struct reset_control *rst;
> > >  	void __iomem *base;
> > > 
> > > @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device
> > > *pdev)> 
> > >  		reset_control_deassert(pwm->rst);
> > >  	
> > >  	}
> > > 
> > > +	if (pwm->data->has_bus_clock) {
> > > +		pwm->bus_clk = devm_clk_get(&pdev->dev, "bus");
> > 
> > Similar to my suggestion in patch 2: I'd use devm_clk_get_optional() and
> > drop struct sun4i_pwm_data::has_bus_clock.
> 
> This one is not so simple. This patch has incorrect logic. Correct logic would 
> be to use "devm_clk_get(&pdev->dev, NULL)" for variants without bus clock as 
> it is done already and "devm_clk_get(&pdev->dev, "bus")" and 
> "devm_clk_get(&pdev->dev, "mod")" for variants with bus clock.

Then maybe something like the following?:

	busclk = devm_clk_get_optional(..., "bus");
	modclk = devm_clk_get_optional(..., "mod");

	/*
	 * old dtbs might have a single clock but no clock names. Fall
	 * back to this for compatibility reasons.
	 */
	if (!modclk) {
		modclk = devm_clk_get(..., NULL);
	}
 
> You see, DT nodes for other variants don't have clock-names property at all. 
> If it would be specified, it would be "mod". So, DT nodes for other variants 
> have "mod" clock specified on first place (the only one), while H6 DT node will 
> have "mod" clock specified on second place (see one of e-mails from Maxime), so 
> "NULL" can't be used instead of "mod" in both cases.
> 
> So I would say quirk is beneficial to know if you have to look up clocks by 
> name or you just take first clock specified.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
