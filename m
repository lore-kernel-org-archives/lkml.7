Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82445C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557FF205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCHRnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:43:43 -0500
Received: from anholt.net ([50.246.234.109]:53290 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfCHRnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:43:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9072310A2E2B;
        Fri,  8 Mar 2019 09:43:39 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7UZ6USuLgM-6; Fri,  8 Mar 2019 09:43:37 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C135010A2BEE;
        Fri,  8 Mar 2019 09:43:36 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 43CA82FE1BF4; Fri,  8 Mar 2019 09:43:36 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 2/2] drm/v3d: Add support for V3D v4.2.
Date:   Fri,  8 Mar 2019 09:43:36 -0800
Message-Id: <20190308174336.7866-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308174336.7866-1-eric@anholt.net>
References: <20190308174336.7866-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No compatible string for it yet, just the version-dependent changes.
They've now tied the hub and the core interrupt lines into a single
interrupt line coming out of the block.  It also turns out I made a
mistake in modeling the V3D v3.3 and v4.1 bridge as a part of V3D
itself -- the bridge is going away in favor of an external reset
controller in a larger HW module.

v2: Use consistent checks for whether we're on 4.2, and fix a leak in
    an error path.
v3: Use more general means of determining if the current 4.2 changes
    are in place, as apparently other platforms may switch back (noted
    by Dave).  Update the binding doc.
v4: Improve error handling for IRQ init.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../devicetree/bindings/gpu/brcm,bcm-v3d.txt  | 11 +++--
 drivers/gpu/drm/v3d/v3d_drv.c                 | 21 +++++++--
 drivers/gpu/drm/v3d/v3d_drv.h                 |  2 +
 drivers/gpu/drm/v3d/v3d_gem.c                 | 12 ++++-
 drivers/gpu/drm/v3d/v3d_irq.c                 | 45 ++++++++++++++-----
 5 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
index c907aa8dd755..b2df82b44625 100644
--- a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
+++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
@@ -6,15 +6,20 @@ For V3D 2.x, see brcm,bcm-vc4.txt.
 Required properties:
 - compatible:	Should be "brcm,7268-v3d" or "brcm,7278-v3d"
 - reg:		Physical base addresses and lengths of the register areas
-- reg-names:	Names for the register areas.  The "hub", "bridge", and "core0"
+- reg-names:	Names for the register areas.  The "hub" and "core0"
 		  register areas are always required.  The "gca" register area
-		  is required if the GCA cache controller is present.
+		  is required if the GCA cache controller is present.  The
+		  "bridge" register area is required if an external reset
+		  controller is not present.
 - interrupts:	The interrupt numbers.  The first interrupt is for the hub,
-		  while the following interrupts are for the cores.
+		  while the following interrupts are separate interrupt lines
+		  for the cores (if they don't share the hub's interrupt).
 		  See bindings/interrupt-controller/interrupts.txt
 
 Optional properties:
 - clocks:	The core clock the unit runs on
+- resets:	The reset line for v3d, if not using a mapping of the bridge
+		  See bindings/reset/reset.txt
 
 v3d {
 	compatible = "brcm,7268-v3d";
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index f9906cac7a88..89b7567d550f 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 
@@ -264,10 +265,6 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d->pdev = pdev;
 	drm = &v3d->drm;
 
-	ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
-	if (ret)
-		goto dev_free;
-
 	ret = map_regs(v3d, &v3d->hub_regs, "hub");
 	if (ret)
 		goto dev_free;
@@ -282,6 +279,22 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d->cores = V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_NCORES);
 	WARN_ON(v3d->cores > 1); /* multicore not yet implemented */
 
