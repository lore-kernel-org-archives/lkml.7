Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4AFC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECC320843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfEOMcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:32:47 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50139 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfEOMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:32:46 -0400
Received: from localhost (unknown [92.184.112.208])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 43E7C20000A;
        Wed, 15 May 2019 12:32:42 +0000 (UTC)
Date:   Wed, 15 May 2019 14:32:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     roman.stratiienko@globallogic.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: test: enable wakeup flags
Message-ID: <20190515123241.GL7622@piout.net>
References: <20190515111436.14513-1-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515111436.14513-1-roman.stratiienko@globallogic.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(You didn't use my correct email address, please update your kernel)

On 15/05/2019 14:14:36+0300, roman.stratiienko@globallogic.com wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Alarmtimer interface uses only the RTC with wekeup flags enabled.
> Allow to use rtc-test driver with alarmtimer interface.
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>  drivers/rtc/rtc-test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
> index 6c5f09c815e8..c839ae575c77 100644
> --- a/drivers/rtc/rtc-test.c
> +++ b/drivers/rtc/rtc-test.c
> @@ -123,6 +123,8 @@ static int test_probe(struct platform_device *plat_dev)
>  
>  	platform_set_drvdata(plat_dev, rtd);
>  
> +	device_init_wakeup(&plat_dev->dev, 1);
> +

The first created RTC doesn't have any alarm, so this must not be done
for all the devices.

Also, this driver will never wake up the platform so I'm not sure it is
relevant to test alarmtimers.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
