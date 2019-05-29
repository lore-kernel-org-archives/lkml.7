Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1A7C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66435216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfE2BfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:35:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1978 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbfE2BfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:35:19 -0400
X-UUID: 309489357c424e4daafe8cb7ec3897c9-20190529
X-UUID: 309489357c424e4daafe8cb7ec3897c9-20190529
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1821457272; Wed, 29 May 2019 09:35:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 29 May
 2019 09:35:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 09:35:11 +0800
Message-ID: <1559093711.11380.6.camel@mtksdaap41>
Subject: Re: [PATCH 1/3] drm: mediatek: fix unbind functions
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 29 May 2019 09:35:11 +0800
In-Reply-To: <20190527045054.113259-2-hsinyi@chromium.org>
References: <20190527045054.113259-1-hsinyi@chromium.org>
         <20190527045054.113259-2-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-yi:

On Mon, 2019-05-27 at 12:50 +0800, Hsin-Yi Wang wrote:
> move mipi_dsi_host_unregister() to .remove since mipi_dsi_host_register()
> is called in .probe.

In the latest kernel [1], mipi_dsi_host_register() is called in
mtk_dsi_bind(), I think we don't need this part.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/mediatek/mtk_dsi.c?h=v5.2-rc2

> 
> detatch panel in mtk_dsi_destroy_conn_enc(), since .bind will try to
> attach it again.
> 
> Fixes: 2e54c14e310f ("drm/mediatek: Add DSI sub driver")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index b00eb2d2e086..c9b6d3a68c8b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -844,6 +844,8 @@ static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi)
>  	/* Skip connector cleanup if creation was delegated to the bridge */
>  	if (dsi->conn.dev)
>  		drm_connector_cleanup(&dsi->conn);
> +	if (dsi->panel)
> +		drm_panel_detach(dsi->panel);

I think mtk_dsi_destroy_conn_enc() has much thing to do and I would like
you to do more. You could refer to [2] for complete implementation.

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/exynos/exynos_drm_dsi.c?h=v5.2-rc2#n1575

Regards,
CK

>  }
>  
>  static void mtk_dsi_ddp_start(struct mtk_ddp_comp *comp)
> @@ -1073,7 +1075,6 @@ static void mtk_dsi_unbind(struct device *dev, struct device *master,
>  	struct mtk_dsi *dsi = dev_get_drvdata(dev);
>  
>  	mtk_dsi_destroy_conn_enc(dsi);
> -	mipi_dsi_host_unregister(&dsi->host);
>  	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>  }
>  
> @@ -1179,6 +1180,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
>  
>  	mtk_output_dsi_disable(dsi);
>  	component_del(&pdev->dev, &mtk_dsi_component_ops);
> +	mipi_dsi_host_unregister(&dsi->host);
>  
>  	return 0;
>  }


