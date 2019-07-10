Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5090C71142
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7AF2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfGJMgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:36:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:22835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJMgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:36:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:51 -0700
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170906934"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:48 -0700
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
Subject: [RFC PATCH 3/6] drm/i915: Propagate "_release" function name suffix down
Date:   Wed, 10 Jul 2019 14:36:28 +0200
Message-Id: <20190710123631.26575-4-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
References: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace mixed "_fini"/"_cleanup"/"_cleanup_hw" suffixes found in names
of fucntions called from i915_driver_release() with "_release" suffix
consistently.  This provides better code readability, especially
helpful when trying to work out which phase the code is in.

Functions names starting with "i915_driver_", i.e., those defined in
drivers/gpu/dri/i915/i915_drv.c, just have their "cleanup" or "fini"
parts of their names replaced with the "_release" suffix, while names
of functions coming from other source files have been suffixed with
"_driver_release" to avoid ambiguity with other possible .release entry
points.

Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c         | 33 +++++++++++++------------
 drivers/gpu/drm/i915/i915_drv.h         |  2 +-
 drivers/gpu/drm/i915/i915_gem.c         |  2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c     |  4 +--
 drivers/gpu/drm/i915/i915_gem_gtt.h     |  2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.h |  2 +-
 7 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index ad24957ad86d..36c872220f68 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -752,7 +752,7 @@ static int i915_load_modeset_init(struct drm_device *dev)
 cleanup_gem:
 	i915_gem_suspend(dev_priv);
 	i915_gem_fini_hw(dev_priv);
-	i915_gem_fini(dev_priv);
+	i915_gem_driver_release(dev_priv);
 cleanup_modeset:
 	intel_modeset_cleanup(dev);
 cleanup_irq:
@@ -962,10 +962,11 @@ static int i915_driver_init_early(struct drm_i915_private *dev_priv)
 }
 
 /**
- * i915_driver_cleanup_early - cleanup the setup done in i915_driver_init_early()
+ * i915_driver_early_release - cleanup the setup done in
+ *			       i915_driver_init_early()
  * @dev_priv: device private
  */
-static void i915_driver_cleanup_early(struct drm_i915_private *dev_priv)
+static void i915_driver_early_release(struct drm_i915_private *dev_priv)
 {
 	intel_irq_fini(dev_priv);
 	intel_power_domains_cleanup(dev_priv);
@@ -1028,10 +1029,10 @@ static int i915_driver_init_mmio(struct drm_i915_private *dev_priv)
 }
 
 /**
- * i915_driver_cleanup_mmio - cleanup the setup done in i915_driver_init_mmio()
+ * i915_driver_mmio_release - cleanup the setup done in i915_driver_init_mmio()
  * @dev_priv: device private
  */
-static void i915_driver_cleanup_mmio(struct drm_i915_private *dev_priv)
+static void i915_driver_mmio_release(struct drm_i915_private *dev_priv)
 {
 	intel_teardown_mchbar(dev_priv);
 	intel_uncore_fini_mmio(&dev_priv->uncore);
@@ -1684,7 +1685,7 @@ static int i915_driver_init_hw(struct drm_i915_private *dev_priv)
 		pci_disable_msi(pdev);
 	pm_qos_remove_request(&dev_priv->pm_qos);
 err_ggtt:
-	i915_ggtt_cleanup_hw(dev_priv);
+	i915_ggtt_driver_release(dev_priv);
 err_perf:
 	i915_perf_fini(dev_priv);
 	return ret;
@@ -1929,15 +1930,15 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 out_cleanup_hw:
 	i915_driver_cleanup_hw(dev_priv);
-	i915_ggtt_cleanup_hw(dev_priv);
+	i915_ggtt_driver_release(dev_priv);
 
 	/* Paranoia: make sure we have disabled everything before we exit. */
 	intel_sanitize_gt_powersave(dev_priv);
 out_cleanup_mmio:
-	i915_driver_cleanup_mmio(dev_priv);
+	i915_driver_mmio_release(dev_priv);
 out_runtime_pm_put:
 	enable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
-	i915_driver_cleanup_early(dev_priv);
+	i915_driver_early_release(dev_priv);
 out_pci_disable:
 	pci_disable_device(pdev);
 out_fini:
@@ -2000,19 +2001,19 @@ static void i915_driver_release(struct drm_device *dev)
 
 	disable_rpm_wakeref_asserts(rpm);
 
-	i915_gem_fini(dev_priv);
+	i915_gem_driver_release(dev_priv);
 
-	i915_ggtt_cleanup_hw(dev_priv);
+	i915_ggtt_driver_release(dev_priv);
 
 	/* Paranoia: make sure we have disabled everything before we exit. */
 	intel_sanitize_gt_powersave(dev_priv);
 
-	i915_driver_cleanup_mmio(dev_priv);
+	i915_driver_mmio_release(dev_priv);
 
 	enable_rpm_wakeref_asserts(rpm);
-	intel_runtime_pm_cleanup(rpm);
+	intel_runtime_pm_driver_release(rpm);
 
-	i915_driver_cleanup_early(dev_priv);
+	i915_driver_early_release(dev_priv);
 	i915_driver_destroy(dev_priv);
 }
 
