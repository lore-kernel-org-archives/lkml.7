Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681B6C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0B820B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIFUNwNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfFRCpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:45:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39048 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRCpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:45:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so8188884qta.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8KPbeBe1Izb/oXnubNpoebguldEg1IGhY2Zsm9jUIkc=;
        b=jIFUNwNOQDgYQ+LupPGr48TtotyUTjpb9+gsc7h4cEidc+lFsVhBVavMi2fttyL6WP
         DhlEaZjRsstTTIy5yBGjHeOCYwTJ00hChejyepsRC62T+97ppWDMd82ovALdPSWhspQZ
         dN5zOURRRWDX/bR2dJgk9XcQk/lmme5KMkfF+M6mNIqTcT2QGxOZWCNKyOVhl5vkjBk/
         VEtFeuF7NabIwp29c+dvSP+T3tCc8S3tt8l4WH8mOS7hkv5ccyXXTbT/5FD7H1NWSFS3
         19XD6SZyefb/WdclBRaO8rHi/pTalTXZBMJpqaieCp8iFjmTrn0oY/43ufre+HGdId0C
         XEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8KPbeBe1Izb/oXnubNpoebguldEg1IGhY2Zsm9jUIkc=;
        b=gC7XDEgWut4VYDpG5GZ8wca1dgf0uGIyzEA28mPK1jbe1bGfQoCqfBreXUiCQibi6M
         3booLWmxXbNG2jJIuDf13oYopkKFC65rj7ePlRHeQRxbspqnOHURFqqoDC/9LkPUuOhY
         a4D3PYpUWRYSC1aqx6d6tbCnDYVb67X8x5VxK00ljlyBKYQ6A2Mcugx/jLU8yG1gmI/p
         7sU96G8+DXhtL6/Xp2nXKoWXoxNbL6u5asVZO/J6PreB3EARJuhA0jT9AYZwipBeHs5W
         gpknzcyq6zxBolWQcke8ul2WWfELOikfSn6Z5TWkGUNmWVGnuKl5knxNYMZIDAZ231Vq
         J/1Q==
X-Gm-Message-State: APjAAAUuL9C6InNzpIeBKsvUIguQFpxGKm2Mq1rqFPGmfBgkKUAX874J
        mQHEGXLOD9uYNe8hf0cLsZs=
X-Google-Smtp-Source: APXvYqyjb9meqRuihmeZFMzBK6sW+mj5SPJgPZKeAR4jCHZ6vjWkicT6mbIE3vqb/ZHfyqiL5cb5Yw==
X-Received: by 2002:ac8:4442:: with SMTP id m2mr17809198qtn.107.1560825933887;
        Mon, 17 Jun 2019 19:45:33 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id s64sm7140356qkb.56.2019.06.17.19.45.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:45:33 -0700 (PDT)
Date:   Mon, 17 Jun 2019 23:45:29 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <971da2ede86d11357e6822409bef23cb03869f83.1560820888.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When vkms calls drm_universal_plane_init(), it sets 0 for the
possible_crtcs parameter which works well for a single encoder and
connector; however, this approach is not flexible and does not fit well
for vkms. This commit adds an index parameter for vkms_plane_init()
which makes code flexible and enables vkms to support other DRM features.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h    | 4 ++--
 drivers/gpu/drm/vkms/vkms_output.c | 6 +++---
 drivers/gpu/drm/vkms/vkms_plane.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index cc53ef88a331..966b3d653189 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -127,7 +127,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.preferred_depth = 24;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
-	return vkms_output_init(vkmsdev);
+	return vkms_output_init(vkmsdev, 0);
 }
 
 static int __init vkms_init(void)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8d628d18105e..ad63dbe5e994 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -115,10 +115,10 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
 			       int *max_error, ktime_t *vblank_time,
 			       bool in_vblank_irq);
 
-int vkms_output_init(struct vkms_device *vkmsdev);
+int vkms_output_init(struct vkms_device *vkmsdev, int index);
 
 struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				  enum drm_plane_type type);
+				  enum drm_plane_type type, int index);
 
 /* Gem stuff */
 struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 56fb5c2a2315..fb1941a6522c 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -35,7 +35,7 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.get_modes    = vkms_conn_get_modes,
 };
 
-int vkms_output_init(struct vkms_device *vkmsdev)
+int vkms_output_init(struct vkms_device *vkmsdev, int index)
 {
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
@@ -45,12 +45,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	struct drm_plane *primary, *cursor = NULL;
 	int ret;
 
-	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
+	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
 	if (enable_cursor) {
-		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
+		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
 		if (IS_ERR(cursor)) {
 			ret = PTR_ERR(cursor);
 			goto err_cursor;
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8cf40297cf56..3f8e8b53f3bb 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -176,7 +176,7 @@ static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
 };
 
 struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				  enum drm_plane_type type)
+				  enum drm_plane_type type, int index)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	const struct drm_plane_helper_funcs *funcs;
@@ -198,7 +198,7 @@ struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 		funcs = &vkms_primary_helper_funcs;
 	}
 
-	ret = drm_universal_plane_init(dev, plane, 0,
+	ret = drm_universal_plane_init(dev, plane, 1 << index,
 				       &vkms_plane_funcs,
 				       formats, nformats,
 				       NULL, type, NULL);
-- 
2.21.0
