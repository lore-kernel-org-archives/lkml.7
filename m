Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F25C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FDF2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfECIqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:46:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:5541 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfECIpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811592"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:42 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 15/22] intel_th: Add switch triggering support
Date:   Fri,  3 May 2019 11:44:48 +0300
Message-Id: <20190503084455.23436-16-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for asserting window switch trigger when tracing to MSU output
ports. This allows for software controlled switching between windows of
the MSU buffer, which can be used for double buffering while exporting the
trace data further from the MSU.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c     | 25 ++++++++++++++++--
 drivers/hwtracing/intel_th/gth.c      | 37 +++++++++++++++++++++++++++
 drivers/hwtracing/intel_th/gth.h      | 19 ++++++++++++++
 drivers/hwtracing/intel_th/intel_th.h |  6 +++++
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 390031df3edf..033dce563c99 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -430,9 +430,9 @@ static const struct intel_th_subdevice {
 		.nres	= 1,
 		.res	= {
 			{
-				/* Handle TSCU from GTH driver */
+				/* Handle TSCU and CTS from GTH driver */
 				.start	= REG_GTH_OFFSET,
-				.end	= REG_TSCU_OFFSET + REG_TSCU_LENGTH - 1,
+				.end	= REG_CTS_OFFSET + REG_CTS_LENGTH - 1,
 				.flags	= IORESOURCE_MEM,
 			},
 		},
@@ -987,6 +987,27 @@ int intel_th_trace_enable(struct intel_th_device *thdev)
 }
 EXPORT_SYMBOL_GPL(intel_th_trace_enable);
 
+/**
+ * intel_th_trace_switch() - execute a switch sequence
+ * @thdev:	output device that requests tracing switch
+ */
+int intel_th_trace_switch(struct intel_th_device *thdev)
+{
+	struct intel_th_device *hub = to_intel_th_device(thdev->dev.parent);
+	struct intel_th_driver *hubdrv = to_intel_th_driver(hub->dev.driver);
+
+	if (WARN_ON_ONCE(hub->type != INTEL_TH_SWITCH))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(thdev->type != INTEL_TH_OUTPUT))
+		return -EINVAL;
+
+	hubdrv->trig_switch(hub, &thdev->output);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_th_trace_switch);
+
 /**
  * intel_th_trace_disable() - disable tracing for an output device
  * @thdev:	output device that requests tracing be disabled
diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index a879445ef451..fa9d34af87ac 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -308,6 +308,11 @@ static int intel_th_gth_reset(struct gth_device *gth)
 	iowrite32(0, gth->base + REG_GTH_SCR);
 	iowrite32(0xfc, gth->base + REG_GTH_SCR2);
 
+	/* setup CTS for single trigger */
+	iowrite32(CTS_EVENT_ENABLE_IF_ANYTHING, gth->base + REG_CTS_C0S0_EN);
+	iowrite32(CTS_ACTION_CONTROL_SET_STATE(CTS_STATE_IDLE) |
+		  CTS_ACTION_CONTROL_TRIGGER, gth->base + REG_CTS_C0S0_ACT);
+
 	return 0;
 }
 
@@ -594,6 +599,37 @@ static void intel_th_gth_enable(struct intel_th_device *thdev,
 	intel_th_gth_start(gth, output);
 }
 
