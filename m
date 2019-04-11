Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5660421841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfDKHrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:47:15 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:40844 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKHrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:47:15 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.227])
        by regular1.263xmail.com (Postfix) with ESMTP id 6237C213;
        Thu, 11 Apr 2019 15:47:02 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30808T139664108582656S1554968819709234_;
        Thu, 11 Apr 2019 15:47:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2b9bb47e36087b4ebe357ba5ef503818>
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
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <db977a75-195f-4c98-ef84-aa186b484e0d@rock-chips.com>
Date:   Thu, 11 Apr 2019 15:46:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <30325add-d75a-6775-50c0-d2d2274ff81e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

在 2019/4/4 上午11:03, Daniel Lezcano 写道:
> On 01/04/2019 08:43, Elaine Zhang wrote:
>> Based on the TSADC Tshut mode to select pinctrl,
>> instead of setting pinctrl based on architecture
>> (Not depends on pinctrl setting by "init" or "default").
>> And it requires setting the tshut polarity before select pinctrl.
> I'm not sure to fully read the description. Can you rephrase/elaborate
> the changelog?
Example:
         tsadc: tsadc@ff250000 {
                     compatible = "rockchip,rk3328-tsadc";
                     .....
                 pinctrl-names = "init", "default", "sleep";
                     pinctrl-0 = <&otp_gpio>;
                     pinctrl-1 = <&otp_out>;
                     pinctrl-2 = <&otp_gpio>;
                     status = "disabled";
                 .....
             };
         &tsadc {
                 rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
                 status = "okay";
         };
     Application on the product, hope tsadc overtemperature reset cru to 
restart.
     But when pinctrl is initialized, it will setting pinctrl by "init" 
and "default".
     So the pinctrl will set iomux to "otp_out", which may be make 
system crash.
     tsadc gpio iomux:
     "otp_gpio" : just normal gpio, keep default level.
     "otp_out" : tsadc shut down io, when overtemperature,this io may be 
