Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB570C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED7B2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 15:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFOPlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 11:41:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53492 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFOPlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 11:41:16 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hcAnn-0002or-84; Sat, 15 Jun 2019 17:41:11 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: rockchip: Use of_clk_get_parent_count()
Date:   Sat, 15 Jun 2019 17:41:10 +0200
Message-ID: <5458953.i9kcuLIT7L@diego>
In-Reply-To: <20190527135509.184544-1-wangkefeng.wang@huawei.com>
References: <20190525115941.108309-1-wangkefeng.wang@huawei.com> <20190527135509.184544-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. Mai 2019, 15:55:09 CEST schrieb Kefeng Wang:
> Use of_clk_get_parent_count() instead of open coding.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> v2:
> - add include <linux/of_clk.h>
>  drivers/pwm/pwm-rockchip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 4d99d468df09..d8f23daca290 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_clk.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> @@ -329,8 +330,8 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	count = of_count_phandle_with_args(pdev->dev.of_node,
> -					   "clocks", "#clock-cells");
> +	count = of_clk_get_parent_count(pdev->dev.of_node);
> +
>  	if (count == 2)
>  		pc->pclk = devm_clk_get(&pdev->dev, "pclk");
>  	else
> 




