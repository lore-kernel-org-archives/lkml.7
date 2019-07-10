Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0C2C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2C320861
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfGJMg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:36:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:22835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJMgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:36:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:54 -0700
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170906941"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:51 -0700
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
Subject: [RFC PATCH 4/6] drm/i915: Propagate "_remove" function name suffix down
Date:   Wed, 10 Jul 2019 14:36:29 +0200
Message-Id: <20190710123631.26575-5-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
References: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the "_release" case, consistently replace mixed
"_cleanup"/"_fini"/"_fini_hw" components found in names of functions
called from i915_driver_remove() with "_remove" or "_driver_remove"
suffixes for better code readability.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c     |  4 ++--
 drivers/gpu/drm/i915/display/intel_bios.h     |  2 +-
 drivers/gpu/drm/i915/display/intel_display.c  |  2 +-
 .../drm/i915/display/intel_display_power.c    |  6 ++---
 .../drm/i915/display/intel_display_power.h    |  2 +-
 drivers/gpu/drm/i915/i915_drv.c               | 24 +++++++++----------
 drivers/gpu/drm/i915/i915_drv.h               |  4 ++--
 drivers/gpu/drm/i915/i915_gem.c               |  2 +-
 drivers/gpu/drm/i915/intel_gvt.c              |  5 ++--
 drivers/gpu/drm/i915/intel_gvt.h              |  4 ++--
 10 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 0c9808132d67..3c725edc79ef 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1891,10 +1891,10 @@ void intel_bios_init(struct drm_i915_private *dev_priv)
 }
 
 /**
- * intel_bios_cleanup - Free any resources allocated by intel_bios_init()
+ * intel_bios_driver_remove - Free any resources allocated by intel_bios_init()
  * @dev_priv: i915 device instance
  */
-void intel_bios_cleanup(struct drm_i915_private *dev_priv)
+void intel_bios_driver_remove(struct drm_i915_private *dev_priv)
 {
 	kfree(dev_priv->vbt.child_dev);
 	dev_priv->vbt.child_dev = NULL;
diff --git a/drivers/gpu/drm/i915/display/intel_bios.h b/drivers/gpu/drm/i915/display/intel_bios.h
index 0b7be6389a07..4969189e620f 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.h
+++ b/drivers/gpu/drm/i915/display/intel_bios.h
@@ -228,7 +228,7 @@ struct mipi_pps_data {
 } __packed;
 
 void intel_bios_init(struct drm_i915_private *dev_priv);
-void intel_bios_cleanup(struct drm_i915_private *dev_priv);
+void intel_bios_driver_remove(struct drm_i915_private *dev_priv);
 bool intel_bios_is_valid_vbt(const void *buf, size_t size);
 bool intel_bios_is_tv_present(struct drm_i915_private *dev_priv);
 bool intel_bios_is_lvds_present(struct drm_i915_private *dev_priv, u8 *i2c_pin);
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index f09eda75711a..47dd682c9a62 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -17062,7 +17062,7 @@ static void intel_hpd_poll_fini(struct drm_device *dev)
 	drm_connector_list_iter_end(&conn_iter);
 }
 
