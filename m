Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DEBC46470
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638AC2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfEQVNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:13:45 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47943 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEQVNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:13:45 -0400
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 069E0240004;
        Fri, 17 May 2019 21:13:36 +0000 (UTC)
Date:   Fri, 17 May 2019 23:13:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] clk: at91: sckc: add support to specify registers
 bit offsets
Message-ID: <20190517211336.GB7685@piout.net>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
 <1557487388-32098-3-git-send-email-claudiu.beznea@microchip.com>
 <20190510213242.GE7622@piout.net>
 <b99b1782-30be-b6b9-0df2-f14125be22ac@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b99b1782-30be-b6b9-0df2-f14125be22ac@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 08:10:34+0000, Claudiu.Beznea@microchip.com wrote:
> >> @@ -69,10 +80,11 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
> >>  	void __iomem *sckcr = osc->sckcr;
> >>  	u32 tmp = readl(sckcr);
> >>  
> >> -	if (tmp & (AT91_SCKC_OSC32BYP | AT91_SCKC_OSC32EN))
> >> +	if (tmp & (AT91_SCKC_OSC32BYP(osc->bits) |
> >> +		   AT91_SCKC_OSC32EN(osc->bits)))
> > 
> > I still find that:
> > 
> > 	if (tmp & (osc->bits->cr_osc32byp | osc->bits->cr_osc32en))
> > 
> > would be shorter and easier to read and still fits on one line.
> 
> Agree, but I thought to use the same interface everywhere. Anyway, tell me
> if you want to resend with these changes.
> 
My comment applies to all the AT91_SCKC_.*() macros. I don't feel that
the macros make the code clearer, accessing bits->cr_.* is self
documenting enough (and makes the code shorter).

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
