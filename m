Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0709FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE32C20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437349;
	bh=2K3Nhn17oyQlttcoEwq3Au9rsNdUXZ/WhlXS/lb70BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R3Z/HSFN3GwlZkPz7SxR3WUd7kPY7L3gGviPVusjf3AJ2XIh+DYk2sD7w9kjCkNIB
	 OVmKgJHhJ6WQINlqNDj6yvWqEtNqWeGE4JEHG8fng85xSfiBsFOtfw70O1QtrIZAbX
	 0zN/O0YYoIp2rxm7w0sJWJnt5jBX/hhF5WecBcJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfJRWFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbfJRWFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:05:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7552222C6;
        Fri, 18 Oct 2019 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436346;
        bh=2K3Nhn17oyQlttcoEwq3Au9rsNdUXZ/WhlXS/lb70BA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjrGiBd5YuiReS77LKj/0bAf6oktgCFlZsCWLYMskiyxXlW8j5aTk2SJIJzlK6w33
         2Wt0cwDl7o1eOT2bzeXFFR7DeFFyCTJC2OnJ+pZzE7NKIr+4ltV6eO4BvFZLcr8R3D
         B/nAZn0pbFKslb1fAR/YaBBFhm2XZgposE2YDU1o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeykumar Sankaran <jsanka@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 012/100] drm/msm/dpu: handle failures while initializing displays
Date:   Fri, 18 Oct 2019 18:03:57 -0400
Message-Id: <20191018220525.9042-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeykumar Sankaran <jsanka@codeaurora.org>

[ Upstream commit a802ee99c448ca0496fa307f3e46b834ae2a46a3 ]

Bail out KMS hw init on display initialization failures with
proper error logging.

changes in v3:
    - introduced in the series
changes in v4:
    - avoid duplicate return on errors (Sean Paul)
    - avoid spamming errors on failures (Jordon Crouse)

Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 31 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 74cc204b07e80..2d9b7b5fb49c8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -442,35 +442,38 @@ static void dpu_kms_wait_for_commit_done(struct msm_kms *kms,
 	}
 }
 
-static void _dpu_kms_initialize_dsi(struct drm_device *dev,
+static int _dpu_kms_initialize_dsi(struct drm_device *dev,
 				    struct msm_drm_private *priv,
 				    struct dpu_kms *dpu_kms)
 {
 	struct drm_encoder *encoder = NULL;
-	int i, rc;
+	int i, rc = 0;
+
+	if (!(priv->dsi[0] || priv->dsi[1]))
+		return rc;
 
 	/*TODO: Support two independent DSI connectors */
 	encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DSI);
-	if (IS_ERR_OR_NULL(encoder)) {
+	if (IS_ERR(encoder)) {
 		DPU_ERROR("encoder init failed for dsi display\n");
-		return;
+		return PTR_ERR(encoder);
 	}
 
 	priv->encoders[priv->num_encoders++] = encoder;
 
 	for (i = 0; i < ARRAY_SIZE(priv->dsi); i++) {
-		if (!priv->dsi[i]) {
-			DPU_DEBUG("invalid msm_dsi for ctrl %d\n", i);
-			return;
-		}
+		if (!priv->dsi[i])
+			continue;
 
 		rc = msm_dsi_modeset_init(priv->dsi[i], dev, encoder);
 		if (rc) {
 			DPU_ERROR("modeset_init failed for dsi[%d], rc = %d\n",
 				i, rc);
-			continue;
+			break;
 		}
 	}
+
+	return rc;
 }
 
 /**
@@ -481,16 +484,16 @@ static void _dpu_kms_initialize_dsi(struct drm_device *dev,
  * @dpu_kms:    Pointer to dpu kms structure
  * Returns:     Zero on success
  */
-static void _dpu_kms_setup_displays(struct drm_device *dev,
+static int _dpu_kms_setup_displays(struct drm_device *dev,
 				    struct msm_drm_private *priv,
 				    struct dpu_kms *dpu_kms)
 {
-	_dpu_kms_initialize_dsi(dev, priv, dpu_kms);
-
 	/**
 	 * Extend this function to initialize other
 	 * types of displays
 	 */
+
+	return _dpu_kms_initialize_dsi(dev, priv, dpu_kms);
 }
 
 static void _dpu_kms_drm_obj_destroy(struct dpu_kms *dpu_kms)
@@ -552,7 +555,9 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 	 * Create encoder and query display drivers to create
 	 * bridges and connectors
 	 */
-	_dpu_kms_setup_displays(dev, priv, dpu_kms);
+	ret = _dpu_kms_setup_displays(dev, priv, dpu_kms);
+	if (ret)
+		goto fail;
 
 	max_crtc_count = min(catalog->mixer_count, priv->num_encoders);
 
-- 
2.20.1

