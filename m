Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364E6C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DDA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfGJMgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:36:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:22835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJMgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:36:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:48 -0700
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170906925"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:45 -0700
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
Subject: [RFC PATCH 2/6] drm/i915: Replace "_load" with "_probe" consequently
Date:   Wed, 10 Jul 2019 14:36:27 +0200
Message-Id: <20190710123631.26575-3-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
References: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "_probe" nomenclature not only in i915_driver_probe() helper
name but also in other related function / variable names for
consistency.  Only the userspace exposed name of a related module
parameter is left untouched.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 .../gpu/drm/i915/display/intel_connector.c    |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |  2 +-
 drivers/gpu/drm/i915/i915_drv.c               | 20 +++++++++----------
 drivers/gpu/drm/i915/i915_drv.h               | 10 +++++-----
 drivers/gpu/drm/i915/i915_gem.c               |  8 ++++----
 drivers/gpu/drm/i915/i915_pci.c               |  2 +-
 drivers/gpu/drm/i915/intel_gvt.c              |  2 +-
 drivers/gpu/drm/i915/intel_uncore.c           |  2 +-
 drivers/gpu/drm/i915/intel_wopcm.c            |  2 +-
 9 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/drm/i915/display/intel_connector.c
index 41310f8e5a2a..d0163d86c42a 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.c
+++ b/drivers/gpu/drm/i915/display/intel_connector.c
@@ -118,7 +118,7 @@ int intel_connector_register(struct drm_connector *connector)
 	if (ret)
 		goto err;
 
-	if (i915_inject_load_failure()) {
+	if (i915_inject_probe_failure()) {
 		ret = -EFAULT;
 		goto err_backlight;
 	}
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index df5932f5f578..a17f0f812735 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -426,7 +426,7 @@ int intel_engines_init_mmio(struct drm_i915_private *i915)
 	WARN_ON(engine_mask &
 		GENMASK(BITS_PER_TYPE(mask) - 1, I915_NUM_ENGINES));
 
-	if (i915_inject_load_failure())
+	if (i915_inject_probe_failure())
 		return -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(intel_engines); i++) {
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 8b72ae7c1f5d..ad24957ad86d 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -81,14 +81,14 @@
 static struct drm_driver driver;
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG)
-static unsigned int i915_load_fail_count;
+static unsigned int i915_probe_fail_count;
 
