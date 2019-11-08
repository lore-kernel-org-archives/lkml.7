Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C278C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F066B21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="o5VnrpWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKHFPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:15:21 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:27230 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfKHFPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:15:20 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xA85E4ks007705;
        Fri, 8 Nov 2019 14:14:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xA85E4ks007705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573190048;
        bh=Idc6mhhIU6S0WcIeoVc6oZ1PavRhukf9adx3dsbfmJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5VnrpWiTwCFGElWIogo1yRRY5j5GEXQDEpRE10Lz9Qxusivjhgfi8l9jjIjZg/ZQ
         gGAZHrFD6Z14HC00sqfn1HbFP6uDBWFQu9Wes1kX6i83m8hPsQqhOHCVbLGg1xQJQZ
         oRCuUOKMu7vl4QlVeSrJy5YdHIinUPcqvAO/pw9RSFD6IK2qh8rb7BMxXjxhoQCHxf
         Kl434j8D/YpeH5d5XQAMBo/aDl47I5TUQkee7BbQzzYCzAbhtHQuL/TGRSAIYZy4Xv
         k69Jx/54rfQjoQ+/CVnr3svSOpG0on4jhNBVcNkqG+ttd5GuxI4x79jO3yNbD60vuH
         WvHYkqO0/We5g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Matthew Auld <matthew.auld@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/i915: make more headers self-contained
Date:   Fri,  8 Nov 2019 14:13:56 +0900
Message-Id: <20191108051356.29980-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191108051356.29980-1-yamada.masahiro@socionext.com>
References: <20191108051356.29980-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headers in the gem/selftests/, gt/selftests, gvt/, selftests/
directories have never been compile-tested, but it would be possible
to make them self-contained.

This commit only addresses missing <linux/types.h> and forward
struct declarations.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpu/drm/i915/gem/selftests/mock_context.h | 3 +++
 drivers/gpu/drm/i915/gt/selftests/mock_timeline.h | 2 ++
 drivers/gpu/drm/i915/gvt/cmd_parser.h             | 4 ++++
 drivers/gpu/drm/i915/gvt/display.h                | 5 +++++
 drivers/gpu/drm/i915/gvt/edid.h                   | 4 ++++
 drivers/gpu/drm/i915/gvt/execlist.h               | 2 ++
 drivers/gpu/drm/i915/gvt/fb_decoder.h             | 2 ++
 drivers/gpu/drm/i915/gvt/hypercall.h              | 4 ++++
 drivers/gpu/drm/i915/gvt/interrupt.h              | 3 +++
 drivers/gpu/drm/i915/gvt/mmio.h                   | 2 ++
 drivers/gpu/drm/i915/gvt/page_track.h             | 3 +++
 drivers/gpu/drm/i915/gvt/sched_policy.h           | 3 +++
 drivers/gpu/drm/i915/selftests/mock_drm.h         | 2 ++
 drivers/gpu/drm/i915/selftests/mock_gtt.h         | 3 +++
 drivers/gpu/drm/i915/selftests/mock_region.h      | 5 +++++
 drivers/gpu/drm/i915/selftests/mock_uncore.h      | 3 +++
 16 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_context.h b/drivers/gpu/drm/i915/gem/selftests/mock_context.h
index 0b926653914f..45de09ec28d1 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_context.h
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_context.h
@@ -7,6 +7,9 @@
 #ifndef __MOCK_CONTEXT_H
 #define __MOCK_CONTEXT_H
 
+struct drm_file;
+struct drm_i915_private;
+
 void mock_init_contexts(struct drm_i915_private *i915);
 
 struct i915_gem_context *
diff --git a/drivers/gpu/drm/i915/gt/selftests/mock_timeline.h b/drivers/gpu/drm/i915/gt/selftests/mock_timeline.h
index 689efc66c908..d2bcc3df6183 100644
--- a/drivers/gpu/drm/i915/gt/selftests/mock_timeline.h
+++ b/drivers/gpu/drm/i915/gt/selftests/mock_timeline.h
@@ -7,6 +7,8 @@
 #ifndef __MOCK_TIMELINE__
 #define __MOCK_TIMELINE__
 
+#include <linux/types.h>
+
 struct intel_timeline;
 
 void mock_timeline_init(struct intel_timeline *timeline, u64 context);
diff --git a/drivers/gpu/drm/i915/gvt/cmd_parser.h b/drivers/gpu/drm/i915/gvt/cmd_parser.h
index 286703643002..ab25d151932a 100644
--- a/drivers/gpu/drm/i915/gvt/cmd_parser.h
+++ b/drivers/gpu/drm/i915/gvt/cmd_parser.h
@@ -38,6 +38,10 @@
 
 #define GVT_CMD_HASH_BITS 7
 
