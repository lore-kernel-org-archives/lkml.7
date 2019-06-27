Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0553C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98574205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfF0CDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:03:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:43508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726830AbfF0CDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:03:19 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id AFCE5163E993FDC9B65B;
        Thu, 27 Jun 2019 10:03:15 +0800 (CST)
Received: from dggeme761-chm.china.huawei.com (10.3.19.107) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Jun 2019 10:03:15 +0800
Received: from [127.0.0.1] (10.121.91.75) by dggeme761-chm.china.huawei.com
 (10.3.19.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Jun 2019 10:03:15 +0800
Subject: Re: [PATCH RESEND] mfd: hi655x-pmic: Fix missing return value check
 for devm_regmap_init_mmio_clk
To:     Axel Lin <axel.lin@ingics.com>, Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20190626133007.591-1-axel.lin@ingics.com>
From:   Chen Feng <puck.chen@hisilicon.com>
Message-ID: <40ae33d4-10fd-852a-30e6-db56d709ef1c@hisilicon.com>
Date:   Thu, 27 Jun 2019 10:03:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190626133007.591-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.121.91.75]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme761-chm.china.huawei.com (10.3.19.107)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

On 2019/6/26 21:30, Axel Lin wrote:
> Since devm_regmap_init_mmio_clk can fail, add return value checking.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Acked-by: Chen Feng <puck.chen@hisilicon.com>
> ---
> This was sent on https://lkml.org/lkml/2019/3/6/904
> 
>   drivers/mfd/hi655x-pmic.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
> index 96c07fa1802a..6693f74aa6ab 100644
> --- a/drivers/mfd/hi655x-pmic.c
> +++ b/drivers/mfd/hi655x-pmic.c
> @@ -112,6 +112,8 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
>   
>   	pmic->regmap = devm_regmap_init_mmio_clk(dev, NULL, base,
>   						 &hi655x_regmap_config);
> +	if (IS_ERR(pmic->regmap))
> +		return PTR_ERR(pmic->regmap);
>   
>   	regmap_read(pmic->regmap, HI655X_BUS_ADDR(HI655X_VER_REG), &pmic->ver);
>   	if ((pmic->ver < PMU_VER_START) || (pmic->ver > PMU_VER_END)) {
> 