+	v3d->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(v3d->reset)) {
+		ret = PTR_ERR(v3d->reset);
+
+		if (ret == -EPROBE_DEFER)
+			goto dev_free;
+
+		v3d->reset = NULL;
+		ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
+		if (ret) {
+			dev_err(dev,
+				"Failed to get reset control or bridge regs\n");
+			goto dev_free;
+		}
+	}
+
 	if (v3d->ver < 41) {
 		ret = map_regs(v3d, &v3d->gca_regs, "gca");
 		if (ret)
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index bb58ecb9d9c5..b5efac7894ca 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -33,6 +33,7 @@ struct v3d_dev {
 	 * and revision.
 	 */
 	int ver;
+	bool single_irq_line;
 
 	struct device *dev;
 	struct platform_device *pdev;
@@ -41,6 +42,7 @@ struct v3d_dev {
 	void __iomem *bridge_regs;
 	void __iomem *gca_regs;
 	struct clk *clk;
+	struct reset_control *reset;
 
 	/* Virtual and DMA addresses of the single shared page table. */
 	volatile u32 *pt;
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 0a83268dec0c..449d01ea54a0 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/sched/signal.h>
@@ -70,7 +71,7 @@ v3d_idle_gca(struct v3d_dev *v3d)
 }
 
 static void
-v3d_reset_v3d(struct v3d_dev *v3d)
+v3d_reset_by_bridge(struct v3d_dev *v3d)
 {
 	int version = V3D_BRIDGE_READ(V3D_TOP_GR_BRIDGE_REVISION);
 
@@ -90,6 +91,15 @@ v3d_reset_v3d(struct v3d_dev *v3d)
 				 V3D_TOP_GR_BRIDGE_SW_INIT_1_V3D_CLK_108_SW_INIT);
 		V3D_BRIDGE_WRITE(V3D_TOP_GR_BRIDGE_SW_INIT_1, 0);
 	}
+}
+
+static void
+v3d_reset_v3d(struct v3d_dev *v3d)
+{
+	if (v3d->reset)
+		reset_control_reset(v3d->reset);
+	else
+		v3d_reset_by_bridge(v3d);
 
 	v3d_init_hw_state(v3d);
 }
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 29d746cfce57..b8aea2dfbe82 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -27,6 +27,9 @@
 			    V3D_HUB_INT_MMU_CAP |	\
 			    V3D_HUB_INT_TFUC))
 
+static irqreturn_t
+v3d_hub_irq(int irq, void *arg);
+
 static void
 v3d_overflow_mem_work(struct work_struct *work)
 {
@@ -112,6 +115,12 @@ v3d_irq(int irq, void *arg)
 	if (intsts & V3D_INT_GMPV)
 		dev_err(v3d->dev, "GMP violation\n");
 
+	/* V3D 4.2 wires the hub and core IRQs together, so if we &
+	 * didn't see the common one then check hub for MMU IRQs.
+	 */
+	if (v3d->single_irq_line && status == IRQ_NONE)
+		return v3d_hub_irq(irq, arg);
+
 	return status;
 }
 
@@ -159,7 +168,7 @@ v3d_hub_irq(int irq, void *arg)
 int
 v3d_irq_init(struct v3d_dev *v3d)
 {
-	int ret, core;
+	int irq1, ret, core;
 
 	INIT_WORK(&v3d->overflow_mem_work, v3d_overflow_mem_work);
 
@@ -170,17 +179,29 @@ v3d_irq_init(struct v3d_dev *v3d)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS);
 	V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS);
 
-	ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
-			       v3d_hub_irq, IRQF_SHARED,
-			       "v3d_hub", v3d);
-	if (ret)
-		goto fail;
-
-	ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 1),
-			       v3d_irq, IRQF_SHARED,
-			       "v3d_core0", v3d);
-	if (ret)
-		goto fail;
+	irq1 = platform_get_irq(v3d->pdev, 1);
+	if (irq1 == -EPROBE_DEFER)
+		return irq1;
+	if (irq1 > 0) {
+		ret = devm_request_irq(v3d->dev, irq1,
+				       v3d_irq, IRQF_SHARED,
+				       "v3d_core0", v3d);
+		if (ret)
+			goto fail;
+		ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
+				       v3d_hub_irq, IRQF_SHARED,
+				       "v3d_hub", v3d);
+		if (ret)
+			goto fail;
+	} else {
+		v3d->single_irq_line = true;
+
+		ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
+				       v3d_irq, IRQF_SHARED,
+				       "v3d", v3d);
+		if (ret)
+			goto fail;
+	}
 
 	v3d_irq_enable(v3d);
 	return 0;
-- 
2.20.1

