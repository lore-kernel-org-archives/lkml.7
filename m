Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F85C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B68218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYPTBmaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfDWXWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33826 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfDWXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so8375998pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yGwLHd/QsORrF/a1ijwtnZ+FE24YlLye7sgtz4UzsFE=;
        b=AYPTBmaPULPqQbE+sL+NfzdmJ/NSE/o6yP6F6cIWoYXmY0CqMRVYk/UqRfdeT4uWTu
         FQdwL60ib0zDfBNSOWNEuX694R0uH2Q9CsYZ6cr0WqglN6ZwWFkOV+H45t9HzzwIHfF6
         TI6pgwM0e7lwezJzRWb8S/5jUO4lyyb+wNYhtZUOn36PlKzewKJIGzcfo2q+JVMNnxTJ
         wEiGjR5F0Vt9rkPbPUA6c5ldPVlCHSSYwiJlzTFoYBjKqKC8p1p3c4J1up/bV8J/s+Z8
         AHvc9WgLr89MkVCoyF7TFjEgPCQ2l354ROa52gpn4GqMXWHhhrm6JSus+CzcxEkbheR+
         5IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yGwLHd/QsORrF/a1ijwtnZ+FE24YlLye7sgtz4UzsFE=;
        b=WWfN2PJysnesHBFZov0Z3JC8lx3pnGmO5IDw2z4ROaaEEYTniY28rxLMUL/0KbJa8W
         W+/yZD0YGNNzDgm94NoLSsFAR0FZcWP8GFLuHx9Oa+bxkp4ekXulGUe+OVReqIrNMica
         cIPaGdrYKZ1GeR/Uqufvdlc3hN9TP2mxjSd1GcmG4JePovCtTxIWtl9X7fHcrN5M4XAT
         7hfQMb+6eU2pFE0rpZ1/Fukoy/bBXnWyVLYXKVuWL/6fmBwxLLBLW5UPvg0V4YQKNvYF
         onpByDxWafAISiNHP99JO2IZnWq+QuvvhGaCpirTmTFUrsLWKZdOFh0jNfPrBIpKa1Df
         CurQ==
X-Gm-Message-State: APjAAAX8SyrplL+tQiye86Oat3+/tYgTQJKFBNlBWznm6HMMBvUvVDFc
        Qtg2Jm+vb5wXfXIRZMeFC5C05yUu2Gc=
X-Google-Smtp-Source: APXvYqx4xkcgjslUOx5dI/zefCl0o3ZiR4S9OssYEKtes1yNrH8CUQdAzRyAgv7ZkgB3p9XTSiFj6w==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr30576470pfb.16.1556061683551;
        Tue, 23 Apr 2019 16:21:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:22 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 16/25] drm: kirin: Move plane number and primay plane in driver data
Date:   Tue, 23 Apr 2019 16:20:47 -0700
Message-Id: <1556061656-1733-17-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the number of
planes and the primary plane value to the kirin_drm_data
structure

This will make it easier to add support for new devices
via a new kirin_drm_data structure.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded comit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 21 +++++++++++++--------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  2 ++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 0e68257..b6b1da6 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -35,7 +35,6 @@
 #include "kirin_drm_drv.h"
 #include "kirin_ade_reg.h"
 
-#define PRIMARY_CH	ADE_CH1 /* primary plane */
 #define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
 #define ADE_DEBUG	1
 
@@ -991,7 +990,7 @@ static int ade_drm_init(struct platform_device *pdev)
 	struct kirin_plane *kplane;
 	enum drm_plane_type type;
 	int ret;
-	int i;
+	u32 ch;
 
 	ade = devm_kzalloc(dev->dev, sizeof(*ade), GFP_KERNEL);
 	if (!ade) {
@@ -1015,12 +1014,15 @@ static int ade_drm_init(struct platform_device *pdev)
 	 * TODO: Now only support primary plane, overlay planes
 	 * need to do.
 	 */
-	for (i = 0; i < ADE_CH_NUM; i++) {
-		kplane = &ade->planes[i];
-		kplane->ch = i;
+	for (ch = 0; ch < ade_driver_data.num_planes; ch++) {
+		kplane = &ade->planes[ch];
+		kplane->ch = ch;
 		kplane->hw_ctx = ctx;
-		type = i == PRIMARY_CH ? DRM_PLANE_TYPE_PRIMARY :
-			DRM_PLANE_TYPE_OVERLAY;
+
+		if (ch == ade_driver_data.prim_plane)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
 
 		ret = ade_plane_init(dev, kplane, type);
 		if (ret)
@@ -1028,7 +1030,8 @@ static int ade_drm_init(struct platform_device *pdev)
 	}
 
 	/* crtc init */
-	ret = ade_crtc_init(dev, &kcrtc->base, &ade->planes[PRIMARY_CH].base);
+	ret = ade_crtc_init(dev, &kcrtc->base,
+				&ade->planes[ade_driver_data.prim_plane].base);
 	if (ret)
 		return ret;
 
@@ -1047,6 +1050,8 @@ static const struct drm_mode_config_funcs ade_mode_config_funcs = {
 };
 
 struct kirin_drm_data ade_driver_data = {
+	.num_planes = ADE_CH_NUM,
+	.prim_plane = ADE_CH1,
 	.channel_formats = channel_formats,
 	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
 	.crtc_helper_funcs = &ade_crtc_helper_funcs,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 700a203..59fc888 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -41,6 +41,8 @@ struct kirin_plane {
 struct kirin_drm_data {
 	const u32 *channel_formats;
 	u32 channel_formats_cnt;
+	u32 num_planes;
+	u32 prim_plane;
 
 	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
 	const struct drm_crtc_funcs *crtc_funcs;
-- 
2.7.4

