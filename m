Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0080420675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ke6yJck4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfFTN4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:56:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33678 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfFTN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:56:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so6986094wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lFm7NdIa2HHNh0HHo0ufCJYY4GiimW3KQmJfZuX/+1A=;
        b=Ke6yJck4jVgEhh/tKvRzf4ORtRvDLepDlBQG7G/hYzHQMzbUIg7HdjRx50Eut9YlBw
         XY4sV2dTy/Xj36F66LMAAEym59Oa53iPPeBZJXoKXqxrnOUH+dOUJd32WQGYDfM7opNG
         J3AjnSL2NiTS/ThA75UTKJa/nPmqpEnSbFnhay98AkR/l4+yfCNwdC5HNQ+/4YTQl8Wr
         Y68y8KszF3i3UrkHx0aWzS8lD9GISUTkuGIzCvCgEnXLAHz93/VkIhqB+tBasCXhJ5WC
         4GIPtssQwjmmvH3+bRDbRGyrgyJTcexbC8Xb10toGo0T4GB4mgKNHy4+gIGl6fV5wWBZ
         auMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lFm7NdIa2HHNh0HHo0ufCJYY4GiimW3KQmJfZuX/+1A=;
        b=Jruv30Vt8/Z0BTAlvvkLXZmMTKp8pK0lgmfQ7CLwof7nzlLJHuqNsYTLzpUG4tbSI8
         Wizc1SbdTExpUfY1dYdBgr8fpry944cnjHrqxm274V3zWpLFsTuV0sY5FIQpU054q/I+
         UBHtLlyk7e1VUo4nfbM2Po515TEonDcVrBz8Jk/oEKKwEJSM59X2IQzRhmiEoOQPRSgR
         pKDuq5V/3mmT54pr4iLRBLG8RcWN6tQ2SFHLI6oyveASBo32LZItdU8LBXgPNOPuxFDl
         q4+0noOwTgJ3CTELmsyZSa1qVQ0CqBLaL1lKzutOEydhXIcu1q1h7V/YaYwOrjVF18nw
         EqoA==
X-Gm-Message-State: APjAAAUp8UVIp0DCcMc0Mgo83hyP8+zFYQNoe3CW2oaOJKMhiTggdOEl
        6NdSu1uPFfSvaotxHmb83//1bQ==
X-Google-Smtp-Source: APXvYqw2i7LeGM36+7/WxrmFj2jyg/Rfps966Iqc9Kr0ftD/oKO7Uqgzi6rVFaEgRy0R5VxDX5/biw==
X-Received: by 2002:a1c:6156:: with SMTP id v83mr3145978wmb.81.1561038987399;
        Thu, 20 Jun 2019 06:56:27 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id d18sm36948937wrb.90.2019.06.20.06.56.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:56:26 -0700 (PDT)
Subject: Re: Re: [PATCH] backlight: gpio-backlight: Set power state instead of
 brightness at probe
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20190517150546.4508-1-paul.kocialkowski@bootlin.com>
 <bee40295b2c6b489468d4e1fc12d7a1ac122cb9b.camel@bootlin.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <29712212-0567-702b-fbc9-c0f37806d84c@linaro.org>
Date:   Thu, 20 Jun 2019 14:56:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bee40295b2c6b489468d4e1fc12d7a1ac122cb9b.camel@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 13:58, Paul Kocialkowski wrote:
> Hi,
> 
> On Fri, 2019-05-17 at 17:05 +0200, Paul Kocialkowski wrote:
>> On a trivial gpio-backlight setup with a panel using the backlight but
>> no boot software to enable it beforehand, we fall in a case where the
>> backlight is disabled (not just blanked) and thus remains disabled when
>> the panel gets enabled.
>>
>> Setting gbl->def_value via the device-tree prop allows enabling the
>> backlight in this situation, but it will be unblanked straight away,
>> in compliance with the binding. This does not work well when there was no
>> boot software to display something before, since we really need to unblank
>> by the time the panel is enabled, not before.
>>
>> Resolve the situation by setting the brightness to 1 at probe and
>> managing the power state accordingly, a bit like it's done in
>> pwm-backlight.
> 
> Any feedback on this? I was under the impression that it could be quite
> controversial, as it implies that the backlight can no longer be
> enabled without a bound panel (which IMO makes good sense but could be
> a matter to debate).

My apologies. This patch brought on such severe deja-vu I got rather 
confused. Then when I went digging I've also dropped the ball on the 
same feature previously.

Peter Ujfalusi provided a similar patch to yours but with a slightly 
different implementation:
https://lore.kernel.org/patchwork/patch/1002359/

On the whole I think it is important to read the GPIO pin since 
otherwise we swap problems when there bootloader does setup the 
backlight for problems where it does not.

The thing I don't get is why both patches try to avoid setting the 
backlight brightness from def_value. Simple displays, especially 
monochrome ones are perfectly readable with the backlight off... zero 
brightness is not a "bad" value.

Not sure if Peter is still willing to rev his version of this code 
(given how badly we neglected him previously) or whether you want to try 
and combine both ideas.


Daniel.


> 
> Cheers,
> 
> Paul
> 
>> Fixes: 8b770e3c9824 ("backlight: Add GPIO-based backlight driver")
>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> ---
>>   drivers/video/backlight/gpio_backlight.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>> index e470da95d806..c9cb97fa13d0 100644
>> --- a/drivers/video/backlight/gpio_backlight.c
>> +++ b/drivers/video/backlight/gpio_backlight.c
>> @@ -57,6 +57,21 @@ static const struct backlight_ops gpio_backlight_ops = {
>>   	.check_fb	= gpio_backlight_check_fb,
>>   };
>>   
>> +static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
>> +{
>> +	struct device_node *node = gbl->dev->of_node;
>> +
>> +	/* If we absolutely want the backlight enabled at boot. */
>> +	if (gbl->def_value)
>> +		return FB_BLANK_UNBLANK;
>> +
>> +	/* If there's no panel to unblank the backlight later. */
>> +	if (!node || !node->phandle)
>> +		return FB_BLANK_UNBLANK;
>> +
>> +	return FB_BLANK_POWERDOWN;
>> +}
>> +
>>   static int gpio_backlight_probe_dt(struct platform_device *pdev,
>>   				   struct gpio_backlight *gbl)
>>   {
>> @@ -142,7 +157,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>   		return PTR_ERR(bl);
>>   	}
>>   
>> -	bl->props.brightness = gbl->def_value;
>> +	bl->props.brightness = 1;
>> +	bl->props.power = gpio_backlight_initial_power_state(gbl);
>> +
>>   	backlight_update_status(bl);
>>   
>>   	platform_set_drvdata(pdev, bl);

