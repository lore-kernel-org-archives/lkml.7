Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9EBC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B152075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nh0J9d5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfE0Evm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 00:51:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39366 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Evi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:51:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so8840425pfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUlmxOGnO1980oiGUAyuWMhEyWoJa2PD9pLjCihMzns=;
        b=nh0J9d5tWECthEBuxY2gAfAcXw9czzCE8YBbgHOFmoDnQGRnZEmVmdROoGoBbFK5l5
         S5RwdS7TIk22ToA6KWeEGhKKKMhk701Hett9H/ziY9fXTnM2ZOxXEYwhuy2heRufHuva
         pU6I6/OE0aiTYhfWOUjCBadxOrSI2D3SvI0JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUlmxOGnO1980oiGUAyuWMhEyWoJa2PD9pLjCihMzns=;
        b=i/0MDM6MCSYFWh+JDnC2lII9xNSn7bJfrLniCP9RjQUu5XaloYeAzDRerQX9KnS8Hx
         2B1BUEq0Mg0IPJut9nAcodgIzCNUg6b7jynReD95uGWVqmSiS3gbmjZW9WQkROnUCEAr
         ZkXZ7AWCuXFzqSNxMp3CvT7wyDpkcZvENwk3qzCXograjgr+nSENxdHldJEwu41wRuEZ
         DZzB2P9q/q8v7p9Wji69VVMBAl7HCbC0ekHz2PUQVFCmkX+NToq8Vkc1WAV+n4Cmx5qx
         yR4DaT1Gwb3RnBhi6LLHouSmkRjPGDw0H1FT2I7kq/VssgenyIUN/l2NWOZCiCSBbvLa
         6j6w==
X-Gm-Message-State: APjAAAXnWZ3RK46lyPJ9Kr3ljAmFabrIXpCpc7svgrMgGiJQVBtF2gNe
        G6difxtD0FoHCXQgBcDBq5Dizg==
X-Google-Smtp-Source: APXvYqzFWcOQGNGke5SxYSfkPoz9/3QKFu6HpjgLwWyUA0idRxx7jSQ5CVK8tJUBDNqu1vgLMfZVlg==
X-Received: by 2002:a63:6bc3:: with SMTP id g186mr111791764pgc.21.1558932698131;
        Sun, 26 May 2019 21:51:38 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id t18sm8082745pgm.69.2019.05.26.21.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 21:51:37 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm: mediatek: unbind components in mtk_drm_unbind()
Date:   Mon, 27 May 2019 12:50:54 +0800
Message-Id: <20190527045054.113259-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527045054.113259-1-hsinyi@chromium.org>
References: <20190527045054.113259-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unbinding components (i.e. mtk_dsi and mtk_disp_ovl/rdma/color) will
trigger master(mtk_drm)'s .unbind(), and currently mtk_drm's unbind
won't actually unbind components. During the next bind,
mtk_drm_kms_init() is called, and the components are added back.

.unbind() should call mtk_drm_kms_deinit() to unbind components.

And since component_master_del() in .remove() will trigger .unbind(),
which will also unregister device, it's fine to remove original functions
called here.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 57ce4708ef1b..bbfe3a464aea 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -311,6 +311,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 static void mtk_drm_kms_deinit(struct drm_device *drm)
 {
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
@@ -397,7 +398,9 @@ static void mtk_drm_unbind(struct device *dev)
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 
 	drm_dev_unregister(private->drm);
+	mtk_drm_kms_deinit(private->drm);
 	drm_dev_put(private->drm);
+	private->num_pipes = 0;
 	private->drm = NULL;
 }
 
@@ -568,13 +571,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
 static int mtk_drm_remove(struct platform_device *pdev)
 {
 	struct mtk_drm_private *private = platform_get_drvdata(pdev);
-	struct drm_device *drm = private->drm;
 	int i;
 
-	drm_dev_unregister(drm);
-	mtk_drm_kms_deinit(drm);
-	drm_dev_put(drm);
-
 	component_master_del(&pdev->dev, &mtk_drm_ops);
 	pm_runtime_disable(&pdev->dev);
 	of_node_put(private->mutex_node);
-- 
2.20.1

