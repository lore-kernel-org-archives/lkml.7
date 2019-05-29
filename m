Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C506EC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFD820883
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfE2F6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 01:58:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39499 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726120AbfE2F6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 01:58:25 -0400
X-UUID: 4dfc356528964fd7bf64cd1f4a95aab7-20190529
X-UUID: 4dfc356528964fd7bf64cd1f4a95aab7-20190529
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1189642757; Wed, 29 May 2019 13:58:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkexhb01.mediatek.inc (172.21.101.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 13:58:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 29 May
 2019 13:58:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 13:58:10 +0800
Message-ID: <1559109490.15592.6.camel@mtksdaap41>
Subject: Re: [PATCH 2/3] drm: mediatek: remove clk_unprepare() in
 mtk_drm_crtc_destroy()
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
Date:   Wed, 29 May 2019 13:58:10 +0800
In-Reply-To: <20190527045054.113259-3-hsinyi@chromium.org>
References: <20190527045054.113259-1-hsinyi@chromium.org>
         <20190527045054.113259-3-hsinyi@chromium.org>
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

On Mon, 2019-05-27 at 12:50 +0800, Hsin-Yi Wang wrote:
> There is no clk_prepare() called in mtk_drm_crtc_reset(), when unbinding
> drm device, mtk_drm_crtc_destroy() will be triggered, and the clocks will
> be disabled and unprepared in mtk_crtc_ddp_clk_disable. If clk_unprepare()
> is called here, we'll get warnings[1], so remove clk_unprepare() here.

In original code, clk_prepare() is called in mtk_drm_crtc_create() and
clk_unprepare() is called in mtk_drm_crtc_destroy(). This looks correct.
I don't know why we should do any thing about clock in
mtk_drm_crtc_reset(). To debug this, the first step is to print message
when mediatek drm call clk_prepare() and clk_unprepare(). If these two
interface is called in pair, I think we should not modify mediatek drm
driver, the bug maybe in clock driver.

Regards,
CK

> 
> [1]
> [   19.416020] mm_disp_ovl0 already unprepared
> ....
> [   19.487536] pstate: 60000005 (nZCv daif -PAN -UAO)
> [   19.492325] pc : clk_core_unprepare+0x1d8/0x220
> [   19.496851] lr : clk_core_unprepare+0x1d8/0x220
> [   19.501373] sp : ffffff8017bbba30
> [   19.504681] x29: ffffff8017bbba50 x28: fffffff3f7978000
> [   19.509989] x27: 0000000000000000 x26: 0000000000000000
> [   19.515298] x25: 0000000044000000 x24: fffffff3f7978000
> [   19.520605] x23: 0000000000000060 x22: ffffff9688a89f48
> [   19.525912] x21: fffffff3f8755540 x20: 0000000000000000
> [   19.531219] x19: fffffff3f9d5ca00 x18: 00000000fffebd18
> [   19.536526] x17: 000000000000003c x16: ffffff96881458e4
> [   19.541833] x15: 0000000000000005 x14: 706572706e752079
> [   19.547140] x13: ffffff80085cc950 x12: 0000000000000000
> [   19.552446] x11: 0000000000000000 x10: 0000000000000000
> [   19.557754] x9 : 1b0fa21f0ec0d800 x8 : 1b0fa21f0ec0d800
> [   19.563060] x7 : 0000000000000000 x6 : ffffff9688b5dd07
> [   19.568366] x5 : 0000000000000000 x4 : 0000000000000000
> [   19.573673] x3 : 0000000000000000 x2 : fffffff3fffa0248
> [   19.578979] x1 : fffffff3fff97a00 x0 : 000000000000001f
> [   19.584288] Call trace:
> [   19.586734]  clk_core_unprepare+0x1d8/0x220
> [   19.590914]  clk_unprepare+0x30/0x40
> [   19.594491]  mtk_drm_crtc_destroy+0x30/0x5c
> [   19.598672]  drm_mode_config_cleanup+0x124/0x290
> [   19.603286]  mtk_drm_unbind+0x44/0x5c
> [   19.606946]  take_down_master+0x40/0x54
> [   19.610775]  component_master_del+0x70/0x94
> [   19.614952]  mtk_drm_remove+0x28/0x44
> [   19.618612]  platform_drv_remove+0x28/0x50
> [   19.622702]  device_release_driver_internal+0x138/0x1ec
> [   19.627921]  device_release_driver+0x24/0x30
> [   19.632185]  unbind_store+0x90/0xdc
> [   19.635667]  drv_attr_store+0x3c/0x54
> [   19.639327]  sysfs_kf_write+0x50/0x68
> [   19.642986]  kernfs_fop_write+0x12c/0x1c8
> [   19.646997]  __vfs_write+0x54/0x15c
> [   19.650482]  vfs_write+0xcc/0x188
> [   19.653792]  ksys_write+0x78/0xd8
> [   19.657104]  __arm64_sys_write+0x20/0x2c
> [   19.661027]  el0_svc_common+0x9c/0xfc
> [   19.664686]  el0_svc_compat_handler+0x2c/0x38
> [   19.669039]  el0_svc_compat+0x8/0x18
> [   19.672609] ---[ end trace 41ce954855cda6f0 ]---
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index acad088173da..c2b38997ac8b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -98,10 +98,6 @@ static void mtk_drm_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
>  static void mtk_drm_crtc_destroy(struct drm_crtc *crtc)
>  {
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> -	int i;
> -
> -	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
> -		clk_unprepare(mtk_crtc->ddp_comp[i]->clk);
>  
>  	mtk_disp_mutex_put(mtk_crtc->mutex);
>  


