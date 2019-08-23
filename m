Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45371C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262C9233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395148AbfHWOFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:05:19 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58397 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHWOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:05:17 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 22A26100016;
        Fri, 23 Aug 2019 14:05:14 +0000 (UTC)
Date:   Fri, 23 Aug 2019 16:05:13 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     a.zummo@towertech.it, bruno.thomsen@gmail.com, linux@roeck-us.net,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] rtc: pcf2127: Fix build error without
 CONFIG_WATCHDOG_CORE
Message-ID: <20190823140513.GB9844@piout.net>
References: <20190823124553.19364-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823124553.19364-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2019 20:45:53+0800, YueHaibing wrote:
> If WATCHDOG_CORE is not set, build fails:
> 
> drivers/rtc/rtc-pcf2127.o: In function `pcf2127_probe.isra.6':
> drivers/rtc/rtc-pcf2127.c:478: undefined reference to `devm_watchdog_register_device'
> 
> Add WATCHDOG_CORE Kconfig dependency to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: bbc597561ce1 ("rtc: pcf2127: add watchdog feature support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/rtc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 25af63d..9dce7dc 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -886,6 +886,8 @@ config RTC_DRV_DS3232_HWMON
>  config RTC_DRV_PCF2127
>  	tristate "NXP PCF2127"
>  	depends on RTC_I2C_AND_SPI
> +	depends on WATCHDOG

Definitively not, I fixed it that way:
+       select WATCHDOG_CORE if WATCHDOG


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
