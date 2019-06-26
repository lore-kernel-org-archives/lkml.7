Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A6C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9A221479
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEfuWP65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfFZBg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:36:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42871 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfFZBgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:36:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so640140qtk.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 18:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z5NrdX7NWwAoR74sTDNwhmRnjPJuMOFlYOfia6fSoF0=;
        b=AEfuWP65YYdqezhUt9Nl1emQyjaECK5qQwk7hrbZkP9cB8u9dyggDWOVgkQXMVEXlM
         i4Gb7BFWNZcCoTnlzijHQ0Bu7OagWa9qJH55mozGBqrfw6Uo3nOS6SikMx9mKy2OtFNp
         GMXsPpGvML02cMESF1OGC1ruB1sosAsriTZQv2/wXhGx+QjUsNGd1neSDKMa4BvsKxFk
         1j+q+w5HnMc+PqnHVDpmvw1p6ul83sF0/gMzkVTQ6IZMrN257C5bDNSfEW0ZHy4fGELX
         NthS+POR7/9jtHo5OnTmhRpbqyys0Cl+RoS4IpXLscaWKk/RfOmlpxWquli5yxMXSKA1
         Yl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5NrdX7NWwAoR74sTDNwhmRnjPJuMOFlYOfia6fSoF0=;
        b=jQOwJ9iVxgckSSXw07mGuRnT9QMEbRLBhUNABShDHn7DX1W6IWjdatZo/OImjImyLX
         Xe3y5rxKzcTt7guZ5ohgmGJip6faacxTZP9M/XFqeQ4s2/F1mAU4kZOojuQDp5T7puCl
         io+uY+4AEjVqRsI0MtfcIdyyxm6octXxaTsUbtpRwvXdnmChJfTV+CCYdA+8Hl3atiS8
         DHtkDzu+nxiy45hi2pDg/UpWd03gJBTqSiINsIATge1z7S0K3+xOWRnEWVMheTdrPNHp
         0ELABWALv8MvuJ4M2EjgLqsnrcgYHLutK8WN8fdY7hx8Pay5VCzl9TE7ZYQ5RUmYszKc
         nxag==
X-Gm-Message-State: APjAAAUqnFpQog/NOYsz5BAHcn3nj5AdXuOS3kiCi3zqZ5zLsRc0H7hp
        iVmXPFuAcHqpGCdWT1PgXJA=
X-Google-Smtp-Source: APXvYqwGsxCL242iIdEU4rNVTpJKxMlXP+fmKwcNueML+N/BprK0zHQHzHQ6gOhAYyCUgth2h/NuJQ==
X-Received: by 2002:ac8:17e6:: with SMTP id r35mr1292524qtk.215.1561512983200;
        Tue, 25 Jun 2019 18:36:23 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id c5sm8641883qkb.41.2019.06.25.18.36.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 18:36:22 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:36:18 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] drm/vkms: Avoid assigning 0 for possible_crtc
Message-ID: <d67849c62a8d8ace1a0af455998b588798a4c45f.1561491964.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When vkms invoke drm_universal_plane_init(), it sets 0 for
possible_crtcs parameter which means that planes can't be attached to
any CRTC. It currently works due to some safeguard in the drm_crtc file;
however, it is possible to identify the problem by trying to append a
second connector. This patch fixes this issue by modifying
vkms_plane_init() to accept an index parameter which makes the code a
little bit more flexible and avoid set zero to possible_crtcs.

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
index 12b4db7ac641..e2d1aa089dec 100644
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
index 0fceb6258422..18c630cfc485 100644
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
