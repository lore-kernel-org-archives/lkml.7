Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FD6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8D123427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH3F1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:27:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:10317 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726023AbfH3F1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:27:50 -0400
X-UUID: d155563031be49d3bcfcda7a07ac0e3d-20190830
X-UUID: d155563031be49d3bcfcda7a07ac0e3d-20190830
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 924913638; Fri, 30 Aug 2019 13:27:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 13:27:43 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 13:27:43 +0800
Message-ID: <1567142858.5942.6.camel@mtksdaap41>
Subject: Re: [PATCH v5, 12/32] drm/mediatek: add mmsys private data for ddp
 path config
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
Date:   Fri, 30 Aug 2019 13:27:38 +0800
In-Reply-To: <1567090254-15566-13-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-13-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 0403CC6CAD71087F131AA535FE8BA4CF0B137D41514B8E4735E8F6BDD168E4142000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add mmsys private data for ddp path config
> all these register offset and value will be different in future SOC
> add these define into mmsys private data
> 	u32 ovl0_mout_en;
> 	u32 rdma1_sout_sel_in;
> 	u32 rdma1_sout_dsi0;
> 	u32 dpi0_sel_in;
> 	u32 dpi0_sel_in_rdma1;
> 	u32 dsi0_sel_in;
> 	u32 dsi0_sel_in_rdma1;
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  4 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 86 +++++++++++++++++++++++----------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  5 ++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  3 ++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  3 ++
>  5 files changed, 76 insertions(+), 25 deletions(-)
> 

[snip]

>  
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> +			      const struct mtk_mmsys_reg_data *reg_data,
>  			      enum mtk_ddp_comp_id cur,
>  			      enum mtk_ddp_comp_id next)
>  {
>  	unsigned int addr, value, reg;
>  
> -	value = mtk_ddp_mout_en(cur, next, &addr);
> +	value = mtk_ddp_mout_en(reg_data, cur, next, &addr);
>  	if (value) {
>  		reg = readl_relaxed(config_regs + addr) | value;
>  		writel_relaxed(reg, config_regs + addr);
>  	}
>  
> -	mtk_ddp_sout_sel(config_regs, cur, next);
> +	value = mtk_ddp_sout_sel(reg_data, cur, next, &addr);
> +	if (value)
> +		writel_relaxed(value, config_regs + addr);

I think the register could be written inside mtk_ddp_sout_sel(), why do
you move out of that function?

Regards,
CK

>  
> -	value = mtk_ddp_sel_in(cur, next, &addr);
> +	value = mtk_ddp_sel_in(reg_data, cur, next, &addr);
>  	if (value) {
>  		reg = readl_relaxed(config_regs + addr) | value;
>  		writel_relaxed(reg, config_regs + addr);
> @@ -420,18 +455,19 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
>  }
>  
>  
>  