+struct intel_gvt;
+struct intel_shadow_wa_ctx;
+struct intel_vgpu_workload;
+
 void intel_gvt_clean_cmd_parser(struct intel_gvt *gvt);
 
 int intel_gvt_init_cmd_parser(struct intel_gvt *gvt);
diff --git a/drivers/gpu/drm/i915/gvt/display.h b/drivers/gpu/drm/i915/gvt/display.h
index a87f33e6a23c..b59b34046e1e 100644
--- a/drivers/gpu/drm/i915/gvt/display.h
+++ b/drivers/gpu/drm/i915/gvt/display.h
@@ -35,6 +35,11 @@
 #ifndef _GVT_DISPLAY_H_
 #define _GVT_DISPLAY_H_
 
+#include <linux/types.h>
+
+struct intel_gvt;
+struct intel_vgpu;
+
 #define SBI_REG_MAX	20
 #define DPCD_SIZE	0x700
 
diff --git a/drivers/gpu/drm/i915/gvt/edid.h b/drivers/gpu/drm/i915/gvt/edid.h
index f6dfc8b795ec..dfe0cbc6aad8 100644
--- a/drivers/gpu/drm/i915/gvt/edid.h
+++ b/drivers/gpu/drm/i915/gvt/edid.h
@@ -35,6 +35,10 @@
 #ifndef _GVT_EDID_H_
 #define _GVT_EDID_H_
 
+#include <linux/types.h>
+
+struct intel_vgpu;
+
 #define EDID_SIZE		128
 #define EDID_ADDR		0x50 /* Linux hvm EDID addr */
 
diff --git a/drivers/gpu/drm/i915/gvt/execlist.h b/drivers/gpu/drm/i915/gvt/execlist.h
index 5ccc2c695848..5c0c1fd30c83 100644
--- a/drivers/gpu/drm/i915/gvt/execlist.h
+++ b/drivers/gpu/drm/i915/gvt/execlist.h
@@ -35,6 +35,8 @@
 #ifndef _GVT_EXECLIST_H_
 #define _GVT_EXECLIST_H_
 
