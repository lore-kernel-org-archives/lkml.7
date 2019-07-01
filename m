Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BDDC06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D602208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvWQhGsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGADYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 23:24:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34607 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfGADYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:24:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so13189881qtu.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K3NuKdFEgq5BVV5xPgHvrMD/faP4K7WOl8ZJ9WIj/Xk=;
        b=IvWQhGsm+FpCtynl/Y11txgTCNs/79JiJ3qwpzrawy3ctdoxx71HYmtq5iuDvf3HjM
         XVahi85PQv/zWxtzctSAZ0W8gplW2mEHBS7NgoZb8BrP4MyRLqt0Eri1Njxp1IKAj7gr
         BWCLifrNNigi87hshqwmhgyLgn4XwfpjI9xt3LGhCgaemkICwhk7RmT+mvZnDMyExooo
         bMhJEaM8154joJ1MB7ZqvPNV5yBmqWdwFJcQKDAA8wLjtr3lHuaSJEeQIzV0Di+KKT8A
         HXMQfwrDmgcqHXcecfeTnYpgzyxXhjoCQvucC5f9RC9K/TSpyqThOvE+CcDfMZhUUOY1
         THbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K3NuKdFEgq5BVV5xPgHvrMD/faP4K7WOl8ZJ9WIj/Xk=;
        b=BYXRSVNiRrjzxtVNG2CiiBikygvHs3nTlntwzJ+JZIYwfmE8G3TiBeuEIZE508dAqV
         F802tfRP1+74Lskn7OdqsA+yNYbsT3apZCIDL/X1O6frnItXi9UVrG4rWBRY3rp61kkq
         BNsModR9EbzCrNvwveWbkU7ZNn8ECV1ChPYW1FQgzsTg03l+tZ3twpNpMAKaUHzj7mei
         M4Y08jvSYItcWh9Gbq/dfOzZJTCNYVx02mPP7gOp2ozk98jGnaxJtLzHvssggkpX7FEs
         6cQ1GZ6wc7/0HC5y7QxdpK/ba9QK1oE3891WH4NkUyaO1MQzbc7pGzPyLop3N/d11jpY
         Mbow==
X-Gm-Message-State: APjAAAWDvqgjwlWyYew/W26lHHOys+mo98NKlarz5HL3u3Hkp1hVKkgj
        aTdqsiLU3gLgQCfF8pJ17ywoXAvQ
X-Google-Smtp-Source: APXvYqzoNHdmQbwyteQnjItCSSCXAPmKX7z63t8UiKZy+sQ9oeM6hrklQWS1C2vZ3eHIPWlgspHSDw==
X-Received: by 2002:a05:6214:10c5:: with SMTP id r5mr18310561qvs.224.1561951454954;
        Sun, 30 Jun 2019 20:24:14 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id f19sm667745qtq.5.2019.06.30.20.24.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 20:24:14 -0700 (PDT)
Date:   Mon, 1 Jul 2019 00:24:10 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/vkms: Add enable/disable functions per connector
Message-ID: <f5b654ec89aa754d5f572f9fc983fbd0d861e1ce.1561950553.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, virtual and writeback connectors have the code responsible
for initialization and cleanup spread around different places in vkms.
This patch creates an enable and disable function per connector which
allows vkms to hotplug connectors easily.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h       |  5 ++
 drivers/gpu/drm/vkms/vkms_output.c    | 84 +++++++++++++++++----------
 drivers/gpu/drm/vkms/vkms_writeback.c | 31 ++++++++--
 3 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 9ff2cd4ebf81..a1ca5c658355 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -152,7 +152,12 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 /* Composer Support */
 void vkms_composer_worker(struct work_struct *work);
 
+/* Virtual connector */
+int enable_virtual_connector(struct vkms_device *vkmsdev);
+void disable_virtual_connector(struct vkms_device *vkmsdev);
+
 /* Writeback */
 int enable_writeback_connector(struct vkms_device *vkmsdev);
+void disable_writeback_connector(struct vkms_device *connector);
 
 #endif /* _VKMS_DRV_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index aea1d4410864..26ecab52e82e 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -6,6 +6,7 @@
 
 static void vkms_connector_destroy(struct drm_connector *connector)
 {
+	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 }
 
