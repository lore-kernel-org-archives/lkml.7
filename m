Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A46CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B5D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YB+ceC9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfCNKny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:43:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38856 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCNKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:43:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2EAhnGx014078;
        Thu, 14 Mar 2019 05:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552560229;
        bh=GAjC5l57/8fSJx9tJ+c2oVjaNgQVjJ2OvdGfyncv3nY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YB+ceC9TODQDynxI6NRbbJutZy3mq1zZcqyvcaLUKkVnH+WciSIZshcX0BcOow9vb
         ATeR6RZN4XjR5CYDdq9P2YPC0XyeGq6mAI3dRvZm+4CigIAyuh90QznEOTIy6wzbAR
         TfB0ocRcPiv0T0uodt6A/d+T7tTeN0gw2Kp83Gao=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2EAhnuq113507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 05:43:49 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Mar 2019 05:43:49 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Mar 2019 05:43:49 -0500
Received: from [172.22.128.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2EAhk7i024057;
        Thu, 14 Mar 2019 05:43:47 -0500
Subject: Re: [PATCH] drivers: gpio: omap: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        <linux-kernel@vger.kernel.org>
CC:     <ssantosh@kernel.org>, <khilman@kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <d3b12ed4-67e6-2993-4f56-80b1be572a24@gmail.com>
 <1552333805-23235-1-git-send-email-info@metux.net>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <d9f45854-e4f6-824a-330f-2ec76a41089c@ti.com>
Date:   Thu, 14 Mar 2019 12:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1552333805-23235-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.03.19 21:50, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-omap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 7f33024..ce6e67a 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1289,7 +1289,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	const struct of_device_id *match;
>  	const struct omap_gpio_platform_data *pdata;
> -	struct resource *res;
>  	struct gpio_bank *bank;
>  	struct irq_chip *irqc;
>  	int ret;
> @@ -1375,8 +1374,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  	raw_spin_lock_init(&bank->wa_lock);
>  
>  	/* Static mapping, never released */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	bank->base = devm_ioremap_resource(dev, res);
> +	bank->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(bank->base)) {
>  		return PTR_ERR(bank->base);
>  	}
> 

Acked-by: Grygorii Strashko <grygorii.strashko@ti.com> 

-- 
Best regards,
grygorii
