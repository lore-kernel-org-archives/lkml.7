Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB7220652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PfVr7lF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfDPKML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:12:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54216 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDPKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:12:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so24579636wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DGlPruOQEHBmD2AZlNm9OuKeCKupH6NVbDsAG0Qc7lk=;
        b=PfVr7lF7ZwkNHQ5hLVsUMMJkHDZAemlKNo0XD3O0+ARccmqz8mgUsBghaxgLInwRrW
         2FbxS6VfLAyT0VPclfWNTU/q6psmDZt+IsaM1OBnH3U5se+S/WwipqRH05ggMVJOhljd
         R/WtPdZvygX0xaTjtIKN//AcNtajFHoWQ+GlTt+RdcTM398Lfv6tLa4tyHTa3ybgkQ5x
         A6gZYLdkcW6nzg3HA0LmV1MFFpGPX05cYf2ba85t5SOKh7Ic8g4g5ZB5IFIdJ4lT3DDH
         KHIwTi14ok1z3MN8rPg+R1RWM0Y24j5HMR1C4jD+P8XxZlB5Ku8ih/24JpSviYqiVHDX
         gHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DGlPruOQEHBmD2AZlNm9OuKeCKupH6NVbDsAG0Qc7lk=;
        b=P8/ZXIMQb1t20OI1Py1hFg1gl8laXczct9MV+Hoz7YiJYwqLLAnj3f8O03JEyhe/O4
         Z3mtSCKM2niNA/SFvgkeQs3ynAGX2r86DOZtG5P5BKLLgeSBp1N/XjLFIydq9gVYsmbc
         co52m1ctbfm+6a4YLoC4rRlpUr4hA8MRjNGpbaZzkcxDQOC3ihYBnLiyVyKnnF6gmrOt
         GmIlh7SQLWi3OsEKVW2T/xPoasGFjvjkdvqoe+aSzdiwUv0LZtluyXbA2gm4bUFV7LzD
         mE8oaf34myqwbSQ7OheG74Xnq05xuwiovvcfHp1IanNlOOCWgk4UWHTo+ntHLhtpjTz9
         ggng==
X-Gm-Message-State: APjAAAXWhdg7jn4/v+uOa3W+qO0xhtpL1YmjBKx5v9tqjW7co5CwHGEO
        qK0jkLEQ2S/KmYItiuu8mxX4N0JRnZ8=
X-Google-Smtp-Source: APXvYqx4vKePC7jqgqfdmBOobpj0ah5kUW8T77yM0s/3M8x60wmwwITfe6PNq8zyCWwgwesFqFzIFQ==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr13824966wmc.98.1555409527469;
        Tue, 16 Apr 2019 03:12:07 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id y5sm42626654wrw.23.2019.04.16.03.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 03:12:06 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] thermal: rockchip: add pinctrl control
To:     "elaine.zhang" <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
 <1554100985-11385-2-git-send-email-zhangqing@rock-chips.com>
 <30325add-d75a-6775-50c0-d2d2274ff81e@linaro.org>
 <db977a75-195f-4c98-ef84-aa186b484e0d@rock-chips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6267ffc8-6ca4-86ad-7f87-c669bc9f3454@linaro.org>
Date:   Tue, 16 Apr 2019 12:12:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <db977a75-195f-4c98-ef84-aa186b484e0d@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Elaine,

On 11/04/2019 09:46, elaine.zhang wrote:
> hi,
> 
> 在 2019/4/4 上午11:03, Daniel Lezcano 写道:
>> On 01/04/2019 08:43, Elaine Zhang wrote:
>>> Based on the TSADC Tshut mode to select pinctrl,
>>> instead of setting pinctrl based on architecture
>>> (Not depends on pinctrl setting by "init" or "default").
>>> And it requires setting the tshut polarity before select pinctrl.
>> I'm not sure to fully read the description. Can you rephrase/elaborate
>> the changelog?
> Example:
>         tsadc: tsadc@ff250000 {
>                     compatible = "rockchip,rk3328-tsadc";
>                     .....
>                 pinctrl-names = "init", "default", "sleep";
>                     pinctrl-0 = <&otp_gpio>;
>                     pinctrl-1 = <&otp_out>;
>                     pinctrl-2 = <&otp_gpio>;
>                     status = "disabled";
>                 .....
>             };
>         &tsadc {
>                 rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
>                 status = "okay";
>         };
>     Application on the product, hope tsadc overtemperature reset cru to
> restart.
>     But when pinctrl is initialized, it will setting pinctrl by "init"
> and "default".
>     So the pinctrl will set iomux to "otp_out", which may be make system
> crash.

