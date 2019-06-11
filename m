Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E636AC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC51421721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560288909;
	bh=PEAX2fnoaW3u/PRYHUJbAy07G1ly6c9mOaPfV6Nhx20=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=BnUvxQ35D0MjyfbPK6dl5EE3jv/cVW0TKntNFwCeDQiq6pJg6lpeipO28rjzAZHfw
	 F0V7tfd5bqQg8MMrleEDtzglqacj/nXiZrbeNADF+d0QeQ0cVjeVqralVlh0HNv+KP
	 RlV61CgDgwqARFdpfl2ppvARe3fXLbYuCwczyRWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392018AbfFKVfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387764AbfFKVfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:35:08 -0400
Received: from [192.168.1.32] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1769A2086D;
        Tue, 11 Jun 2019 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560288906;
        bh=PEAX2fnoaW3u/PRYHUJbAy07G1ly6c9mOaPfV6Nhx20=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=lMo3dm3LsgTs4LtPLiPNNqItR4UusmyTv6FtzqDMYKd3h+lR85mwyOoxVOW0Dijrl
         UT4wJ82DDJz+NUuuYwAhg2nZ3BxfyVJHX6+fygFH5k30h5SJhDjmpAg4PWvWzJHYAR
         9P7pUMKdxJt5Zl78jFGsvAmrsJkvBqc3k3BtbHQA=
From:   Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCHv4 2/2] mtd: spi-nor: cadence-quadspi: add reset control
To:     Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org
Cc:     marex@denx.de, dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, tien.fong.chee@intel.com
References: <20190508134338.20565-1-dinguyen@kernel.org>
 <20190508134338.20565-2-dinguyen@kernel.org>
 <73c8c69a-0756-811f-7a75-dd2255db7d7b@microchip.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <69a85f50-da43-f8f2-d959-6152fbcf95dc@kernel.org>
Date:   Tue, 11 Jun 2019 16:35:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <73c8c69a-0756-811f-7a75-dd2255db7d7b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/19 3:26 AM, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 05/08/2019 04:43 PM, Dinh Nguyen wrote:
>> Get the reset control properties for the QSPI controller and bring them
>> out of reset. Most will have just one reset bit, but there is an additional
>> OCP reset bit that is used ECC. The OCP reset bit will also need to get
>> de-asserted as well. [1]
>>
> 
> It's always good to say why the change is needed, e.g. reset the controller at
> init to have it in a clean state in case the bootloader messed with it.

Will update..

> 
>> [1] https://www.intel.com/content/www/us/en/programmable/hps/arria-10/hps.html#reg_soc_top/sfo1429890575955.html
>>
>> Suggested-by: Tien-Fong Chee <tien.fong.chee@intel.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v4: fix compile error
>> v3: return full error by using PTR_ERR(rtsc)
>>     move reset control calls until after the clock enables
>>     use udelay(2) to be safe
>>     Add optional OCP(Open Core Protocol) reset signal
>> v2: use devm_reset_control_get_optional_exclusive
>>     print an error message
>>     return -EPROBE_DEFER
>> ---
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 30 +++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index 792628750eec..d3906e5a1d44 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
>>  #include <linux/sched.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/timer.h>
>> @@ -1336,6 +1337,8 @@ static int cqspi_probe(struct platform_device *pdev)
>>  	struct cqspi_st *cqspi;
>>  	struct resource *res;
>>  	struct resource *res_ahb;
>> +	struct reset_control *rstc;
>> +	struct reset_control *rstc_ocp;
>>  	const struct cqspi_driver_platdata *ddata;
>>  	int ret;
>>  	int irq;
>> @@ -1402,6 +1405,33 @@ static int cqspi_probe(struct platform_device *pdev)
>>  		goto probe_clk_failed;
>>  	}
>>  
>> +	/* Obtain QSPI reset control */
>> +	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
>> +	if (IS_ERR(rstc)) {
>> +		dev_err(dev, "Cannot get QSPI reset.\n");
>> +		if (PTR_ERR(rstc) == -EPROBE_DEFER)
> 
> what I meant was to get rid of this if and return PTR_ERR(rstc) directly.
> 

Okay..

>> +			return PTR_ERR(rstc);
>> +	}
>> +
>> +	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
>> +	if (IS_ERR(rstc_ocp)) {
>> +		dev_err(dev, "Cannot get QSPI OCP reset.\n");
>> +		if (PTR_ERR(rstc_ocp) == -EPROBE_DEFER)
>> +			return PTR_ERR(rstc_ocp);
>> +	}
>> +
>> +	if (rstc) {> +		reset_control_assert(rstc);
>> +		udelay(2);
> 
> why 2us? what's the appropriate length of time that we should wait between
> assert and deassert?
> 

This length hasn't been documented anywhere. I've tested with both 2us
and none, and both cases seem to be working fine. 2us was something I
saw in the STM32 driver. I'll remove it.

>> +		reset_control_deassert(rstc);
>> +	}
>> +
>> +	if (rstc_ocp) {
>> +		reset_control_assert(rstc_ocp);
> 
> Does it mater the order in which you assert these signals? can we group these
> module resets asserts, i.e. first do the assert for both rstc and rstcp and then
> the deassert?
> 
>> +		udelay(2);
>> +		reset_control_deassert(rstc_ocp);
> Is software deassert needed? I'm looking at [2], Table 46. PER1 Group, Generated
> Module Resets, and it seems that software deassert is not an option for
> qspi_flash_ecc_rst_n
> 
> [2]https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/arria-10/a10_5v4.pdf
>

I believe this is a mistake. QSPI is not working for me if I don't do a
software reset deassert on the ocp bit.

Dinh


