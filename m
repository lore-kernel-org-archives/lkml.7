Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E15C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FB2214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565387153;
	bh=sfTjuwi8pWUgoSihYRLC2rC3ps8LjdVj2oOl8OMRaf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w7md67ENkwCfJoXHh1mniMs9WnftQfyQSdD8+k7jRc2gUBOVk5WK/fYWJibtjR1W5
	 PyRQocPB1FdIGKQgQegjma1k6MHOJ88mI86iWpwX+5w6/MsmOIglmxw3sfffjRojIA
	 uqVgBAezL8qDSBT2u6dwNHlFqJgXiY40sYCYkgjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfHIVpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:45:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33444 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfHIVpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:45:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so138005973otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVpKg76iNK8Q/96SWBmPErgH7+sWQHry8Kj0z1Q3E4s=;
        b=VPG1KTp/U3INFqDj/Hn3VLHmSyuQMd3T6+O/C0Cmwq9AD5aPNiFJoLIbZ+qA5GiDCM
         nDjwxr1VqTeaeCLG9s/7Pff8yI1GJ4X7k79SpE2tRv/jSayXwVf4jyH0Z4wIloNYDZZc
         JvRKBhAnChodTNPzUrdwsq8CT+xfNzKB4Ukf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVpKg76iNK8Q/96SWBmPErgH7+sWQHry8Kj0z1Q3E4s=;
        b=AtqzmDayLqEtQJI8G9lZgS/mFNb9Fs54LaNLsKkVg1a97ozVs/x4QVn9vGf/f6Aw+U
         3LmHt7+Zz6kKHpuS5s6xm9iTzBWmuqxxEFVR0cU8KyiVlz9otTMObkOgcKUkuSQ60n/s
         76vJrsYrE2HMtKyek8gafsiUmeEmGGGOHWKivoQt1orFTrq8Xs+bri1fNqPw/n1hrfs3
         So2bJed+uaqQOB+WG6qwo0qv369ZZ8SYrOq3SsXvFplhzvzjwPxv+q8hVKus2+AOs9lF
         vx8ayoXDMZm4fv3F7ZsGipIEj1h+fGPHorGkwDmfG7tSeFHPRAVPFyy4CKe5ojQ/ejKv
         k4pg==
X-Gm-Message-State: APjAAAVmwyXO9jTDAGg+Vx1FNLHN9w4Gxo/O41XGbxkKgwnV9mqIAIwD
        p0W18Jy8L1w3f9bLWOIM01fd6g==
X-Google-Smtp-Source: APXvYqym8uiYgHJ73R3fcQFikPHmj9xtcamzMx0wWGxeIp2gzZe9jI3kGz/pr3OE7haDJQqFvoVgsw==
X-Received: by 2002:a6b:8f82:: with SMTP id r124mr12222862iod.6.1565387149231;
        Fri, 09 Aug 2019 14:45:49 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n17sm75861623iog.63.2019.08.09.14.45.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 14:45:48 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, helen.koike@collabora.com, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 1/3] media: vimc: move private defines to a common header
Date:   Fri,  9 Aug 2019 15:45:41 -0600
Message-Id: <142cc5a6a10f75ed97de8b2d9b1e73b034a88b2f.1565386363.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1565386363.git.skhan@linuxfoundation.org>
References: <cover.1565386363.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for collapsing the component driver structure into
a monolith, move private device structure defines to a new common
header file.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/media/platform/vimc/vimc-capture.c |  21 +----
 drivers/media/platform/vimc/vimc-core.c    |  18 +---
 drivers/media/platform/vimc/vimc-debayer.c |  16 +---
 drivers/media/platform/vimc/vimc-scaler.c  |  15 +--
 drivers/media/platform/vimc/vimc-sensor.c  |  13 +--
 drivers/media/platform/vimc/vimc.h         | 102 +++++++++++++++++++++
 6 files changed, 107 insertions(+), 78 deletions(-)
 create mode 100644 drivers/media/platform/vimc/vimc.h

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index 664855708fdf..c52fc5d97c2d 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -13,6 +13,7 @@
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-vmalloc.h>
 
+#include "vimc.h"
 #include "vimc-common.h"
 #include "vimc-streamer.h"
 
@@ -44,26 +45,6 @@ static const u32 vimc_cap_supported_pixfmt[] = {
 	V4L2_PIX_FMT_SRGGB12,
 };
 
