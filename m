Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A87EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D901922CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfICUtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:49:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbfICUtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:49:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A304B30A56B0;
        Tue,  3 Sep 2019 20:49:00 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2436D1001B02;
        Tue,  3 Sep 2019 20:48:57 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Emily Deng <Emily.Deng@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Evan Quan <evan.quan@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Yu Zhao <yuzhao@google.com>, Shirish S <shirish.s@amd.com>,
        David Francis <David.Francis@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Thierry Reding <treding@nvidia.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/27] drm/amdgpu: Iterate through DRM connectors correctly
Date:   Tue,  3 Sep 2019 16:46:01 -0400
Message-Id: <20190903204645.25487-24-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 03 Sep 2019 20:49:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, every single piece of code in amdgpu that loops through
connectors does it incorrectly and doesn't use the proper list iteration
helpers, drm_connector_list_iter_begin() and
drm_connector_list_iter_end(). Yeesh.

So, do that.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 13 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 20 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  | 40 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  5 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 34 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 34 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 40 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 34 ++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++-------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 10 ++++-
 11 files changed, 195 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index ece55c8fa673..bd31bb595c04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1022,8 +1022,12 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 			 */
 			if (amdgpu_connector->shared_ddc && (ret == connector_status_connected)) {
 				struct drm_connector *list_connector;
+				struct drm_connector_list_iter iter;
 				struct amdgpu_connector *list_amdgpu_connector;
-				list_for_each_entry(list_connector, &dev->mode_config.connector_list, head) {
+
+				drm_connector_list_iter_begin(dev, &iter);
+				drm_for_each_connector_iter(list_connector,
+							    &iter) {
 					if (connector == list_connector)
 						continue;
 					list_amdgpu_connector = to_amdgpu_connector(list_connector);
@@ -1040,6 +1044,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 						}
 					}
 				}
+				drm_connector_list_iter_end(&iter);
 			}
 		}
 	}
@@ -1501,6 +1506,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector;
 	struct amdgpu_connector_atom_dig *amdgpu_dig_connector;
 	struct drm_encoder *encoder;
@@ -1515,10 +1521,12 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 		return;
 
 	/* see if we already added it */
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		amdgpu_connector = to_amdgpu_connector(connector);
 		if (amdgpu_connector->connector_id == connector_id) {
 			amdgpu_connector->devices |= supported_device;
+			drm_connector_list_iter_end(&iter);
 			return;
 		}
 		if (amdgpu_connector->ddc_bus && i2c_bus->valid) {
@@ -1533,6 +1541,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			}
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	/* check if it's a dp bridge */
 	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f884699eaef..acd39ce9b08e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3004,6 +3004,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool suspend, bool fbcon)
 	struct amdgpu_device *adev;
 	struct drm_crtc *crtc;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	int r;
 
 	if (dev == NULL || dev->dev_private == NULL) {
@@ -3026,9 +3027,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool suspend, bool fbcon)
 	if (!amdgpu_device_has_dc_support(adev)) {
 		/* turn off display hw */
 		drm_modeset_lock_all(dev);
-		list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-			drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
-		}
+		drm_connector_list_iter_begin(dev, &iter);
+		drm_for_each_connector_iter(connector, &iter)
+			drm_helper_connector_dpms(connector,
+						  DRM_MODE_DPMS_OFF);
+		drm_connector_list_iter_end(&iter);
 		drm_modeset_unlock_all(dev);
 			/* unpin the front buffers and cursors */
 		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
@@ -3107,6 +3110,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool suspend, bool fbcon)
 int amdgpu_device_resume(struct drm_device *dev, bool resume, bool fbcon)
 {
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_device *adev = dev->dev_private;
 	struct drm_crtc *crtc;
 	int r = 0;
@@ -3177,9 +3181,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool resume, bool fbcon)
 
 			/* turn on display hw */
 			drm_modeset_lock_all(dev);