-bool __i915_inject_load_failure(const char *func, int line)
+bool __i915_inject_probe_failure(const char *func, int line)
 {
-	if (i915_load_fail_count >= i915_modparams.inject_load_failure)
+	if (i915_probe_fail_count >= i915_modparams.inject_load_failure)
 		return false;
 
-	if (++i915_load_fail_count == i915_modparams.inject_load_failure) {
+	if (++i915_probe_fail_count == i915_modparams.inject_load_failure) {
 		DRM_INFO("Injecting failure at checkpoint %u [%s:%d]\n",
 			 i915_modparams.inject_load_failure, func, line);
 		i915_modparams.inject_load_failure = 0;
@@ -100,7 +100,7 @@ bool __i915_inject_load_failure(const char *func, int line)
 
 bool i915_error_injected(void)
 {
-	return i915_load_fail_count && !i915_modparams.inject_load_failure;
+	return i915_probe_fail_count && !i915_modparams.inject_load_failure;
 }
 
 #endif
@@ -681,7 +681,7 @@ static int i915_load_modeset_init(struct drm_device *dev)
 	struct pci_dev *pdev = dev_priv->drm.pdev;
 	int ret;
 
-	if (i915_inject_load_failure())
+	if (i915_inject_probe_failure())
 		return -ENODEV;
 
 	if (HAS_DISPLAY(dev_priv)) {
@@ -897,7 +897,7 @@ static int i915_driver_init_early(struct drm_i915_private *dev_priv)
 {
 	int ret = 0;
 
-	if (i915_inject_load_failure())
+	if (i915_inject_probe_failure())
 		return -ENODEV;
 
 	intel_device_info_subplatform_init(dev_priv);
@@ -991,7 +991,7 @@ static int i915_driver_init_mmio(struct drm_i915_private *dev_priv)
 {
 	int ret;
 
-	if (i915_inject_load_failure())
+	if (i915_inject_probe_failure())
 		return -ENODEV;
 
 	if (i915_get_bridge_dev(dev_priv))
@@ -1535,7 +1535,7 @@ static int i915_driver_init_hw(struct drm_i915_private *dev_priv)
 	struct pci_dev *pdev = dev_priv->drm.pdev;
 	int ret;
 
-	if (i915_inject_load_failure())
+	if (i915_inject_probe_failure())
 		return -ENODEV;
 
 	intel_device_info_runtime_init(dev_priv);
@@ -1941,7 +1941,7 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 out_pci_disable:
 	pci_disable_device(pdev);
 out_fini:
-	i915_load_error(dev_priv, "Device initialization failed (%d)\n", ret);
+	i915_probe_error(dev_priv, "Device initialization failed (%d)\n", ret);
 	i915_driver_destroy(dev_priv);
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index ebb4c09f8817..4deadec2e20b 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -122,20 +122,20 @@
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG)
 
-bool __i915_inject_load_failure(const char *func, int line);
-#define i915_inject_load_failure() \
-	__i915_inject_load_failure(__func__, __LINE__)
+bool __i915_inject_probe_failure(const char *func, int line);
+#define i915_inject_probe_failure() \
+	__i915_inject_probe_failure(__func__, __LINE__)
 
 bool i915_error_injected(void);
 
 #else
 
-#define i915_inject_load_failure() false
+#define i915_inject_probe_failure() false
 #define i915_error_injected() false
 
 #endif
 
-#define i915_load_error(i915, fmt, ...)					 \
+#define i915_probe_error(i915, fmt, ...)				   \
 	__i915_printk(i915, i915_error_injected() ? KERN_DEBUG : KERN_ERR, \
 		      fmt, ##__VA_ARGS__)
 
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 7ade42b8ec99..015208741405 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1515,12 +1515,12 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 	if (ret)
 		goto err_gt;
 
-	if (i915_inject_load_failure()) {
+	if (i915_inject_probe_failure()) {
 		ret = -ENODEV;
 		goto err_gt;
 	}
 
-	if (i915_inject_load_failure()) {
+	if (i915_inject_probe_failure()) {
 		ret = -EIO;
 		goto err_gt;
 	}
@@ -1582,8 +1582,8 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 		 * for all other failure, such as an allocation failure, bail.
 		 */
 		if (!i915_reset_failed(dev_priv)) {
-			i915_load_error(dev_priv,
-					"Failed to initialize GPU, declaring it wedged!\n");
+			i915_probe_error(dev_priv,
+					 "Failed to initialize GPU, declaring it wedged!\n");
 			i915_gem_set_wedged(dev_priv);
 		}
 
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 786ca7b3439b..64301bf9e1a3 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -927,7 +927,7 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
-	if (i915_inject_load_failure()) {
+	if (i915_inject_probe_failure()) {
 		i915_pci_remove(pdev);
 		return -ENODEV;
 	}
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 1d7d26e4cf14..842ee26effd4 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -95,7 +95,7 @@ int intel_gvt_init(struct drm_i915_private *dev_priv)
 {
 	int ret;
 
-	if (i915_inject_load_failure())
+	if (i915_inject_probe_failure())
 		return -ENODEV;
 
 	if (!i915_modparams.enable_gvt) {
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index 4015e964c6fc..475ab3d4d91d 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -1331,7 +1331,7 @@ static int __fw_domain_init(struct intel_uncore *uncore,
 	GEM_BUG_ON(domain_id >= FW_DOMAIN_ID_COUNT);
 	GEM_BUG_ON(uncore->fw_domain[domain_id]);
 
-	if (i915_inject_load_failure())
+	if (i915_inject_probe_failure())
 		return -ENOMEM;
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
diff --git a/drivers/gpu/drm/i915/intel_wopcm.c b/drivers/gpu/drm/i915/intel_wopcm.c
index 8c850785e4b4..a6bc15bc7be3 100644
--- a/drivers/gpu/drm/i915/intel_wopcm.c
+++ b/drivers/gpu/drm/i915/intel_wopcm.c
@@ -177,7 +177,7 @@ int intel_wopcm_init(struct intel_wopcm *wopcm)
 
 	GEM_BUG_ON(!wopcm->size);
 
-	if (i915_inject_load_failure())
+	if (i915_inject_probe_failure())
 		return -E2BIG;
 
 	if (guc_fw_size >= wopcm->size) {
-- 
2.21.0

