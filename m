Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6010220856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfDBKmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:42:37 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37455 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbfDBKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:42:34 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F05541BF209;
        Tue,  2 Apr 2019 10:42:30 +0000 (UTC)
Date:   Tue, 2 Apr 2019 12:42:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190402104230.GY3430@piout.net>
References: <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai>
 <20190401185346.GP3430@piout.net>
 <20190401193424.sqnapthocznhjqok@ninjato>
 <20190402085325.GT3430@piout.net>
 <20190402093359.GB2960@kunai>
 <20190402095115.GW3430@piout.net>
 <DB7PR10MB2348398516E5744F4CF8C18BFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR10MB2348398516E5744F4CF8C18BFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 10:33:37+0000, Steve Twiss wrote:
> Hi,
> 
> > > >  drivers/rtc/rtc-da9063.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
> > > > index 1b792bcea3c7..53e690b0f3a2 100644
> > > > --- a/drivers/rtc/rtc-da9063.c
> > > > +++ b/drivers/rtc/rtc-da9063.c
> > > > @@ -475,6 +475,9 @@ static int da9063_rtc_probe(struct platform_device *pdev)
> > > >  	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
> > > >  	rtc->rtc_sync = false;
> > > >
> > > > +	if (config->rtc_data_start != RTC_SEC)
> > > > +		rtc->rtc_dev->uie_unsupported = 1;
> > > > +
> > >
> > > I think we should have a comment here, like:
> > > /* FIXME: Make use of the TICK interrupt once the RTC core supports it */
> 
> Is this TICK interrupt suggestion to use the DA9063 TICK interrupt to simulate
> a second granularity in the AD alarm?
> 
> If I remember correctly, the original DA9063 patch set which was for AD silicon
> only, and which was sent to LKML before I took over looking at DA9063, used the
> DA9063 1-second TICK interrupt to count-down the seconds from the nearest
> minute in order to simulate second resolution on the RTC alarm for AD.
> 
> ... yes. Here it is. The original patch was from Krystian Garbaciak and tried to
> support RTC alarms on the AD silicon to a second resolution by counting down
> the DA9063 TICK interrupt:
> 
> https://marc.info/?l=lm-sensors&m=134613501230005&w=2
> 
> However, I dropped that patch completely and wrote a new RTC device driver
> because it didn't work in my tests.
> 
> The problem was: the TICK interrupt was indistinguishable from the ALARM
> interrupt for a wake event and when I tested AD silicon to wake up an Android
> device from suspend or power-off using the RTC IRQ, the device woke up on the
> ALARM minute (0 seconds), discovered it was not the correct time and immediately
> went back to sleep. Then it woke-up and returned back to sleep every TICK IRQ
> second until the correct alarm time was reached (up to 59 times!). At which point
> it woke up properly.
> 

No, the suggestion is to use the TICK interrupt to have a proper UIE
support even if the alarm has a minute granularity. As stated, this is
not yet supported by the core and need some work. Some RTCs have the
following in their set_alarm:

	if (tm->time.tm_sec) {
		time64_t alarm_time = rtc_tm_to_time64(&tm->time);

		alarm_time += 60 - tm->time.tm_sec;
		rtc_time64_to_tm(alarm_time, &tm->time);
	}

But my plan is to actually expose the capability to userspace and the
core so this doesn't have to be handled in the driver.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