-struct vimc_cap_device {
-	struct vimc_ent_device ved;
-	struct video_device vdev;
-	struct device *dev;
-	struct v4l2_pix_format format;
-	struct vb2_queue queue;
-	struct list_head buf_list;
-	/*
-	 * NOTE: in a real driver, a spin lock must be used to access the
-	 * queue because the frames are generated from a hardware interruption
-	 * and the isr is not allowed to sleep.
-	 * Even if it is not necessary a spinlock in the vimc driver, we
-	 * use it here as a code reference
-	 */
-	spinlock_t qlock;
-	struct mutex lock;
-	u32 sequence;
-	struct vimc_stream stream;
-};
-
 static const struct v4l2_pix_format fmt_default = {
 	.width = 640,
 	.height = 480,
diff --git a/drivers/media/platform/vimc/vimc-core.c b/drivers/media/platform/vimc/vimc-core.c
index 571c55aa0e16..c9b351472272 100644
--- a/drivers/media/platform/vimc/vimc-core.c
+++ b/drivers/media/platform/vimc/vimc-core.c
@@ -12,6 +12,7 @@
 #include <media/media-device.h>
 #include <media/v4l2-device.h>
 
+#include "vimc.h"
 #include "vimc-common.h"
 
 #define VIMC_MDEV_MODEL_NAME "VIMC MDEV"
@@ -24,23 +25,6 @@
 	.flags = link_flags,					\
 }
 
