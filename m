Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A69C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8644E205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbfGRBoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbfGRBoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA90D2F8BE3;
        Thu, 18 Jul 2019 01:44:12 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06D5B19C67;
        Thu, 18 Jul 2019 01:44:08 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/26] drm/dp_mst: Move test_calc_pbn_mode() into an actual selftest
Date:   Wed, 17 Jul 2019 21:42:26 -0400
Message-Id: <20190718014329.8107-4-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 18 Jul 2019 01:44:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, apparently we've been testing this for every single driver load for
quite a long time now. At least that means our PBN calculation is solid!

Anyway, introduce self tests for MST and move this into there.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c         | 27 --------------
 drivers/gpu/drm/selftests/Makefile            |  2 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |  1 +
 .../drm/selftests/test-drm_dp_mst_helper.c    | 36 +++++++++++++++++++
 .../drm/selftests/test-drm_modeset_common.h   |  1 +
 5 files changed, 39 insertions(+), 28 deletions(-)
 create mode 100644 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index d7c3d9233834..9e382117896d 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -45,7 +45,6 @@
  */
 static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
 				  char *buf);
-static int test_calc_pbn_mode(void);
 
 static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
 
@@ -3439,30 +3438,6 @@ int drm_dp_calc_pbn_mode(int clock, int bpp)
 }
 EXPORT_SYMBOL(drm_dp_calc_pbn_mode);
 
-static int test_calc_pbn_mode(void)
-{
-	int ret;
-	ret = drm_dp_calc_pbn_mode(154000, 30);
-	if (ret != 689) {
-		DRM_ERROR("PBN calculation test failed - clock %d, bpp %d, expected PBN %d, actual PBN %d.\n",
-				154000, 30, 689, ret);
-		return -EINVAL;
-	}
-	ret = drm_dp_calc_pbn_mode(234000, 30);
-	if (ret != 1047) {
-		DRM_ERROR("PBN calculation test failed - clock %d, bpp %d, expected PBN %d, actual PBN %d.\n",
-				234000, 30, 1047, ret);
-		return -EINVAL;
-	}
-	ret = drm_dp_calc_pbn_mode(297000, 24);
-	if (ret != 1063) {
-		DRM_ERROR("PBN calculation test failed - clock %d, bpp %d, expected PBN %d, actual PBN %d.\n",
-				297000, 24, 1063, ret);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 /* we want to kick the TX after we've ack the up/down IRQs. */
 static void drm_dp_mst_kick_tx(struct drm_dp_mst_topology_mgr *mgr)
 {
@@ -3898,8 +3873,6 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	if (!mgr->proposed_vcpis)
 		return -ENOMEM;
 	set_bit(0, &mgr->payload_mask);
-	if (test_calc_pbn_mode() < 0)
-		DRM_ERROR("MST PBN self-test failed\n");
 
 	mst_state = kzalloc(sizeof(*mst_state), GFP_KERNEL);
 	if (mst_state == NULL)
diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index aae88f8a016c..d2137342b371 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
                       test-drm_format.o test-drm_framebuffer.o \
-		      test-drm_damage_helper.o
+		      test-drm_damage_helper.o test-drm_dp_mst_helper.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o test-drm_cmdline_parser.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 464753746013..dec3ee3ec96f 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -32,3 +32,4 @@ selftest(damage_iter_damage_one_intersect, igt_damage_iter_damage_one_intersect)
 selftest(damage_iter_damage_one_outside, igt_damage_iter_damage_one_outside)
 selftest(damage_iter_damage_src_moved, igt_damage_iter_damage_src_moved)
 selftest(damage_iter_damage_not_visible, igt_damage_iter_damage_not_visible)
+selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
new file mode 100644
index 000000000000..51b2486ec917
--- /dev/null
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test cases for for the DRM DP MST helpers
+ */
+
+#define pr_fmt(fmt) "drm_dp_mst_helper: " fmt
+
+#include <drm/drm_dp_mst_helper.h>
+#include <drm/drm_print.h>
+
+#include "test-drm_modeset_common.h"
+
+int igt_dp_mst_calc_pbn_mode(void *ignored)
+{
+	int pbn, i;
+	const struct {
+		int rate;
+		int bpp;
+		int expected;
+	} test_params[] = {
+		{ 154000, 30, 689 },
+		{ 234000, 30, 1047 },
+		{ 297000, 24, 1063 },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(test_params); i++) {
+		pbn = drm_dp_calc_pbn_mode(test_params[i].rate,
+					   test_params[i].bpp);
+		FAIL(pbn != test_params[i].expected,
+		     "Expected PBN %d for clock %d bpp %d, got %d\n",
+		     test_params[i].expected, test_params[i].rate,
+		     test_params[i].bpp, pbn);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index 8c76f09c12d1..590bda35a683 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -39,5 +39,6 @@ int igt_damage_iter_damage_one_intersect(void *ignored);
 int igt_damage_iter_damage_one_outside(void *ignored);
 int igt_damage_iter_damage_src_moved(void *ignored);
 int igt_damage_iter_damage_not_visible(void *ignored);
+int igt_dp_mst_calc_pbn_mode(void *ignored);
 
 #endif
-- 
2.21.0

