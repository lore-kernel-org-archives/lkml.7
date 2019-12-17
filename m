Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC025C2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E7F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLQJfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:35:44 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:52409 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:35:44 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 17 Dec
 2019 17:36:17 +0800
Subject: Re: [PATCH v4 3/6] clk: meson: eeclk: refactor eeclk common driver to
 support A1
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191206074052.15557-1-jian.hu@amlogic.com>
 <20191206074052.15557-4-jian.hu@amlogic.com>
 <1j7e31lub4.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <4cb9088c-bacb-ea3b-df43-103ce8902376@amlogic.com>
Date:   Tue, 17 Dec 2019 17:36:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1j7e31lub4.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.99]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/12 18:19, Jerome Brunet wrote:
> 
> On Fri 06 Dec 2019 at 08:40, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> Introduce a common probe function for A1 series, the way to get
>> regmap is different between A1 series and the previous series.
>> The register region is only for one clock driver, the function of
>> meson_eeclkc_probe is not fit for A1, So it is necessary to
>> introduce a new function.
> 
> Please drop this patch
> 
> #1 you are patching the EE driver for something that is no longer an EE
>   driver
> #2 Let's get the basics right, you can move (re)factoring afterward
> 
> Your probe function is simple enough. Just properly write it in each
> driver for now.
OK, I will realize it in each driver.
> 
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   drivers/clk/meson/meson-eeclk.c | 59 +++++++++++++++++++++++++++------
>>   drivers/clk/meson/meson-eeclk.h |  1 +
>>   2 files changed, 50 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
>> index a7cb1e7aedc4..12ceb1caabd8 100644
>> --- a/drivers/clk/meson/meson-eeclk.c
>> +++ b/drivers/clk/meson/meson-eeclk.c
>> @@ -13,25 +13,37 @@
>>   #include "clk-regmap.h"
>>   #include "meson-eeclk.h"
>>   
>> -int meson_eeclkc_probe(struct platform_device *pdev)
>> +static struct regmap_config clkc_regmap_config = {
>> +	.reg_bits       = 32,
>> +	.val_bits       = 32,
>> +	.reg_stride     = 4,
>> +};
>> +
>> +static struct regmap *meson_regmap_resource(struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base))
>> +		return ERR_CAST(base);
>> +
>> +	return devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +}
>> +
>> +static int meson_common_probe(struct platform_device *pdev, struct regmap *map)
>>   {
>>   	const struct meson_eeclkc_data *data;
>>   	struct device *dev = &pdev->dev;
>> -	struct regmap *map;
>>   	int ret, i;
>>   
>>   	data = of_device_get_match_data(dev);
>>   	if (!data)
>>   		return -EINVAL;
>>   
>> -	/* Get the hhi system controller node */
>> -	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
>> -	if (IS_ERR(map)) {
>> -		dev_err(dev,
>> -			"failed to get HHI regmap\n");
>> -		return PTR_ERR(map);
>> -	}
>> -
>>   	if (data->init_count)
>>   		regmap_multi_reg_write(map, data->init_regs, data->init_count);
>>   
>> @@ -54,3 +66,30 @@ int meson_eeclkc_probe(struct platform_device *pdev)
>>   	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>>   					   data->hw_onecell_data);
>>   }
>> +
>> +int meson_eeclkc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct regmap *map;
>> +
>> +	/* Get the hhi system controller node */
>> +	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
>> +	if (IS_ERR(map)) {
>> +		dev_err(dev,
>> +			"failed to get HHI regmap\n");
>> +		return PTR_ERR(map);
>> +	}
>> +
>> +	return meson_common_probe(pdev, map);
>> +}
>> +
>> +int meson_clkc_probe(struct platform_device *pdev)
>> +{
>> +	struct regmap *map;
>> +
>> +	map = meson_regmap_resource(pdev);
>> +	if (IS_ERR(map))
>> +		return PTR_ERR(map);
>> +
>> +	return meson_common_probe(pdev, map);
>> +}
>> diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
>> index 77316207bde1..a2e9ab3a4f6b 100644
>> --- a/drivers/clk/meson/meson-eeclk.h
>> +++ b/drivers/clk/meson/meson-eeclk.h
>> @@ -21,5 +21,6 @@ struct meson_eeclkc_data {
>>   };
>>   
>>   int meson_eeclkc_probe(struct platform_device *pdev);
>> +int meson_clkc_probe(struct platform_device *pdev);
>>   
>>   #endif /* __MESON_CLKC_H */
> 
> .
> 