-struct vimc_device {
-	/* The platform device */
-	struct platform_device pdev;
-
-	/* The pipeline configuration */
-	const struct vimc_pipeline_config *pipe_cfg;
-
-	/* The Associated media_device parent */
-	struct media_device mdev;
-
-	/* Internal v4l2 parent device*/
-	struct v4l2_device v4l2_dev;
-
-	/* Subdevices */
-	struct platform_device **subdevs;
-};
-
 /* Structure which describes individual configuration for each entity */
 struct vimc_ent_config {
 	const char *name;
diff --git a/drivers/media/platform/vimc/vimc-debayer.c b/drivers/media/platform/vimc/vimc-debayer.c
index 00598fbf3cba..750752bb173c 100644
--- a/drivers/media/platform/vimc/vimc-debayer.c
+++ b/drivers/media/platform/vimc/vimc-debayer.c
@@ -13,6 +13,7 @@
 #include <linux/v4l2-mediabus.h>
 #include <media/v4l2-subdev.h>
 
+#include "vimc.h"
 #include "vimc-common.h"
 
 #define VIMC_DEB_DRV_NAME "vimc-debayer"
@@ -44,21 +45,6 @@ struct vimc_deb_pix_map {
 	enum vimc_deb_rgb_colors order[2][2];
 };
 
-struct vimc_deb_device {
-	struct vimc_ent_device ved;
-	struct v4l2_subdev sd;
-	struct device *dev;
-	/* The active format */
-	struct v4l2_mbus_framefmt sink_fmt;
-	u32 src_code;
-	void (*set_rgb_src)(struct vimc_deb_device *vdeb, unsigned int lin,
-			    unsigned int col, unsigned int rgb[3]);
-	/* Values calculated when the stream starts */
-	u8 *src_frame;
-	const struct vimc_deb_pix_map *sink_pix_map;
-	unsigned int sink_bpp;
-};
-
 static const struct v4l2_mbus_framefmt sink_fmt_default = {
 	.width = 640,
 	.height = 480,
diff --git a/drivers/media/platform/vimc/vimc-scaler.c b/drivers/media/platform/vimc/vimc-scaler.c
index c7123a45c55b..fe99b9102ada 100644
--- a/drivers/media/platform/vimc/vimc-scaler.c
+++ b/drivers/media/platform/vimc/vimc-scaler.c
@@ -13,6 +13,7 @@
 #include <linux/v4l2-mediabus.h>
 #include <media/v4l2-subdev.h>
 
+#include "vimc.h"
 #include "vimc-common.h"
 
 #define VIMC_SCA_DRV_NAME "vimc-scaler"
@@ -31,20 +32,6 @@ static const u32 vimc_sca_supported_pixfmt[] = {
 	V4L2_PIX_FMT_ARGB32,
 };
 
-struct vimc_sca_device {
-	struct vimc_ent_device ved;
-	struct v4l2_subdev sd;
-	struct device *dev;
-	/* NOTE: the source fmt is the same as the sink
-	 * with the width and hight multiplied by mult
-	 */
-	struct v4l2_mbus_framefmt sink_fmt;
-	/* Values calculated when the stream starts */
-	u8 *src_frame;
-	unsigned int src_line_size;
-	unsigned int bpp;
-};
-
 static const struct v4l2_mbus_framefmt sink_fmt_default = {
 	.width = 640,
 	.height = 480,
diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
index 51359472eef2..6c57b1e262f9 100644
--- a/drivers/media/platform/vimc/vimc-sensor.c
+++ b/drivers/media/platform/vimc/vimc-sensor.c
@@ -16,22 +16,11 @@
 #include <media/v4l2-subdev.h>
 #include <media/tpg/v4l2-tpg.h>
 
+#include "vimc.h"
 #include "vimc-common.h"
 
 #define VIMC_SEN_DRV_NAME "vimc-sensor"
 
-struct vimc_sen_device {
-	struct vimc_ent_device ved;
-	struct v4l2_subdev sd;
-	struct device *dev;
-	struct tpg_data tpg;
-	struct task_struct *kthread_sen;
-	u8 *frame;
-	/* The active format */
-	struct v4l2_mbus_framefmt mbus_format;
-	struct v4l2_ctrl_handler hdl;
-};
-
 static const struct v4l2_mbus_framefmt fmt_default = {
 	.width = 640,
 	.height = 480,
diff --git a/drivers/media/platform/vimc/vimc.h b/drivers/media/platform/vimc/vimc.h
new file mode 100644
index 000000000000..a5adebdda941
--- /dev/null
+++ b/drivers/media/platform/vimc/vimc.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ * Copyright (C) 2019 Shuah Khan <skhan@linuxfoundation.org>
+ *
+ */
+
+/*
+ * This file defines vimc driver device and sub-device structures.
+ */
+
+#ifndef _VIMC_H_
+#define _VIMC_H_
+
+#include <linux/platform_device.h>
+#include <media/media-device.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-core.h>
+#include <media/tpg/v4l2-tpg.h>
+#include <media/v4l2-ctrls.h>
+
+#include "vimc-common.h"
+
+struct vimc_cap_device {
+	struct vimc_ent_device ved;
+	struct video_device vdev;
+	struct device *dev;
+	struct v4l2_pix_format format;
+	struct vb2_queue queue;
+	struct list_head buf_list;
+	/*
+	 * NOTE: in a real driver, a spin lock must be used to access the
+	 * queue because the frames are generated from a hardware interruption
+	 * and the isr is not allowed to sleep.
+	 * Even if it is not necessary a spinlock in the vimc driver, we
+	 * use it here as a code reference
+	 */
+	spinlock_t qlock;
+	struct mutex lock;
+	u32 sequence;
+	struct vimc_stream stream;
+};
+
+struct vimc_sca_device {
+	struct vimc_ent_device ved;
+	struct v4l2_subdev sd;
+	struct device *dev;
+	/* NOTE: the source fmt is the same as the sink
+	 * with the width and hight multiplied by mult
+	 */
+	struct v4l2_mbus_framefmt sink_fmt;
+	/* Values calculated when the stream starts */
+	u8 *src_frame;
+	unsigned int src_line_size;
+	unsigned int bpp;
+};
+
+struct vimc_deb_device {
+	struct vimc_ent_device ved;
+	struct v4l2_subdev sd;
+	struct device *dev;
+	/* The active format */
+	struct v4l2_mbus_framefmt sink_fmt;
+	u32 src_code;
+	void (*set_rgb_src)(struct vimc_deb_device *vdeb, unsigned int lin,
+			    unsigned int col, unsigned int rgb[3]);
+	/* Values calculated when the stream starts */
+	u8 *src_frame;
+	const struct vimc_deb_pix_map *sink_pix_map;
+	unsigned int sink_bpp;
+};
+
+struct vimc_sen_device {
+	struct vimc_ent_device ved;
+	struct v4l2_subdev sd;
+	struct device *dev;
+	struct tpg_data tpg;
+	struct task_struct *kthread_sen;
+	u8 *frame;
+	/* The active format */
+	struct v4l2_mbus_framefmt mbus_format;
+	struct v4l2_ctrl_handler hdl;
+};
+
+struct vimc_device {
+	/* The platform device */
+	struct platform_device pdev;
+
+	/* The pipeline configuration */
+	const struct vimc_pipeline_config *pipe_cfg;
+
+	/* The Associated media_device parent */
+	struct media_device mdev;
+
+	/* Internal v4l2 parent device*/
+	struct v4l2_device v4l2_dev;
+
+	/* Subdevices */
+	struct platform_device **subdevs;
+};
+
+#endif
-- 
2.17.1