-void intel_modeset_cleanup(struct drm_device *dev)
+void intel_modeset_driver_remove(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index 7437fc71d289..5f4939a9ca90 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -4427,7 +4427,7 @@ static void intel_power_domains_verify_state(struct drm_i915_private *dev_priv);
  *
  * It will return with power domains disabled (to be enabled later by
  * intel_power_domains_enable()) and must be paired with
- * intel_power_domains_fini_hw().
+ * intel_power_domains_driver_remove().
  */
 void intel_power_domains_init_hw(struct drm_i915_private *i915, bool resume)
 {
@@ -4479,7 +4479,7 @@ void intel_power_domains_init_hw(struct drm_i915_private *i915, bool resume)
 }
 
 /**
- * intel_power_domains_fini_hw - deinitialize hw power domain state
+ * intel_power_domains_driver_remove - deinitialize hw power domain state
  * @i915: i915 device instance
  *
  * De-initializes the display power domain HW state. It also ensures that the
@@ -4489,7 +4489,7 @@ void intel_power_domains_init_hw(struct drm_i915_private *i915, bool resume)
  * intel_power_domains_disable()) and must be paired with
  * intel_power_domains_init_hw().
  */
-void intel_power_domains_fini_hw(struct drm_i915_private *i915)
+void intel_power_domains_driver_remove(struct drm_i915_private *i915)
 {
 	intel_wakeref_t wakeref __maybe_unused =
 		fetch_and_zero(&i915->power_domains.wakeref);
diff --git a/drivers/gpu/drm/i915/display/intel_display_power.h b/drivers/gpu/drm/i915/display/intel_display_power.h
index 8f43f7051a16..dbd1f5ef01d1 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.h
+++ b/drivers/gpu/drm/i915/display/intel_display_power.h
@@ -214,7 +214,7 @@ void gen9_enable_dc5(struct drm_i915_private *dev_priv);
 int intel_power_domains_init(struct drm_i915_private *dev_priv);
 void intel_power_domains_cleanup(struct drm_i915_private *dev_priv);
 void intel_power_domains_init_hw(struct drm_i915_private *dev_priv, bool resume);
-void intel_power_domains_fini_hw(struct drm_i915_private *dev_priv);
+void intel_power_domains_driver_remove(struct drm_i915_private *dev_priv);
 void icl_display_core_init(struct drm_i915_private *dev_priv, bool resume);
 void icl_display_core_uninit(struct drm_i915_private *dev_priv);
 void intel_power_domains_enable(struct drm_i915_private *dev_priv);
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 36c872220f68..6e83fe96d930 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -751,16 +751,16 @@ static int i915_load_modeset_init(struct drm_device *dev)
 
 cleanup_gem:
 	i915_gem_suspend(dev_priv);
-	i915_gem_fini_hw(dev_priv);
+	i915_gem_driver_remove(dev_priv);
 	i915_gem_driver_release(dev_priv);
 cleanup_modeset:
-	intel_modeset_cleanup(dev);
+	intel_modeset_driver_remove(dev);
 cleanup_irq:
 	intel_irq_uninstall(dev_priv);
 	intel_gmbus_teardown(dev_priv);
 cleanup_csr:
 	intel_csr_ucode_fini(dev_priv);
-	intel_power_domains_fini_hw(dev_priv);
+	intel_power_domains_driver_remove(dev_priv);
 	vga_switcheroo_unregister_client(pdev);
 cleanup_vga_client:
 	vga_client_register(pdev, NULL, NULL, NULL);
@@ -1692,10 +1692,10 @@ static int i915_driver_init_hw(struct drm_i915_private *dev_priv)
 }
 
 /**
- * i915_driver_cleanup_hw - cleanup the setup done in i915_driver_init_hw()
+ * i915_driver_hw_remove - cleanup the setup done in i915_driver_hw_probe()
  * @dev_priv: device private
  */
-static void i915_driver_cleanup_hw(struct drm_i915_private *dev_priv)
+static void i915_driver_hw_remove(struct drm_i915_private *dev_priv)
 {
 	struct pci_dev *pdev = dev_priv->drm.pdev;
 
@@ -1929,7 +1929,7 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 out_cleanup_hw:
-	i915_driver_cleanup_hw(dev_priv);
+	i915_driver_hw_remove(dev_priv);
 	i915_ggtt_driver_release(dev_priv);
 
 	/* Paranoia: make sure we have disabled everything before we exit. */
@@ -1970,11 +1970,11 @@ void i915_driver_remove(struct drm_device *dev)
 
 	drm_atomic_helper_shutdown(dev);
 
-	intel_gvt_cleanup(dev_priv);
+	intel_gvt_driver_remove(dev_priv);
 
-	intel_modeset_cleanup(dev);
+	intel_modeset_driver_remove(dev);
 
-	intel_bios_cleanup(dev_priv);
+	intel_bios_driver_remove(dev_priv);
 
 	vga_switcheroo_unregister_client(pdev);
 	vga_client_register(pdev, NULL, NULL, NULL);
@@ -1985,11 +1985,11 @@ void i915_driver_remove(struct drm_device *dev)
 	cancel_delayed_work_sync(&dev_priv->gpu_error.hangcheck_work);
 	i915_reset_error_state(dev_priv);
 
-	i915_gem_fini_hw(dev_priv);
+	i915_gem_driver_remove(dev_priv);
 
-	intel_power_domains_fini_hw(dev_priv);
+	intel_power_domains_driver_remove(dev_priv);
 
-	i915_driver_cleanup_hw(dev_priv);
+	i915_driver_hw_remove(dev_priv);
 
 	enable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
 }
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index be9a2adab5dc..23d9853c5930 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2537,7 +2537,7 @@ bool i915_gem_unset_wedged(struct drm_i915_private *dev_priv);
 void i915_gem_init_mmio(struct drm_i915_private *i915);
 int __must_check i915_gem_init(struct drm_i915_private *dev_priv);
 int __must_check i915_gem_init_hw(struct drm_i915_private *dev_priv);
-void i915_gem_fini_hw(struct drm_i915_private *dev_priv);
+void i915_gem_driver_remove(struct drm_i915_private *dev_priv);
 void i915_gem_driver_release(struct drm_i915_private *dev_priv);
 int i915_gem_wait_for_idle(struct drm_i915_private *dev_priv,
 			   unsigned int flags, long timeout);
@@ -2693,7 +2693,7 @@ mkwrite_device_info(struct drm_i915_private *dev_priv)
 /* modesetting */
 extern void intel_modeset_init_hw(struct drm_device *dev);
 extern int intel_modeset_init(struct drm_device *dev);
-extern void intel_modeset_cleanup(struct drm_device *dev);
+extern void intel_modeset_driver_remove(struct drm_device *dev);
 extern int intel_modeset_vga_set_state(struct drm_i915_private *dev_priv,
 				       bool state);
 extern void intel_display_resume(struct drm_device *dev);
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 51a0fbaa781b..37fe2ed2f582 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1600,7 +1600,7 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 	return ret;
 }
 
