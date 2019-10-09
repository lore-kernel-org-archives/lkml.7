Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F9321848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfJIJYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:24:52 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:50060 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbfJIJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:24:52 -0400
X-UUID: aee3e82328cc419caeedd6668d83c561-20191009
X-UUID: aee3e82328cc419caeedd6668d83c561-20191009
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 619512515; Wed, 09 Oct 2019 17:24:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 17:24:38 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 17:24:37 +0800
Message-ID: <1570613080.7713.6.camel@mtksdaap41>
Subject: Re: [PATCH v5, 21/32] drm/mediatek: add background color input
 select function for ovl/ovl_2l
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
Date:   Wed, 9 Oct 2019 17:24:40 +0800
In-Reply-To: <1567090254-15566-22-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-22-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: B5C9C745579453C1F4ED3109BEA557BFB607994C68765150058BBB90A47201F22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add background color input select function for ovl/ovl_2l
> 
> ovl include 4 DRAM layer and 1 background color layer
> ovl_2l include 4 DRAM layer and 1 background color layer
> DRAM layer frame buffer data from render hardware, GPU for example.
> backgournd color layer is embed in ovl/ovl_2l, we can only set
> it color, but not support DRAM frame buffer.
> 
> for ovl0->ovl0_2l direct link usecase,
> we need set ovl0_2l background color intput select from ovl0
> if render send DRAM buffer layer number <=4, all these layer read
> by ovl.
> layer0 is at the bottom of all layers.
> layer3 is at the top of all layers.
> if render send DRAM buffer layer numbfer >=4 && <=6
> ovl0 read layer0~3
> ovl0_2l read layer4~5
> layer5 is at the top ot all these layers.
> 
> the decision of how to setting ovl0/ovl0_2l read these layer data
> is controlled in mtk crtc, which will be another patch
> 

Applied to mediatek-drm-next-5.5 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index baef066..eb3bf85 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -19,6 +19,8 @@
>  #define DISP_REG_OVL_EN				0x000c
>  #define DISP_REG_OVL_RST			0x0014
>  #define DISP_REG_OVL_ROI_SIZE			0x0020
> +#define DISP_REG_OVL_DATAPATH_CON		0x0024
> +#define OVL_BGCLR_SEL_IN				BIT(2)
>  #define DISP_REG_OVL_ROI_BGCLR			0x0028
>  #define DISP_REG_OVL_SRC_CON			0x002c
>  #define DISP_REG_OVL_CON(n)			(0x0030 + 0x20 * (n))
> @@ -237,6 +239,24 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  		mtk_ovl_layer_on(comp, idx);
>  }
>  
> +static void mtk_ovl_bgclr_in_on(struct mtk_ddp_comp *comp)
> +{
> +	unsigned int reg;
> +
> +	reg = readl(comp->regs + DISP_REG_OVL_DATAPATH_CON);
> +	reg = reg | OVL_BGCLR_SEL_IN;
> +	writel(reg, comp->regs + DISP_REG_OVL_DATAPATH_CON);
> +}
> +
> +static void mtk_ovl_bgclr_in_off(struct mtk_ddp_comp *comp)
> +{
> +	unsigned int reg;
> +
> +	reg = readl(comp->regs + DISP_REG_OVL_DATAPATH_CON);
> +	reg = reg & ~OVL_BGCLR_SEL_IN;
> +	writel(reg, comp->regs + DISP_REG_OVL_DATAPATH_CON);
> +}
> +
>  static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
>  	.config = mtk_ovl_config,
>  	.start = mtk_ovl_start,
> @@ -247,6 +267,8 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  	.layer_on = mtk_ovl_layer_on,
>  	.layer_off = mtk_ovl_layer_off,
>  	.layer_config = mtk_ovl_layer_config,
> +	.bgclr_in_on = mtk_ovl_bgclr_in_on,
> +	.bgclr_in_off = mtk_ovl_bgclr_in_off,
>  };
>  
>  static int mtk_disp_ovl_bind(struct device *dev, struct device *master,


