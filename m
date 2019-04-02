Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F89C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912FA20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfDBIx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:53:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44423 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:53:29 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C969520006;
        Tue,  2 Apr 2019 08:53:25 +0000 (UTC)
Date:   Tue, 2 Apr 2019 10:53:25 +0200
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
Message-ID: <20190402085325.GT3430@piout.net>
References: <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai>
 <20190401185346.GP3430@piout.net>
 <20190401193424.sqnapthocznhjqok@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401193424.sqnapthocznhjqok@ninjato>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 21:34:25+0200, Wolfram Sang wrote:
> 
> > Well, seeing the code, I actually remembered that this test is still
> > there to ensure the core will properly block. If you remove that test,
> > the other ones should all timeout.
> 
> Thanks for your assistance! What I did just now was to make use of the
> 'uie_unsupported' flag. This is the outcome:
> 
> 
> [==========] Running 7 tests from 2 test cases.
> [ RUN      ] rtc.date_read
> rtctest.c:49:rtc.date_read:Current RTC date/time is 01/01/2000 00:13:23.
> [       OK ] rtc.date_read
> [ RUN      ] rtc.uie_read
> [       OK ] rtc.uie_read
> [ RUN      ] rtc.uie_select
> [       OK ] rtc.uie_select
> [ RUN      ] rtc.alarm_alm_set
> rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 00:13:32.
> rtctest.c:148:rtc.alarm_alm_set:Expected 0 (0) != rc (0)
> rtc.alarm_alm_set: Test terminated by assertion
> [     FAIL ] rtc.alarm_alm_set
> [ RUN      ] rtc.alarm_wkalm_set
> rtctest.c:195:rtc.alarm_wkalm_set:Alarm time now set to 01/01/2000
> 00:13:37.
> rtctest.c:202:rtc.alarm_wkalm_set:Expected 0 (0) != rc (0)
> rtc.alarm_wkalm_set: Test terminated by assertion
> [     FAIL ] rtc.alarm_wkalm_set
> [ RUN      ] rtc.alarm_alm_set_minute
> rtctest.c:239:rtc.alarm_alm_set_minute:Alarm time now set to 00:14:00.
> rtctest.c:258:rtc.alarm_alm_set_minute:data: 1a0
> [       OK ] rtc.alarm_alm_set_minute
> [ RUN      ] rtc.alarm_wkalm_set_minute
> rtctest.c:297:rtc.alarm_wkalm_set_minute:Alarm time now set to
> 01/01/2000 00:15:00.
> [       OK ] rtc.alarm_wkalm_set_minute
> [==========] 5 / 7 tests passed.
> [  FAILED  ]
> 
> I wonder why the_set_minute tests pass, but the other ones fail. I also
> wonder why I need the uie_unsupported flag? It's been a while since I
> dug into the RTC subsystem, I may be missing something. But I see the
> UIE code finally calling into set_alarm for some codepath. We have that
> for DA9063, but it is not executed for the UIE test of rtctest. However,
> it seems the driver doesn't support this in an optimal way, because
> there is a currently unused update interrupt which should be used for
> UIE, or? I also wonder why all this works fine for Steve.
> 

I had a look at the driver and I guess you have a 9063AD while Steve
uses another model.

That explains why you need the uie_unsupported flag. The 9063AD can only
do alarms on a minute boundary.

Since the move to hr_timer, the uie are done using the classic alarm or
they are emulated by the core. This improved the situation for many RTCs
that don't have a separate UIE but this made it worse for a few (and
this is an example). I have plan to work on this but didn't have the
time yet.

I suggest the following patch:

===

From 37b2ab7d537e76e42bde64cf4b57701b0ed8e8cd Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 2 Apr 2019 10:06:46 +0200
Subject: [PATCH] rtc: da9063: set uie_unsupported when relevant

The DA9063AD doesn't support alarms on any seconds and its granularity is
the minute. Set uie_unsupported in that case.

Reported-by: Wolfram Sang <wsa@the-dreams.de>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-da9063.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 1b792bcea3c7..53e690b0f3a2 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -475,6 +475,9 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
 	rtc->rtc_sync = false;
 
+	if (config->rtc_data_start != RTC_SEC)
+		rtc->rtc_dev->uie_unsupported = 1;
+
 	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
 	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
 					da9063_alarm_event,
-- 
2.20.1


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