-void i915_gem_fini_hw(struct drm_i915_private *dev_priv)
+void i915_gem_driver_remove(struct drm_i915_private *dev_priv)
 {
 	GEM_BUG_ON(dev_priv->gt.awake);
 
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 842ee26effd4..c66b2d8a6219 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -122,13 +122,14 @@ int intel_gvt_init(struct drm_i915_private *dev_priv)
 }
 
 /**
- * intel_gvt_cleanup - cleanup GVT components when i915 driver is unloading
+ * intel_gvt_driver_remove - cleanup GVT components when i915 driver is
+ *			     unbinding
  * @dev_priv: drm i915 private *
  *
  * This function is called at the i915 driver unloading stage, to shutdown
  * GVT components and release the related resources.
  */
-void intel_gvt_cleanup(struct drm_i915_private *dev_priv)
+void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 {
 	if (!intel_gvt_active(dev_priv))
 		return;
diff --git a/drivers/gpu/drm/i915/intel_gvt.h b/drivers/gpu/drm/i915/intel_gvt.h
index 85ce37eb7cd6..21d58f6b9e89 100644
--- a/drivers/gpu/drm/i915/intel_gvt.h
+++ b/drivers/gpu/drm/i915/intel_gvt.h
@@ -28,7 +28,7 @@ struct drm_i915_private;
 
 #ifdef CONFIG_DRM_I915_GVT
 int intel_gvt_init(struct drm_i915_private *dev_priv);
-void intel_gvt_cleanup(struct drm_i915_private *dev_priv);
+void intel_gvt_driver_remove(struct drm_i915_private *dev_priv);
 int intel_gvt_init_device(struct drm_i915_private *dev_priv);
 void intel_gvt_clean_device(struct drm_i915_private *dev_priv);
 int intel_gvt_init_host(void);
@@ -38,7 +38,7 @@ static inline int intel_gvt_init(struct drm_i915_private *dev_priv)
 {
 	return 0;
 }
-static inline void intel_gvt_cleanup(struct drm_i915_private *dev_priv)
+static inline void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 {
 }
 
-- 
2.21.0

