Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150AFC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76FF2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfECIqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:46:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:5541 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfECIpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811587"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:41 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 14/22] intel_th: gth: Factor out trace start/stop
Date:   Fri,  3 May 2019 11:44:47 +0300
Message-Id: <20190503084455.23436-15-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace enable/disable functions of the GTH include the code that starts
and stops trace flom from the sources. This start/stop functionality will
also be used in the window switch trigger sequence.

Factor out start/stop code from the larger trace enable/disable code in
preparation for the window switch sequence.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/gth.c | 93 ++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index 7e6b70047125..a879445ef451 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -457,37 +457,28 @@ static int intel_th_output_attributes(struct gth_device *gth)
 }
 
 /**
- * intel_th_gth_disable() - disable tracing to an output device
- * @thdev:	GTH device
- * @output:	output device's descriptor
+ * intel_th_gth_stop() - stop tracing to an output device
+ * @gth:		GTH device
+ * @output:		output device's descriptor
+ * @capture_done:	set when no more traces will be captured
  *
- * This will deconfigure all masters set to output to this device,
- * disable tracing using force storeEn off signal and wait for the
- * "pipeline empty" bit for corresponding output port.
+ * This will stop tracing using force storeEn off signal and wait for the
+ * pipelines to be empty for the corresponding output port.
  */
-static void intel_th_gth_disable(struct intel_th_device *thdev,
-				 struct intel_th_output *output)
+static void intel_th_gth_stop(struct gth_device *gth,
+			      struct intel_th_output *output,
+			      bool capture_done)
 {
-	struct gth_device *gth = dev_get_drvdata(&thdev->dev);
 	struct intel_th_device *outdev =
 		container_of(output, struct intel_th_device, output);
 	struct intel_th_driver *outdrv =
 		to_intel_th_driver(outdev->dev.driver);
 	unsigned long count;
-	int master;
 	u32 reg;
-
-	spin_lock(&gth->gth_lock);
-	output->active = false;
-
-	for_each_set_bit(master, gth->output[output->port].master,
-			 TH_CONFIGURABLE_MASTERS) {
-		gth_master_set(gth, master, -1);
-	}
-	spin_unlock(&gth->gth_lock);
+	u32 scr2 = 0xfc | (capture_done ? 1 : 0);
 
 	iowrite32(0, gth->base + REG_GTH_SCR);
-	iowrite32(0xfd, gth->base + REG_GTH_SCR2);
+	iowrite32(scr2, gth->base + REG_GTH_SCR2);
 
 	/* wait on pipeline empty for the given port */
 	for (reg = 0, count = GTH_PLE_WAITLOOP_DEPTH;
@@ -496,15 +487,63 @@ static void intel_th_gth_disable(struct intel_th_device *thdev,
 		cpu_relax();
 	}
 
+	if (!count)
+		dev_dbg(gth->dev, "timeout waiting for GTH[%d] PLE\n",
+			output->port);
+
+	/* wait on output piepline empty */
 	if (outdrv->wait_empty)
 		outdrv->wait_empty(outdev);
 
 	/* clear force capture done for next captures */
 	iowrite32(0xfc, gth->base + REG_GTH_SCR2);
+}
 
-	if (!count)
-		dev_dbg(&thdev->dev, "timeout waiting for GTH[%d] PLE\n",
-			output->port);
+/**
+ * intel_th_gth_start() - start tracing to an output device
+ * @gth:	GTH device
+ * @output:	output device's descriptor
+ *
+ * This will start tracing using force storeEn signal.
+ */
+static void intel_th_gth_start(struct gth_device *gth,
+			       struct intel_th_output *output)
+{
+	u32 scr = 0xfc0000;
+
+	if (output->multiblock)
+		scr |= 0xff;
+
+	iowrite32(scr, gth->base + REG_GTH_SCR);
+	iowrite32(0, gth->base + REG_GTH_SCR2);
+}
+
+/**
+ * intel_th_gth_disable() - disable tracing to an output device
+ * @thdev:	GTH device
+ * @output:	output device's descriptor
+ *
+ * This will deconfigure all masters set to output to this device,
+ * disable tracing using force storeEn off signal and wait for the
+ * "pipeline empty" bit for corresponding output port.
+ */
+static void intel_th_gth_disable(struct intel_th_device *thdev,
+				 struct intel_th_output *output)
+{
+	struct gth_device *gth = dev_get_drvdata(&thdev->dev);
+	int master;
+	u32 reg;
+
+	spin_lock(&gth->gth_lock);
+	output->active = false;
+
+	for_each_set_bit(master, gth->output[output->port].master,
+			 TH_CONFIGURABLE_MASTERS) {
+		gth_master_set(gth, master, -1);
+	}
+	spin_unlock(&gth->gth_lock);
+
+	intel_th_gth_stop(gth, output, true);
 
 	reg = ioread32(gth->base + REG_GTH_SCRPD0);
 	reg &= ~output->scratchpad;
@@ -533,8 +572,8 @@ static void intel_th_gth_enable(struct intel_th_device *thdev,
 {
 	struct gth_device *gth = dev_get_drvdata(&thdev->dev);
 	struct intel_th *th = to_intel_th(thdev);
-	u32 scr = 0xfc0000, scrpd;
 	int master;
+	u32 scrpd;
 
 	spin_lock(&gth->gth_lock);
 	for_each_set_bit(master, gth->output[output->port].master,
@@ -542,9 +581,6 @@ static void intel_th_gth_enable(struct intel_th_device *thdev,
 		gth_master_set(gth, master, output->port);
 	}
 
-	if (output->multiblock)
-		scr |= 0xff;
-
 	output->active = true;
 	spin_unlock(&gth->gth_lock);
 
@@ -555,8 +591,7 @@ static void intel_th_gth_enable(struct intel_th_device *thdev,
 	scrpd |= output->scratchpad;
 	iowrite32(scrpd, gth->base + REG_GTH_SCRPD0);
 
-	iowrite32(scr, gth->base + REG_GTH_SCR);
-	iowrite32(0, gth->base + REG_GTH_SCR2);
+	intel_th_gth_start(gth, output);
 }
 
 /**
-- 
2.20.1

