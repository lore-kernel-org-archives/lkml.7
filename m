Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D8C71142
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DC82084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfGJMgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:36:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:22835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJMgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:36:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:45 -0700
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170906906"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:42 -0700
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
Subject: [RFC PATCH 1/6] drm/i915: Rename "_load"/"_unload" to match PCI entry points
Date:   Wed, 10 Jul 2019 14:36:26 +0200
Message-Id: <20190710123631.26575-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
References: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current names of i915_driver_load/unload() functions originate in
legacy DRM stubs.  Reduce nomenclature ambiguity by renaming them to
match their current use as helpers called from PCI entry points.

Suggested by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c | 8 ++++----
 drivers/gpu/drm/i915/i915_drv.h | 4 ++--
 drivers/gpu/drm/i915/i915_pci.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 12182d2fc03c..8b72ae7c1f5d 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1870,17 +1870,17 @@ static void i915_driver_destroy(struct drm_i915_private *i915)
 }
 
 /**
- * i915_driver_load - setup chip and create an initial config
+ * i915_driver_probe - setup chip and create an initial config
  * @pdev: PCI device
  * @ent: matching PCI ID entry
  *
- * The driver load routine has to do several things:
+ * The driver probe routine has to do several things:
  *   - drive output discovery via intel_modeset_init()
  *   - initialize the memory manager
  *   - allocate initial config memory
  *   - setup the DRM framebuffer with the allocated memory
  */
-int i915_driver_load(struct pci_dev *pdev, const struct pci_device_id *ent)
+int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct intel_device_info *match_info =
 		(struct intel_device_info *)ent->driver_data;
@@ -1946,7 +1946,7 @@ int i915_driver_load(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ret;
 }
 
-void i915_driver_unload(struct drm_device *dev)
+void i915_driver_remove(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct pci_dev *pdev = dev_priv->drm.pdev;
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index a9381e404fd5..ebb4c09f8817 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2395,9 +2395,9 @@ extern long i915_compat_ioctl(struct file *filp, unsigned int cmd,
 #endif
 extern const struct dev_pm_ops i915_pm_ops;
 
-extern int i915_driver_load(struct pci_dev *pdev,
+extern int i915_driver_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent);
-extern void i915_driver_unload(struct drm_device *dev);
+extern void i915_driver_remove(struct drm_device *dev);
 
 extern void intel_engine_init_hangcheck(struct intel_engine_cs *engine);
 extern void intel_hangcheck_init(struct drm_i915_private *dev_priv);
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 94b588e0a1dd..786ca7b3439b 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -848,7 +848,7 @@ static void i915_pci_remove(struct pci_dev *pdev)
 	if (!dev) /* driver load aborted, nothing to cleanup */
 		return;
 
-	i915_driver_unload(dev);
+	i915_driver_remove(dev);
 	drm_dev_put(dev);
 
 	pci_set_drvdata(pdev, NULL);
@@ -923,7 +923,7 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (vga_switcheroo_client_probe_defer(pdev))
 		return -EPROBE_DEFER;
 
-	err = i915_driver_load(pdev, ent);
+	err = i915_driver_probe(pdev, ent);
 	if (err)
 		return err;
 
-- 
2.21.0

