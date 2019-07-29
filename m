Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F9C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D2C2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfG2Gtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:49:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfG2Gtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:49:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BEA15D77010AD440D088;
        Mon, 29 Jul 2019 14:49:46 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 14:49:45 +0800
Subject: Re: [PATCH] drm/bridge: lvds-encoder: Fix build error
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <eric@anholt.net>
References: <20190729063539.19328-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <69256ea7-b831-00eb-7d48-82302689574e@huawei.com>
Date:   Mon, 29 Jul 2019 14:49:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190729063539.19328-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls drop this one, will resend new.

On 2019/7/29 14:35, YueHaibing wrote:
> If CONFIG_DRM_LVDS_ENCODER=y but CONFIG_DRM_KMS_HELPER=m,
> build fails:
> 
> drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
> lvds-encoder.c:(.text+0x155): undefined reference to `devm_drm_panel_bridge_add'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: dbb58bfd9ae6 drm/bridge: ("Fix lvds-encoder since the panel_bridge rework.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index a6eec90..2926750 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -8,7 +8,7 @@ config DRM_BRIDGE
>  config DRM_PANEL_BRIDGE
>  	def_bool y
>  	depends on DRM_BRIDGE
> -	depends on DRM_KMS_HELPER
> +	select DRM_KMS_HELPER
>  	select DRM_PANEL
>  	help
>  	  DRM bridge wrapper of DRM panels
> 