why?

>     tsadc gpio iomux:
>     "otp_gpio" : just normal gpio, keep default level.
>     "otp_out" : tsadc shut down io, when overtemperature,this io may be
> trigger high
>     level or low level(depend on the tsadc polarity).
> 
>     After correction:
>     if rockchip,hw-tshut-mode = <0>; (tsadc overtemperature reset cru to
> restart)
>     select pinctrl to otp_gpio
>     if rockchip,hw-tshut-mode = <1>;(tsadc overtemperature IO triggers
> output at high or low levels)
>     select pinctrl to otp_out.
>     Actively select iomux based on rockchip,hw-tshut-mode,
>     rather than relying on the pinctrl framework to select iomux.

Let me rephrase it and tell me if I understood correctly:

"When the temperature sensor mode is set to 0, it will automatically
reset the board via the Clock-Reset-Unit (CRU) if the over temperature
threshold is reached. However, when the pinctrl initializes, it does a
transition to "otp_out" which may lead the SoC to crash (why?)

Explicitly use the pinctrl to set/unset the right mode instead of
relying on the pinctrl init mode"

So this patch is a fix and it must contain the Fixes: ... tag.


>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>>> ---
>>>   drivers/thermal/rockchip_thermal.c | 61
>>> +++++++++++++++++++++++++++++++-------
>>>   1 file changed, 50 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rockchip_thermal.c
>>> b/drivers/thermal/rockchip_thermal.c
>>> index 9c7643d62ed7..faa6c7792155 100644
>>> --- a/drivers/thermal/rockchip_thermal.c
>>> +++ b/drivers/thermal/rockchip_thermal.c
>>> @@ -34,7 +34,7 @@
>>>    */
>>>   enum tshut_mode {
>>>       TSHUT_MODE_CRU = 0,
>>> -    TSHUT_MODE_GPIO,
>>> +    TSHUT_MODE_OTP,
>> Why do you change the enum name? The impact on the patch is much higher,
>> no ?
> 
> I just want to make it a little bit more intuitive to understand the
> definition of mode.
> 
> TSHUT_MODE_CRU: pinctrl select iomux to otp_gpio,the io is normal io.
> TSHUT_MODE_OTP: pinctrl select iomux to otp_out, the io is tsadc shut io.

I understand, but at the end the changes for this patch are counter
intuitive, so it is preferable to keep it as is so we can review the
important part.

[ ... ]

>>>   +static void thermal_pinctrl_select_otp(struct
>>> rockchip_thermal_data *thermal)
>>> +{
>>> +    if (!IS_ERR(thermal->pinctrl) &&
>>> !IS_ERR_OR_NULL(thermal->otp_state))
>>> +        pinctrl_select_state(thermal->pinctrl,
>>> +                     thermal->otp_state);
>>> +}
>>> +
>>> +static void thermal_pinctrl_select_gpio(struct rockchip_thermal_data
>>> *thermal)
>>> +{
>>> +    if (!IS_ERR(thermal->pinctrl) &&
>>> !IS_ERR_OR_NULL(thermal->gpio_state))
>>> +        pinctrl_select_state(thermal->pinctrl,
>>> +                     thermal->gpio_state);
>>> +}
>> You should not have to create a couple of specific functions just to
>> check the pinctrl pointers are set. The caller should do that.
> Because there are several places where the call is made,create a couple
> of specific functions reduce a lot of duplicated code.

No, that does not reduce a lot of duplicated code, it hides the fact
there is no control from the caller. See the comments below.

[ ... ]

>>>   static int rockchip_configure_from_dt(struct device *dev,
>>>                         struct device_node *np,
>>>                         struct rockchip_thermal_data *thermal)
>>> @@ -1103,7 +1120,7 @@ static int rockchip_configure_from_dt(struct
>>> device *dev,
>>>       if (of_property_read_u32(np, "rockchip,hw-tshut-mode",
>>> &tshut_mode)) {
>>>           dev_warn(dev,
>>>                "Missing tshut mode property, using default (%s)\n",
>>> -             thermal->chip->tshut_mode == TSHUT_MODE_GPIO ?
>>> +             thermal->chip->tshut_mode == TSHUT_MODE_OTP ?
>>>                   "gpio" : "cru");
>>>           thermal->tshut_mode = thermal->chip->tshut_mode;
>>>       } else {
>>> @@ -1242,6 +1259,8 @@ static int rockchip_thermal_probe(struct
>>> platform_device *pdev)
>>>           return error;
>>>       }
>>>   +    thermal->chip->control(thermal->regs, false);
>>> +
>>>       error = clk_prepare_enable(thermal->clk);
>>>       if (error) {
>>>           dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
>>> @@ -1267,6 +1286,24 @@ static int rockchip_thermal_probe(struct
>>> platform_device *pdev)
>>>       thermal->chip->initialize(thermal->grf, thermal->regs,
>>>                     thermal->tshut_polarity);
>>>   +    if (thermal->tshut_mode == TSHUT_MODE_OTP) {
>>> +        thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
>>> +        if (IS_ERR(thermal->pinctrl))
>>> +            dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
>>> +
>>> +        thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
>>> +                               "gpio");

panic if devm_pinctrl_get fails.

>>> +        if (IS_ERR_OR_NULL(thermal->gpio_state))
>>> +            dev_err(&pdev->dev, "failed to find thermal gpio state\n");
>>> +
>>> +        thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
>>> +                              "otpout");
>>> +        if (IS_ERR_OR_NULL(thermal->otp_state))
>>> +            dev_err(&pdev->dev, "failed to find thermal otpout
>>> state\n");
>> What is the meaning for the rest of the code if the lookup fails for any
>> of those ?
> If the lookup fails for any of those， The pinctrl is no longer set and
> remains in its default state(otp_gpio normal io).
>>
>>> +        thermal_pinctrl_select_otp(thermal);
>>> +    }
>>> +

It is pointless to have a otp_state and a gpio_state field. Just use one
as the configuration tells you which lookup to do.

In case of error, just bail out. It is pointless to continue with a
broken configuration.

	thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
	if (IS_ERR(thermal->pinctrl)) {
		dev_err(&pdev->dev, "....");
		return PTR_ERR(thermal->pinctrl);
	}

	thermal->pinctrl_state =
		pinctrl_lookup_state(thermal->pinctrl,
			thermal->tshut_mode == TSHUT_MODE_OTP ?
			"otp" : "gpio");

	if (IS_ERR_OR_NULL(thermal->pinctrl_state)) {
		dev_err(&pdev->dev, "....");
		return -EINVAL;
	}


No need to use the thermal_pinctrl_select_otp/gpio wrappers, just
replace them with:

pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);

and use it unconditionally.


>>>       for (i = 0; i < thermal->chip->chn_num; i++) {
>>>           error = rockchip_thermal_register_sensor(pdev, thermal,
>>>                           &thermal->sensors[i],
>>> @@ -1338,7 +1375,8 @@ static int __maybe_unused
>>> rockchip_thermal_suspend(struct device *dev)
>>>       clk_disable(thermal->pclk);
>>>       clk_disable(thermal->clk);
>>>   -    pinctrl_pm_select_sleep_state(dev);
>>> +    if (thermal->tshut_mode == TSHUT_MODE_OTP)
>>> +        thermal_pinctrl_select_gpio(thermal);
>>>         return 0;
>>>   }
>>> @@ -1383,7 +1421,8 @@ static int __maybe_unused
>>> rockchip_thermal_resume(struct device *dev)
>>>       for (i = 0; i < thermal->chip->chn_num; i++)
>>>           rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>>>   -    pinctrl_pm_select_default_state(dev);
>>> +    if (thermal->tshut_mode == TSHUT_MODE_OTP)
>>> +        thermal_pinctrl_select_otp(thermal);
>>>         return 0;
>>>   }
>>>
>>
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

