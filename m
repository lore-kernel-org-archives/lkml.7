Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F85C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9415720838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfHALfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:35:03 -0400
Received: from fw-tnat-cam3.arm.com ([217.140.106.51]:34948 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725379AbfHALfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:35:02 -0400
X-Greylist: delayed 3144 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 07:35:01 EDT
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.35])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id x71AgVdm015278;
        Thu, 1 Aug 2019 11:42:31 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: drm/komeda: Add support for generation of CRC data per frame.
Date:   Thu,  1 Aug 2019 11:42:31 +0100
Message-Id: <20190801104231.23938-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda has support to generate per-frame CRC values in the DOU
backend subsystem. Implement necessary hooks to expose the CRC
"control" and "data" file over debugfs and program the DOUx_BS
accordingly.

This patch makes use of PL1 (programmable line 1) interrupt to
know when the CRC generation has finished.

Patch is also dependent on the series that adds dual-link support
for komeda: https://patchwork.freedesktop.org/series/62280/

Cc: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    |  2 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 29 ++++++++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 61 ++++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  2 +
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 6 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
index 55a8cc94808a1..3c45468848ee4 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1061,7 +1061,7 @@ static void d71_timing_ctrlr_update(struct komeda_component *c,
 	malidp_write32(reg, BS_PREFETCH_LINE, D71_DEFAULT_PREPRETCH_LINE);
 
 	/* configure bs control register */
-	value = BS_CTRL_EN | BS_CTRL_VM;
+	value = BS_CTRL_EN | BS_CTRL_VM | BS_CTRL_CRC;
 	if (c->pipeline->dual_link) {
 		malidp_write32(reg, BS_DRIFT_TO, hfront_porch + 16);
 		value |= BS_CTRL_DL;
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
index d567ab7ed314e..05bfd9891c540 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -115,6 +115,8 @@ static u64 get_dou_event(struct d71_pipeline *d71_pipeline)
 	raw_status = malidp_read32(reg, BLK_IRQ_RAW_STATUS);
 	if (raw_status & DOU_IRQ_PL0)
 		evts |= KOMEDA_EVENT_VSYNC;
+	if (raw_status & DOU_IRQ_PL1)
+		evts |= KOMEDA_EVENT_CRCDONE;
 	if (raw_status & DOU_IRQ_UND)
 		evts |= KOMEDA_EVENT_URUN;
 
@@ -149,7 +151,7 @@ static u64 get_dou_event(struct d71_pipeline *d71_pipeline)
 
 static u64 get_pipeline_event(struct d71_pipeline *d71_pipeline, u32 gcu_status)
 {
-	u32 evts = 0ULL;
+	u64 evts = 0ULL;
 
 	if (gcu_status & (GLB_IRQ_STATUS_LPU0 | GLB_IRQ_STATUS_LPU1))
 		evts |= get_lpu_event(d71_pipeline);
@@ -163,6 +165,26 @@ static u64 get_pipeline_event(struct d71_pipeline *d71_pipeline, u32 gcu_status)
 	return evts;
 }
 
+static void get_frame_crcs(struct d71_pipeline *d71_pipeline, u32 pipe,
+			   struct komeda_events *evts)
+{
+	if (evts->pipes[pipe] & KOMEDA_EVENT_CRCDONE) {
+		struct komeda_component *c;
+
+		c = komeda_pipeline_get_component(&d71_pipeline->base,
+						  KOMEDA_COMPONENT_TIMING_CTRLR);
+		if (!c)
+			return;
+
+		evts->crcs[pipe][0] = malidp_read32(c->reg, BS_CRC0_LOW);
+		evts->crcs[pipe][1] = malidp_read32(c->reg, BS_CRC0_HIGH);
+		if (d71_pipeline->base.dual_link) {
+			evts->crcs[pipe][2] = malidp_read32(c->reg, BS_CRC1_LOW);
+			evts->crcs[pipe][3] = malidp_read32(c->reg, BS_CRC1_HIGH);
+		}
+	}
+}
+
 static irqreturn_t
 d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
 {
@@ -195,6 +217,9 @@ d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
 	if (gcu_status & GLB_IRQ_STATUS_PIPE1)
 		evts->pipes[1] |= get_pipeline_event(d71->pipes[1], gcu_status);
 
+	get_frame_crcs(d71->pipes[0], 0, evts);
+	get_frame_crcs(d71->pipes[1], 1, evts);
+
 	return gcu_status ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -202,7 +227,7 @@ d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
 				 GCU_IRQ_MODE | GCU_IRQ_ERR)
 #define ENABLED_LPU_IRQS	(LPU_IRQ_IBSY | LPU_IRQ_ERR | LPU_IRQ_EOW)
 #define ENABLED_CU_IRQS		(CU_IRQ_OVR | CU_IRQ_ERR)
-#define ENABLED_DOU_IRQS	(DOU_IRQ_UND | DOU_IRQ_ERR)
+#define ENABLED_DOU_IRQS	(DOU_IRQ_UND | DOU_IRQ_ERR | DOU_IRQ_PL1)
 
 static int d71_enable_irq(struct komeda_dev *mdev)
 {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index fa9a4593bb375..4b9f5d33e999d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -207,10 +207,13 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 			drm_crtc_send_vblank_event(crtc, event);
 		} else {
 			DRM_WARN("CRTC[%d]: FLIP happen but no pending commit.\n",
-				 drm_crtc_index(&kcrtc->base));
+				 drm_crtc_index(crtc));
 		}
 		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 	}
