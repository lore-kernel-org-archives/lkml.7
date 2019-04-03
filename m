Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA003C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A022084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNx3KIn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDCNSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:18:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45446 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:18:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so8313119pgk.12;
        Wed, 03 Apr 2019 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+C4lSlQByTDMNg8o68cNiQpqPcaeTF9I5BO3xn3kJY=;
        b=FNx3KIn2hcPpA3Eu1CtBcIzkjFvnISQ4KagJv5+BCFIw2CSLifxVCMbV6W6+xpGDRm
         5YTiv5h2DpgBXWkZSU5N5x4BeGK0ADKVyvtzTy+MELIx+o2RhXsGER616eXjQ0XpaF4F
         eeLC8y8WvZx48ULgR+rpmbrWKXHjPwU8mVYf3tAvKuj8iTTnHyZcayJb6NymK/LQJgwx
         jPYBqL9y+VTK7cAqHqRPVdQZTVT2lxXd6p3rUgIpvpW9hZwuwOPZip5a31JDOIP+omk1
         J9C4VZ4mEs+MrcIsOTJizxmi5TDxP5iyblfTd1/UFbSJAw6bsAxdCvUB0vWIY+u/JLaT
         7agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+C4lSlQByTDMNg8o68cNiQpqPcaeTF9I5BO3xn3kJY=;
        b=Z0c8vaqFQCs2V+rI+j8m5JXZtvx25XCuIXxkkgn4WavrHtn09eIG7XiyVD6duO4xOH
         D1ShLgdkk8rRI2pjO9RuD0Ha5XkAj2jfAy8TuBTQlHmB+MmImN41jh0wGxSPew5FTItL
         tS9crGPaDVqVSSxzhbbsIQud2TBM0Gm9tAms/KlzXxzOVdEIIwGcWRz3cG0BXe71b07l
         vG4UmKh8wv7pBdKQ9PtP1Q5S0EdCS7lFWCOccZwvCSFBiQMIInqQtgocd7IIfwIBDNVR
         mgdDplNHg80qlqEQ8Da4QjrKWUXt7OMytw6meGju4jtBc+3Izr9MZkPDgYU3kzeO62PJ
         L+Mw==
X-Gm-Message-State: APjAAAU75LViTMaPqq1IeOlxejstHg2QjfJortIppbxdUQ+9hU7Pa2yb
        aEq6cEHYfWNOEdQorBdse1s=
X-Google-Smtp-Source: APXvYqya+UOdlRz7gi8/RE2wWs4EW5kVigxBbZfqCIFteSmQ3zr7O0ZI2jsK5dvdPq8ZfAdO0p3SuQ==
X-Received: by 2002:aa7:8019:: with SMTP id j25mr76037272pfi.77.1554297523467;
        Wed, 03 Apr 2019 06:18:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k75sm40264975pfj.46.2019.04.03.06.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 06:18:41 -0700 (PDT)
Date:   Wed, 3 Apr 2019 06:18:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, "# 4 . 14" <stable@vger.kernel.org>
Subject: Re: [PATCH] hwmon: pwm-fan: Disable PWM if fetching cooling data
 fails
Message-ID: <20190403131839.GA31325@roeck-us.net>
References: <1554295713-18656-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554295713-18656-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:48:33PM +0200, Stefan Wahren wrote:
> In case pwm_fan_of_get_cooling_data() fails we should disable the PWM
> just like in the other error cases.
> 
> Reported-by: Guenter Rock <linux@roeck-us.net>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 2e5219c77183 ("hwmon: (pwm-fan) Read PWM FAN configuration from device tree")
> Cc: <stable@vger.kernel.org> # 4.14

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 167221c..e4c5197 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -271,7 +271,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
>  	if (ret)
> -		return ret;
> +		goto err_pwm_disable;
>  
>  	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
>  	if (IS_ENABLED(CONFIG_THERMAL)) {
