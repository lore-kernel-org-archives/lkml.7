Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E5BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA4F20882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5pcsICO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbfJVCl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:41:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387540AbfJVCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qVLKwdCwmKE7PemCRdgKVdzjgvhUz+Gb8R1pV3mz7I=;
        b=h5pcsICO9CFgwkjwVs3YUxgssCB1E5M51RDLTLqqPSbAljU/GgDFtJQB+djUkdTtKgWip8
        Vte/KL+bVS5pxeeMnLrQZ6aZtCYnvxwvl3MN0E/lrjDDlV6BzTKjMFItrK21GlvZCM/Ob3
        lkOAM02g7pONi3WuHqICHTKN2UDP50w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-ofYjIIQnPf-VOphui10-KA-1; Mon, 21 Oct 2019 22:41:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3774080183E;
        Tue, 22 Oct 2019 02:41:17 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F7F26012D;
        Tue, 22 Oct 2019 02:40:47 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Huang Rui <ray.huang@amd.com>, xinhui pan <xinhui.pan@amd.com>,
        Emily Deng <Emily.Deng@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Monk Liu <Monk.Liu@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Yu Zhao <yuzhao@google.com>,
        David Francis <David.Francis@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/14] drm/amdgpu: Iterate through DRM connectors correctly
Date:   Mon, 21 Oct 2019 22:36:06 -0400
Message-Id: <20191022023641.8026-12-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ofYjIIQnPf-VOphui10-KA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_connectors.c
index d8729285f731..a62cbc8199de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1019,8 +1019,12 @@ amdgpu_connector_dvi_detect(struct drm_connector *co=
nnector, bool force)
 =09=09=09 */
 =09=09=09if (amdgpu_connector->shared_ddc && (ret =3D=3D connector_status_=
connected)) {
 =09=09=09=09struct drm_connector *list_connector;
+=09=09=09=09struct drm_connector_list_iter iter;
 =09=09=09=09struct amdgpu_connector *list_amdgpu_connector;
-=09=09=09=09list_for_each_entry(list_connector, &dev->mode_config.connecto=
r_list, head) {
+
+=09=09=09=09drm_connector_list_iter_begin(dev, &iter);
+=09=09=09=09drm_for_each_connector_iter(list_connector,
+=09=09=09=09=09=09=09    &iter) {
 =09=09=09=09=09if (connector =3D=3D list_connector)
 =09=09=09=09=09=09continue;
 =09=09=09=09=09list_amdgpu_connector =3D to_amdgpu_connector(list_connecto=
r);
@@ -1037,6 +1041,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *con=
nector, bool force)
 =09=09=09=09=09=09}
 =09=09=09=09=09}
 =09=09=09=09}
+=09=09=09=09drm_connector_list_iter_end(&iter);
 =09=09=09}
 =09=09}
 =09}
@@ -1494,6 +1499,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector;
 =09struct amdgpu_connector_atom_dig *amdgpu_dig_connector;
 =09struct drm_encoder *encoder;
@@ -1508,10 +1514,12 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 =09=09return;
=20
 =09/* see if we already added it */
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09if (amdgpu_connector->connector_id =3D=3D connector_id) {
 =09=09=09amdgpu_connector->devices |=3D supported_device;
+=09=09=09drm_connector_list_iter_end(&iter);
 =09=09=09return;
 =09=09}
 =09=09if (amdgpu_connector->ddc_bus && i2c_bus->valid) {
@@ -1526,6 +1534,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 =09=09=09}
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09/* check if it's a dp bridge */
 =09list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5a1939dbd4e3..cff16f554f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3007,6 +3007,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l suspend, bool fbcon)
 =09struct amdgpu_device *adev;
 =09struct drm_crtc *crtc;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09int r;
