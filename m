Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA0C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9698920872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfGKGmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:42:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24139 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbfGKGmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:42:20 -0400
X-UUID: 933fac2b4b2d49e8b026ef4fde19c715-20190711
X-UUID: 933fac2b4b2d49e8b026ef4fde19c715-20190711
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1755053807; Thu, 11 Jul 2019 14:42:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 11 Jul
 2019 14:41:58 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Jul 2019 14:41:58 +0800
Message-ID: <1562827318.5818.0.camel@mtksdaap41>
Subject: Re: [PATCH v7 4/4] drm/mtk: add panel orientation property
From:   CK Hu <ck.hu@mediatek.com>
To:     Derek Basehore <dbasehore@chromium.org>
CC:     <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 11 Jul 2019 14:41:58 +0800
In-Reply-To: <20190710021659.177950-5-dbasehore@chromium.org>
References: <20190710021659.177950-1-dbasehore@chromium.org>
         <20190710021659.177950-5-dbasehore@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Derek:

On Tue, 2019-07-09 at 19:16 -0700, Derek Basehore wrote:
> This inits the panel orientation property for the mediatek dsi driver
> if the panel orientation (connector.display_info.panel_orientation) is
> not DRM_MODE_PANEL_ORIENTATION_UNKNOWN.
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index b91c4616644a..2920458ae2fb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -790,10 +790,18 @@ static int mtk_dsi_create_connector(struct drm_device *drm, struct mtk_dsi *dsi)
>  			DRM_ERROR("Failed to attach panel to drm\n");
>  			goto err_connector_cleanup;
>  		}
> +
> +		ret = drm_connector_init_panel_orientation_property(&dsi->conn);
> +		if (ret) {
> +			DRM_ERROR("Failed to init panel orientation\n");
> +			goto err_panel_detach;
> +		}
>  	}
>  
>  	return 0;
>  
> +err_panel_detach:
> +	drm_panel_detach(dsi->panel);
>  err_connector_cleanup:
>  	drm_connector_cleanup(&dsi->conn);
>  	return ret;


