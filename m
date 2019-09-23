Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F15C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DA2206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbfIWVeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:34:08 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37261 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388117AbfIWVeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:34:07 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6F140200005;
        Mon, 23 Sep 2019 21:34:04 +0000 (UTC)
Date:   Mon, 23 Sep 2019 23:34:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] clk: at91: avoid sleeping early
Message-ID: <20190923213403.GF4141@piout.net>
References: <20190920153906.20887-1-alexandre.belloni@bootlin.com>
 <20190923165848.3108A20882@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923165848.3108A20882@mail.kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2019 09:58:47-0700, Stephen Boyd wrote:
> Quoting Alexandre Belloni (2019-09-20 08:39:06)
> > It is not allowed to sleep to early in the boot process and this may lead
> > to kernel issues if the bootloader didn't prepare the slow clock and main
> > clock.
> > 
> > This results in the following error and dump stack on the AriettaG25:
> >    bad: scheduling from the idle thread!
> > 
> > Ensure it is possible to sleep, else simply have a delay.
> > 
> > Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> > 
> > Note that this was already discussed a while ago and Arnd said this approach was
> > reasonable:
> >   https://lore.kernel.org/lkml/6120818.MyeJZ74hYa@wuerfel/
> 
> Does this need a Fixes: tag?
> 

I'm not sure how far this can get backported

Fixes: 80eded6ce8bb ("clk: at91: add slow clks driver")


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
