Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADED0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2052171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfCXDes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 23:34:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1799 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727706AbfCXDer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 23:34:47 -0400
X-UUID: 4139318f1e5040d8bdad11c93286e163-20190324
X-UUID: 4139318f1e5040d8bdad11c93286e163-20190324
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1396306676; Sun, 24 Mar 2019 11:34:29 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Mar 2019 11:34:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Mar 2019 11:34:26 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 24 Mar 2019 11:34:26 +0800
Message-ID: <1553398466.26628.0.camel@mtksdaap41>
Subject: Re: [PATCH 09/24] mmc: mtk-sd: check for valid optional memory
 resource
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <linux-watchdog@vger.kernel.org>, <jjian.zhou@mediatek.com>,
        <wenzhen.yu@mediatek.com>, <stephane.leprovost@mediatek.com>,
        <sean.wang@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yong.mao@mediatek.com>,
        <linux-spi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <hsin-hsiung.wang@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <chaotian.jing@mediatek.com>,
        <linux-i2c@vger.kernel.org>
Date:   Sun, 24 Mar 2019 11:34:26 +0800
In-Reply-To: <20190323211612.860-10-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
         <20190323211612.860-10-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-TM-SNTS-SMTP: 054869C2B2FF6DCD1AFCF49E6578D95B61694A9C9726265AD53ECF398AE763E82000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-23 at 22:15 +0100, Fabien Parent wrote:
> 'top_base' memory region is optional. Check that the resource is valid
> before using it. This avoid getting a "invalid resource" error message
> printed by the kernel.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 833ef0590af8..573aa127d00b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	host->top_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(host->top_base))
> -		host->top_base = NULL;
> +	if (ret) {

This should be res?

> +		host->top_base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(host->top_base))
> +			host->top_base = NULL;
> +	}
>  
>  	ret = mmc_regulator_get_supply(mmc);
>  	if (ret)


