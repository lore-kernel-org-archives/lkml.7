Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F118BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A452084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfDZOiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:38:25 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40617 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfDZOiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:38:25 -0400
X-Originating-IP: 109.213.12.238
Received: from localhost (alyon-652-1-29-238.w109-213.abo.wanadoo.fr [109.213.12.238])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id F134740008;
        Fri, 26 Apr 2019 14:38:22 +0000 (UTC)
Date:   Fri, 26 Apr 2019 16:38:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     linux-rtc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] rtc: jz4740: switch to
 rtc_time64_to_tm/rtc_tm_to_time64
Message-ID: <20190426143822.GS14604@piout.net>
References: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
 <20190418100045.29288-2-alexandre.belloni@bootlin.com>
 <CA+7wUswt4mEyrrVugOMgjC=jTnQwf1cTeVwd9BtZtApjmo8gGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUswt4mEyrrVugOMgjC=jTnQwf1cTeVwd9BtZtApjmo8gGQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 16:29:36+0200, Mathieu Malaterre wrote:
> On Thu, Apr 18, 2019 at 12:00 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Call the 64bit versions of rtc_tm time conversion now that the range is
> > enforced by the core.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/rtc/rtc-jz4740.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> > index 079469627bd7..15b6832f3931 100644
> > --- a/drivers/rtc/rtc-jz4740.c
> > +++ b/drivers/rtc/rtc-jz4740.c
> > @@ -171,7 +171,7 @@ static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
> >         if (timeout == 0)
> >                 return -EIO;
> >
> > -       rtc_time_to_tm(secs, time);
> > +       rtc_time64_to_tm(secs, time);
> >
> >         return 0;
> >  }
> > @@ -196,7 +196,7 @@ static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> >         alrm->enabled = !!(ctrl & JZ_RTC_CTRL_AE);
> >         alrm->pending = !!(ctrl & JZ_RTC_CTRL_AF);
> >
> > -       rtc_time_to_tm(secs, &alrm->time);
> > +       rtc_time64_to_tm(secs, &alrm->time);
> >
> >         return rtc_valid_tm(&alrm->time);
> >  }
> > @@ -205,9 +205,7 @@ static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> >  {
> >         int ret;
> >         struct jz4740_rtc *rtc = dev_get_drvdata(dev);
> > -       unsigned long secs;
> > -
> > -       rtc_tm_to_time(&alrm->time, &secs);
> > +       unsigned long secs = rtc_tm_to_time64(&alrm->time);
> 
> nitpick: all other declarations are done with uint32_t, so to make it
> clear (maybe) with something like:
> 
> uint32_t secs = lower_32_bits(rtc_tm_to_time64(&alrm->time));
> 

Ok, I'll change that.

> Technically I would have stored the full time64_t here and put a
> WARN_ON(secs > U32_MAX) but I am not sure what other driver are
> supposed to do in this case.
> 

Because range_max is set properly, the core will ensure that all the
times passed to the driver fit within the range.

Thanks for the review!

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