+
+	if ((kcrtc->crc_enabled) && (events & KOMEDA_EVENT_CRCDONE))
+		drm_crtc_add_crc_entry(crtc, false, 0, evts->crcs[kcrtc->master->id]);
 }
 
 static void
@@ -487,6 +490,59 @@ static void komeda_crtc_vblank_disable(struct drm_crtc *crtc)
 	mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, false);
 }
 
+static const char * const komeda_pipe_crc_sources[] = {"auto"};
+
+static const char *const *komeda_crtc_get_crc_sources(struct drm_crtc *crtc,
+						      size_t *count)
+{
+	*count = ARRAY_SIZE(komeda_pipe_crc_sources);
+	return komeda_pipe_crc_sources;
+}
+
+static int komeda_crtc_parse_crc_source(const char *source)
+{
+	if (!source)
+		return 0;
+	if (strcmp(source, "auto") == 0)
+		return 1;
+
+	return -EINVAL;
+}
+
+static int komeda_crtc_verify_crc_source(struct drm_crtc *crtc,
+					 const char *source_name,
+					 size_t *values_count)
+{
+	struct komeda_crtc *kcrtc = to_kcrtc(crtc);
+	int source = komeda_crtc_parse_crc_source(source_name);
+
+	if (source < 0) {
+		DRM_DEBUG_DRIVER("Unknown or invalid CRC source for CRTC%d\n",
+				 drm_crtc_index(crtc));
+		return -EINVAL;
+	}
+
+	*values_count = kcrtc->master->dual_link ? 4 : 2;
+
+	return 0;
+}
+
+static int komeda_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
+{
+	struct komeda_crtc *kcrtc = to_kcrtc(crtc);
+	int src = komeda_crtc_parse_crc_source(source);
+
+	if (src < 0) {
+		DRM_DEBUG_DRIVER("Unknown or invalid CRC source for CRTC%d\n",
+				 drm_crtc_index(crtc));
+		return -EINVAL;
+	}
+
+	kcrtc->crc_enabled = src & 1;
+
+	return 0;
+}
+
 static const struct drm_crtc_funcs komeda_crtc_funcs = {
 	.gamma_set		= drm_atomic_helper_legacy_gamma_set,
 	.destroy		= drm_crtc_cleanup,
@@ -497,6 +553,9 @@ static const struct drm_crtc_funcs komeda_crtc_funcs = {
 	.atomic_destroy_state	= komeda_crtc_atomic_destroy_state,
 	.enable_vblank		= komeda_crtc_vblank_enable,
 	.disable_vblank		= komeda_crtc_vblank_disable,
+	.set_crc_source		= komeda_crtc_set_crc_source,
+	.verify_crc_source	= komeda_crtc_verify_crc_source,
+	.get_crc_sources	= komeda_crtc_get_crc_sources,
 };
 
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
index d1c86b6174c80..244227b945f63 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -20,6 +20,7 @@
 #define KOMEDA_EVENT_OVR		BIT_ULL(4)
 #define KOMEDA_EVENT_EOW		BIT_ULL(5)
 #define KOMEDA_EVENT_MODE		BIT_ULL(6)
+#define KOMEDA_EVENT_CRCDONE		BIT_ULL(7)
 
 #define KOMEDA_ERR_TETO			BIT_ULL(14)
 #define KOMEDA_ERR_TEMR			BIT_ULL(15)
@@ -69,6 +70,7 @@ struct komeda_dev;
 struct komeda_events {
 	u64 global;
 	u64 pipes[KOMEDA_MAX_PIPELINES];
+	u32 crcs[KOMEDA_MAX_PIPELINES][KOMEDA_MAX_CRCS];
 };
 
 /**
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
index 45c498e15e7ae..de7c93b2d0a11 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -84,6 +84,9 @@ struct komeda_crtc {
 
 	/** @disable_done: this flip_done is for tracing the disable */
 	struct completion *disable_done;
+
+	/** @crc_enabled: true if per-frame generation of CRC is enabled */
+	bool crc_enabled;
 };
 
 /**
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
index a7a84e66549d6..dfe2482c6274b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -16,6 +16,7 @@
 #define KOMEDA_PIPELINE_MAX_LAYERS	4
 #define KOMEDA_PIPELINE_MAX_SCALERS	2
 #define KOMEDA_COMPONENT_N_INPUTS	5
+#define KOMEDA_MAX_CRCS			4
 
 /* pipeline component IDs */
 enum {
-- 
2.22.0

