Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7970EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD9D21655
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2DOhDxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfHVB6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:58:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33755 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfHVB6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:58:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so2504628pgn.0;
        Wed, 21 Aug 2019 18:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJBfS7HIIw1t/KK9zKQwHG83jtFIbrBblcy5i1M3+M4=;
        b=V2DOhDxms/aCzjwvp+EYpdBZevSpf1y6RnvYOLQRPf/KEzBZd/2pHH44khpmdfZ3gh
         mf30Vu05Jiw9tDj/EOOQX0MXXdOnfcZdpxaYuFPhB49/nNpB4s/3DbOeIRyZSMQBhjFn
         MhQdCKtpsBT47+OrFBonrWDUJL/hl2C6UE61527E1kblHicXCdu000jV6KRKbfetQKD9
         gyunEfAcRXsp17MoYkRLk9pOfzwS+p8arB2extymDS1OZSj5h0nkXW3ytbXtwpJhrmtJ
         tvPjd6Bsv0AN/ooYJfYdnfXaPvo+igEOE5EOu6gFTymST2Ry6VrEYVLXD0JZwf/kp1L0
         nXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJBfS7HIIw1t/KK9zKQwHG83jtFIbrBblcy5i1M3+M4=;
        b=uZsDnz3wnyNCytiUbxZxCxo2rfyJSgOZyiPQOky7BNX7sq41q+4dAtHcxykjFed98B
         GbZ102ZUXT0aVzMiNSUB4VBKDBwZOvxZz3+TSk+3SaMcKeKACnY6+EFf4/vMKx1tRiw7
         3NHgG+ClP/WciTzbHmbWWbOTBH51npO+AI68VxKXnHbkJlOPHKrO4yDX+9KBe7/uOOTC
         KYODDqjEKHfmA5j6BHnh9Be83ZWp+a16cGWrZceGFrI35dpvLP1pdm2s5JHOESYjRq2r
         cZZplXIAKW7GqRG59Oph1xFsNCRmAn3QhUIZJPOHgiiXUKfgpBhKzIih5GNrHnp7tdL6
         xPdg==
X-Gm-Message-State: APjAAAUuJnjPVTsiVVKKUYyKtYFm92LN9BDQB2+RqMb53FDkgb3wdsU3
        pv9PefGyDB6E5IWTFKA44Gw=
X-Google-Smtp-Source: APXvYqyvoZ7A9MJNRQaT97XhZXrPGJpTdMj8MJfIJaj36BJLJB03HwNxOQd5CVSOwVr34QPNZTjg1w==
X-Received: by 2002:a63:5648:: with SMTP id g8mr31039969pgm.81.1566439083040;
        Wed, 21 Aug 2019 18:58:03 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:e554::6bd7])
        by smtp.gmail.com with ESMTPSA id 203sm36739709pfz.107.2019.08.21.18.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 18:58:02 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bruce Wang <bzwang@chromium.org>,
        Fritz Koenig <frkoenig@google.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: add rotation property
Date:   Wed, 21 Aug 2019 18:57:24 -0700
Message-Id: <20190822015756.30807-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 45bfac9e3af7..c5653771e8fa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1040,8 +1040,21 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane)
 				pstate->multirect_mode);
 
 	if (pdpu->pipe_hw->ops.setup_format) {
+		unsigned int rotation;
+
 		src_flags = 0x0;
 
+		rotation = drm_rotation_simplify(state->rotation,
+						 DRM_MODE_ROTATE_0 |
+						 DRM_MODE_REFLECT_X |
+						 DRM_MODE_REFLECT_Y);
+
+		if (rotation & DRM_MODE_REFLECT_X)
+			src_flags |= DPU_SSPP_FLIP_UD;
+
+		if (rotation & DRM_MODE_REFLECT_Y)
+			src_flags |= DPU_SSPP_FLIP_LR;
+
 		/* update format */
 		pdpu->pipe_hw->ops.setup_format(pdpu->pipe_hw, fmt, src_flags,
 				pstate->multirect_index);
@@ -1522,6 +1535,13 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
 	if (ret)
 		DPU_ERROR("failed to install zpos property, rc = %d\n", ret);
 
+	drm_plane_create_rotation_property(plane,
+			DRM_MODE_ROTATE_0,
+			DRM_MODE_ROTATE_0 |
+			DRM_MODE_ROTATE_180 |
+			DRM_MODE_REFLECT_X |
+			DRM_MODE_REFLECT_Y);
+
 	drm_plane_enable_fb_damage_clips(plane);
 
 	/* success! finalize initialization */
-- 
2.21.0

