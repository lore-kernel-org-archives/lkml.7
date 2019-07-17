Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5929C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8574B2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfGQJHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:07:01 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56183 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQJHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:07:00 -0400
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 34A23240008;
        Wed, 17 Jul 2019 09:06:55 +0000 (UTC)
Date:   Wed, 17 Jul 2019 11:06:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ran Bi <ran.bi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        YT Shen <yt.shen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 2/3] rtc: Add support for the MediaTek MT2712 RTC
Message-ID: <20190717090655.GA21823@piout.net>
References: <20190702032120.16539-1-ran.bi@mediatek.com>
 <20190702032120.16539-3-ran.bi@mediatek.com>
 <20190713211231.GD4732@piout.net>
 <1563353694.19945.33.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563353694.19945.33.camel@mhfsdcap03>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2019 16:54:54+0800, Ran Bi wrote:
> > > +
> > > +/* we map HW YEAR 0 to 1968 not 1970 because 2000 is the leap year */
> > > +#define RTC_MIN_YEAR		1968
> > > +#define RTC_BASE_YEAR		1900
> > > +#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
> > 
> > Do not do that. If this RTC range starts in 200, ths is what the driver
> > has to support, you should not care about dates before 2000. Note that
> > the RTC core can still properly shift the range if it is absolutely
> > necessary.
> > 
> 
> Do we need to care about default alarm date 1970-01-01? Or can I just
> set it to 2000-01-01?
> 

You never have to set a default value. It doesn't add any value versus
an unknown value.

> > > +
> > > +static inline u32 rtc_readl(struct mt2712_rtc *rtc, u32 reg)
> > 
> > Please use a more descriptive prefix than just rtc_.
> > 
> 
> Do you mean it's better to use prefix "mt2712_rtc_"?
> 

Yes.

> > > +
> > > +	/*
> > > +	 * register status was not correct,
> > > +	 * need set time and alarm to default
> > > +	 */
> > > +	if (p1 != RTC_POWERKEY1_KEY || p2 != RTC_POWERKEY2_KEY
> > > +	    || !valid_rtc_time(rtc)) {
> > > +		reset_rtc_time(rtc);
> > 
> > Do not do that. This is valuable information. If the time is invalid,
> > report it as such in read_time and read_alarm. Resetting the time here
> > will lead to more issues later (i.e. userspace is not able to know
> > whether the time is set correctly or not).
> > 
> 
> When RTC's power run out, RTC will lost it's registers value and time
> data at next boot up. We even cannot know what the date and time it
> shows. We want to check this state here and set a default RTC date. Do
> you think it's no need here and the date should be set by system?
> 

If I understand correctly, the POWERKEY register will lose their value.
This means that you know that the time is incorrect. instead of setting
it to a default value and losing that valuable information, simply check
for that in read_time and return EINVAL in that case. then on the next
set_time invocation, you can set the POWERKEY registers and set the time
to a known value.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
