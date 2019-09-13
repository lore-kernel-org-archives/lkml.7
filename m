Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6BE206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404023AbfIMWFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfIMWFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:05:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20B2710CC1EC;
        Fri, 13 Sep 2019 22:05:23 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0E6C600CE;
        Fri, 13 Sep 2019 22:05:21 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Peteris Rudzusiks <peteris.rudzusiks@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/nouveau: dispnv50: Use less encoders by making mstos per-head
Date:   Fri, 13 Sep 2019 18:03:52 -0400
Message-Id: <20190913220355.6883-3-lyude@redhat.com>
In-Reply-To: <20190913220355.6883-1-lyude@redhat.com>
References: <20190913220355.6883-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 13 Sep 2019 22:05:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, for every single MST capable DRM connector we create a set of
fake encoders, one for each possible head. Unfortunately this ends up
being a huge waste of encoders. While this currently isn't causing us
any problems, it's extremely close to doing so.

The ThinkPad P71 is a good example of this. Originally when trying to
figure out why nouveau was failing to load on this laptop, I discovered
it was because nouveau was creating too many encoders. This ended up
being because we were mistakenly creating MST encoders for the eDP port,
however we are still extremely close to hitting the encoder limit on
this machine as it exposes 1 eDP port and 5 DP ports, resulting in 31
encoders.

So while this fix didn't end up being necessary to fix the P71, we still
need to implement this so that we avoid hitting the encoder limit for
valid display configurations in the event that some machine with more
connectors then this becomes available. Plus, we don't want to let good
code go to waste :)

So, use less encoders by only creating one MSTO per head. Then, attach
each new MSTC to each MSTO which corresponds to a head that it's parent
DP port is capable of using. This brings the number of encoders we
register on the ThinkPad P71 from 31, down to just 15. Yay!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 92 +++++++++++++++----------
 drivers/gpu/drm/nouveau/dispnv50/disp.h |  2 +
 drivers/gpu/drm/nouveau/dispnv50/head.c | 17 +++--
 drivers/gpu/drm/nouveau/dispnv50/head.h |  3 +-
 4 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index a3f350fdfa8c..d23ac13763b5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -650,7 +650,6 @@ struct nv50_mstm {
 	struct nouveau_encoder *outp;
 
 	struct drm_dp_mst_topology_mgr mgr;
-	struct nv50_msto *msto[4];
 
 	bool modified;
 	bool disabled;
@@ -716,7 +715,6 @@ nv50_msto_cleanup(struct nv50_msto *msto)
 	drm_dp_mst_deallocate_vcpi(&mstm->mgr, mstc->port);
 
 	msto->mstc = NULL;
-	msto->head = NULL;
 	msto->disabled = false;
 }
 
@@ -846,7 +844,6 @@ nv50_msto_enable(struct drm_encoder *encoder)
 
 	mstm->outp->update(mstm->outp, head->base.index, armh, proto, depth);
 
-	msto->head = head;
 	msto->mstc = mstc;
 	mstm->modified = true;
 }
@@ -887,37 +884,40 @@ nv50_msto = {
 	.destroy = nv50_msto_destroy,
 };
 
-static int
-nv50_msto_new(struct drm_device *dev, u32 heads, const char *name, int id,
-	      struct nv50_msto **pmsto)
+static struct nv50_msto *
+nv50_msto_new(struct drm_device *dev, struct nv50_head *head, int id)
 {
 	struct nv50_msto *msto;
 	int ret;
 
-	if (!(msto = *pmsto = kzalloc(sizeof(*msto), GFP_KERNEL)))
-		return -ENOMEM;
+	msto = kzalloc(sizeof(*msto), GFP_KERNEL);
+	if (!msto)
+		return ERR_PTR(-ENOMEM);
 
 	ret = drm_encoder_init(dev, &msto->encoder, &nv50_msto,
-			       DRM_MODE_ENCODER_DPMST, "%s-mst-%d", name, id);
+			       DRM_MODE_ENCODER_DPMST, "mst-%d", id);
 	if (ret) {
-		kfree(*pmsto);
-		*pmsto = NULL;
-		return ret;
+		kfree(msto);
+		return ERR_PTR(ret);
 	}
 
 	drm_encoder_helper_add(&msto->encoder, &nv50_msto_help);
