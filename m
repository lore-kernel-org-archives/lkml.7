Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F7C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CE22075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfE1Ixb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:53:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54814 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726702AbfE1Ixa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:53:30 -0400
X-UUID: 3bf0cdba7e454cf191ca3bdb5d6ffc8c-20190528
X-UUID: 3bf0cdba7e454cf191ca3bdb5d6ffc8c-20190528
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 919406679; Tue, 28 May 2019 16:53:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 28 May
 2019 16:53:06 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 28 May 2019 16:53:06 +0800
Message-ID: <1559033586.5141.3.camel@mtksdaap41>
Subject: Re: [PATCH v3] gpu/drm: mediatek: call mtk_dsi_stop() after
 mtk_drm_crtc_atomic_disable()
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 28 May 2019 16:53:06 +0800
In-Reply-To: <20190528073908.633-1-hsinyi@chromium.org>
References: <20190528073908.633-1-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

On Tue, 2019-05-28 at 15:39 +0800, Hsin-Yi Wang wrote:
> mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(), which needs
> ovl irq for drm_crtc_wait_one_vblank(), since after mtk_dsi_stop() is called,
> ovl irq will be disabled. If drm_crtc_wait_one_vblank() is called after last
> irq, it will timeout with this message: "vblank wait timed out on crtc 0". This
> happens sometimes when turning off the screen.
> 
> In drm_atomic_helper.c#disable_outputs(),
> the calling sequence when turning off the screen is:
> 
> 1. mtk_dsi_encoder_disable()
>      --> mtk_output_dsi_disable()
>        --> mtk_dsi_stop();  // sometimes make vblank timeout in atomic_disable
>        --> mtk_dsi_poweroff();
> 2. mtk_drm_crtc_atomic_disable()
>      --> drm_crtc_wait_one_vblank();
>      ...
>        --> mtk_dsi_ddp_stop()
>          --> mtk_dsi_poweroff();
> 
> mtk_dsi_poweroff() has reference count design, change to make mtk_dsi_stop()
> called in mtk_dsi_poweroff() when refcount is 0.
> 
> Fixes: 0707632b5bac ("drm/mediatek: update DSI sub driver flow for sending commands to panel")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change log v2->v3:
> * remove unnecessary codes in unbind
> * based on discussion in v2, if we move mtk_dsi_start() to mtk_dsi_poweron(),
> in order to make mtk_dsi_start() and mtk_dsi_stop() symmetric, will results in
> no irq for panel with bridge. So we keep mtk_dsi_start() in original place.

I think we've already discussed in [1]. I need a reason to understand
this is hardware behavior or software bug. If this is a software bug, we
need to fix the bug and code could be symmetric.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2019-March/018423.html

Regards,
CK

> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index b00eb2d2e086..b7f829ecd3ad 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -630,6 +630,8 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>  	if (--dsi->refcount != 0)
>  		return;
>  
> +	mtk_dsi_stop(dsi);
> +
>  	if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
>  		if (dsi->panel) {
>  			if (drm_panel_unprepare(dsi->panel)) {
> @@ -696,7 +698,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
>  		}
>  	}
>  
> -	mtk_dsi_stop(dsi);
>  	mtk_dsi_poweroff(dsi);
>  
>  	dsi->enabled = false;


