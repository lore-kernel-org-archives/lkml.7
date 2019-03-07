Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8300DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5890120675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCGBo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:44:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfCGBo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:44:26 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0DD2119F7FAE2E915D2;
        Thu,  7 Mar 2019 09:44:23 +0800 (CST)
Received: from [127.0.0.1] (10.142.193.64) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Mar 2019
 09:44:20 +0800
Subject: Re: [PATCH] mfd: hi655x-pmic: Fix missing return value check for
 devm_regmap_init_mmio_clk
To:     Axel Lin <axel.lin@ingics.com>, Lee Jones <lee.jones@linaro.org>
References: <20190306134949.31883-1-axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>
From:   Chen Feng <puck.chen@hisilicon.com>
Message-ID: <5C80776F.4070806@hisilicon.com>
Date:   Thu, 7 Mar 2019 09:44:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190306134949.31883-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.193.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

On 2019/3/6 21:49, Axel Lin wrote:
> Since devm_regmap_init_mmio_clk can fail, add return value checking.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mfd/hi655x-pmic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
> index 96c07fa1802a..6693f74aa6ab 100644
> --- a/drivers/mfd/hi655x-pmic.c
> +++ b/drivers/mfd/hi655x-pmic.c
> @@ -112,6 +112,8 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
>  
>  	pmic->regmap = devm_regmap_init_mmio_clk(dev, NULL, base,
>  						 &hi655x_regmap_config);
> +	if (IS_ERR(pmic->regmap))
> +		return PTR_ERR(pmic->regmap);
>  
>  	regmap_read(pmic->regmap, HI655X_BUS_ADDR(HI655X_VER_REG), &pmic->ver);
>  	if ((pmic->ver < PMU_VER_START) || (pmic->ver > PMU_VER_END)) {
> 

-- 
Cheers,
- Feng

