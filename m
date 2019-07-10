Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA7C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411972086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfGJMhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:37:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:22835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJMg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:36:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:56 -0700
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170906945"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:54 -0700
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
Subject: [RFC PATCH 5/6] drm/i915: Propagate "_probe" function name suffix down
Date:   Wed, 10 Jul 2019 14:36:30 +0200
Message-Id: <20190710123631.26575-6-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
References: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the "_release" and "_remove" cases, consequently replace
"_init" components of names of functions called from
i915_driver_probe() with "_probe" suffixes for better code readability.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 6e83fe96d930..7241a7d14e9b 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -675,7 +675,7 @@ static const struct vga_switcheroo_client_ops i915_switcheroo_ops = {
 	.can_switch = i915_switcheroo_can_switch,
 };
 
-static int i915_load_modeset_init(struct drm_device *dev)
+static int i915_driver_modeset_probe(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct pci_dev *pdev = dev_priv->drm.pdev;
@@ -884,7 +884,7 @@ static void intel_detect_preproduction_hw(struct drm_i915_private *dev_priv)
 }
 
 /**
- * i915_driver_init_early - setup state not requiring device access
+ * i915_driver_early_probe - setup state not requiring device access
  * @dev_priv: device private
  *
  * Initialize everything that is a "SW-only" state, that is state not
@@ -893,7 +893,7 @@ static void intel_detect_preproduction_hw(struct drm_i915_private *dev_priv)
  * system memory allocation, setting up device specific attributes and
  * function hooks not requiring accessing the device.
  */
-static int i915_driver_init_early(struct drm_i915_private *dev_priv)
+static int i915_driver_early_probe(struct drm_i915_private *dev_priv)
 {
 	int ret = 0;
 
@@ -963,7 +963,7 @@ static int i915_driver_init_early(struct drm_i915_private *dev_priv)
 
 /**
  * i915_driver_early_release - cleanup the setup done in
- *			       i915_driver_init_early()
+ *			       i915_driver_early_probe()
  * @dev_priv: device private
  */
 static void i915_driver_early_release(struct drm_i915_private *dev_priv)
@@ -980,7 +980,7 @@ static void i915_driver_early_release(struct drm_i915_private *dev_priv)
 }
 
 /**
- * i915_driver_init_mmio - setup device MMIO
+ * i915_driver_mmio_probe - setup device MMIO
  * @dev_priv: device private
  *
  * Setup minimal device state necessary for MMIO accesses later in the
@@ -988,7 +988,7 @@ static void i915_driver_early_release(struct drm_i915_private *dev_priv)
  * side effects or exposing the driver via kernel internal or user space
  * interfaces.
  */
-static int i915_driver_init_mmio(struct drm_i915_private *dev_priv)
+static int i915_driver_mmio_probe(struct drm_i915_private *dev_priv)
 {
 	int ret;
 
@@ -1029,7 +1029,7 @@ static int i915_driver_init_mmio(struct drm_i915_private *dev_priv)
 }
 
 /**
- * i915_driver_mmio_release - cleanup the setup done in i915_driver_init_mmio()
+ * i915_driver_mmio_release - cleanup the setup done in i915_driver_mmio_probe()
  * @dev_priv: device private
  */
 static void i915_driver_mmio_release(struct drm_i915_private *dev_priv)
@@ -1525,13 +1525,13 @@ static void edram_detect(struct drm_i915_private *dev_priv)
 }
 
 /**
- * i915_driver_init_hw - setup state requiring device access
+ * i915_driver_hw_probe - setup state requiring device access
  * @dev_priv: device private
  *
  * Setup state that requires accessing the device, but doesn't require
  * exposing the driver via kernel internal or userspace interfaces.
  */
-static int i915_driver_init_hw(struct drm_i915_private *dev_priv)
+static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 {
 	struct pci_dev *pdev = dev_priv->drm.pdev;
 	int ret;
@@ -1900,7 +1900,7 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto out_fini;
 
-	ret = i915_driver_init_early(dev_priv);
+	ret = i915_driver_early_probe(dev_priv);
 	if (ret < 0)
 		goto out_pci_disable;
 
@@ -1908,15 +1908,15 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	i915_detect_vgpu(dev_priv);
 
-	ret = i915_driver_init_mmio(dev_priv);
+	ret = i915_driver_mmio_probe(dev_priv);
 	if (ret < 0)
 		goto out_runtime_pm_put;
 
-	ret = i915_driver_init_hw(dev_priv);
+	ret = i915_driver_hw_probe(dev_priv);
 	if (ret < 0)
 		goto out_cleanup_mmio;
 
-	ret = i915_load_modeset_init(&dev_priv->drm);
+	ret = i915_driver_modeset_probe(&dev_priv->drm);
 	if (ret < 0)
 		goto out_cleanup_hw;
 
-- 
2.21.0

