Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C149020818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGQGzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:55:09 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:59306 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727012AbfGQGzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:55:07 -0400
X-UUID: 9f1c975c797c4aa99fc512c38799216e-20190717
X-UUID: 9f1c975c797c4aa99fc512c38799216e-20190717
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1132981241; Wed, 17 Jul 2019 14:55:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Jul 2019 14:55:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Jul 2019 14:55:01 +0800
Message-ID: <1563346501.29169.25.camel@mtksdaap41>
Subject: Re: [PATCH v4, 24/33] drm/mediatek: distinguish ovl and ovl_2l by
 layer_nr
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
Date:   Wed, 17 Jul 2019 14:55:01 +0800
In-Reply-To: <1562625253-29254-25-git-send-email-yongqiang.niu@mediatek.com>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
         <1562625253-29254-25-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 11F1DE6BD2C0561D80B2B9B084DC8B4CE48F7F7536BCB170DD002279A4AB79AD2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Tue, 2019-07-09 at 06:34 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> distinguish ovl and ovl_2l by layer_nr when get comp
> id
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 8ca4965..7e99827 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -326,7 +326,12 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_OVL);
> +	priv->data = of_device_get_match_data(dev);
> +
> +	comp_id = mtk_ddp_comp_get_id(dev->of_node,
> +				      priv->data->layer_nr == 4 ?
> +				      MTK_DISP_OVL :
> +				      MTK_DISP_OVL_2L);
>  	if (comp_id < 0) {
>  		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
>  		return comp_id;
> @@ -339,8 +344,6 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	priv->data = of_device_get_match_data(dev);
> -
>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = devm_request_irq(dev, irq, mtk_disp_ovl_irq_handler,


