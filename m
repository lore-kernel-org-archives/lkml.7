Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46270C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB2E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfDQDaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:30:06 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:52058 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfDQDaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:30:06 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 23:30:02 EDT
Received: from zhangqing?rock-chips.com (unknown [192.168.167.43])
        by lucky1.263xmail.com (Postfix) with ESMTP id B7BCB2F584;
        Wed, 17 Apr 2019 11:22:56 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 0
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30916T140176444028672S1555471374916933_;
        Wed, 17 Apr 2019 11:22:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <020b41a7e80fdb0536edcef5a9450d35>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v1 1/3] thermal: rockchip: add pinctrl control
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
 <1554100985-11385-2-git-send-email-zhangqing@rock-chips.com>
 <30325add-d75a-6775-50c0-d2d2274ff81e@linaro.org>
 <db977a75-195f-4c98-ef84-aa186b484e0d@rock-chips.com>
 <6267ffc8-6ca4-86ad-7f87-c669bc9f3454@linaro.org>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <659a1c49-71e6-ab76-1ec1-b4f6c2843650@rock-chips.com>
Date:   Wed, 17 Apr 2019 11:22:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6267ffc8-6ca4-86ad-7f87-c669bc9f3454@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

在 2019/4/16 下午6:12, Daniel Lezcano 写道:
> Hi Elaine,
>
> On 11/04/2019 09:46, elaine.zhang wrote:
>> hi,
>>
>> 在 2019/4/4 上午11:03, Daniel Lezcano 写道:
>>> On 01/04/2019 08:43, Elaine Zhang wrote:
>>>> Based on the TSADC Tshut mode to select pinctrl,
>>>> instead of setting pinctrl based on architecture
>>>> (Not depends on pinctrl setting by "init" or "default").
>>>> And it requires setting the tshut polarity before select pinctrl.
>>> I'm not sure to fully read the description. Can you rephrase/elaborate
>>> the changelog?
>> Example:
>>          tsadc: tsadc@ff250000 {
>>                      compatible = "rockchip,rk3328-tsadc";
>>                      .....
>>                  pinctrl-names = "init", "default", "sleep";
>>                      pinctrl-0 = <&otp_gpio>;
>>                      pinctrl-1 = <&otp_out>;
>>                      pinctrl-2 = <&otp_gpio>;
>>                      status = "disabled";
>>                  .....
>>              };
>>          &tsadc {
>>                  rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
>>                  status = "okay";
>>          };
>>      Application on the product, hope tsadc overtemperature reset cru to
>> restart.
>>      But when pinctrl is initialized, it will setting pinctrl by "init"
>> and "default".
>>      So the pinctrl will set iomux to "otp_out", which may be make system
>> crash.
> why?
This "otp_out" IO may be connected to the RESET circuit on the hardware. 
If the IO is in the wrong state, it will trigger RESET (similar to the 
effect of pressing the RESET button), which will cause the system to 
restart all the time.
>
>>      tsadc gpio iomux:
>>      "otp_gpio" : just normal gpio, keep default level.
>>      "otp_out" : tsadc shut down io, when overtemperature,this io may be
>> trigger high
>>      level or low level(depend on the tsadc polarity).
>>
>>      After correction:
>>      if rockchip,hw-tshut-mode = <0>; (tsadc overtemperature reset cru to
>> restart)
>>      select pinctrl to otp_gpio
>>      if rockchip,hw-tshut-mode = <1>;(tsadc overtemperature IO triggers
>> output at high or low levels)
>>      select pinctrl to otp_out.
>>      Actively select iomux based on rockchip,hw-tshut-mode,
>>      rather than relying on the pinctrl framework to select iomux.
> Let me rephrase it and tell me if I understood correctly:
>
> "When the temperature sensor mode is set to 0, it will automatically
> reset the board via the Clock-Reset-Unit (CRU) if the over temperature
> threshold is reached. However, when the pinctrl initializes, it does a
> transition to "otp_out" which may lead the SoC to crash (why?)
>
> Explicitly use the pinctrl to set/unset the right mode instead of
> relying on the pinctrl init mode"
This explanation is correct.
>
> So this patch is a fix and it must contain the Fixes: ... tag.
OK, I'll fix that in the v2.
>
>
>>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>>>> ---
>>>>    drivers/thermal/rockchip_thermal.c | 61
>>>> +++++++++++++++++++++++++++++++-------
>>>>    1 file changed, 50 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/rockchip_thermal.c
>>>> b/drivers/thermal/rockchip_thermal.c
>>>> index 9c7643d62ed7..faa6c7792155 100644
>>>> --- a/drivers/thermal/rockchip_thermal.c
>>>> +++ b/drivers/thermal/rockchip_thermal.c
>>>> @@ -34,7 +34,7 @@
>>>>     */
>>>>    enum tshut_mode {
>>>>        TSHUT_MODE_CRU = 0,
>>>> -    TSHUT_MODE_GPIO,
>>>> +    TSHUT_MODE_OTP,
>>> Why do you change the enum name? The impact on the patch is much higher,
>>> no ?
>> I just want to make it a little bit more intuitive to understand the
>> definition of mode.
>>
>> TSHUT_MODE_CRU: pinctrl select iomux to otp_gpio,the io is normal io.
>> TSHUT_MODE_OTP: pinctrl select iomux to otp_out, the io is tsadc shut io.
> I understand, but at the end the changes for this patch are counter
> intuitive, so it is preferable to keep it as is so we can review the
> important part.
>
> [ ... ]
OK, keep the enum name. I'll fix it in the V2.
>
>>>>    +static void thermal_pinctrl_select_otp(struct
>>>> rockchip_thermal_data *thermal)
>>>> +{
>>>> +    if (!IS_ERR(thermal->pinctrl) &&
>>>> !IS_ERR_OR_NULL(thermal->otp_state))
>>>> +        pinctrl_select_state(thermal->pinctrl,
>>>> +                     thermal->otp_state);
>>>> +}
>>>> +
>>>> +static void thermal_pinctrl_select_gpio(struct rockchip_thermal_data
>>>> *thermal)
>>>> +{
>>>> +    if (!IS_ERR(thermal->pinctrl) &&
>>>> !IS_ERR_OR_NULL(thermal->gpio_state))
>>>> +        pinctrl_select_state(thermal->pinctrl,
>>>> +                     thermal->gpio_state);
>>>> +}
>>> You should not have to create a couple of specific functions just to
>>> check the pinctrl pointers are set. The caller should do that.
>> Because there are several places where the call is made,create a couple
>> of specific functions reduce a lot of duplicated code.
> No, that does not reduce a lot of duplicated code, it hides the fact
> there is no control from the caller. See the comments below.
>
> [ ... ]
OK, I'll fix it in the V2.
>
>>>>    static int rockchip_configure_from_dt(struct device *dev,
>>>>                          struct device_node *np,
>>>>                          struct rockchip_thermal_data *thermal)
>>>> @@ -1103,7 +1120,7 @@ static int rockchip_configure_from_dt(struct
>>>> device *dev,
>>>>        if (of_property_read_u32(np, "rockchip,hw-tshut-mode",
>>>> &tshut_mode)) {
>>>>            dev_warn(dev,
>>>>                 "Missing tshut mode property, using default (%s)\n",
>>>> -             thermal->chip->tshut_mode == TSHUT_MODE_GPIO ?
>>>> +             thermal->chip->tshut_mode == TSHUT_MODE_OTP ?
>>>>                    "gpio" : "cru");
>>>>            thermal->tshut_mode = thermal->chip->tshut_mode;
>>>>        } else {
>>>> @@ -1242,6 +1259,8 @@ static int rockchip_thermal_probe(struct
>>>> platform_device *pdev)
>>>>            return error;
>>>>        }
>>>>    +    thermal->chip->control(thermal->regs, false);
>>>> +
>>>>        error = clk_prepare_enable(thermal->clk);
>>>>        if (error) {
>>>>            dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
>>>> @@ -1267,6 +1286,24 @@ static int rockchip_thermal_probe(struct
>>>> platform_device *pdev)
>>>>        thermal->chip->initialize(thermal->grf, thermal->regs,
>>>>                      thermal->tshut_polarity);
>>>>    +    if (thermal->tshut_mode == TSHUT_MODE_OTP) {
>>>> +        thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
>>>> +        if (IS_ERR(thermal->pinctrl))
>>>> +            dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
>>>> +
>>>> +        thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
>>>> +                               "gpio");
> panic if devm_pinctrl_get fails.
OK, It's good advice. I'll fix it in the V2.
>
>>>> +        if (IS_ERR_OR_NULL(thermal->gpio_state))
>>>> +            dev_err(&pdev->dev, "failed to find thermal gpio state\n");
>>>> +
>>>> +        thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
>>>> +                              "otpout");
>>>> +        if (IS_ERR_OR_NULL(thermal->otp_state))
>>>> +            dev_err(&pdev->dev, "failed to find thermal otpout
>>>> state\n");
>>> What is the meaning for the rest of the code if the lookup fails for any
>>> of those ?
>> If the lookup fails for any of those， The pinctrl is no longer set and
>> remains in its default state(otp_gpio normal io).
>>>> +        thermal_pinctrl_select_otp(thermal);
>>>> +    }
>>>> +
> It is pointless to have a otp_state and a gpio_state field. Just use one
> as the configuration tells you which lookup to do.
>
> In case of error, just bail out. It is pointless to continue with a
> broken configuration.
If the DST node is not modified synchronously, which may cause the 
rockchip_thermal driver probe failed.
Should I ignore this?
>
> 	thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
> 	if (IS_ERR(thermal->pinctrl)) {
> 		dev_err(&pdev->dev, "....");
> 		return PTR_ERR(thermal->pinctrl);
> 	}
>
> 	thermal->pinctrl_state =
> 		pinctrl_lookup_state(thermal->pinctrl,
> 			thermal->tshut_mode == TSHUT_MODE_OTP ?
> 			"otp" : "gpio");
>
> 	if (IS_ERR_OR_NULL(thermal->pinctrl_state)) {
> 		dev_err(&pdev->dev, "....");
> 		return -EINVAL;
> 	}
>
>
> No need to use the thermal_pinctrl_select_otp/gpio wrappers, just
> replace them with:
>
> pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);
>
> and use it unconditionally.
OK. I'll fix it in the V2.
>
>
>>>>        for (i = 0; i < thermal->chip->chn_num; i++) {
>>>>            error = rockchip_thermal_register_sensor(pdev, thermal,
>>>>                            &thermal->sensors[i],
>>>> @@ -1338,7 +1375,8 @@ static int __maybe_unused
>>>> rockchip_thermal_suspend(struct device *dev)
>>>>        clk_disable(thermal->pclk);
>>>>        clk_disable(thermal->clk);
>>>>    -    pinctrl_pm_select_sleep_state(dev);
>>>> +    if (thermal->tshut_mode == TSHUT_MODE_OTP)
>>>> +        thermal_pinctrl_select_gpio(thermal);
>>>>          return 0;
>>>>    }
>>>> @@ -1383,7 +1421,8 @@ static int __maybe_unused
>>>> rockchip_thermal_resume(struct device *dev)
>>>>        for (i = 0; i < thermal->chip->chn_num; i++)
>>>>            rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>>>>    -    pinctrl_pm_select_default_state(dev);
>>>> +    if (thermal->tshut_mode == TSHUT_MODE_OTP)
>>>> +        thermal_pinctrl_select_otp(thermal);
>>>>          return 0;
>>>>    }
>>>>
>>
>


