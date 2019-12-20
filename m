Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39913C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E76E2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfLTJSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:18:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49918 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTJS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:18:29 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 401c98b8ae270856; Fri, 20 Dec 2019 10:18:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / sleep: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Fri, 20 Dec 2019 10:18:27 +0100
Message-ID: <1750207.ZPif39L95I@kreacher>
In-Reply-To: <20191210170540.3006422-1-alexandre.belloni@bootlin.com>
References: <20191210170540.3006422-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 10, 2019 6:05:40 PM CET Alexandre Belloni wrote:
> Call the 64bit versions of rtc_tm time conversion to avoid the y2038 issue.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  kernel/power/suspend_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
> index 60564b58de07..e1ed58adb69e 100644
> --- a/kernel/power/suspend_test.c
> +++ b/kernel/power/suspend_test.c
> @@ -70,7 +70,7 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
>  	static char info_test[] __initdata =
>  		KERN_INFO "PM: test RTC wakeup from '%s' suspend\n";
>  
> -	unsigned long		now;
> +	time64_t		now;
>  	struct rtc_wkalrm	alm;
>  	int			status;
>  
> @@ -81,10 +81,10 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
>  		printk(err_readtime, dev_name(&rtc->dev), status);
>  		return;
>  	}
> -	rtc_tm_to_time(&alm.time, &now);
> +	now = rtc_tm_to_time64(&alm.time);
>  
>  	memset(&alm, 0, sizeof alm);
> -	rtc_time_to_tm(now + TEST_SUSPEND_SECONDS, &alm.time);
> +	rtc_time64_to_tm(now + TEST_SUSPEND_SECONDS, &alm.time);
>  	alm.enabled = true;
>  
>  	status = rtc_set_alarm(rtc, &alm);
> 

Applied (with a slightly modified changelog) as 5.6 material, thanks!




