Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1766EC10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE10220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCKGKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:10:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64694 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbfCKGKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:10:35 -0400
X-UUID: 38f12cbe4e1d4ba9bf5976d5633a568c-20190311
X-UUID: 38f12cbe4e1d4ba9bf5976d5633a568c-20190311
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <eddie.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1005944272; Mon, 11 Mar 2019 14:10:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Mar 2019 14:10:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 14:10:22 +0800
Message-ID: <1552284619.28295.3.camel@mtksdaap41>
Subject: Re: [PATCH v2 9/9] rtc: Add support for the MediaTek MT6358 RTC
From:   Eddie Huang <eddie.huang@mediatek.com>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ran Bi =?UTF-8?Q?=28=E6=AF=95=E5=86=89=29?= 
        <Ran.Bi@mediatek.com>
Date:   Mon, 11 Mar 2019 14:10:19 +0800
In-Reply-To: <1552275991-34648-10-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1552275991-34648-10-git-send-email-hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 11:46 +0800, Hsin-Hsiung Wang wrote:
> From: Ran Bi <ran.bi@mediatek.com>
> 
> This add support for the MediaTek MT6358 RTC. MT6397 mfd will pass
> RTC_WRTGR address offset to RTC driver.
> 
> Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index f85f1fc..c8a0090 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -27,7 +27,7 @@
>  #define RTC_BBPU		0x0000
>  #define RTC_BBPU_CBUSY		BIT(6)
>  
> -#define RTC_WRTGR		0x003c
> +#define RTC_WRTGR_DEFAULT	0x003c
>  
>  #define RTC_IRQ_STA		0x0002
>  #define RTC_IRQ_STA_AL		BIT(0)
> @@ -78,6 +78,7 @@ struct mt6397_rtc {
>  	struct regmap		*regmap;
>  	int			irq;
>  	u32			addr_base;
> +	u32			wrtgr_offset;

It is strange that hardware change trigger register offset, I think we
have no choice to add a field to describe it.

>  };
>  
>  static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> @@ -86,7 +87,8 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  	int ret;
>  	u32 data;
>  
> -	ret = regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> +	ret = regmap_write(rtc->regmap,
> +			   rtc->addr_base + rtc->wrtgr_offset, 1);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -341,6 +343,15 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rtc->addr_base = res->start;
>  
> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> +	if (res) {
> +		rtc->wrtgr_offset = res->start;
> +		dev_info(&pdev->dev, "register offset:%d\n", rtc->wrtgr_offset);

Nit: useless log

> +	} else {
> +		rtc->wrtgr_offset = RTC_WRTGR_DEFAULT;
> +		dev_err(&pdev->dev, "Failed to get register offset\n");
> +	}
> +
>  	rtc->irq = platform_get_irq(pdev, 0);
>  	if (rtc->irq < 0)
>  		return rtc->irq;
> @@ -420,6 +431,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
>  			mt6397_rtc_resume);
>  
>  static const struct of_device_id mt6397_rtc_of_match[] = {
> +	{ .compatible = "mediatek,mt6358-rtc", },
>  	{ .compatible = "mediatek,mt6397-rtc", },
>  	{ }
>  };

Without the log, you can my get 
Acked-by: Eddie Huang <eddie.huang@mediatekcom>


