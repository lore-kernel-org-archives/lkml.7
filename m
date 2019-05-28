Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1662C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7034E208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GUdlc/vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfE1F5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:57:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37530 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbfE1F5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:57:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so10281037pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8mj9qGbzot8Xj37nuez+wWnw7XkoYPD1tlUP7ZA3qY=;
        b=GUdlc/vZi39Kmj7FgkmdCG+O8kOKEKk39Z6dNSk/VYAd7L1TB7MXDZ/TYYkrEQ/qOa
         aJLBYZdc9afN00AOL3+z1ztKDs8usbb6wS1xFC2qNMg0zV2RDZFS2zK4paCH2pOPxw2X
         05f5lVryqfltU1mATDlnZzsjiYfQERqMKjr9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8mj9qGbzot8Xj37nuez+wWnw7XkoYPD1tlUP7ZA3qY=;
        b=sSClwZClLUeD/e0VL7GZwxn8FxQrpTCq6dQKnjLbVfqYsXmqPV4wVWZzdK/o4n098r
         8o7cNG4ZV9og+DsAcUvmxSzKXesFuVtIe69qspZ113l0uAFEErwdySECgH/3Ij9yZy0M
         armjF0x/OUCpWHQC1rAQCt/Bv8PSbS7tiH3QhuIFaA3vBv5oQfca8Z5N/sJ89+u8sdx1
         f2l2/x6s+cnzVbgh6jsGcBrWYREQE+YxHncEBlSOovh2uhj/cXaErwbNbTWBQYW9t+K9
         E0KMkpUIJKHS12AhLvz9VIm5BwkqI+PIIRh7AKoV9TGvMEgY7jyxd8SbCt9CvXuy33tV
         AuCQ==
X-Gm-Message-State: APjAAAUqQgHCKcbX0qWJFi6/0FOxQC3voi2VksMKk4noVl2njyGYOZRQ
        27FZCJdYeAoWpKH7iFepLKOUXA==
X-Google-Smtp-Source: APXvYqwIV6GdnU24EfH5xLs3vWriiE99LZ1YsYg0z958dKGDjwKOgLO6Gf6ZE/d554C3ffc0PPtXOA==
X-Received: by 2002:a65:624f:: with SMTP id q15mr130429358pgv.436.1559023061943;
        Mon, 27 May 2019 22:57:41 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id w1sm13950551pfg.51.2019.05.27.22.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 22:57:41 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv1 11/12] media: mtk-vcodec: vdec: add media device if using stateless api
Date:   Tue, 28 May 2019 14:56:34 +0900
Message-Id: <20190528055635.12109-12-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190528055635.12109-1-acourbot@chromium.org>
References: <20190528055635.12109-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

The stateless API requires a media device for issuing requests. Add one
if it turns out we are using it.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
[acourbot: refactor, cleanup and split]
---
 drivers/media/platform/Kconfig                |  1 +
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  | 40 +++++++++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  2 +
 3 files changed, 43 insertions(+)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 853330c642f1..f5476827259b 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -247,6 +247,7 @@ config VIDEO_MEDIATEK_VCODEC
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	select VIDEO_MEDIATEK_VPU
+	select MEDIA_CONTROLLER
 	help
 	    Mediatek video codec driver provides HW capability to
 	    encode and decode in a range of video formats
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index ffa6f3d0869d..8be0c04f7e81 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -22,6 +22,7 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
+#include <media/v4l2-device.h>
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_dec.h"
@@ -337,6 +338,31 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_event_workq;
 	}
 
+	if (dev->vdec_pdata->uses_stateless_api) {
+		dev->mdev_dec.dev = &pdev->dev;
+		strscpy(dev->mdev_dec.model, MTK_VCODEC_DEC_NAME,
+				sizeof(dev->mdev_dec.model));
+
+		media_device_init(&dev->mdev_dec);
+		dev->mdev_dec.ops = &mtk_vcodec_media_ops;
+		dev->v4l2_dev.mdev = &dev->mdev_dec;
+
+		ret = v4l2_m2m_register_media_controller(dev->m2m_dev_dec,
+			dev->vfd_dec, MEDIA_ENT_F_PROC_VIDEO_DECODER);
+		if (ret) {
+			mtk_v4l2_err("Failed to register media controller");
+			goto err_reg_cont;
+		}
+
+		ret = media_device_register(&dev->mdev_dec);
+		if (ret) {
+			mtk_v4l2_err("Failed to register media device");
+			goto err_media_reg;
+		}
+
+		mtk_v4l2_debug(0, "media registered as /dev/media%d",
+			vfd_dec->num);
+	}
 	ret = video_register_device(vfd_dec, VFL_TYPE_GRABBER, 0);
 	if (ret) {
 		mtk_v4l2_err("Failed to register video device");
@@ -349,6 +375,12 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	return 0;
 
 err_dec_reg:
+	if (dev->vdec_pdata->uses_stateless_api)
+		media_device_unregister(&dev->mdev_dec);
+err_media_reg:
+	if (dev->vdec_pdata->uses_stateless_api)
+		v4l2_m2m_unregister_media_controller(dev->m2m_dev_dec);
+err_reg_cont:
 	destroy_workqueue(dev->decode_workqueue);
 err_event_workq:
 	v4l2_m2m_release(dev->m2m_dev_dec);
@@ -362,6 +394,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 }
 
 extern const struct mtk_vcodec_dec_pdata mtk_frame_8173_pdata;
+extern const struct mtk_vcodec_dec_pdata mtk_req_8183_pdata;
 
 static const struct of_device_id mtk_vcodec_match[] = {
 	{
@@ -379,6 +412,13 @@ static int mtk_vcodec_dec_remove(struct platform_device *pdev)
 
 	flush_workqueue(dev->decode_workqueue);
 	destroy_workqueue(dev->decode_workqueue);
+
+	if (media_devnode_is_registered(dev->mdev_dec.devnode)) {
+		media_device_unregister(&dev->mdev_dec);
+		v4l2_m2m_unregister_media_controller(dev->m2m_dev_dec);
+		media_device_cleanup(&dev->mdev_dec);
+	}
+
 	if (dev->m2m_dev_dec)
 		v4l2_m2m_release(dev->m2m_dev_dec);
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 6ce7b3a14193..38e499bb7d2b 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -353,6 +353,7 @@ struct mtk_vcodec_dec_pdata {
  * struct mtk_vcodec_dev - driver data
  * @v4l2_dev: V4L2 device to register video devices for.
  * @vfd_dec: Video device for decoder
+ * @mdev_dec: Media device for decoder
  * @vfd_enc: Video device for encoder.
  *
  * @m2m_dev_dec: m2m device for decoder
@@ -389,6 +390,7 @@ struct mtk_vcodec_dec_pdata {
 struct mtk_vcodec_dev {
 	struct v4l2_device v4l2_dev;
 	struct video_device *vfd_dec;
+	struct media_device mdev_dec;
 	struct video_device *vfd_enc;
 
 	struct v4l2_m2m_dev *m2m_dev_dec;
-- 
2.22.0.rc1.257.g3120a18244-goog

