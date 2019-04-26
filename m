Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07234C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C850C2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDZOnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:43:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53523 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:43:55 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hK24q-0003vQ-7G; Fri, 26 Apr 2019 16:43:48 +0200
Message-ID: <1556289824.2584.36.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] power: supply: Add driver for Microchip UCS1002
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Health <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Apr 2019 16:43:44 +0200
In-Reply-To: <20190417084457.28747-3-andrew.smirnov@gmail.com>
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
         <20190417084457.28747-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Am Mittwoch, den 17.04.2019, 01:44 -0700 schrieb Andrey Smirnov:
> Add driver for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation. The driver exposed a power supply
> device to control/monitor various parameter of the device as well as a
> regulator to allow controlling VBUS line.
> 
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Health <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
[...]
> +	if (irq_a_det > 0) {
> > +		ret = devm_request_threaded_irq(dev, irq_a_det, NULL,
> > +						ucs1002_charger_irq,
> > +						IRQF_TRIGGER_FALLING |
> > +						IRQF_TRIGGER_RISING |
> > +						IRQF_ONESHOT,
> > +						"ucs1002-a_det", info);
> > +		if (ret) {
> > +			dev_err(dev, "failed to request A_DET threaded irq\n");
> > +			return ret;
> > +		}
> > +	}
> +
> > +	if (irq_alert > 0) {
> > +		ret = devm_request_threaded_irq(dev, irq_alert, NULL,
> > +						ucs1002_alert_irq,
> > +						IRQF_TRIGGER_FALLING |
> > +						IRQF_TRIGGER_RISING |
> > +						IRQF_ONESHOT,
> > +						"ucs1002-alert", info);
> > +		if (ret) {
> > +			dev_err(dev, "failed to request ALERT threaded irq\n");
> > +			return ret;
> > +		}
> > +	}

Any reason to explicitly set the IRQ trigger type here? Normally I
would expect this to be set via the DT interrupt specifier.

Regards,
Lucas
