Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FE3C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F6D206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blQLHqQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDKTct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:32:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40095 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:32:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so3929980pfc.7;
        Thu, 11 Apr 2019 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9XE1ib70CTBCSJF1AkKgPieTl/mYKPumX5XUQ7K4E/8=;
        b=blQLHqQvBq+O9L7KTuFQmZM9goy3qi59JqpJZbwpVdgiR3SMu+6lN57yOukdqz4F8D
         xJf4JUg9SSeQXENYohhFqAAkisUKl+3iVl49Qis/Ys61zlraymssdk9KGlP3LJAbZ1sq
         IvMtfdlrb0Xg+sFMQwnfo30tRtcVxJf6X7i7vawICEeffjaq0yL6BNw+sjgNVIxicG/j
         gLGQRLQIojp2m686esB1GgBx+9KlcPhvVJy9l8z/VQ3AxCO2Zh8ZENht15OBhkeumh1v
         kXQUT5hVoOPUpG0UYMb1RBxQmxWomVf8vBOCuEQOd941wLQu+4g3bM4iKj+9oJqBq7ta
         Xzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9XE1ib70CTBCSJF1AkKgPieTl/mYKPumX5XUQ7K4E/8=;
        b=Gwg+k6sxFEWGNtHV+E4YuioyHWXHOqiBuabLV2S4DFInM4tLnYkUQEEw0VqT8J+a3r
         2Wtt19SWL3nyKHiNeTo7Fbifrq2Y58//iAvnyrezx7NUnGvxUm3C/1IV3Hga3EUN5eGq
         6disesYlcsufxjWLcFc5rEcQK4NSSV5rdxZIjOySm/BE3tw/IaFCWCsJVhujpNtPxr7N
         EGAmibCEu9dtNvbeP8PEuBevfrCzHb7nKmGTC9rdepeGyyCMzsOdACGqz4czR0cVdQnD
         3rWsMoKm2yyll2mIOIfR/1OwQcgDYAEJ6I4q4MnBUHg1+YZZxSogqJQsa9fzk1Cxun2d
         laVg==
X-Gm-Message-State: APjAAAVGcHVF+uP6wS7JQOzUyZtnW2YGtiixwbdD02N6u0cGmetuebjR
        soRkG/IPw1l/gKu1Mh66MjY=
X-Google-Smtp-Source: APXvYqy6Ba4+foRyMZv/a7l+tqCVbPsa5UFcKncFOYADaM0FY91MvYHXO5TZJ2w+iM0JLp2db86zoA==
X-Received: by 2002:aa7:8252:: with SMTP id e18mr51335183pfn.105.1555011167940;
        Thu, 11 Apr 2019 12:32:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s12sm63433920pgc.28.2019.04.11.12.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 12:32:46 -0700 (PDT)
Date:   Thu, 11 Apr 2019 12:32:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: pnx4008: readout watchdog state
Message-ID: <20190411193245.GA1742@roeck-us.net>
References: <20190411191437.12173-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411191437.12173-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 09:14:37PM +0200, Alexandre Belloni wrote:
> Readout the enabled state so it is possible to get the pre-userspace
> handler working. Also, avoid disabling the watchdog to ensure it continues
> working and triggers if there is an issue later in the boot or if userspace
> fails to start.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/pnx4008_wdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index 8e261799c84e..4ce0389d1442 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -209,7 +209,8 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
>  	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
>  	watchdog_set_restart_priority(&pnx4008_wdd, 128);
>  
> -	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
> +	if (readl(WDTIM_CTRL(wdt_base)) & COUNT_ENAB)
> +		set_bit(WDOG_HW_RUNNING, &pnx4008_wdd.status);
>  
>  	ret = watchdog_register_device(&pnx4008_wdd);
>  	if (ret < 0) {
> -- 
> 2.20.1
> 
