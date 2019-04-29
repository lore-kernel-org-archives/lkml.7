Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D748DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC062087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfD2K1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:27:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39041 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfD2K1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:27:45 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hL3Va-0006sr-JI; Mon, 29 Apr 2019 12:27:38 +0200
Message-ID: <1556533656.2560.7.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] power: supply: Add driver for Microchip UCS1002
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Apr 2019 12:27:36 +0200
In-Reply-To: <20190429054741.7286-3-andrew.smirnov@gmail.com>
References: <20190429054741.7286-1-andrew.smirnov@gmail.com>
         <20190429054741.7286-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Am Sonntag, den 28.04.2019, 22:47 -0700 schrieb Andrey Smirnov:
> Add driver for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation. The driver exposed a power supply
> device to control/monitor various parameter of the device as well as a
> regulator to allow controlling VBUS line.
> 
> > Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
[...]
> +	/* Enable charge rationing by default */
> > +	ret = regmap_update_bits(info->regmap, UCS1002_REG_GENERAL_CFG,
> > +				 F_RATION_EN, F_RATION_EN);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to read general config: %d\n", ret);
> > +		return ret;
> > +	}
> +
> > +	/*
> > +	 * Ignore the M1, M2, PWR_EN, and EM_EN pin states. Set active
> > +	 * mode selection to BC1.2 CDP.
> > +	 */
> > +	ret = regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG,
> > +				 V_SET_ACTIVE_MODE_MASK,
> +				 V_SET_ACTIVE_MODE_BC12_CDP);

This doesn't work as the F_PIN_IGNORE bit isn't set, so the the
external strap settings are applied. I had to apply the following diff
to make the driver behave as expected again:

--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -548,8 +548,8 @@ static int ucs1002_probe(struct i2c_client *client,
         * mode selection to BC1.2 CDP.
         */
        ret = regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG,
-                                V_SET_ACTIVE_MODE_MASK,
-                                V_SET_ACTIVE_MODE_BC12_CDP);
+                                V_SET_ACTIVE_MODE_MASK | F_PIN_IGNORE,
+                                V_SET_ACTIVE_MODE_BC12_CDP | F_PIN_IGNORE);

Regards,
Lucas
