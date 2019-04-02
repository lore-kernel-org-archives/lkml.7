Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38225C10F0C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1249A207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfDBJvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:51:20 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:39269 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfDBJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:51:19 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 64EC32000D;
        Tue,  2 Apr 2019 09:51:16 +0000 (UTC)
Date:   Tue, 2 Apr 2019 11:51:15 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190402095115.GW3430@piout.net>
References: <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai>
 <20190401185346.GP3430@piout.net>
 <20190401193424.sqnapthocznhjqok@ninjato>
 <20190402085325.GT3430@piout.net>
 <20190402093359.GB2960@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402093359.GB2960@kunai>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 11:33:59+0200, Wolfram Sang wrote:
> Hi Alexandre,
> 
> > I had a look at the driver and I guess you have a 9063AD while Steve
> > uses another model.
> > 
> > That explains why you need the uie_unsupported flag. The 9063AD can only
> > do alarms on a minute boundary.
> 
> Bingo! Nice catch. I was on the wrong track because we have an early
> boot quirk handling for the DA on this platform and I was searching
> there for side effects. Makes all sense now. Thanks a lot for your help!
> 
> > Since the move to hr_timer, the uie are done using the classic alarm or
> > they are emulated by the core. This improved the situation for many RTCs
> > that don't have a separate UIE but this made it worse for a few (and
> > this is an example). I have plan to work on this but didn't have the
> > time yet.
> 
> I understand. That explains why my RTC knowledge from a few years ago
> feels so outdated :)
> 
> > I suggest the following patch:
> > 
> > ===
> > 
> > From 37b2ab7d537e76e42bde64cf4b57701b0ed8e8cd Mon Sep 17 00:00:00 2001
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Date: Tue, 2 Apr 2019 10:06:46 +0200
> > Subject: [PATCH] rtc: da9063: set uie_unsupported when relevant
> > 
> > The DA9063AD doesn't support alarms on any seconds and its granularity is
> > the minute. Set uie_unsupported in that case.
> > 
> > Reported-by: Wolfram Sang <wsa@the-dreams.de>
> 
> Please use this address:
> 
> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> And probably Geert wants his "+renesas" address, too:
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/rtc/rtc-da9063.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
> > index 1b792bcea3c7..53e690b0f3a2 100644
> > --- a/drivers/rtc/rtc-da9063.c
> > +++ b/drivers/rtc/rtc-da9063.c
> > @@ -475,6 +475,9 @@ static int da9063_rtc_probe(struct platform_device *pdev)
> >  	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
> >  	rtc->rtc_sync = false;
> >  
> > +	if (config->rtc_data_start != RTC_SEC)
> > +		rtc->rtc_dev->uie_unsupported = 1;
> > +
> 
> I think we should have a comment here, like:
> 
> /* FIXME: Make use of the TICK interrupt once the RTC core supports it */
> 

Well, My plan is to go over all the uie_unsupported users once the
infrastructure is in place but I'll put a comment there.

> So, this helps the UIE test:
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> And I guess we have to live with two of the alarm tests failing because
> of the minute granularity?
> 
> Regards,
> 
>    Wolfram
> 



-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