=20
 =09if (dev =3D=3D NULL || dev->dev_private =3D=3D NULL) {
@@ -3029,9 +3030,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol suspend, bool fbcon)
 =09if (!amdgpu_device_has_dc_support(adev)) {
 =09=09/* turn off display hw */
 =09=09drm_modeset_lock_all(dev);
-=09=09list_for_each_entry(connector, &dev->mode_config.connector_list, hea=
d) {
-=09=09=09drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
-=09=09}
+=09=09drm_connector_list_iter_begin(dev, &iter);
+=09=09drm_for_each_connector_iter(connector, &iter)
+=09=09=09drm_helper_connector_dpms(connector,
+=09=09=09=09=09=09  DRM_MODE_DPMS_OFF);
+=09=09drm_connector_list_iter_end(&iter);
 =09=09drm_modeset_unlock_all(dev);
 =09=09=09/* unpin the front buffers and cursors */
 =09=09list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
@@ -3110,6 +3113,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l suspend, bool fbcon)
 int amdgpu_device_resume(struct drm_device *dev, bool resume, bool fbcon)
 {
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct drm_crtc *crtc;
 =09int r =3D 0;
@@ -3180,9 +3184,13 @@ int amdgpu_device_resume(struct drm_device *dev, boo=
l resume, bool fbcon)
=20
 =09=09=09/* turn on display hw */
 =09=09=09drm_modeset_lock_all(dev);
-=09=09=09list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
-=09=09=09=09drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
-=09=09=09}
+
+=09=09=09drm_connector_list_iter_begin(dev, &iter);
+=09=09=09drm_for_each_connector_iter(connector, &iter)
+=09=09=09=09drm_helper_connector_dpms(connector,
+=09=09=09=09=09=09=09  DRM_MODE_DPMS_ON);
+=09=09=09drm_connector_list_iter_end(&iter);
+
 =09=09=09drm_modeset_unlock_all(dev);
 =09=09}
 =09=09amdgpu_fbdev_set_suspend(adev, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 1d4aaa9580f4..d2dd59a95e8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -370,11 +370,13 @@ void amdgpu_display_print_display_setup(struct drm_de=
vice *dev)
 =09struct amdgpu_connector *amdgpu_connector;
 =09struct drm_encoder *encoder;
 =09struct amdgpu_encoder *amdgpu_encoder;
+=09struct drm_connector_list_iter iter;
 =09uint32_t devices;
 =09int i =3D 0;
=20
+=09drm_connector_list_iter_begin(dev, &iter);
 =09DRM_INFO("AMDGPU Display Connectors\n");
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09DRM_INFO("Connector %d:\n", i);
 =09=09DRM_INFO("  %s\n", connector->name);
@@ -438,6 +440,7 @@ void amdgpu_display_print_display_setup(struct drm_devi=
ce *dev)
 =09=09}
 =09=09i++;
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_encoders.c
index 571a6dfb473e..61fcf247a638 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
@@ -37,12 +37,14 @@ amdgpu_link_encoder_connector(struct drm_device *dev)
 {
 =09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector;
 =09struct drm_encoder *encoder;
 =09struct amdgpu_encoder *amdgpu_encoder;
=20
+=09drm_connector_list_iter_begin(dev, &iter);
 =09/* walk the list and link encoders to connectors */
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
 =09=09=09amdgpu_encoder =3D to_amdgpu_encoder(encoder);
@@ -55,6 +57,7 @@ amdgpu_link_encoder_connector(struct drm_device *dev)
 =09=09=09}
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 void amdgpu_encoder_set_active_device(struct drm_encoder *encoder)
@@ -62,8 +65,10 @@ void amdgpu_encoder_set_active_device(struct drm_encoder=
 *encoder)
 =09struct drm_device *dev =3D encoder->dev;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector=
(connector);
 =09=09=09amdgpu_encoder->active_device =3D amdgpu_encoder->devices & amdgp=
u_connector->devices;
@@ -72,6 +77,7 @@ void amdgpu_encoder_set_active_device(struct drm_encoder =
*encoder)
 =09=09=09=09  amdgpu_connector->devices, encoder->encoder_type);
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 struct drm_connector *
@@ -79,15 +85,20 @@ amdgpu_get_connector_for_encoder(struct drm_encoder *en=
coder)
 {
 =09struct drm_device *dev =3D encoder->dev;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
-=09struct drm_connector *connector;
+=09struct drm_connector *connector, *found =3D NULL;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09amdgpu_connector =3D to_amdgpu_connector(connector);
-=09=09if (amdgpu_encoder->active_device & amdgpu_connector->devices)
-=09=09=09return connector;
+=09=09if (amdgpu_encoder->active_device & amdgpu_connector->devices) {
+=09=09=09found =3D connector;
+=09=09=09break;
+=09=09}
 =09}
