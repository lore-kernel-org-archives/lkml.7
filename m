Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39FC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BE921655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504862AbfIXMWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:22:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41539 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfIXMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:22:00 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCjpI-0006IT-GQ; Tue, 24 Sep 2019 14:21:52 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCjpD-00085A-Ku; Tue, 24 Sep 2019 14:21:47 +0200
Date:   Tue, 24 Sep 2019 14:21:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: avoid sleeping early
Message-ID: <20190924122147.fojcu5u44letrele@pengutronix.de>
References: <20190920153906.20887-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190920153906.20887-1-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 05:39:06PM +0200, Alexandre Belloni wrote:
> It is not allowed to sleep to early in the boot process and this may lead
> to kernel issues if the bootloader didn't prepare the slow clock and main
> clock.
> 
> This results in the following error and dump stack on the AriettaG25:
>    bad: scheduling from the idle thread!
> 
> Ensure it is possible to sleep, else simply have a delay.
> 
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

See below for a comment.

> Note that this was already discussed a while ago and Arnd said this approach was
> reasonable:
>   https://lore.kernel.org/lkml/6120818.MyeJZ74hYa@wuerfel/
> 
>  drivers/clk/at91/clk-main.c |  5 ++++-
>  drivers/clk/at91/sckc.c     | 20 ++++++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index f607ee702c83..ccd48e7a3d74 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -293,7 +293,10 @@ static int clk_main_probe_frequency(struct regmap *regmap)
>  		regmap_read(regmap, AT91_CKGR_MCFR, &mcfr);
>  		if (mcfr & AT91_PMC_MAINRDY)
>  			return 0;
> -		usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);
> +		if (system_state < SYSTEM_RUNNING)
> +			udelay(MAINF_LOOP_MIN_WAIT);
> +		else
> +			usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);

Given that this construct is introduced several times, I wonder if we
want something like:

	static inline void early_usleep_range(unsigned long min, unsigned long max)
	{
		if (system_state < SYSTEM_RUNNING)
			udelay(min);
		else
			usleep_range(min, max);
	}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
