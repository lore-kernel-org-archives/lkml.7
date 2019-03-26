Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E811C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F5220823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfCZOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:06:00 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35011 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCZOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:05:59 -0400
Received: from localhost (alyon-652-1-47-144.w109-213.abo.wanadoo.fr [109.213.38.144])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 13F9F200013;
        Tue, 26 Mar 2019 14:05:52 +0000 (UTC)
Date:   Tue, 26 Mar 2019 15:05:52 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH v11 6/8] rtc: bd70528: Initial support for ROHM bd70528
 RTC
Message-ID: <20190326140552.GS30105@piout.net>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <901900e12e2a06865b3649ec94af511fcc6443a3.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190325170451.GQ30105@piout.net>
 <1db28c6d6223f2c052c0853121fd7b7aa6f7b227.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db28c6d6223f2c052c0853121fd7b7aa6f7b227.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 13:51:40+0000, Vaittinen, Matti wrote:
> On Mon, 2019-03-25 at 18:04 +0100, Alexandre Belloni wrote:
> > On 25/03/2019 14:06:42+0200, Matti Vaittinen wrote:
> > > Support RTC block in ROHM bd70528 power management IC. Support
> > > getting and setting the time and date as well as arming an alarm
> > > which can also be used to wake the PMIC from standby state.
> > > 
> > > HW supports wake interrupt only for the next 24 hours (sec, minute
> > > and hour information only) so we limit also the alarm interrupt to
> > > this 24 hours for the sake of consistency.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > 
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > 
> > > +	r->time.hour |= BD70528_MASK_RTC_HOUR_24H;
> > > +	r->day |= bin2bcd(t->tm_mday);
> > > +	r->week |= bin2bcd(t->tm_wday);
> > > +	r->month |= bin2bcd(t->tm_mon + 1);
> > > +	r->year = bin2bcd(t->tm_year-100);
> > 
> > If you ever have to resend, please add spaces around that -
> 
> Good catch, thanks! I wonder why I didn't get checkpatch warning... I
> should've had one. (I usually do run checkpatch).
> 

checkpatch --strict would tell you.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