-=09return NULL;
+=09drm_connector_list_iter_end(&iter);
+=09return found;
 }
=20
 struct drm_connector *
@@ -95,15 +106,20 @@ amdgpu_get_connector_for_encoder_init(struct drm_encod=
er *encoder)
 {
 =09struct drm_device *dev =3D encoder->dev;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
-=09struct drm_connector *connector;
+=09struct drm_connector *connector, *found =3D NULL;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09amdgpu_connector =3D to_amdgpu_connector(connector);
-=09=09if (amdgpu_encoder->devices & amdgpu_connector->devices)
-=09=09=09return connector;
+=09=09if (amdgpu_encoder->devices & amdgpu_connector->devices) {
+=09=09=09found =3D connector;
+=09=09=09break;
+=09=09}
 =09}
-=09return NULL;
+=09drm_connector_list_iter_end(&iter);
+=09return found;
 }
=20
 struct drm_encoder *amdgpu_get_external_encoder(struct drm_encoder *encode=
r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c
index 2a3f5ec298db..977e121204e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -87,10 +87,13 @@ static void amdgpu_hotplug_work_func(struct work_struct=
 *work)
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_mode_config *mode_config =3D &dev->mode_config;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
=20
 =09mutex_lock(&mode_config->mutex);
-=09list_for_each_entry(connector, &mode_config->connector_list, head)
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter)
 =09=09amdgpu_connector_hotplug(connector);
