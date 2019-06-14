Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9686C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A315D204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfFNFCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:02:15 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:55515 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbfFNFCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:02:15 -0400
X-UUID: 57caa488e5f3470f8aac425cc8cf59a1-20190614
X-UUID: 57caa488e5f3470f8aac425cc8cf59a1-20190614
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2128396892; Fri, 14 Jun 2019 13:02:09 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Jun 2019 13:02:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Jun 2019 13:02:07 +0800
Message-ID: <1560488527.16718.17.camel@mtksdaap41>
Subject: Re: [PATCH v3, 18/27] drm/medaitek: add layer_nr for ovl private
 data
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
Date:   Fri, 14 Jun 2019 13:02:07 +0800
In-Reply-To: <1559734986-7379-19-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
         <1559734986-7379-19-git-send-email-yongqiang.niu@mediatek.com>
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

On Wed, 2019-06-05 at 19:42 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add layer_nr for ovl private data
> ovl_2l almost same with with ovl hardware, except the
> layer number for ovl_2l is 2 and ovl is 4.
> this patch is a preparation for ovl-2l and
> ovl share the same driver.

This patch is identical to v2, and I've give a 'Reviewed-by' for v2,
so you should keep this 'Reviewed-by' tag in this patch, so I still give
you a

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index afb313c..a0ab760 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -60,6 +60,7 @@
>  struct mtk_disp_ovl_data {
>  	unsigned int addr;
>  	unsigned int gmc_bits;
> +	unsigned int layer_nr;
>  	bool fmt_rgb565_is_0;
>  };
>  
> @@ -137,7 +138,9 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
>  
>  static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
>  {
> -	return 4;
> +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
> +
> +	return ovl->data->layer_nr;
>  }
>  
>  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
> @@ -342,12 +345,14 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
>  static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT2701,
>  	.gmc_bits = 8,
> +	.layer_nr = 4,
>  	.fmt_rgb565_is_0 = false,
>  };
>  
>  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT8173,
>  	.gmc_bits = 8,
> +	.layer_nr = 4,
>  	.fmt_rgb565_is_0 = true,
>  };
>  


