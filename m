Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F00C31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D95208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfFQDGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:06:14 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8652 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727383AbfFQDGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:06:14 -0400
X-UUID: 0b2b5341301845fbaedf068b07628bff-20190617
X-UUID: 0b2b5341301845fbaedf068b07628bff-20190617
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 924756873; Mon, 17 Jun 2019 11:06:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Jun 2019 11:06:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Jun 2019 11:06:03 +0800
Message-ID: <1560740762.25168.3.camel@mtksdaap41>
Subject: Re: [PATCH v3, 26/27] drm/mediatek: add clock property check before
 get it
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 17 Jun 2019 11:06:02 +0800
In-Reply-To: <1559734986-7379-27-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
         <1559734986-7379-27-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-06-05 at 19:43 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add clock property check before get it

In the binding document [1], clock is required property. In this patch,
you change it to optional property. I think you should change the
binding document and describe _WHY_ do you do this.

[1]
https://www.kernel.org/doc/Documentation/devicetree/bindings/display/mediatek/mediatek%2Cdisp.txt

Regards,
CK

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 9986c61..28274d2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -689,10 +689,12 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>  	for (i = 0; i < 10; i++)
>  		ddp->mutex[i].id = i;
>  
> -	ddp->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(ddp->clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> -		return PTR_ERR(ddp->clk);
> +	if (of_find_property(dev->of_node, "clocks", &i)) {
> +		ddp->clk = devm_clk_get(dev, NULL);
> +		if (IS_ERR(ddp->clk)) {
> +			dev_err(dev, "Failed to get clock\n");
> +			return PTR_ERR(ddp->clk);
> +		}
>  	}
>  
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);


