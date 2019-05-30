Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CDFC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74530259A7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfE3NbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:31:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:51815 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfE3NbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:31:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 06:31:15 -0700
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 06:31:12 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v2] drm/i915: Split off pci_driver.remove() tail to drm_driver.release()
Date:   Thu, 30 May 2019 15:31:05 +0200
Message-Id: <20190530133105.30467-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support driver hot unbind, some cleanup operations, now
performed on PCI driver remove, must be called later, after all device
file descriptors are closed.

Split out those operations from the tail of pci_driver.remove()
callback and put them into drm_driver.release() which is called as soon
as all references to the driver are put.  As a result, those cleanups
will be now run on last drm_dev_put(), either still called from
pci_driver.remove() if all device file descriptors are already closed,
or on last drm_release() file operation.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
---
Changelog:
v1 -> v2:
- defer intel_engines_cleanup() as well. (Chris)

 drivers/gpu/drm/i915/i915_drv.c | 17 +++++++++++++----
 drivers/gpu/drm/i915/i915_drv.h |  1 +
 drivers/gpu/drm/i915/i915_gem.c | 10 +++++++++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 83d2eb9e74cb..8be69f84eb6d 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -738,6 +738,7 @@ static int i915_load_modeset_init(struct drm_device *dev)
 
 cleanup_gem:
 	i915_gem_suspend(dev_priv);
+	i915_gem_fini_hw(dev_priv);
 	i915_gem_fini(dev_priv);
 cleanup_modeset:
 	intel_modeset_cleanup(dev);
@@ -1685,7 +1686,6 @@ static void i915_driver_cleanup_hw(struct drm_i915_private *dev_priv)
 		pci_disable_msi(pdev);
 
 	pm_qos_remove_request(&dev_priv->pm_qos);
-	i915_ggtt_cleanup_hw(dev_priv);
 }
 
 /**
@@ -1909,6 +1909,7 @@ int i915_driver_load(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 out_cleanup_hw:
 	i915_driver_cleanup_hw(dev_priv);
+	i915_ggtt_cleanup_hw(dev_priv);
 out_cleanup_mmio:
 	i915_driver_cleanup_mmio(dev_priv);
 out_runtime_pm_put:
@@ -1960,21 +1961,29 @@ void i915_driver_unload(struct drm_device *dev)
 	cancel_delayed_work_sync(&dev_priv->gpu_error.hangcheck_work);
 	i915_reset_error_state(dev_priv);
 
-	i915_gem_fini(dev_priv);
+	i915_gem_fini_hw(dev_priv);
 
 	intel_power_domains_fini_hw(dev_priv);
 
 	i915_driver_cleanup_hw(dev_priv);
-	i915_driver_cleanup_mmio(dev_priv);
 
 	enable_rpm_wakeref_asserts(dev_priv);
-	intel_runtime_pm_cleanup(dev_priv);
 }
 
 static void i915_driver_release(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
 
+	disable_rpm_wakeref_asserts(dev_priv);
+
+	i915_gem_fini(dev_priv);
+
+	i915_ggtt_cleanup_hw(dev_priv);
+	i915_driver_cleanup_mmio(dev_priv);
+
+	enable_rpm_wakeref_asserts(dev_priv);
+	intel_runtime_pm_cleanup(dev_priv);
+
 	i915_driver_cleanup_early(dev_priv);
 	i915_driver_destroy(dev_priv);
 }
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index a2664ea1395b..d08e7bd83544 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -3047,6 +3047,7 @@ void i915_gem_init_mmio(struct drm_i915_private *i915);
 int __must_check i915_gem_init(struct drm_i915_private *dev_priv);
 int __must_check i915_gem_init_hw(struct drm_i915_private *dev_priv);
 void i915_gem_init_swizzling(struct drm_i915_private *dev_priv);
+void i915_gem_fini_hw(struct drm_i915_private *dev_priv);
 void i915_gem_fini(struct drm_i915_private *dev_priv);
 int i915_gem_wait_for_idle(struct drm_i915_private *dev_priv,
 			   unsigned int flags, long timeout);
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 7cafd5612f71..20d3f7532cef 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -4667,7 +4667,7 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 	return ret;
 }
 
-void i915_gem_fini(struct drm_i915_private *dev_priv)
+void i915_gem_fini_hw(struct drm_i915_private *dev_priv)
 {
 	GEM_BUG_ON(dev_priv->gt.awake);
 
@@ -4680,6 +4680,14 @@ void i915_gem_fini(struct drm_i915_private *dev_priv)
 	mutex_lock(&dev_priv->drm.struct_mutex);
 	intel_uc_fini_hw(dev_priv);
 	intel_uc_fini(dev_priv);
+	mutex_unlock(&dev_priv->drm.struct_mutex);
+
+	i915_gem_drain_freed_objects(dev_priv);
+}
+
+void i915_gem_fini(struct drm_i915_private *dev_priv)
+{
+	mutex_lock(&dev_priv->drm.struct_mutex);
 	intel_engines_cleanup(dev_priv);
 	i915_gem_contexts_fini(dev_priv);
 	i915_gem_fini_scratch(dev_priv);
-- 
2.21.0