+/**
+ * intel_th_gth_switch() - execute a switch sequence
+ * @thdev:	GTH device
+ * @output:	output device's descriptor
+ *
+ * This will execute a switch sequence that will trigger a switch window
+ * when tracing to MSC in multi-block mode.
+ */
+static void intel_th_gth_switch(struct intel_th_device *thdev,
+				struct intel_th_output *output)
+{
+	struct gth_device *gth = dev_get_drvdata(&thdev->dev);
+	unsigned long count;
+	u32 reg;
+
+	/* trigger */
+	iowrite32(0, gth->base + REG_CTS_CTL);
+	iowrite32(CTS_CTL_SEQUENCER_ENABLE, gth->base + REG_CTS_CTL);
+	/* wait on trigger status */
+	for (reg = 0, count = CTS_TRIG_WAITLOOP_DEPTH;
+	     count && !(reg & BIT(4)); count--) {
+		reg = ioread32(gth->base + REG_CTS_STAT);
+		cpu_relax();
+	}
+	if (!count)
+		dev_dbg(&thdev->dev, "timeout waiting for CTS Trigger\n");
+
+	intel_th_gth_stop(gth, output, false);
+	intel_th_gth_start(gth, output);
+}
+
 /**
  * intel_th_gth_assign() - assign output device to a GTH output port
  * @thdev:	GTH device
@@ -777,6 +813,7 @@ static struct intel_th_driver intel_th_gth_driver = {
 	.unassign	= intel_th_gth_unassign,
 	.set_output	= intel_th_gth_set_output,
 	.enable		= intel_th_gth_enable,
+	.trig_switch	= intel_th_gth_switch,
 	.disable	= intel_th_gth_disable,
 	.driver	= {
 		.name	= "gth",
diff --git a/drivers/hwtracing/intel_th/gth.h b/drivers/hwtracing/intel_th/gth.h
index 6f2b0b930875..bfcc0fd01177 100644
--- a/drivers/hwtracing/intel_th/gth.h
+++ b/drivers/hwtracing/intel_th/gth.h
@@ -49,6 +49,12 @@ enum {
 	REG_GTH_SCRPD3		= 0xec, /* ScratchPad[3] */
 	REG_TSCU_TSUCTRL	= 0x2000, /* TSCU control register */
 	REG_TSCU_TSCUSTAT	= 0x2004, /* TSCU status register */
+
+	/* Common Capture Sequencer (CTS) registers */
+	REG_CTS_C0S0_EN		= 0x30c0, /* clause_event_enable_c0s0 */
+	REG_CTS_C0S0_ACT	= 0x3180, /* clause_action_control_c0s0 */
+	REG_CTS_STAT		= 0x32a0, /* cts_status */
+	REG_CTS_CTL		= 0x32a4, /* cts_control */
 };
 
 /* waiting for Pipeline Empty bit(s) to assert for GTH */
@@ -57,4 +63,17 @@ enum {
 #define TSUCTRL_CTCRESYNC	BIT(0)
 #define TSCUSTAT_CTCSYNCING	BIT(1)
 
+/* waiting for Trigger status to assert for CTS */
+#define CTS_TRIG_WAITLOOP_DEPTH	10000
+
+#define CTS_EVENT_ENABLE_IF_ANYTHING	BIT(31)
+#define CTS_ACTION_CONTROL_STATE_OFF	27
+#define CTS_ACTION_CONTROL_SET_STATE(x)	\
+	(((x) & 0x1f) << CTS_ACTION_CONTROL_STATE_OFF)
+#define CTS_ACTION_CONTROL_TRIGGER	BIT(4)
+
+#define CTS_STATE_IDLE			0x10u
+
+#define CTS_CTL_SEQUENCER_ENABLE	BIT(0)
+
 #endif /* __INTEL_TH_GTH_H__ */
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 74a6a4071e7f..0df480072b6c 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -164,6 +164,8 @@ struct intel_th_driver {
 					    struct intel_th_device *othdev);
 	void			(*enable)(struct intel_th_device *thdev,
 					  struct intel_th_output *output);
+	void			(*trig_switch)(struct intel_th_device *thdev,
+					       struct intel_th_output *output);
 	void			(*disable)(struct intel_th_device *thdev,
 					   struct intel_th_output *output);
 	/* output ops */
@@ -228,6 +230,7 @@ int intel_th_driver_register(struct intel_th_driver *thdrv);
 void intel_th_driver_unregister(struct intel_th_driver *thdrv);
 
 int intel_th_trace_enable(struct intel_th_device *thdev);
+int intel_th_trace_switch(struct intel_th_device *thdev);
 int intel_th_trace_disable(struct intel_th_device *thdev);
 int intel_th_set_output(struct intel_th_device *thdev,
 			unsigned int master);
@@ -308,6 +311,9 @@ enum {
 	REG_TSCU_OFFSET		= 0x2000,
 	REG_TSCU_LENGTH		= 0x1000,
 
+	REG_CTS_OFFSET		= 0x3000,
+	REG_CTS_LENGTH		= 0x1000,
+
 	/* Software Trace Hub (STH) [0x4000..0x4fff] */
 	REG_STH_OFFSET		= 0x4000,
 	REG_STH_LENGTH		= 0x2000,
-- 
2.20.1

