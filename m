Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A103C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B1320882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfIVTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:06:43 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58321 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439182AbfIVTFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:05:44 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0162360006;
        Sun, 22 Sep 2019 19:05:42 +0000 (UTC)
Date:   Sun, 22 Sep 2019 21:05:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org
Subject: Re: [PATCH v2 1/2] rtc: wilco-ec: Remove yday and wday calculations
Message-ID: <20190922190542.GC3185@piout.net>
References: <20190916181215.501-1-ncrews@chromium.org>
 <20190922161306.GA1999@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190922161306.GA1999@bug>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2019 18:13:06+0200, Pavel Machek wrote:
> On Mon 2019-09-16 12:12:15, Nick Crews wrote:
> > The tm_yday and tm_wday fields are not used by userspace,
> > so since they aren't needed within the driver, don't
> > bother calculating them. This is especially needed since
> > the rtc_year_days() call was crashing if the HW returned
> > an invalid time.
> > 
> > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > ---
> >  drivers/rtc/rtc-wilco-ec.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > index 8ad4c4e6d557..e84faa268caf 100644
> > --- a/drivers/rtc/rtc-wilco-ec.c
> > +++ b/drivers/rtc/rtc-wilco-ec.c
> > @@ -110,10 +110,6 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> >  	tm->tm_mday	= rtc.day;
> >  	tm->tm_mon	= rtc.month - 1;
> >  	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
> > -	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> > -
> > -	/* Don't compute day of week, we don't need it. */
> > -	tm->tm_wday = -1;
> >  
> >  	return 0;
> 
> Are you sure? It would be bad to pass unititialized memory to userspace...
> 

This problem doesn't exist because userspace is passing the memory, not
the other way around.

> If userspace does not need those fields, why are they there?
> 

This is coming from struct tm, it is part of C89 but I think I was not
born when this decision was made. man rtc properly reports that those
fields are unused and no userspace tools are actually making use of
them. Nobody cares about the broken down representation of the time.
What is done is use the ioctl then mktime to have a UNIX timestamp.

"The mktime function ignores the specified contents of the tm_wday,
tm_yday, tm_gmtoff, and tm_zone members of the broken-down time
structure. It uses the values of the other components to determine the
calendar time; it’s permissible for these components to have
unnormalized values outside their normal ranges. The last thing that
mktime does is adjust the components of the brokentime structure,
including the members that were initially ignored."


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
