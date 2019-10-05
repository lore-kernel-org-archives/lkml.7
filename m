Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D58AC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 20:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF20620867
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 20:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfJEUF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 16:05:29 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40137 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbfJEUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 16:05:26 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0621D60004;
        Sat,  5 Oct 2019 20:05:21 +0000 (UTC)
Date:   Sat, 5 Oct 2019 22:05:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     u.kleine-koenig@pengutronix.de,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: avoid sleeping early
Message-ID: <20191005200521.GB4254@piout.net>
References: <20190920153906.20887-1-alexandre.belloni@bootlin.com>
 <20190924122147.fojcu5u44letrele@pengutronix.de>
 <20190924202015.EFEBF20640@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924202015.EFEBF20640@mail.kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2019 13:20:15-0700, Stephen Boyd wrote:
> Quoting Uwe  (2019-09-24 05:21:47)
> > On Fri, Sep 20, 2019 at 05:39:06PM +0200, Alexandre Belloni wrote:
> > > Note that this was already discussed a while ago and Arnd said this approach was
> > > reasonable:
> > >   https://lore.kernel.org/lkml/6120818.MyeJZ74hYa@wuerfel/
> > > 
> > >  drivers/clk/at91/clk-main.c |  5 ++++-
> > >  drivers/clk/at91/sckc.c     | 20 ++++++++++++++++----
> > >  2 files changed, 20 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> > > index f607ee702c83..ccd48e7a3d74 100644
> > > --- a/drivers/clk/at91/clk-main.c
> > > +++ b/drivers/clk/at91/clk-main.c
> > > @@ -293,7 +293,10 @@ static int clk_main_probe_frequency(struct regmap *regmap)
> > >               regmap_read(regmap, AT91_CKGR_MCFR, &mcfr);
> > >               if (mcfr & AT91_PMC_MAINRDY)
> > >                       return 0;
> > > -             usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);
> > > +             if (system_state < SYSTEM_RUNNING)
> > > +                     udelay(MAINF_LOOP_MIN_WAIT);
> > > +             else
> > > +                     usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);
> > 
> > Given that this construct is introduced several times, I wonder if we
> > want something like:
> > 
> >         static inline void early_usleep_range(unsigned long min, unsigned long max)
> >         {
> >                 if (system_state < SYSTEM_RUNNING)
> >                         udelay(min);
> >                 else
> >                         usleep_range(min, max);
> >         }
> > 
> 
> Maybe, but I think the intent is to not encourage this behavior? So
> providing a wrapper will make it "easy" and then we'll have to tell
> users to stop calling it. Another idea would be to make usleep_range()
> "do the right thing" and call udelay if the system isn't running. And
> another idea from tlgx[1] is to pull the delay logic into another clk op
> that we can call to see when the enable or prepare is done. That may be
> possible by introducing another clk_ops callback that when present
> indicates we should sleep or delay for so much time while waiting for
> the prepare or enable to complete.
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.11.1606061448010.28031@nanos
> 

Do you want me to implement that now or are you planning to apply the
patch in the meantime ?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
