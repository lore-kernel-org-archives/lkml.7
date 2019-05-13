Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CD4C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B052133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfEMKCB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:02:01 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33309 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfEMKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:02:00 -0400
X-Originating-IP: 80.215.106.0
Received: from localhost (unknown [80.215.106.0])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9B95724000F;
        Mon, 13 May 2019 10:01:50 +0000 (UTC)
Date:   Mon, 13 May 2019 12:01:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Message-ID: <20190513100149.w3uvpnuqql4eqwid@flea>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512223955.6lhclj6jr2akmsdx@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190512223955.6lhclj6jr2akmsdx@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 12:39:55AM +0200, Ondřej Jirman wrote:
> > +	/*
> > +	 * clkin = 24MHz
> > +	 * T acquire = clkin / (SUN50I_THS_CTRL0_T_ACQ + 1)
> > +	 *           = 20us
> > +	 */
> > +	regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> > +		     SUN50I_THS_CTRL0_T_ACQ(479));
> > +	/* average over 4 samples */
> > +	regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> > +		     SUN50I_THS_FILTER_EN |
> > +		     SUN50I_THS_FILTER_TYPE(1));
> > +	/* period = (SUN50I_H6_THS_PC_TEMP_PERIOD + 1) * 4096 / clkin; ~10ms */
> > +	regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> > +		     SUN50I_H6_THS_PC_TEMP_PERIOD(58));
>
> Also this math is not all that clear:
>
>   period = (SUN50I_H6_THS_PC_TEMP_PERIOD + 1) * 4096 / clkin; ~10ms
>
> SUN50I_H6_THS_PC_TEMP_PERIOD is a macro with an argument. So how does
> this work?
>
> Also, related to this, I've noticed that you removed the interrupt
> processing from the original driver. Without that you have to make sure
> that OF contains non-zero polling-delay and polling-delay-passive.
>
> Nonzero values are necessary for enabling polling mode of the tz core,
> otherwise tz core will not read values periodically from your driver.
>
> You should documment it in the DT bindings, too. Or keep the interrupt
> handling for THS.

If there's interrupts for this in the H6, yeah we should use them over
polling.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
