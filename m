Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C32C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FD1206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFB6pJd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbfG3SpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:45:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42364 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388284AbfG3So7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:44:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so30505439pgb.9;
        Tue, 30 Jul 2019 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=S1nsXPYcuzBODwWjxf6hbitln4+kPW1L467cooD2L8I=;
        b=hFB6pJd/y1cGg0Uq3nwezCr6y1q77GXcF30vI1RyYjgK6pLzNmWP69AAc2zgnLupD1
         Nat5/Fa3kaRhZEky4MxDWVhI85r6OVA0/srH7tEoNBiO6nNo1GHb5WgsLVomLbAogVpX
         0kkV9n4qSRctRJKL3Wx7/6kUQQf5GESqSpsOuSr8ly3oZU3DC6O3MDAwj21w3pRyooh7
         UCz3WGadcvkZVXsBjyftQOP6gJ5uhOAHs5upJ9avdtDKwPtP9RlJMZXTh8JwJ482BwDi
         JkyKDxs6tQf81UdN0CE2s1Vw4m+u7OTQq0pI9K2ItwOTynY7qRh3wqHTFWzjDge3op4m
         h5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=S1nsXPYcuzBODwWjxf6hbitln4+kPW1L467cooD2L8I=;
        b=H37PowGYspjr2aEiwV9/oj9pIDVr6VLyvZkY9x3k2pZGhKRI3doHiey+BEKyytajTo
         fap5ZqYME7a0ACO7UmPc+aOfo0Jf9DbMqBDy6gI2aWmTwHjrJfeXJ89/JDD0viUhsWDa
         6XTGi5trQf5yUNzyRzunL5Oy9yVn9Li88+HA78YkbMMRHo2uJa792DN6T6oXzSZltewn
         SFOxBzTAMwcjEQp1I9gJxCsFmUK1z2NHkeWUCYauErFPhfHkiR5Dd52d2o8vCldpj6gb
         XdR3IednJECIGhunI3Sn2gUj9Cl0RYEGFurBpsrlMowBNFbzwcZGDS4DbQVgm0+ekkha
         CfXQ==
X-Gm-Message-State: APjAAAVqPlX5yy1SAfom9UzQ0zckDafNLmdoRUqf+TclBcmsbvSn19KS
        HKcjDqx/LffBmI5i0EHkqy0=
X-Google-Smtp-Source: APXvYqwQgWdh4gGyx7yucY0IKdCLcErFc4WxTUvksiqXdhz8KScvJ/e7MBznHOVFwpu+DRxpppdXYg==
X-Received: by 2002:a17:90a:db08:: with SMTP id g8mr114252435pjv.39.1564512298838;
        Tue, 30 Jul 2019 11:44:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l25sm81649037pff.143.2019.07.30.11.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 11:44:58 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:44:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 17/57] hwmon: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190730184457.GA32534@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:15:17AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to hwmon-next.

Guenter

> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/hwmon/jz4740-hwmon.c    | 5 +----
>  drivers/hwmon/npcm750-pwm-fan.c | 4 +---
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
> index bec5befd1d8b..47bed41b55a1 100644
> --- a/drivers/hwmon/jz4740-hwmon.c
> +++ b/drivers/hwmon/jz4740-hwmon.c
> @@ -93,11 +93,8 @@ static int jz4740_hwmon_probe(struct platform_device *pdev)
>  	hwmon->cell = mfd_get_cell(pdev);
>  
>  	hwmon->irq = platform_get_irq(pdev, 0);
> -	if (hwmon->irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get platform irq: %d\n",
> -			hwmon->irq);
> +	if (hwmon->irq < 0)
>  		return hwmon->irq;
> -	}
>  
>  	hwmon->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(hwmon->base))
> diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
> index 09aaefa6fdb8..11a28609da3c 100644
> --- a/drivers/hwmon/npcm750-pwm-fan.c
> +++ b/drivers/hwmon/npcm750-pwm-fan.c
> @@ -967,10 +967,8 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
>  		spin_lock_init(&data->fan_lock[i]);
>  
>  		data->fan_irq[i] = platform_get_irq(pdev, i);
> -		if (data->fan_irq[i] < 0) {
> -			dev_err(dev, "get IRQ fan%d failed\n", i);
> +		if (data->fan_irq[i] < 0)
>  			return data->fan_irq[i];
> -		}
>  
>  		sprintf(name, "NPCM7XX-FAN-MD%d", i);
>  		ret = devm_request_irq(dev, data->fan_irq[i], npcm7xx_fan_isr,
> -- 
> Sent by a computer through tubes
> 
