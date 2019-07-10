Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B2C71142
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E28121473
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfGJMhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:37:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:22835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfGJMhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:37:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:59 -0700
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170906953"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:57 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Micha=C5=82=20Wajdeczko?= <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [RFC PATCH 6/6] drm/i915: Rename "inject_load_failure" module parameter
Date:   Wed, 10 Jul 2019 14:36:31 +0200
Message-Id: <20190710123631.26575-7-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
References: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "probe" nomenclature for consistency with internally used names
of functions and variables.

Requires adjustment of IGT tests and possibly affects other user custom
applications.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c    | 10 +++++-----
 drivers/gpu/drm/i915/i915_params.c |  2 +-
 drivers/gpu/drm/i915/i915_params.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 7241a7d14e9b..3bac6be9f37d 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -85,13 +85,13 @@ static unsigned int i915_probe_fail_count;
 
 bool __i915_inject_probe_failure(const char *func, int line)
 {
-	if (i915_probe_fail_count >= i915_modparams.inject_load_failure)
+	if (i915_probe_fail_count >= i915_modparams.inject_probe_failure)
 		return false;
 
-	if (++i915_probe_fail_count == i915_modparams.inject_load_failure) {
+	if (++i915_probe_fail_count == i915_modparams.inject_probe_failure) {
 		DRM_INFO("Injecting failure at checkpoint %u [%s:%d]\n",
-			 i915_modparams.inject_load_failure, func, line);
-		i915_modparams.inject_load_failure = 0;
+			 i915_modparams.inject_probe_failure, func, line);
+		i915_modparams.inject_probe_failure = 0;
 		return true;
 	}
 
@@ -100,7 +100,7 @@ bool __i915_inject_probe_failure(const char *func, int line)
 
 bool i915_error_injected(void)
 {
-	return i915_probe_fail_count && !i915_modparams.inject_load_failure;
+	return i915_probe_fail_count && !i915_modparams.inject_probe_failure;
 }
 
 #endif
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 296452f9efe4..59a6586dae15 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -165,7 +165,7 @@ i915_param_named_unsafe(enable_dp_mst, bool, 0600,
 	"Enable multi-stream transport (MST) for new DisplayPort sinks. (default: true)");
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG)
-i915_param_named_unsafe(inject_load_failure, uint, 0400,
+i915_param_named_unsafe(inject_probe_failure, uint, 0400,
 	"Force an error after a number of failure check points (0:disabled (default), N:force failure at the Nth failure check point)");
 #endif
 
diff --git a/drivers/gpu/drm/i915/i915_params.h b/drivers/gpu/drm/i915/i915_params.h
index d29ade3b7de6..8c887413fc70 100644
--- a/drivers/gpu/drm/i915/i915_params.h
+++ b/drivers/gpu/drm/i915/i915_params.h
@@ -62,7 +62,7 @@ struct drm_printer;
 	param(int, mmio_debug, -IS_ENABLED(CONFIG_DRM_I915_DEBUG_MMIO)) \
 	param(int, edp_vswing, 0) \
 	param(int, reset, 2) \
-	param(unsigned int, inject_load_failure, 0) \
+	param(unsigned int, inject_probe_failure, 0) \
 	param(int, fastboot, -1) \
 	param(int, enable_dpcd_backlight, 0) \
 	param(char *, force_probe, CONFIG_DRM_I915_FORCE_PROBE) \
-- 
2.21.0