-			list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
-			}
+
+			drm_connector_list_iter_begin(dev, &iter);
+			drm_for_each_connector_iter(connector, &iter)
+				drm_helper_connector_dpms(connector,
+							  DRM_MODE_DPMS_ON);
+			drm_connector_list_iter_end(&iter);
+
 			drm_modeset_unlock_all(dev);
 		}
 		amdgpu_fbdev_set_suspend(adev, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 1d4aaa9580f4..d2dd59a95e8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -370,11 +370,13 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 	struct amdgpu_connector *amdgpu_connector;
 	struct drm_encoder *encoder;
 	struct amdgpu_encoder *amdgpu_encoder;
+	struct drm_connector_list_iter iter;
 	uint32_t devices;
 	int i = 0;
 
+	drm_connector_list_iter_begin(dev, &iter);
 	DRM_INFO("AMDGPU Display Connectors\n");
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_for_each_connector_iter(connector, &iter) {
 		amdgpu_connector = to_amdgpu_connector(connector);
 		DRM_INFO("Connector %d:\n", i);
 		DRM_INFO("  %s\n", connector->name);
@@ -438,6 +440,7 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 		}
 		i++;
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
index 571a6dfb473e..61fcf247a638 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
@@ -37,12 +37,14 @@ amdgpu_link_encoder_connector(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = dev->dev_private;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector;
 	struct drm_encoder *encoder;
 	struct amdgpu_encoder *amdgpu_encoder;
 
+	drm_connector_list_iter_begin(dev, &iter);
 	/* walk the list and link encoders to connectors */
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_for_each_connector_iter(connector, &iter) {
 		amdgpu_connector = to_amdgpu_connector(connector);
 		list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
 			amdgpu_encoder = to_amdgpu_encoder(encoder);
@@ -55,6 +57,7 @@ amdgpu_link_encoder_connector(struct drm_device *dev)
 			}
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 void amdgpu_encoder_set_active_device(struct drm_encoder *encoder)
@@ -62,8 +65,10 @@ void amdgpu_encoder_set_active_device(struct drm_encoder *encoder)
 	struct drm_device *dev = encoder->dev;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 			amdgpu_encoder->active_device = amdgpu_encoder->devices & amdgpu_connector->devices;
@@ -72,6 +77,7 @@ void amdgpu_encoder_set_active_device(struct drm_encoder *encoder)
 				  amdgpu_connector->devices, encoder->encoder_type);
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 struct drm_connector *
@@ -79,15 +85,20 @@ amdgpu_get_connector_for_encoder(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
-	struct drm_connector *connector;
+	struct drm_connector *connector, *found = NULL;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		amdgpu_connector = to_amdgpu_connector(connector);
-		if (amdgpu_encoder->active_device & amdgpu_connector->devices)
-			return connector;
+		if (amdgpu_encoder->active_device & amdgpu_connector->devices) {
+			found = connector;
+			break;
+		}
 	}
-	return NULL;
+	drm_connector_list_iter_end(&iter);
+	return found;
 }
 
 struct drm_connector *
@@ -95,15 +106,20 @@ amdgpu_get_connector_for_encoder_init(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
-	struct drm_connector *connector;
+	struct drm_connector *connector, *found = NULL;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		amdgpu_connector = to_amdgpu_connector(connector);
-		if (amdgpu_encoder->devices & amdgpu_connector->devices)
-			return connector;
+		if (amdgpu_encoder->devices & amdgpu_connector->devices) {
+			found = connector;
+			break;
+		}
 	}