+=09drm_connector_list_iter_end(&iter);
 =09mutex_unlock(&mode_config->mutex);
 =09/* Just fire off a uevent and let userspace tell us what to do */
 =09drm_helper_hpd_irq_event(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/dce_v10_0.c
index 645550e7caf5..be82871ac3bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -330,9 +330,11 @@ static void dce_v10_0_hpd_init(struct amdgpu_device *a=
dev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector(co=
nnector);
=20
 =09=09if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hpd)
@@ -368,6 +370,7 @@ static void dce_v10_0_hpd_init(struct amdgpu_device *ad=
ev)
 =09=09amdgpu_irq_get(adev, &adev->hpd_irq,
 =09=09=09       amdgpu_connector->hpd.hpd);
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 /**
@@ -382,9 +385,11 @@ static void dce_v10_0_hpd_fini(struct amdgpu_device *a=
dev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector(co=
nnector);
=20
 =09=09if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hpd)
@@ -397,6 +402,7 @@ static void dce_v10_0_hpd_fini(struct amdgpu_device *ad=
ev)
 =09=09amdgpu_irq_put(adev, &adev->hpd_irq,
 =09=09=09       amdgpu_connector->hpd.hpd);
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 static u32 dce_v10_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
@@ -1219,10 +1225,12 @@ static void dce_v10_0_afmt_audio_select_pin(struct =
drm_encoder *encoder)
 static void dce_v10_0_audio_write_latency_fields(struct drm_encoder *encod=
er,
 =09=09=09=09=09=09struct drm_display_mode *mode)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09u32 tmp;
 =09int interlace =3D 0;
@@ -1230,12 +1238,14 @@ static void dce_v10_0_audio_write_latency_fields(st=
ruct drm_encoder *encoder,
 =09if (!dig || !dig->afmt || !dig->afmt->pin)
 =09=09return;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1261,10 +1271,12 @@ static void dce_v10_0_audio_write_latency_fields(st=
ruct drm_encoder *encoder,
=20
 static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *e=
ncoder)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09u32 tmp;
 =09u8 *sadb =3D NULL;
@@ -1273,12 +1285,14 @@ static void dce_v10_0_audio_write_speaker_allocatio=
n(struct drm_encoder *encoder
 =09if (!dig || !dig->afmt || !dig->afmt->pin)
 =09=09return;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1313,10 +1327,12 @@ static void dce_v10_0_audio_write_speaker_allocatio=
n(struct drm_encoder *encoder
=20
 static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09struct cea_sad *sads;
 =09int i, sad_count;
@@ -1339,12 +1355,14 @@ static void dce_v10_0_audio_write_sad_regs(struct d=
rm_encoder *encoder)
 =09if (!dig || !dig->afmt || !dig->afmt->pin)
 =09=09return;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/dce_v11_0.c
index d9f470632b2c..bde48775cf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -348,9 +348,11 @@ static void dce_v11_0_hpd_init(struct amdgpu_device *a=
dev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector(co=
nnector);
=20
 =09=09if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hpd)
@@ -385,6 +387,7 @@ static void dce_v11_0_hpd_init(struct amdgpu_device *ad=
ev)
 =09=09dce_v11_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 =09=09amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 /**
@@ -399,9 +402,11 @@ static void dce_v11_0_hpd_fini(struct amdgpu_device *a=
dev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector(co=
nnector);
=20
 =09=09if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hpd)
@@ -413,6 +418,7 @@ static void dce_v11_0_hpd_fini(struct amdgpu_device *ad=
ev)
=20
 =09=09amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 static u32 dce_v11_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
@@ -1245,10 +1251,12 @@ static void dce_v11_0_afmt_audio_select_pin(struct =
drm_encoder *encoder)
 static void dce_v11_0_audio_write_latency_fields(struct drm_encoder *encod=
er,
 =09=09=09=09=09=09struct drm_display_mode *mode)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09u32 tmp;
 =09int interlace =3D 0;
@@ -1256,12 +1264,14 @@ static void dce_v11_0_audio_write_latency_fields(st=
ruct drm_encoder *encoder,
 =09if (!dig || !dig->afmt || !dig->afmt->pin)
 =09=09return;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1287,10 +1297,12 @@ static void dce_v11_0_audio_write_latency_fields(st=
ruct drm_encoder *encoder,
=20
 static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder *e=
ncoder)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09u32 tmp;
 =09u8 *sadb =3D NULL;
@@ -1299,12 +1311,14 @@ static void dce_v11_0_audio_write_speaker_allocatio=
n(struct drm_encoder *encoder
 =09if (!dig || !dig->afmt || !dig->afmt->pin)
 =09=09return;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1339,10 +1353,12 @@ static void dce_v11_0_audio_write_speaker_allocatio=
n(struct drm_encoder *encoder
=20
 static void dce_v11_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09struct cea_sad *sads;
 =09int i, sad_count;
@@ -1365,12 +1381,14 @@ static void dce_v11_0_audio_write_sad_regs(struct d=
rm_encoder *encoder)
 =09if (!dig || !dig->afmt || !dig->afmt->pin)
 =09=09return;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/dce_v6_0.c
index 3eb2e7429269..65f61de931d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -281,9 +281,11 @@ static void dce_v6_0_hpd_init(struct amdgpu_device *ad=
ev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector(co=
nnector);
=20
 =09=09if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hpd)
@@ -309,7 +311,7 @@ static void dce_v6_0_hpd_init(struct amdgpu_device *ade=
v)
 =09=09dce_v6_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 =09=09amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 =09}
-
+=09drm_connector_list_iter_end(&iter);
 }
=20
 /**
@@ -324,9 +326,11 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *ad=
ev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector(co=
nnector);
=20
 =09=09if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hpd)
@@ -338,6 +342,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *ade=
v)
=20
 =09=09amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
@@ -1124,20 +1129,24 @@ static void dce_v6_0_audio_select_pin(struct drm_en=
coder *encoder)
 static void dce_v6_0_audio_write_latency_fields(struct drm_encoder *encode=
r,
 =09=09=09=09=09=09struct drm_display_mode *mode)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09int interlace =3D 0;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1164,21 +1173,25 @@ static void dce_v6_0_audio_write_latency_fields(str=
uct drm_encoder *encoder,
=20
 static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *en=
coder)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09u8 *sadb =3D NULL;
 =09int sad_count;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1221,10 +1234,12 @@ static void dce_v6_0_audio_write_speaker_allocation=
(struct drm_encoder *encoder)
=20
 static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09struct cea_sad *sads;
 =09int i, sad_count;
@@ -1244,12 +1259,14 @@ static void dce_v6_0_audio_write_sad_regs(struct dr=
m_encoder *encoder)
 =09=09{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR13, HDMI_AUDIO_CODIN=
G_TYPE_WMA_PRO },
 =09};
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1632,6 +1649,7 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder =
*encoder,
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09int em =3D amdgpu_atombios_encoder_get_encoder_mode(encoder);
 =09int bpc =3D 8;
@@ -1639,12 +1657,14 @@ static void dce_v6_0_afmt_setmode(struct drm_encode=
r *encoder,
 =09if (!dig || !dig->afmt)
 =09=09return;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/dce_v8_0.c
index a16c5e9e610e..e5f50882a51d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -275,9 +275,11 @@ static void dce_v8_0_hpd_init(struct amdgpu_device *ad=
ev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector(co=
nnector);
=20
 =09=09if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hpd)
@@ -303,6 +305,7 @@ static void dce_v8_0_hpd_init(struct amdgpu_device *ade=
v)
 =09=09dce_v8_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 =09=09amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 /**
@@ -317,9 +320,11 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *ad=
ev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09u32 tmp;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector(co=
nnector);
=20
 =09=09if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hpd)
@@ -331,6 +336,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *ade=
v)
=20
 =09=09amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 static u32 dce_v8_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
@@ -1157,10 +1163,12 @@ static void dce_v8_0_afmt_audio_select_pin(struct d=
rm_encoder *encoder)
 static void dce_v8_0_audio_write_latency_fields(struct drm_encoder *encode=
r,
 =09=09=09=09=09=09struct drm_display_mode *mode)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09u32 tmp =3D 0, offset;
=20
@@ -1169,12 +1177,14 @@ static void dce_v8_0_audio_write_latency_fields(str=
uct drm_encoder *encoder,
=20
 =09offset =3D dig->afmt->pin->offset;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1214,10 +1224,12 @@ static void dce_v8_0_audio_write_latency_fields(str=
uct drm_encoder *encoder,
=20
 static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *en=
coder)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09u32 offset, tmp;
 =09u8 *sadb =3D NULL;
@@ -1228,12 +1240,14 @@ static void dce_v8_0_audio_write_speaker_allocation=
(struct drm_encoder *encoder)
=20
 =09offset =3D dig->afmt->pin->offset;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
@@ -1263,11 +1277,13 @@ static void dce_v8_0_audio_write_speaker_allocation=
(struct drm_encoder *encoder)
=20
 static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
-=09struct amdgpu_device *adev =3D encoder->dev->dev_private;
+=09struct drm_device *dev =3D encoder->dev;
+=09struct amdgpu_device *adev =3D dev->dev_private;
 =09struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
 =09struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
 =09u32 offset;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct amdgpu_connector *amdgpu_connector =3D NULL;
 =09struct cea_sad *sads;
 =09int i, sad_count;
@@ -1292,12 +1308,14 @@ static void dce_v8_0_audio_write_sad_regs(struct dr=
m_encoder *encoder)
=20
 =09offset =3D dig->afmt->pin->offset;
=20
-=09list_for_each_entry(connector, &encoder->dev->mode_config.connector_lis=
t, head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09if (connector->encoder =3D=3D encoder) {
 =09=09=09amdgpu_connector =3D to_amdgpu_connector(connector);
 =09=09=09break;
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (!amdgpu_connector) {
 =09=09DRM_ERROR("Couldn't find encoder's connector\n");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c67d3c41db19..887bc1d5d9e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -897,27 +897,29 @@ static int detect_mst_link_for_all_connectors(struct =
drm_device *dev)
 {
 =09struct amdgpu_dm_connector *aconnector;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09int ret =3D 0;
=20
-=09drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09aconnector =3D to_amdgpu_dm_connector(connector);
 =09=09if (aconnector->dc_link->type =3D=3D dc_connection_mst_branch &&
 =09=09    aconnector->mst_mgr.aux) {
 =09=09=09DRM_DEBUG_DRIVER("DM_MST: starting TM on aconnector: %p [id: %d]\=
n",
-=09=09=09=09=09aconnector, aconnector->base.base.id);
+=09=09=09=09=09 aconnector,
+=09=09=09=09=09 aconnector->base.base.id);
=20
 =09=09=09ret =3D drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, tru=
e);
 =09=09=09if (ret < 0) {
 =09=09=09=09DRM_ERROR("DM_MST: Failed to start MST\n");
-=09=09=09=09((struct dc_link *)aconnector->dc_link)->type =3D dc_connectio=
n_single;
-=09=09=09=09return ret;
-=09=09=09=09}
+=09=09=09=09aconnector->dc_link->type =3D
+=09=09=09=09=09dc_connection_single;
+=09=09=09=09break;
 =09=09=09}
+=09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
-=09drm_modeset_unlock(&dev->mode_config.connection_mutex);
 =09return ret;
 }
=20
@@ -955,14 +957,13 @@ static void s3_handle_mst(struct drm_device *dev, boo=
l suspend)
 {
 =09struct amdgpu_dm_connector *aconnector;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct drm_dp_mst_topology_mgr *mgr;
 =09int ret;
 =09bool need_hotplug =3D false;
=20
-=09drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-
-=09list_for_each_entry(connector, &dev->mode_config.connector_list,
-=09=09=09    head) {
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09aconnector =3D to_amdgpu_dm_connector(connector);
 =09=09if (aconnector->dc_link->type !=3D dc_connection_mst_branch ||
 =09=09    aconnector->mst_port)
@@ -980,8 +981,7 @@ static void s3_handle_mst(struct drm_device *dev, bool =
suspend)
 =09=09=09}
 =09=09}
 =09}
-
-=09drm_modeset_unlock(&dev->mode_config.connection_mutex);
+=09drm_connector_list_iter_end(&iter);
=20
 =09if (need_hotplug)
 =09=09drm_kms_helper_hotplug_event(dev);
@@ -1163,6 +1163,7 @@ static int dm_resume(void *handle)
 =09struct amdgpu_display_manager *dm =3D &adev->dm;
 =09struct amdgpu_dm_connector *aconnector;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
 =09struct drm_crtc *crtc;
 =09struct drm_crtc_state *new_crtc_state;
 =09struct dm_crtc_state *dm_new_crtc_state;
@@ -1195,7 +1196,8 @@ static int dm_resume(void *handle)
 =09amdgpu_dm_irq_resume_early(adev);
=20
 =09/* Do detection*/
-=09list_for_each_entry(connector, &ddev->mode_config.connector_list, head)=
 {
+=09drm_connector_list_iter_begin(ddev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09aconnector =3D to_amdgpu_dm_connector(connector);
=20
 =09=09/*
@@ -1223,6 +1225,7 @@ static int dm_resume(void *handle)
 =09=09amdgpu_dm_update_connector_after_detect(aconnector);
 =09=09mutex_unlock(&aconnector->hpd_lock);
 =09}
+=09drm_connector_list_iter_end(&iter);
=20
 =09/* Force mode set in atomic commit */
 =09for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index fa5d503d379c..64445c4cc4c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -732,8 +732,10 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_dm_connector *amdgpu_dm_connector =3D
 =09=09=09=09to_amdgpu_dm_connector(connector);
=20
@@ -751,6 +753,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 =09=09=09=09=09true);
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
=20
 /**
@@ -765,8 +768,10 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 {
 =09struct drm_device *dev =3D adev->ddev;
 =09struct drm_connector *connector;
+=09struct drm_connector_list_iter iter;
=20
-=09list_for_each_entry(connector, &dev->mode_config.connector_list, head) =
{
+=09drm_connector_list_iter_begin(dev, &iter);
+=09drm_for_each_connector_iter(connector, &iter) {
 =09=09struct amdgpu_dm_connector *amdgpu_dm_connector =3D
 =09=09=09=09to_amdgpu_dm_connector(connector);
 =09=09const struct dc_link *dc_link =3D amdgpu_dm_connector->dc_link;
@@ -779,4 +784,5 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 =09=09=09=09=09false);
 =09=09}
 =09}
+=09drm_connector_list_iter_end(&iter);
 }
--=20
2.21.0

