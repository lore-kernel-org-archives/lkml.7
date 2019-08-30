Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B930CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B4C20659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfH3GbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:31:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58925 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbfH3GbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:31:02 -0400
X-UUID: b911d93b8a8d4f329b4c8b0c92d915fa-20190830
X-UUID: b911d93b8a8d4f329b4c8b0c92d915fa-20190830
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1160289486; Fri, 30 Aug 2019 14:30:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 14:30:53 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 14:30:53 +0800
Message-ID: <1567146647.5942.19.camel@mtksdaap41>
Subject: Re: [PATCH v5, 28/32] drm/mediatek: add connection from OVL_2L0 to
 RDMA0
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
Date:   Fri, 30 Aug 2019 14:30:47 +0800
In-Reply-To: <1567090254-15566-29-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-29-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 4CE476717C2C671C40EAF66D9332FFD3A6FB89C3A2A75C9C0B564E557C4AD3FA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> this patch add add connection from OVL_2L0 to RDMA0

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index aa6173b..943e114 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -33,6 +33,12 @@
>  #define DISP_REG_CONFIG_DSI_SEL			0x050
>  #define DISP_REG_CONFIG_DPI_SEL			0x064
>  
> +#define MT8183_DISP_OVL0_2L_MOUT_EN		0xf04
> +#define MT8183_DISP_PATH0_SEL_IN		0xf24
> +
> +#define OVL0_2L_MOUT_EN_DISP_PATH0			BIT(0)
> +#define DISP_PATH0_SEL_IN_OVL0_2L			0x1
> +
>  #define MT2701_DISP_MUTEX0_MOD0			0x2c
>  #define MT2701_DISP_MUTEX0_SOF0			0x30
>  
> @@ -307,6 +313,10 @@ static unsigned int mtk_ddp_mout_en(const struct mtk_mmsys_reg_data *data,
>  	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_OVL_2L0) {
>  		*addr = data->ovl0_mout_en;
>  		value = OVL0_MOUT_EN_OVL0_2L;
> +	} else if (cur == DDP_COMPONENT_OVL_2L0 &&
> +		   next == DDP_COMPONENT_RDMA0) {
> +		*addr = MT8183_DISP_OVL0_2L_MOUT_EN;
> +		value = OVL0_2L_MOUT_EN_DISP_PATH0;
>  	} else {
>  		value = 0;
>  	}
> @@ -366,6 +376,10 @@ static unsigned int mtk_ddp_sel_in(const struct mtk_mmsys_reg_data *data,
>  	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
>  		*addr = DISP_REG_CONFIG_DSI_SEL;
>  		value = DSI_SEL_IN_BLS;
> +	} else if (cur == DDP_COMPONENT_OVL_2L0 &&
> +		   next == DDP_COMPONENT_RDMA0) {
> +		*addr = MT8183_DISP_PATH0_SEL_IN;
> +		value = DISP_PATH0_SEL_IN_OVL0_2L;
>  	} else {
>  		value = 0;
>  	}