trigger high
     level or low level(depend on the tsadc polarity).

     After correction:
     if rockchip,hw-tshut-mode = <0>; (tsadc overtemperature reset cru 
to restart)
     select pinctrl to otp_gpio
     if rockchip,hw-tshut-mode = <1>;(tsadc overtemperature IO triggers 
output at high or low levels)
     select pinctrl to otp_out.
     Actively select iomux based on rockchip,hw-tshut-mode,
     rather than relying on the pinctrl framework to select iomux.
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   drivers/thermal/rockchip_thermal.c | 61 +++++++++++++++++++++++++++++++-------
>>   1 file changed, 50 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
>> index 9c7643d62ed7..faa6c7792155 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -34,7 +34,7 @@
>>    */
>>   enum tshut_mode {
>>   	TSHUT_MODE_CRU = 0,
>> -	TSHUT_MODE_GPIO,
>> +	TSHUT_MODE_OTP,
> Why do you change the enum name? The impact on the patch is much higher,
> no ?

I just want to make it a little bit more intuitive to understand the 
definition of mode.

TSHUT_MODE_CRU: pinctrl select iomux to otp_gpio,the io is normal io.
TSHUT_MODE_OTP: pinctrl select iomux to otp_out, the io is tsadc shut io.

>
>>   };
>>   
>>   /**
>> @@ -172,6 +172,9 @@ struct rockchip_thermal_data {
>>   	int tshut_temp;
>>   	enum tshut_mode tshut_mode;
>>   	enum tshut_polarity tshut_polarity;
>> +	struct pinctrl *pinctrl;
>> +	struct pinctrl_state *gpio_state;
>> +	struct pinctrl_state *otp_state;
>>   };
>>   
>>   /**
>> @@ -807,7 +810,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>   	u32 val;
>>   
>>   	val = readl_relaxed(regs + TSADCV2_INT_EN);
>> -	if (mode == TSHUT_MODE_GPIO) {
>> +	if (mode == TSHUT_MODE_OTP) {
>>   		val &= ~TSADCV2_SHUT_2CRU_SRC_EN(chn);
>>   		val |= TSADCV2_SHUT_2GPIO_SRC_EN(chn);
>>   	} else {
>> @@ -822,7 +825,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>   	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>   	.chn_num = 1, /* one channel for tsadc */
>>   
>> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>>   	.tshut_temp = 95000,
>>   
>> @@ -846,7 +849,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>   	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>   	.chn_num = 1, /* one channel for tsadc */
>>   
>> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>>   	.tshut_temp = 95000,
>>   
>> @@ -871,7 +874,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>   	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
>>   	.chn_num = 2, /* two channels for tsadc */
>>   
>> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>>   	.tshut_temp = 95000,
>>   
>> @@ -919,7 +922,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>   	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>>   	.chn_num = 2, /* two channels for tsadc */
>>   
>> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>>   	.tshut_temp = 95000,
>>   
>> @@ -944,7 +947,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>   	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>>   	.chn_num = 2, /* two channels for tsadc */
>>   
>> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>>   	.tshut_temp = 95000,
>>   
>> @@ -969,7 +972,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>   	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>>   	.chn_num = 2, /* two channels for tsadc */
>>   
>> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>>   	.tshut_temp = 95000,
>>   
>> @@ -1080,6 +1083,20 @@ static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
>>   	.set_trips = rockchip_thermal_set_trips,
>>   };
>>   
>> +static void thermal_pinctrl_select_otp(struct rockchip_thermal_data *thermal)
>> +{
>> +	if (!IS_ERR(thermal->pinctrl) && !IS_ERR_OR_NULL(thermal->otp_state))
>> +		pinctrl_select_state(thermal->pinctrl,
>> +				     thermal->otp_state);
>> +}
>> +
>> +static void thermal_pinctrl_select_gpio(struct rockchip_thermal_data *thermal)
>> +{
>> +	if (!IS_ERR(thermal->pinctrl) && !IS_ERR_OR_NULL(thermal->gpio_state))
>> +		pinctrl_select_state(thermal->pinctrl,
>> +				     thermal->gpio_state);
>> +}
> You should not have to create a couple of specific functions just to
> check the pinctrl pointers are set. The caller should do that.
Because there are several places where the call is made,create a couple 
of specific functions reduce a lot of duplicated code.
>
>>   static int rockchip_configure_from_dt(struct device *dev,
>>   				      struct device_node *np,
>>   				      struct rockchip_thermal_data *thermal)
>> @@ -1103,7 +1120,7 @@ static int rockchip_configure_from_dt(struct device *dev,
>>   	if (of_property_read_u32(np, "rockchip,hw-tshut-mode", &tshut_mode)) {
>>   		dev_warn(dev,
>>   			 "Missing tshut mode property, using default (%s)\n",
>> -			 thermal->chip->tshut_mode == TSHUT_MODE_GPIO ?
>> +			 thermal->chip->tshut_mode == TSHUT_MODE_OTP ?
>>   				"gpio" : "cru");
>>   		thermal->tshut_mode = thermal->chip->tshut_mode;
>>   	} else {
>> @@ -1242,6 +1259,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>>   		return error;
>>   	}
>>   
>> +	thermal->chip->control(thermal->regs, false);
>> +
>>   	error = clk_prepare_enable(thermal->clk);
>>   	if (error) {
>>   		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
>> @@ -1267,6 +1286,24 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>>   	thermal->chip->initialize(thermal->grf, thermal->regs,
>>   				  thermal->tshut_polarity);
>>   
>> +	if (thermal->tshut_mode == TSHUT_MODE_OTP) {
>> +		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
>> +		if (IS_ERR(thermal->pinctrl))
>> +			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
>> +
>> +		thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
>> +							   "gpio");
>> +		if (IS_ERR_OR_NULL(thermal->gpio_state))
>> +			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
>> +
>> +		thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
>> +							  "otpout");
>> +		if (IS_ERR_OR_NULL(thermal->otp_state))
>> +			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
> What is the meaning for the rest of the code if the lookup fails for any
> of those ?
If the lookup fails for any of those， The pinctrl is no longer set and 
remains in its default state(otp_gpio normal io).
>
>> +		thermal_pinctrl_select_otp(thermal);
>> +	}
>> +
>>   	for (i = 0; i < thermal->chip->chn_num; i++) {
>>   		error = rockchip_thermal_register_sensor(pdev, thermal,
>>   						&thermal->sensors[i],
>> @@ -1338,7 +1375,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>>   	clk_disable(thermal->pclk);
>>   	clk_disable(thermal->clk);
>>   
>> -	pinctrl_pm_select_sleep_state(dev);
>> +	if (thermal->tshut_mode == TSHUT_MODE_OTP)
>> +		thermal_pinctrl_select_gpio(thermal);
>>   
>>   	return 0;
>>   }
>> @@ -1383,7 +1421,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>>   	for (i = 0; i < thermal->chip->chn_num; i++)
>>   		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>>   
>> -	pinctrl_pm_select_default_state(dev);
>> +	if (thermal->tshut_mode == TSHUT_MODE_OTP)
>> +		thermal_pinctrl_select_otp(thermal);
>>   
>>   	return 0;
>>   }
>>
>