-	msto->encoder.possible_crtcs = heads;
-	return 0;
+	msto->encoder.possible_crtcs = drm_crtc_mask(&head->base.base);
+	msto->head = head;
+	return msto;
 }
 
 static struct drm_encoder *
 nv50_mstc_atomic_best_encoder(struct drm_connector *connector,
 			      struct drm_connector_state *connector_state)
 {
-	struct nv50_head *head = nv50_head(connector_state->crtc);
 	struct nv50_mstc *mstc = nv50_mstc(connector);
+	struct drm_crtc *crtc = connector_state->crtc;
 
-	return &mstc->mstm->msto[head->base.index]->encoder;
+	if (!(mstc->mstm->outp->dcb->heads & drm_crtc_mask(crtc)))
+		return NULL;
+
+	return &nv50_head(crtc)->msto->encoder;
 }
 
 static enum drm_mode_status
@@ -1036,8 +1036,9 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_dp_mst_port *port,
 	      const char *path, struct nv50_mstc **pmstc)
 {
 	struct drm_device *dev = mstm->outp->base.base.dev;
+	struct drm_crtc *crtc;
 	struct nv50_mstc *mstc;
-	int ret, i;
+	int ret;
 
 	if (!(mstc = *pmstc = kzalloc(sizeof(*mstc), GFP_KERNEL)))
 		return -ENOMEM;
@@ -1057,8 +1058,13 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_dp_mst_port *port,
 	mstc->connector.funcs->reset(&mstc->connector);
 	nouveau_conn_attach_properties(&mstc->connector);
 
-	for (i = 0; i < ARRAY_SIZE(mstm->msto) && mstm->msto[i]; i++)
-		drm_connector_attach_encoder(&mstc->connector, &mstm->msto[i]->encoder);
+	drm_for_each_crtc(crtc, dev) {
+		if (!(mstm->outp->dcb->heads & drm_crtc_mask(crtc)))
+			continue;
+
+		drm_connector_attach_encoder(&mstc->connector,
+					     &nv50_head(crtc)->msto->encoder);
+	}
 
 	drm_object_attach_property(&mstc->connector.base, dev->mode_config.path_property, 0);
 	drm_object_attach_property(&mstc->connector.base, dev->mode_config.tile_property, 0);
@@ -1332,7 +1338,7 @@ nv50_mstm_new(struct nouveau_encoder *outp, struct drm_dp_aux *aux, int aux_max,
 	const int max_payloads = hweight8(outp->dcb->heads);
 	struct drm_device *dev = outp->base.base.dev;
 	struct nv50_mstm *mstm;
-	int ret, i;
+	int ret;
 	u8 dpcd;
 
 	/* This is a workaround for some monitors not functioning
@@ -1355,13 +1361,6 @@ nv50_mstm_new(struct nouveau_encoder *outp, struct drm_dp_aux *aux, int aux_max,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < max_payloads; i++) {
-		ret = nv50_msto_new(dev, outp->dcb->heads, outp->base.base.name,
-				    i, &mstm->msto[i]);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -1540,17 +1539,24 @@ nv50_sor_func = {
 	.destroy = nv50_sor_destroy,
 };
 
+static bool nv50_has_mst(struct nouveau_drm *drm)
+{
+	struct nvkm_bios *bios = nvxx_bios(&drm->client.device);
+	u32 data;
+	u8 ver, hdr, cnt, len;
+
+	data = nvbios_dp_table(bios, &ver, &hdr, &cnt, &len);
+	return data && ver >= 0x40 && (nvbios_rd08(bios, data + 0x08) & 0x04);
+}
+
 static int
 nv50_sor_create(struct drm_connector *connector, struct dcb_output *dcbe)
 {
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_drm *drm = nouveau_drm(connector->dev);
-	struct nvkm_bios *bios = nvxx_bios(&drm->client.device);
 	struct nvkm_i2c *i2c = nvxx_i2c(&drm->client.device);
 	struct nouveau_encoder *nv_encoder;
 	struct drm_encoder *encoder;
-	u8 ver, hdr, cnt, len;
-	u32 data;
 	int type, ret;
 
 	switch (dcbe->type) {
@@ -1595,10 +1601,9 @@ nv50_sor_create(struct drm_connector *connector, struct dcb_output *dcbe)
 		}
 
 		if (nv_connector->type != DCB_CONNECTOR_eDP &&
-		    (data = nvbios_dp_table(bios, &ver, &hdr, &cnt, &len)) &&
-		    ver >= 0x40 && (nvbios_rd08(bios, data + 0x08) & 0x04)) {
-			ret = nv50_mstm_new(nv_encoder, &nv_connector->aux, 16,
-					    nv_connector->base.base.id,
+		    nv50_has_mst(drm)) {
+			ret = nv50_mstm_new(nv_encoder, &nv_connector->aux,
+					    16, nv_connector->base.base.id,
 					    &nv_encoder->dp.mstm);
 			if (ret)
 				return ret;
@@ -2294,6 +2299,7 @@ nv50_display_create(struct drm_device *dev)
 	struct nv50_disp *disp;
 	struct dcb_output *dcbe;
 	int crtcs, ret, i;
+	bool has_mst = nv50_has_mst(drm);
 
 	disp = kzalloc(sizeof(*disp), GFP_KERNEL);
 	if (!disp)
@@ -2342,11 +2348,25 @@ nv50_display_create(struct drm_device *dev)
 		crtcs = 0x3;
 
 	for (i = 0; i < fls(crtcs); i++) {
+		struct nv50_head *head;
+
 		if (!(crtcs & (1 << i)))
 			continue;
-		ret = nv50_head_create(dev, i);
-		if (ret)
+
+		head = nv50_head_create(dev, i);
+		if (IS_ERR(head)) {
+			ret = PTR_ERR(head);
 			goto out;
+		}
+
+		if (has_mst) {
+			head->msto = nv50_msto_new(dev, head, i);
+			if (IS_ERR(head->msto)) {
+				ret = PTR_ERR(head->msto);
+				head->msto = NULL;
+				goto out;
+			}
+		}
 	}
 
 	/* create encoder/connector objects based on VBIOS DCB table */
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.h b/drivers/gpu/drm/nouveau/dispnv50/disp.h
index 7c41b0599d1a..b16f4aa09e02 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.h
@@ -4,6 +4,8 @@
 
 #include "nouveau_display.h"
 
+struct nv50_msto;
+
 struct nv50_disp {
 	struct nvif_disp *disp;
 	struct nv50_core *core;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index 71c23bf1fe25..bd2f6bf5edfd 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -474,7 +474,7 @@ nv50_head_func = {
 	.atomic_destroy_state = nv50_head_atomic_destroy_state,
 };
 
-int
+struct nv50_head *
 nv50_head_create(struct drm_device *dev, int index)
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -486,7 +486,7 @@ nv50_head_create(struct drm_device *dev, int index)
 
 	head = kzalloc(sizeof(*head), GFP_KERNEL);
 	if (!head)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	head->func = disp->core->func->head;
 	head->base.index = index;
@@ -504,7 +504,7 @@ nv50_head_create(struct drm_device *dev, int index)
 		ret = nv50_curs_new(drm, head->base.index, &curs);
 	if (ret) {
 		kfree(head);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	crtc = &head->base.base;
@@ -519,12 +519,11 @@ nv50_head_create(struct drm_device *dev, int index)
 
 	if (head->func->olut_set) {
 		ret = nv50_lut_init(disp, &drm->client.mmu, &head->olut);
-		if (ret)
-			goto out;
+		if (ret) {
+			nv50_head_destroy(crtc);
+			return ERR_PTR(ret);
+		}
 	}
 
-out:
-	if (ret)
-		nv50_head_destroy(crtc);
-	return ret;
+	return head;
 }
diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.h b/drivers/gpu/drm/nouveau/dispnv50/head.h
index d1c002f534d4..f31ef5e07f43 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.h
@@ -11,9 +11,10 @@ struct nv50_head {
 	const struct nv50_head_func *func;
 	struct nouveau_crtc base;
 	struct nv50_lut olut;
+	struct nv50_msto *msto;
 };
 
-int nv50_head_create(struct drm_device *, int index);
+struct nv50_head *nv50_head_create(struct drm_device *, int index);
 void nv50_head_flush_set(struct nv50_head *, struct nv50_head_atom *);
 void nv50_head_flush_clr(struct nv50_head *, struct nv50_head_atom *, bool y);
 
-- 
2.21.0