-	return NULL;
+	drm_connector_list_iter_end(&iter);
+	return found;
 }
 
 struct drm_encoder *amdgpu_get_external_encoder(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 2a3f5ec298db..977e121204e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -87,10 +87,13 @@ static void amdgpu_hotplug_work_func(struct work_struct *work)
 	struct drm_device *dev = adev->ddev;
 	struct drm_mode_config *mode_config = &dev->mode_config;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 
 	mutex_lock(&mode_config->mutex);
-	list_for_each_entry(connector, &mode_config->connector_list, head)
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
 		amdgpu_connector_hotplug(connector);
+	drm_connector_list_iter_end(&iter);
 	mutex_unlock(&mode_config->mutex);
 	/* Just fire off a uevent and let userspace tell us what to do */
 	drm_helper_hpd_irq_event(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 645550e7caf5..be82871ac3bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -330,9 +330,11 @@ static void dce_v10_0_hpd_init(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	u32 tmp;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
@@ -368,6 +370,7 @@ static void dce_v10_0_hpd_init(struct amdgpu_device *adev)
 		amdgpu_irq_get(adev, &adev->hpd_irq,
 			       amdgpu_connector->hpd.hpd);
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 /**
@@ -382,9 +385,11 @@ static void dce_v10_0_hpd_fini(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	u32 tmp;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
@@ -397,6 +402,7 @@ static void dce_v10_0_hpd_fini(struct amdgpu_device *adev)
 		amdgpu_irq_put(adev, &adev->hpd_irq,
 			       amdgpu_connector->hpd.hpd);
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 static u32 dce_v10_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
@@ -1219,10 +1225,12 @@ static void dce_v10_0_afmt_audio_select_pin(struct drm_encoder *encoder)
 static void dce_v10_0_audio_write_latency_fields(struct drm_encoder *encoder,
 						struct drm_display_mode *mode)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	u32 tmp;
 	int interlace = 0;
@@ -1230,12 +1238,14 @@ static void dce_v10_0_audio_write_latency_fields(struct drm_encoder *encoder,
 	if (!dig || !dig->afmt || !dig->afmt->pin)
 		return;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1261,10 +1271,12 @@ static void dce_v10_0_audio_write_latency_fields(struct drm_encoder *encoder,
 
 static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	u32 tmp;
 	u8 *sadb = NULL;
@@ -1273,12 +1285,14 @@ static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 	if (!dig || !dig->afmt || !dig->afmt->pin)
 		return;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1313,10 +1327,12 @@ static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 
 static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	struct cea_sad *sads;
 	int i, sad_count;
@@ -1339,12 +1355,14 @@ static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	if (!dig || !dig->afmt || !dig->afmt->pin)
 		return;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index d9f470632b2c..bde48775cf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -348,9 +348,11 @@ static void dce_v11_0_hpd_init(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	u32 tmp;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
@@ -385,6 +387,7 @@ static void dce_v11_0_hpd_init(struct amdgpu_device *adev)
 		dce_v11_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 		amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 /**
@@ -399,9 +402,11 @@ static void dce_v11_0_hpd_fini(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	u32 tmp;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
@@ -413,6 +418,7 @@ static void dce_v11_0_hpd_fini(struct amdgpu_device *adev)
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 static u32 dce_v11_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
@@ -1245,10 +1251,12 @@ static void dce_v11_0_afmt_audio_select_pin(struct drm_encoder *encoder)
 static void dce_v11_0_audio_write_latency_fields(struct drm_encoder *encoder,
 						struct drm_display_mode *mode)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	u32 tmp;
 	int interlace = 0;
@@ -1256,12 +1264,14 @@ static void dce_v11_0_audio_write_latency_fields(struct drm_encoder *encoder,
 	if (!dig || !dig->afmt || !dig->afmt->pin)
 		return;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1287,10 +1297,12 @@ static void dce_v11_0_audio_write_latency_fields(struct drm_encoder *encoder,
 
 static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	u32 tmp;
 	u8 *sadb = NULL;
@@ -1299,12 +1311,14 @@ static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 	if (!dig || !dig->afmt || !dig->afmt->pin)
 		return;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1339,10 +1353,12 @@ static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 
 static void dce_v11_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	struct cea_sad *sads;
 	int i, sad_count;
@@ -1365,12 +1381,14 @@ static void dce_v11_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	if (!dig || !dig->afmt || !dig->afmt->pin)
 		return;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 3eb2e7429269..65f61de931d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -281,9 +281,11 @@ static void dce_v6_0_hpd_init(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	u32 tmp;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
@@ -309,7 +311,7 @@ static void dce_v6_0_hpd_init(struct amdgpu_device *adev)
 		dce_v6_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 		amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
-
+	drm_connector_list_iter_end(&iter);
 }
 
 /**
@@ -324,9 +326,11 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	u32 tmp;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
@@ -338,6 +342,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
@@ -1124,20 +1129,24 @@ static void dce_v6_0_audio_select_pin(struct drm_encoder *encoder)
 static void dce_v6_0_audio_write_latency_fields(struct drm_encoder *encoder,
 						struct drm_display_mode *mode)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	int interlace = 0;
 	u32 tmp;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1164,21 +1173,25 @@ static void dce_v6_0_audio_write_latency_fields(struct drm_encoder *encoder,
 
 static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	u8 *sadb = NULL;
 	int sad_count;
 	u32 tmp;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1221,10 +1234,12 @@ static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 
 static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	struct cea_sad *sads;
 	int i, sad_count;
@@ -1244,12 +1259,14 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR13, HDMI_AUDIO_CODING_TYPE_WMA_PRO },
 	};
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1632,6 +1649,7 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	int em = amdgpu_atombios_encoder_get_encoder_mode(encoder);
 	int bpc = 8;
@@ -1639,12 +1657,14 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 	if (!dig || !dig->afmt)
 		return;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index a16c5e9e610e..e5f50882a51d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -275,9 +275,11 @@ static void dce_v8_0_hpd_init(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	u32 tmp;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
@@ -303,6 +305,7 @@ static void dce_v8_0_hpd_init(struct amdgpu_device *adev)
 		dce_v8_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 		amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 /**
@@ -317,9 +320,11 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	u32 tmp;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
@@ -331,6 +336,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 static u32 dce_v8_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
@@ -1157,10 +1163,12 @@ static void dce_v8_0_afmt_audio_select_pin(struct drm_encoder *encoder)
 static void dce_v8_0_audio_write_latency_fields(struct drm_encoder *encoder,
 						struct drm_display_mode *mode)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	u32 tmp = 0, offset;
 
@@ -1169,12 +1177,14 @@ static void dce_v8_0_audio_write_latency_fields(struct drm_encoder *encoder,
 
 	offset = dig->afmt->pin->offset;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1214,10 +1224,12 @@ static void dce_v8_0_audio_write_latency_fields(struct drm_encoder *encoder,
 
 static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	u32 offset, tmp;
 	u8 *sadb = NULL;
@@ -1228,12 +1240,14 @@ static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 
 	offset = dig->afmt->pin->offset;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1263,11 +1277,13 @@ static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 
 static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct drm_device *dev = encoder->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 offset;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
 	struct cea_sad *sads;
 	int i, sad_count;
@@ -1292,12 +1308,14 @@ static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 
 	offset = dig->afmt->pin->offset;
 
-	list_for_each_entry(connector, &encoder->dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			amdgpu_connector = to_amdgpu_connector(connector);
 			break;
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
 		DRM_ERROR("Couldn't find encoder's connector\n");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0a71ed1e7762..73630e2940d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -896,27 +896,29 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	int ret = 0;
 
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type == dc_connection_mst_branch &&
 		    aconnector->mst_mgr.aux) {
 			DRM_DEBUG_DRIVER("DM_MST: starting TM on aconnector: %p [id: %d]\n",
-					aconnector, aconnector->base.base.id);
+					 aconnector,
+					 aconnector->base.base.id);
 
 			ret = drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
 			if (ret < 0) {
 				DRM_ERROR("DM_MST: Failed to start MST\n");
-				((struct dc_link *)aconnector->dc_link)->type = dc_connection_single;
-				return ret;
-				}
+				aconnector->dc_link->type =
+					dc_connection_single;
+				break;
 			}
+		}
 	}
+	drm_connector_list_iter_end(&iter);
 
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	return ret;
 }
 
@@ -954,14 +956,13 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct drm_dp_mst_topology_mgr *mgr;
 	int ret;
 	bool need_hotplug = false;
 
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-
-	list_for_each_entry(connector, &dev->mode_config.connector_list,
-			    head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type != dc_connection_mst_branch ||
 		    aconnector->mst_port)
@@ -979,8 +980,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 			}
 		}
 	}
-
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	drm_connector_list_iter_end(&iter);
 
 	if (need_hotplug)
 		drm_kms_helper_hotplug_event(dev);
@@ -1162,6 +1162,7 @@ static int dm_resume(void *handle)
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
 	struct dm_crtc_state *dm_new_crtc_state;
@@ -1194,7 +1195,8 @@ static int dm_resume(void *handle)
 	amdgpu_dm_irq_resume_early(adev);
 
 	/* Do detection*/
-	list_for_each_entry(connector, &ddev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(ddev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		/*
@@ -1222,6 +1224,7 @@ static int dm_resume(void *handle)
 		amdgpu_dm_update_connector_after_detect(aconnector);
 		mutex_unlock(&aconnector->hpd_lock);
 	}
+	drm_connector_list_iter_end(&iter);
 
 	/* Force mode set in atomic commit */
 	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index fa5d503d379c..64445c4cc4c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -732,8 +732,10 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_dm_connector *amdgpu_dm_connector =
 				to_amdgpu_dm_connector(connector);
 
@@ -751,6 +753,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 					true);
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 }
 
 /**
@@ -765,8 +768,10 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev->ddev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_dm_connector *amdgpu_dm_connector =
 				to_amdgpu_dm_connector(connector);
 		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
@@ -779,4 +784,5 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 					false);
 		}
 	}
+	drm_connector_list_iter_end(&iter);
 }
-- 
2.21.0