@@ -2205,7 +2206,7 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
 out:
 	enable_rpm_wakeref_asserts(rpm);
 	if (!dev_priv->uncore.user_forcewake.count)
-		intel_runtime_pm_cleanup(rpm);
+		intel_runtime_pm_driver_release(rpm);
 
 	return ret;
 }
@@ -2969,7 +2970,7 @@ static int intel_runtime_suspend(struct device *kdev)
 	}
 
 	enable_rpm_wakeref_asserts(rpm);
-	intel_runtime_pm_cleanup(rpm);
+	intel_runtime_pm_driver_release(rpm);
 
 	if (intel_uncore_arm_unclaimed_mmio_detection(&dev_priv->uncore))
 		DRM_ERROR("Unclaimed access detected prior to suspending\n");
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 4deadec2e20b..be9a2adab5dc 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2538,7 +2538,7 @@ void i915_gem_init_mmio(struct drm_i915_private *i915);
 int __must_check i915_gem_init(struct drm_i915_private *dev_priv);
 int __must_check i915_gem_init_hw(struct drm_i915_private *dev_priv);
 void i915_gem_fini_hw(struct drm_i915_private *dev_priv);
-void i915_gem_fini(struct drm_i915_private *dev_priv);
+void i915_gem_driver_release(struct drm_i915_private *dev_priv);
 int i915_gem_wait_for_idle(struct drm_i915_private *dev_priv,
 			   unsigned int flags, long timeout);
 void i915_gem_suspend(struct drm_i915_private *dev_priv);
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 015208741405..51a0fbaa781b 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1620,7 +1620,7 @@ void i915_gem_fini_hw(struct drm_i915_private *dev_priv)
 	i915_gem_drain_freed_objects(dev_priv);
 }
 
-void i915_gem_fini(struct drm_i915_private *dev_priv)
+void i915_gem_driver_release(struct drm_i915_private *dev_priv)
 {
 	mutex_lock(&dev_priv->drm.struct_mutex);
 	intel_engines_cleanup(dev_priv);
diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
index 236c964dd761..e8b156b14769 100644
--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -2910,10 +2910,10 @@ static void ggtt_cleanup_hw(struct i915_ggtt *ggtt)
 }
 
 /**
- * i915_ggtt_cleanup_hw - Clean up GGTT hardware initialization
+ * i915_ggtt_driver_release - Clean up GGTT hardware initialization
  * @i915: i915 device
  */
-void i915_ggtt_cleanup_hw(struct drm_i915_private *i915)
+void i915_ggtt_driver_release(struct drm_i915_private *i915)
 {
 	struct pagevec *pvec;
 
diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.h b/drivers/gpu/drm/i915/i915_gem_gtt.h
index 57a68ef4eda7..75c6f11d3df5 100644
--- a/drivers/gpu/drm/i915/i915_gem_gtt.h
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.h
@@ -617,7 +617,7 @@ int i915_ggtt_enable_hw(struct drm_i915_private *dev_priv);
 void i915_ggtt_enable_guc(struct drm_i915_private *i915);
 void i915_ggtt_disable_guc(struct drm_i915_private *i915);
 int i915_init_ggtt(struct drm_i915_private *dev_priv);
-void i915_ggtt_cleanup_hw(struct drm_i915_private *dev_priv);
+void i915_ggtt_driver_release(struct drm_i915_private *dev_priv);
 
 int i915_ppgtt_init_hw(struct intel_gt *gt);
 
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 8d1aebc3e857..b2a05850ea42 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -592,7 +592,7 @@ void intel_runtime_pm_disable(struct intel_runtime_pm *rpm)
 		pm_runtime_put(kdev);
 }
 
-void intel_runtime_pm_cleanup(struct intel_runtime_pm *rpm)
+void intel_runtime_pm_driver_release(struct intel_runtime_pm *rpm)
 {
 	int count = atomic_read(&rpm->wakeref_count);
 
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.h b/drivers/gpu/drm/i915/intel_runtime_pm.h
index 473c4850c01d..89f8d284239a 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.h
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.h
@@ -173,7 +173,7 @@ enable_rpm_wakeref_asserts(struct intel_runtime_pm *rpm)
 void intel_runtime_pm_init_early(struct intel_runtime_pm *rpm);
 void intel_runtime_pm_enable(struct intel_runtime_pm *rpm);
 void intel_runtime_pm_disable(struct intel_runtime_pm *rpm);
-void intel_runtime_pm_cleanup(struct intel_runtime_pm *rpm);
+void intel_runtime_pm_driver_release(struct intel_runtime_pm *rpm);
 
 intel_wakeref_t intel_runtime_pm_get(struct intel_runtime_pm *rpm);
 intel_wakeref_t intel_runtime_pm_get_if_in_use(struct intel_runtime_pm *rpm);
-- 
2.21.0

