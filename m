Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD088C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE4E2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFUF0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 01:26:36 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39093 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbfFUF0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 01:26:35 -0400
X-UUID: 62185891b5ac44099c682d9834e6dc56-20190621
X-UUID: 62185891b5ac44099c682d9834e6dc56-20190621
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 353118230; Fri, 21 Jun 2019 13:26:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Jun
 2019 13:26:20 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Jun 2019 13:26:20 +0800
Message-ID: <1561094780.19385.2.camel@mhfsdcap03>
Subject: Re: [PATCH 2/6] usb: bdc: Cleanup clock support
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Al Cooper <alcooperx@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Jun 2019 13:26:20 +0800
In-Reply-To: <1561064991-16874-3-git-send-email-alcooperx@gmail.com>
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
         <1561064991-16874-3-git-send-email-alcooperx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: ECBE481D9A00CAE8B078A5BE72BABE4F8EF4629F8564CA86349D41B6532423062000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 17:09 -0400, Al Cooper wrote:
> - Fix driver to defer on clk_get defer
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/usb/gadget/udc/bdc/bdc_core.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> index ccbd1d34eb2a..11a43de6c1c6 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -490,8 +490,14 @@ static int bdc_probe(struct platform_device *pdev)
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
> +	bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
> +	if (!bdc)
> +		return -ENOMEM;
> +
>  	clk = devm_clk_get(dev, "sw_usbd");
>  	if (IS_ERR(clk)) {
> +		if (PTR_ERR(clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
what about using devm_clk_get_optional()?

>  		dev_info(dev, "Clock not found in Device Tree\n");
>  		clk = NULL;
>  	}
> @@ -501,11 +507,6 @@ static int bdc_probe(struct platform_device *pdev)
>  		dev_err(dev, "could not enable clock\n");
>  		return ret;
>  	}
> -
> -	bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
> -	if (!bdc)
> -		return -ENOMEM;
> -
>  	bdc->clk = clk;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -551,7 +552,7 @@ static int bdc_probe(struct platform_device *pdev)
>  	ret = bdc_phy_init(bdc);
>  	if (ret) {
>  		dev_err(bdc->dev, "BDC phy init failure:%d\n", ret);
> -		return ret;
> +		goto clk_cleanup;
>  	}
>  
>  	temp = bdc_readl(bdc->regs, BDC_BDCCAP1);
> @@ -583,6 +584,8 @@ static int bdc_probe(struct platform_device *pdev)
>  	bdc_hw_exit(bdc);
>  phycleanup:
>  	bdc_phy_exit(bdc);
> +clk_cleanup:
> +	clk_disable_unprepare(bdc->clk);
>  	return ret;
>  }
>  


