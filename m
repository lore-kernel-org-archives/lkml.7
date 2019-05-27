Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E441C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C432075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjbKieko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0Evi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 00:51:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43704 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Evg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:51:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so8832516pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 21:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nTNnUu5Pg74lFPYV76pxj/avOtvPxN38IgfsN4zW7KQ=;
        b=fjbKiekoEYOoJBE0nUV6/Q9YCysuZfEp+pEMPPi41BXxdQCweXz3u6dxC632AR4SmS
         y2yCfjzWKum60A/UdH1QkxrFpcR111NmZhwY2ZqRwh9ElglQSnMEFWXz4doFbAksG3fj
         /Q/d3ScgIQ/QIeK6u0PHG4rbgVSsL949aTXQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTNnUu5Pg74lFPYV76pxj/avOtvPxN38IgfsN4zW7KQ=;
        b=XuuV8EsxgQZBpahznzGFMVqAVBcw7EWzLn4aLucye4kys8G2Kzx3t0PRMP9xJBPgon
         npRDgRYTITrTTZrFUReLWTLv7q/nfoQFFvoBKF26jcMlL/m1rXcgyV22lxN4clRho+/a
         RLbgyVzWsiyFZdFkNHoukCDI84KUcEZEknX73IN1xHn3sDF68COWFntmvs/pXy8YBJBV
         pPhPgKTImRepySB9nIvdV5G/pfk+cLEDlXdP2qi/RjsmhrmrGYVbCS701P771eRGTNUz
         GWmRV37wXRFzA5swKm2eHvMA3I2LffrhwupKLCS264HyG5Fwnm5VX/Og4NtEI6kQgADx
         12fg==
X-Gm-Message-State: APjAAAWKpFRBj1Nf/p2gDfiyExpvXD0fj5QDdQwJmv3djI4+vQKYwSYm
        PUgLksk5WvieMoX9T1a7NWilNw==
X-Google-Smtp-Source: APXvYqx8WppvdjWZOUQtU7qfCXOcLLa/ChE21AsiaFIreNV8ZZUyC8OHhrhAkIaKUz2GmqI9e+qn3Q==
X-Received: by 2002:a17:90a:fa09:: with SMTP id cm9mr28441942pjb.137.1558932695346;
        Sun, 26 May 2019 21:51:35 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id t18sm8082745pgm.69.2019.05.26.21.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 21:51:34 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm: mediatek: remove clk_unprepare() in mtk_drm_crtc_destroy()
Date:   Mon, 27 May 2019 12:50:53 +0800
Message-Id: <20190527045054.113259-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527045054.113259-1-hsinyi@chromium.org>
References: <20190527045054.113259-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no clk_prepare() called in mtk_drm_crtc_reset(), when unbinding
drm device, mtk_drm_crtc_destroy() will be triggered, and the clocks will
be disabled and unprepared in mtk_crtc_ddp_clk_disable. If clk_unprepare()
is called here, we'll get warnings[1], so remove clk_unprepare() here.

[1]
[   19.416020] mm_disp_ovl0 already unprepared
....
[   19.487536] pstate: 60000005 (nZCv daif -PAN -UAO)
[   19.492325] pc : clk_core_unprepare+0x1d8/0x220
[   19.496851] lr : clk_core_unprepare+0x1d8/0x220
[   19.501373] sp : ffffff8017bbba30
[   19.504681] x29: ffffff8017bbba50 x28: fffffff3f7978000
[   19.509989] x27: 0000000000000000 x26: 0000000000000000
[   19.515298] x25: 0000000044000000 x24: fffffff3f7978000
[   19.520605] x23: 0000000000000060 x22: ffffff9688a89f48
[   19.525912] x21: fffffff3f8755540 x20: 0000000000000000
[   19.531219] x19: fffffff3f9d5ca00 x18: 00000000fffebd18
[   19.536526] x17: 000000000000003c x16: ffffff96881458e4
[   19.541833] x15: 0000000000000005 x14: 706572706e752079
[   19.547140] x13: ffffff80085cc950 x12: 0000000000000000
[   19.552446] x11: 0000000000000000 x10: 0000000000000000
[   19.557754] x9 : 1b0fa21f0ec0d800 x8 : 1b0fa21f0ec0d800
[   19.563060] x7 : 0000000000000000 x6 : ffffff9688b5dd07
[   19.568366] x5 : 0000000000000000 x4 : 0000000000000000
[   19.573673] x3 : 0000000000000000 x2 : fffffff3fffa0248
[   19.578979] x1 : fffffff3fff97a00 x0 : 000000000000001f
[   19.584288] Call trace:
[   19.586734]  clk_core_unprepare+0x1d8/0x220
[   19.590914]  clk_unprepare+0x30/0x40
[   19.594491]  mtk_drm_crtc_destroy+0x30/0x5c
[   19.598672]  drm_mode_config_cleanup+0x124/0x290
[   19.603286]  mtk_drm_unbind+0x44/0x5c
[   19.606946]  take_down_master+0x40/0x54
[   19.610775]  component_master_del+0x70/0x94
[   19.614952]  mtk_drm_remove+0x28/0x44
[   19.618612]  platform_drv_remove+0x28/0x50
[   19.622702]  device_release_driver_internal+0x138/0x1ec
[   19.627921]  device_release_driver+0x24/0x30
[   19.632185]  unbind_store+0x90/0xdc
[   19.635667]  drv_attr_store+0x3c/0x54
[   19.639327]  sysfs_kf_write+0x50/0x68
[   19.642986]  kernfs_fop_write+0x12c/0x1c8
[   19.646997]  __vfs_write+0x54/0x15c
[   19.650482]  vfs_write+0xcc/0x188
[   19.653792]  ksys_write+0x78/0xd8
[   19.657104]  __arm64_sys_write+0x20/0x2c
[   19.661027]  el0_svc_common+0x9c/0xfc
[   19.664686]  el0_svc_compat_handler+0x2c/0x38
[   19.669039]  el0_svc_compat+0x8/0x18
[   19.672609] ---[ end trace 41ce954855cda6f0 ]---

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index acad088173da..c2b38997ac8b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -98,10 +98,6 @@ static void mtk_drm_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
 static void mtk_drm_crtc_destroy(struct drm_crtc *crtc)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	int i;
-
-	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
-		clk_unprepare(mtk_crtc->ddp_comp[i]->clk);
 
 	mtk_disp_mutex_put(mtk_crtc->mutex);
 
-- 
2.20.1

