Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0994AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AB32133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJFKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:06:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfJFKGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:06:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BE62B1B645913D1E252;
        Sun,  6 Oct 2019 18:06:33 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 18:06:29 +0800
Subject: Re: [alsa-devel] [PATCH -next] ASoc: tas2770: Fix build error without
 GPIOLIB
To:     Ladislav Michl <ladis@linux-mips.org>
References: <20191006072241.56808-1-yuehaibing@huawei.com>
 <20191006095720.GA13261@lenoch>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <ckeepax@opensource.cirrus.com>,
        <rf@opensource.wolfsonmicro.com>, <piotrs@opensource.cirrus.com>,
        <enric.balletbo@collabora.com>, <paul@crapouillou.net>,
        <srinivas.kandagatla@linaro.org>, <andradanciu1997@gmail.com>,
        <mirq-linux@rere.qmqm.pl>, <kuninori.morimoto.gx@renesas.com>,
        <m.felsch@pengutronix.de>, <shifu0704@thundersoft.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <4f5b8272-c299-ecc2-83f2-e7cdc534f061@huawei.com>
Date:   Sun, 6 Oct 2019 18:06:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191006095720.GA13261@lenoch>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/6 17:57, Ladislav Michl wrote:
> Dear YueHaibing,
> 
> On Sun, Oct 06, 2019 at 03:22:41PM +0800, YueHaibing wrote:
>> If GPIOLIB is not set, building fails:
>>
>> sound/soc/codecs/tas2770.c: In function tas2770_reset:
>> sound/soc/codecs/tas2770.c:38:3: error: implicit declaration of function gpiod_set_value_cansleep; did you mean gpio_set_value_cansleep? [-Werror=implicit-function-declaration]
>>    gpiod_set_value_cansleep(tas2770->reset_gpio, 0);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~
>>    gpio_set_value_cansleep
>> sound/soc/codecs/tas2770.c: In function tas2770_i2c_probe:
>> sound/soc/codecs/tas2770.c:749:24: error: implicit declaration of function devm_gpiod_get_optional; did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
>>   tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
>>                         ^~~~~~~~~~~~~~~~~~~~~~~
>>                         devm_regulator_get_optional
>> sound/soc/codecs/tas2770.c:751:13: error: GPIOD_OUT_HIGH undeclared (first use in this function); did you mean GPIOF_INIT_HIGH?
>>              GPIOD_OUT_HIGH);
>>              ^~~~~~~~~~~~~~
>>              GPIOF_INIT_HIGH
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  sound/soc/codecs/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index bcac957..d639f17 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -1108,6 +1108,7 @@ config SND_SOC_TAS2552
>>  config SND_SOC_TAS2770
>>  	tristate "Texas Instruments TAS2770 speaker amplifier"
>>  	depends on I2C
>> +	select GPIOLIB
> 
> GPIOLIB API is working perfectly fine even if GPIOLIB is not selected
> and gpiod_* functions will merely return -ENOSYS in this case.
> Please see <linux/gpio/consumer.h> and fix your patch accordingly.


Thanks, will send v2 as your suggestion.

> 
>>  config SND_SOC_TAS5086
>>  	tristate "Texas Instruments TAS5086 speaker amplifier"
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> .
> 

