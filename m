Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD672075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="cDXEzRiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDCN1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:27:16 -0400
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:46272 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbfDCNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:43 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 44Z65v1f8dz2gZ;
        Wed,  3 Apr 2019 15:16:03 +0200 (CEST)
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0186.rbdmz01.com (Postfix) with ESMTPS id 44Z65s43Qlz1XLFjh;
        Wed,  3 Apr 2019 15:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297361;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=cDXEzRiXZWXt4NEpGOX9n0UvvQ8r4Tcqe4wfAYX8cOsTzz7I4iGZGna4NBoAmobZf
         aR4in5ZaqUBYPNJRXa+wHcQrZPiKUCPJfuIqoTBCbzioLW9p4qyII9QiEmHN3rt0n5
         TQPflzTQcg6yWVg5P3pDR5jPnfGT/ZwyRGBR1UPY=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 44Z65s3XX0z6CjQSh;
        Wed,  3 Apr 2019 15:16:01 +0200 (CEST)
X-AuditID: 0a3aad10-03fff70000007f88-c0-5ca4b210ba23
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id 19.BF.32648.012B4AC5; Wed,  3 Apr 2019 15:16:00 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 44Z65r5c14zR6h;
        Wed,  3 Apr 2019 15:16:00 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:58 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Balasubramani Vivekanandan 
        <balasubramani_vivekanandan@mentor.com>
Subject: [PATCH 8/8] drm: rcar-du: Add shutdown callback function in platform_driver
Date:   Wed, 3 Apr 2019 18:44:44 +0530
Message-ID: <1554297284-14009-9-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA21Sf0wbZRjud9derx1nr1dgr223mMb4B8kmqHOnEreQmHRG4zLHNKSZFjja
        xv7AXsvGEifBLZMf0m0KCtvoVsHJJhktbtChQ5sllAUJbGSGGYFtaGi30QnDweLUOwtr//Cf
        y/c97/Pj/Z4ciTNX5VrS5vRwbqfZbiCUUuWLnWvWqUNtptxwDLGNRwYQ6784LGPHFhIEu3i0
        H2P/qJ+QsVfOHyXYs7FZjD3ZGcA3k8bJugHM2LdQjYx/Dh2SGudDa7dKi5T5pZzdVsG5n375
        XaU1MXSYKO/etDsa/rAKndhQixQk0M/BV4NHiFqkJBn6CwxuLfrw5OU7BPM3euUii6FvC5e7
        evFM0OugPxiUi6RMugNB3WwPJg5w+g6C+HVdLSJJDb0dDoaLRFhKPwmNiTP/+VB0IVz+aRxL
        Jq+F8eEaXDwr6B3gj04TyaxC8C/OyZJ8NQw2T0uT9gA/zszgoj3QT0D4BHEQ0S1prJY01nGE
        nUJZZVxuhWPjC3nsencxx+/JzVtf4nKEULJluheFL5VFEE0iQwY10dxmYmTmCr7SEUEbSMyQ
        RT2/V4AeK3aVVlrNvPUdt9fO8QYtpR951cRoHsG8t9hh43mbyxlBQOKGTGrId9zEUKXmyj2c
        25WURZCOlBpWUxbyDRNDW8we7j2OK+fcK9OXSNIAVGZQCFS7OQu3u8xm96yMDWsoJJFImOz0
        SXosRioi6FkyQ8gOnxEsKL7c7OBtlmX540k5s4KmpJfQFrIh+PsxnOy+LnwZqdPl5LSrqVVd
        ggst8q1e56M9tHpK8luriclKG6S84ugqEprUUA/FFTKEXzq1AVA6sTT1MpgSPRMQNPRf2TCR
        0EH02mvQ12qC2IEqBK29Cwii82EcGgKzUrh3rFEGF5oSMlhsuknAD/duERDoXiLg8vkWOcx3
        LsgF7DQJk+PnFDB2JaKA0Y8TCojVdCvhcN2UEu5+/QkFn/5SpYK+fSEVjMf7VLD0/agKvhm7
        oYL+9hY1NMycZODQSFQDbQ/uZEPHtwNaWPL7dHGhW0zolvX6xW49Zs//dLuMpp6mrULtu/zB
        9z8vqb6ZNafcvyr0wcMaryd/OOOC0fJlbdAzSk7JewpuP6Wpe/ufkoIuf/62qZGeV3wXmYm5
        2Eebx/IKTr1lP7dJf99Zv9H368436z/L2b+3K6g3xaerD/zdvD3SuWtf+4OBjsEcV9fpudeb
        t2y7X3it6OfhnQFJeHIm5+yOgiaDlLea83JwN2/+F4/5t6FpBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

