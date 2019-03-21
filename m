Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12193C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E292075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfCUNly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:41:54 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27103 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfCUNlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:41:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LDanrX004257;
        Thu, 21 Mar 2019 14:41:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r8qg4wqs8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Mar 2019 14:41:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C70B33A;
        Thu, 21 Mar 2019 13:41:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A0EAC508A;
        Thu, 21 Mar 2019 13:41:14 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Mar
 2019 14:41:13 +0100
Subject: Re: [PATCH 1/8] iio: adc: stm32-dfsdm: make spi_master_freq more
 accurate
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
References: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
 <1551862524-25098-2-git-send-email-fabrice.gasnier@st.com>
 <20190310100932.71fd1af1@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <62742e3f-3860-3020-33a0-dafc9ae66dd1@st.com>
Date:   Thu, 21 Mar 2019 14:41:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190310100932.71fd1af1@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/19 11:09 AM, Jonathan Cameron wrote:
> On Wed, 6 Mar 2019 09:55:17 +0100
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> When SPI clock isn't accurate, 'spi_master_freq' is filled in with
>> expected frequency. Use computed value instead:
>> - e.g. source clock / (CKOUTDIV + 1)
>> Also, current divider may be set to value that makes CKOUT to exceed
>> spi-max-frequency. Rather use lower value (e.g. round up divider when
>> ckout isn't accurate).
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  drivers/iio/adc/stm32-dfsdm-core.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
>> index bf089f5..65b7556 100644
>> --- a/drivers/iio/adc/stm32-dfsdm-core.c
>> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
>> @@ -243,13 +243,18 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>>  		return 0;
>>  	}
>>  
>> -	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
>> +	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem);
>> +
>> +	/* round up divider when clkout isn't accurate (e.g. !rem) */
>> +	if (priv->spi_clk_out_div && !rem)
>> +		priv->spi_clk_out_div--;
>> +
> This comment perhaps needs adjusting because at the moment it looks
> like it decrements when it is accurate.   With the old code in place
> in the patch it's obvious that's because you actually want one less.
> 
> Might even be worth the dance of
> 
> /* round up if not precise */
> if (priv->spi_clk_out_div && rem)
> 	priv->spi_clk_out_div++;
> 
> /* subtract one because....  */
> priv->spi_clk_out_div--;

Hi Jonathan,

I'll rework this patch in v2, make it easier to understand & read.

In a few words: the clock output is divider = ckoutdiv + 1.
ckoutdiv range can be from 1-255 to provide divider of 2-256.
So I'll introduce this divider as a variable, and use it to setup
spi_clk_out_div.
This should address all your remarks here.

Thanks for reviewing,
Best Regards,
Fabrice
> 
>>  	if (!priv->spi_clk_out_div) {
>>  		/* spi_clk_out_div == 0 means ckout is OFF */
>>  		dev_err(&pdev->dev, "spi-max-frequency not achievable\n");
>>  		return -EINVAL;
>>  	}
>> -	priv->dfsdm.spi_master_freq = spi_freq;
>> +	priv->dfsdm.spi_master_freq = clk_freq / (priv->spi_clk_out_div + 1);
> And we increment it again here? That needs an explanation as well.
>>  
>>  	if (rem) {
>>  		dev_warn(&pdev->dev, "SPI clock not accurate\n");
> 
