Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E4BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3227B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDKGKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:10:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63337 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbfDKGKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:10:00 -0400
X-UUID: 85f4980358b94fe799f953aedfac691e-20190411
X-UUID: 85f4980358b94fe799f953aedfac691e-20190411
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 264371904; Thu, 11 Apr 2019 14:09:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Apr 2019 14:09:48 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 14:09:48 +0800
Message-ID: <1554962988.4768.4.camel@mtksdaap41>
Subject: Re: [PATCH v2 06/25] drm/mediatek: redefine mtk_ddp_sout_sel
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Thu, 11 Apr 2019 14:09:48 +0800
In-Reply-To: <1553667561-25447-7-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-7-git-send-email-yongqiang.niu@mediatek.com>
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

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> the format of "mtk_ddp_sout_sel"was not flexible, after we add more
> mediatek SOC support, that will be redundant

It looks like this patch is part of patch 'add mmsys private data for
ddp path config', so I would like you squash this patch into that patch.

Regards,
CK

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 80dc91f..e4dafe0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -391,20 +391,26 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  	return value;
>  }
>  
> -static void mtk_ddp_sout_sel(void __iomem *config_regs,
> -			     enum mtk_ddp_comp_id cur,
> -			     enum mtk_ddp_comp_id next)
> +static unsigned int mtk_ddp_sout_sel(enum mtk_ddp_comp_id cur,
> +				     enum mtk_ddp_comp_id next,
> +				     unsigned int *addr)
>  {
> +        unsigned int value;
> +
>  	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
> -		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> -			       config_regs + DISP_REG_CONFIG_OUT_SEL);
> +		*addr = DISP_REG_CONFIG_OUT_SEL;
> +                value = BLS_TO_DSI_RDMA1_TO_DPI1;
>  	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> -		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> -			       config_regs + DISP_REG_CONFIG_OUT_SEL);
> +		*addr = DISP_REG_CONFIG_OUT_SEL;
> +                value = BLS_TO_DPI_RDMA1_TO_DSI;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> -		writel_relaxed(DSI_SEL_IN_RDMA,
> -			       config_regs + DISP_REG_CONFIG_DSI_SEL);
> +		*addr = DISP_REG_CONFIG_DSI_SEL;
> +		value = DSI_SEL_IN_RDMA;
> +	} else {
> +		value = 0;
>  	}
> +
> +        return value;
>  }
>  
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> @@ -419,7 +425,9 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
>  		writel_relaxed(reg, config_regs + addr);
>  	}
>  
> -	mtk_ddp_sout_sel(config_regs, cur, next);
> +	value = mtk_ddp_sout_sel(cur, next, &addr);
> +	if (value)
> +                writel_relaxed(value, config_regs + addr);
>  
>  	value = mtk_ddp_sel_in(cur, next, &addr);
>  	if (value) {