When rebooting, the Display driver is accessing H/W (reading DDR).
Therefore, there is a problem of hanging when setting DDR to self
refresh mode.

This patch implement the shutdown function and solve this problem
by stopping H/W access.

In addtion, on the ulcb board, since initial values of versaclock
are used as they are, signals are not output when initializing to
0 with shutdown, so this patch excludes processing to initialize
versaclock to 0.
drm: rcar-du: Add HDMI control clock when S2RAM

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

(cherry picked from horms/renesas-bsp commit 3cfda6331c4069800dd4434427284aba8e6f1ed6)
[slongerbeam: keep integer i in rcar_du_pm_shutdown(), needed because of
 050e54d87f ("drm: rcar-du: drm: rcar-du: Add DU CMM support")]

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

drm: rcar-du: cmm: lut and clu backup not required during
 shutdown
rcar_du_cmm_pm_suspend function copies LUT and CLU hardare
register values to memory. In the patch which adds DU CMM
support (https://github.com/renesas-rcar/du_cmm/commit/
9a65d02119e4ae405a89a850463a6a0d0f2c1ecb), the intention of
the author was to backup the registers during suspend and
restore it on resume. But rcar_du_cmm_pm_suspend was also
called on system shutdown. Though it does not cause any harm,
it is not required during shutdown as it does not make sense
to backup. This patch ensures that rcar_du_cmm_pm_suspend is
called only during suspend

Fixes: https://github.com/renesas-rcar/du_cmm/commit/9a65d02119e4ae405a89a850463a6a0d0f2c1ecb

Signed-off-by: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>

      - Resolved checkpatch errors
      - Resolved merge conflicts according to latest version

Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 35 ++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c     | 54 +++++++++++++++++++++++++------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h |  1 +
 include/drm/bridge/dw_hdmi.h              |  1 +
 5 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 5971976..aa257d7 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2033,6 +2033,41 @@ static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
 	mutex_unlock(&hdmi->mutex);
 }
 
+/*
+ * This function controls clocks of dw_hdmi through drm_bridge
+ * at system suspend/resume.
+ * Arguments:
+ *  bridge: drm_bridge that contains dw_hdmi.
+ *  flag: controlled flag.
+ *		false: is used when suspend.
+ *		true: is used when resume.
+ */
+void dw_hdmi_s2r_ctrl(struct drm_bridge *bridge, int flag)
+{
+	struct dw_hdmi *hdmi = bridge->driver_private;
+
+	if (!hdmi)
+		return;
+
+	if (flag) { /* enable clk */
+		if (hdmi->isfr_clk)
+			clk_prepare_enable(hdmi->isfr_clk);
+		if (hdmi->iahb_clk)
+			clk_prepare_enable(hdmi->iahb_clk);
+
+		initialize_hdmi_ih_mutes(hdmi);
+		dw_hdmi_setup_i2c(hdmi);
+		dw_hdmi_i2c_init(hdmi);
+		dw_hdmi_phy_setup_hpd(hdmi, NULL);
+	} else { /* disable clk */
+		if (hdmi->isfr_clk)
+			clk_disable_unprepare(hdmi->isfr_clk);
+		if (hdmi->iahb_clk)
+			clk_disable_unprepare(hdmi->iahb_clk);
+	}
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_s2r_ctrl);
+
 static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
 	.attach = dw_hdmi_bridge_attach,
 	.enable = dw_hdmi_bridge_enable,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 838b7c9..9eb63b0 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 