+#include <linux/types.h>
+
 struct execlist_ctx_descriptor_format {
 	union {
 		u32 ldw;
diff --git a/drivers/gpu/drm/i915/gvt/fb_decoder.h b/drivers/gpu/drm/i915/gvt/fb_decoder.h
index 60c155085029..67b6ede9e707 100644
--- a/drivers/gpu/drm/i915/gvt/fb_decoder.h
+++ b/drivers/gpu/drm/i915/gvt/fb_decoder.h
@@ -36,6 +36,8 @@
 #ifndef _GVT_FB_DECODER_H_
 #define _GVT_FB_DECODER_H_
 
+#include <linux/types.h>
+
 #define _PLANE_CTL_FORMAT_SHIFT		24
 #define _PLANE_CTL_TILED_SHIFT		10
 #define _PIPE_V_SRCSZ_SHIFT		0
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index 4862fb12778e..9599c0a762b2 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -33,6 +33,10 @@
 #ifndef _GVT_HYPERCALL_H_
 #define _GVT_HYPERCALL_H_
 
+#include <linux/types.h>
+
+struct device;
+
 enum hypervisor_type {
 	INTEL_GVT_HYPERVISOR_XEN = 0,
 	INTEL_GVT_HYPERVISOR_KVM,
diff --git a/drivers/gpu/drm/i915/gvt/interrupt.h b/drivers/gpu/drm/i915/gvt/interrupt.h
index 5313fb1b33e1..fcd663811d37 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.h
+++ b/drivers/gpu/drm/i915/gvt/interrupt.h
@@ -32,6 +32,8 @@
 #ifndef _GVT_INTERRUPT_H_
 #define _GVT_INTERRUPT_H_
 
+#include <linux/types.h>
+
 enum intel_gvt_event_type {
 	RCS_MI_USER_INTERRUPT = 0,
 	RCS_DEBUG,
@@ -135,6 +137,7 @@ enum intel_gvt_event_type {
 
 struct intel_gvt_irq;
 struct intel_gvt;
+struct intel_vgpu;
 
 typedef void (*gvt_event_virt_handler_t)(struct intel_gvt_irq *irq,
 	enum intel_gvt_event_type event, struct intel_vgpu *vgpu);
diff --git a/drivers/gpu/drm/i915/gvt/mmio.h b/drivers/gpu/drm/i915/gvt/mmio.h
index 5874f1cb4306..2e68f4b02c94 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.h
+++ b/drivers/gpu/drm/i915/gvt/mmio.h
@@ -36,6 +36,8 @@
 #ifndef _GVT_MMIO_H_
 #define _GVT_MMIO_H_
 
+#include <linux/types.h>
+
 struct intel_gvt;
 struct intel_vgpu;
 
diff --git a/drivers/gpu/drm/i915/gvt/page_track.h b/drivers/gpu/drm/i915/gvt/page_track.h
index fa607a71c3c0..f6eb7135583c 100644
--- a/drivers/gpu/drm/i915/gvt/page_track.h
+++ b/drivers/gpu/drm/i915/gvt/page_track.h
@@ -25,6 +25,9 @@
 #ifndef _GVT_PAGE_TRACK_H_
 #define _GVT_PAGE_TRACK_H_
 
+#include <linux/types.h>
+
+struct intel_vgpu;
 struct intel_vgpu_page_track;
 
 typedef int (*gvt_page_track_handler_t)(
diff --git a/drivers/gpu/drm/i915/gvt/sched_policy.h b/drivers/gpu/drm/i915/gvt/sched_policy.h
index 7b59e3e88b8b..3dacdad5f529 100644
--- a/drivers/gpu/drm/i915/gvt/sched_policy.h
+++ b/drivers/gpu/drm/i915/gvt/sched_policy.h
@@ -34,6 +34,9 @@
 #ifndef __GVT_SCHED_POLICY__
 #define __GVT_SCHED_POLICY__
 
+struct intel_gvt;
+struct intel_vgpu;
+
 struct intel_gvt_sched_policy_ops {
 	int (*init)(struct intel_gvt *gvt);
 	void (*clean)(struct intel_gvt *gvt);
diff --git a/drivers/gpu/drm/i915/selftests/mock_drm.h b/drivers/gpu/drm/i915/selftests/mock_drm.h
index b39beee9f8f6..5f2aba843fa8 100644
--- a/drivers/gpu/drm/i915/selftests/mock_drm.h
+++ b/drivers/gpu/drm/i915/selftests/mock_drm.h
@@ -25,6 +25,8 @@
 #ifndef __MOCK_DRM_H
 #define __MOCK_DRM_H
 
+struct drm_i915_private;
+
 struct drm_file *mock_file(struct drm_i915_private *i915);
 void mock_file_free(struct drm_i915_private *i915, struct drm_file *file);
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_gtt.h b/drivers/gpu/drm/i915/selftests/mock_gtt.h
index 3387393286de..e3f224f43beb 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gtt.h
+++ b/drivers/gpu/drm/i915/selftests/mock_gtt.h
@@ -25,6 +25,9 @@
 #ifndef __MOCK_GTT_H
 #define __MOCK_GTT_H
 
+struct drm_i915_private;
+struct i915_ggtt;
+
 void mock_init_ggtt(struct drm_i915_private *i915, struct i915_ggtt *ggtt);
 void mock_fini_ggtt(struct i915_ggtt *ggtt);
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_region.h b/drivers/gpu/drm/i915/selftests/mock_region.h
index 24608089d833..329bf74dfaca 100644
--- a/drivers/gpu/drm/i915/selftests/mock_region.h
+++ b/drivers/gpu/drm/i915/selftests/mock_region.h
@@ -6,6 +6,11 @@
 #ifndef __MOCK_REGION_H
 #define __MOCK_REGION_H
 
+#include <linux/types.h>
+
+struct drm_i915_private;
+struct intel_memory_region;
+
 struct intel_memory_region *
 mock_region_create(struct drm_i915_private *i915,
 		   resource_size_t start,
diff --git a/drivers/gpu/drm/i915/selftests/mock_uncore.h b/drivers/gpu/drm/i915/selftests/mock_uncore.h
index 8a2cc553f466..7acf1ef4d488 100644
--- a/drivers/gpu/drm/i915/selftests/mock_uncore.h
+++ b/drivers/gpu/drm/i915/selftests/mock_uncore.h
@@ -25,6 +25,9 @@
 #ifndef __MOCK_UNCORE_H
 #define __MOCK_UNCORE_H
 
+struct drm_i915_private;
+struct intel_uncore;
+
 void mock_uncore_init(struct intel_uncore *uncore,
 		      struct drm_i915_private *i915);
 
-- 
2.17.1