@@ -35,37 +36,19 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.get_modes    = vkms_conn_get_modes,
 };
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index)
+int enable_virtual_connector(struct vkms_device *vkmsdev)
 {
 	struct vkms_output *output = &vkmsdev->output;
-	struct drm_device *dev = &vkmsdev->drm;
 	struct drm_connector *connector = &output->connector;
 	struct drm_encoder *encoder = &output->encoder;
-	struct drm_crtc *crtc = &output->crtc;
-	struct drm_plane *primary, *cursor = NULL;
+	struct drm_device *dev = &vkmsdev->drm;
 	int ret;
 
-	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
-	if (IS_ERR(primary))
-		return PTR_ERR(primary);
-
-	if (enable_cursor) {
-		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
-		if (IS_ERR(cursor)) {
-			ret = PTR_ERR(cursor);
-			goto err_cursor;
-		}
-	}
-
-	ret = vkms_crtc_init(dev, crtc, primary, cursor);
-	if (ret)
-		goto err_crtc;
-
 	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
 				 DRM_MODE_CONNECTOR_VIRTUAL);
 	if (ret) {
 		DRM_ERROR("Failed to init connector\n");
-		goto err_connector;
+		return ret;
 	}
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
@@ -84,17 +67,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		goto err_attach;
 	}
 
-	if (enable_writeback) {
-		ret = enable_writeback_connector(vkmsdev);
-		if (!ret) {
-			output->composer_enabled = true;
-			DRM_INFO("Writeback connector enabled");
-		} else {
-			DRM_ERROR("Failed to init writeback connector\n");
-		}
-	}
-
-	drm_mode_config_reset(dev);
+	drm_connector_register(connector);
 
 	return 0;
 
@@ -104,6 +77,53 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 err_encoder:
 	drm_connector_cleanup(connector);
 
+	return ret;
+}
+
+void disable_virtual_connector(struct vkms_device *vkmsdev)
+{
+	struct vkms_output *output = &vkmsdev->output;
+
+	drm_connector_unregister(&output->connector);
+	drm_connector_cleanup(&output->connector);
+	drm_encoder_cleanup(&output->encoder);
+}
+
+int vkms_output_init(struct vkms_device *vkmsdev, int index)
+{
+	struct vkms_output *output = &vkmsdev->output;
+	struct drm_device *dev = &vkmsdev->drm;
+	struct drm_crtc *crtc = &output->crtc;
+	struct drm_plane *primary, *cursor = NULL;
+	int ret;
+
+	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
+	if (IS_ERR(primary))
+		return PTR_ERR(primary);
+
+	if (enable_cursor) {
+		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
+		if (IS_ERR(cursor)) {
+			ret = PTR_ERR(cursor);
+			goto err_cursor;
+		}
+	}
+
+	ret = vkms_crtc_init(dev, crtc, primary, cursor);
+	if (ret)
+		goto err_crtc;
+
+	ret = enable_virtual_connector(vkmsdev);
+	if (ret)
+		goto err_connector;
+
+	if (enable_writeback)
+		enable_writeback_connector(vkmsdev);
+
+	drm_mode_config_reset(dev);
+
+	return 0;
+
 err_connector:
 	drm_crtc_cleanup(crtc);
 
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 34dad37a0236..6a3f37d60c1d 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -125,17 +125,38 @@ static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
 	.atomic_commit = vkms_wb_atomic_commit,
 };
 
+void disable_writeback_connector(struct vkms_device *vkmsdev)
+{
+	struct vkms_output *output = &vkmsdev->output;
+
+	output->composer_enabled = false;
+	drm_connector_unregister(&output->wb_connector.base);
+	drm_connector_cleanup(&output->wb_connector.base);
+	drm_encoder_cleanup(&output->wb_connector.encoder);
+}
+
 int enable_writeback_connector(struct vkms_device *vkmsdev)
 {
 	struct drm_writeback_connector *wb = &vkmsdev->output.wb_connector;
+	int ret;
 
 	vkmsdev->output.wb_connector.encoder.possible_crtcs = 1;
 	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&vkmsdev->drm, wb,
-					    &vkms_wb_connector_funcs,
-					    &vkms_wb_encoder_helper_funcs,
-					    vkms_wb_formats,
-					    ARRAY_SIZE(vkms_wb_formats));
+	ret = drm_writeback_connector_init(&vkmsdev->drm, wb,
+					   &vkms_wb_connector_funcs,
+					   &vkms_wb_encoder_helper_funcs,
+					   vkms_wb_formats,
+					   ARRAY_SIZE(vkms_wb_formats));
+	if (!ret) {
+		vkmsdev->output.composer_enabled = true;
+		DRM_INFO("Writeback connector enabled");
+	} else {
+		DRM_ERROR("Failed to init writeback connector\n");
+	}
+
+	drm_connector_register(&wb->base);
+
+	return ret;
 }
 
-- 
2.21.0