+#include <drm/bridge/dw_hdmi.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
@@ -368,18 +369,14 @@ static struct drm_driver rcar_du_driver = {
  */
 
 #ifdef CONFIG_PM_SLEEP
-static int rcar_du_pm_suspend(struct device *dev)
+static int rcar_du_pm_shutdown(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
 	struct drm_atomic_state *state;
-	int i;
-
-	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM)) {
-		for (i = 0; i < rcdu->num_crtcs; ++i)
-			rcar_du_cmm_pm_suspend(&rcdu->crtcs[i]);
-	}
-
-	drm_kms_helper_poll_disable(rcdu->ddev);
+#if IS_ENABLED(CONFIG_DRM_RCAR_DW_HDMI)
+	struct drm_encoder *encoder;
+#endif
+		drm_kms_helper_poll_disable(rcdu->ddev);
 	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
 
 	state = drm_atomic_helper_suspend(rcdu->ddev);
@@ -389,11 +386,43 @@ static int rcar_du_pm_suspend(struct device *dev)
 		return PTR_ERR(state);
 	}
 
+#if IS_ENABLED(CONFIG_DRM_RCAR_DW_HDMI)
+	list_for_each_entry(encoder,
+			    &rcdu->ddev->mode_config.encoder_list,
+			    head) {
+		struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
+
+		if (renc->bridge && (renc->output == RCAR_DU_OUTPUT_HDMI0 ||
+				     renc->output == RCAR_DU_OUTPUT_HDMI1))
+			dw_hdmi_s2r_ctrl(encoder->bridge, false);
+	}
+#endif
 	rcdu->suspend_state = state;
 
 	return 0;
 }
 
+static int rcar_du_pm_suspend(struct device *dev)
+{
+	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
+
+	int i, ret;
+
+	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM)) {
+		for (i = 0; i < rcdu->num_crtcs; ++i)
+			rcar_du_cmm_pm_suspend(&rcdu->crtcs[i]);
+	}
+
+	ret = rcar_du_pm_shutdown(dev);
+
+	if (ret)
+		return ret;
+
+	for (i = 0; i < rcdu->num_crtcs; ++i)
+		clk_set_rate(rcdu->crtcs[i].extclock, 0);
+	return 0;
+}
+
 static int rcar_du_pm_resume(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
@@ -504,6 +533,12 @@ static int rcar_du_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void rcar_du_shutdown(struct platform_device *pdev)
+{
+#ifdef CONFIG_PM_SLEEP
+	rcar_du_pm_shutdown(&pdev->dev);
+#endif
+}
 static struct platform_driver rcar_du_platform_driver = {
 	.probe		= rcar_du_probe,
 	.remove		= rcar_du_remove,
@@ -512,6 +547,7 @@ static struct platform_driver rcar_du_platform_driver = {
 		.pm	= &rcar_du_pm_ops,
 		.of_match_table = rcar_du_of_table,
 	},
+	.shutdown       = rcar_du_shutdown,
 };
 
 static int __init rcar_du_init(void)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index f9c933d..98df8a2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -62,7 +62,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 
 	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %u\n",
 		enc_node, output);
-
+	renc->bridge = bridge;
 	/* Locate the DRM bridge from the encoder DT node. */
 	bridge = of_drm_find_bridge(enc_node);
 	if (!bridge) {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index 2d2abca..cc5bfcb 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -23,6 +23,7 @@ struct rcar_du_device;
 struct rcar_du_encoder {
 	struct drm_encoder base;
 	enum rcar_du_output output;
+	struct drm_bridge *bridge;
 };
 
 #define to_rcar_encoder(e) \
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index ccb5aa8..36383cf4 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -171,5 +171,6 @@ enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
 void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
 			    bool force, bool disabled, bool rxsense);
 void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
+void dw_hdmi_s2r_ctrl(struct drm_bridge *bridge, int flag);
 
 #endif /* __IMX_HDMI_H__ */
-- 
2.7.4

