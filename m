Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4858DC004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221862081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfECIpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:5540 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfECIpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811585"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 13/22] intel_th: msu: Factor out pipeline draining
Date:   Fri,  3 May 2019 11:44:46 +0300
Message-Id: <20190503084455.23436-14-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that waits for the pipeline empty condition of the MSU is
currently called in the path that disables the trace. We will also
need this in the window switch trigger sequence. Therefore, factor
out this code and make it accessible to the GTH device.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/gth.c      |  7 +++++++
 drivers/hwtracing/intel_th/intel_th.h |  4 ++++
 drivers/hwtracing/intel_th/msu.c      | 28 +++++++++++++++++----------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index edc52d75e6bd..7e6b70047125 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -469,6 +469,10 @@ static void intel_th_gth_disable(struct intel_th_device *thdev,
 				 struct intel_th_output *output)
 {
 	struct gth_device *gth = dev_get_drvdata(&thdev->dev);
+	struct intel_th_device *outdev =
+		container_of(output, struct intel_th_device, output);
+	struct intel_th_driver *outdrv =
+		to_intel_th_driver(outdev->dev.driver);
 	unsigned long count;
 	int master;
 	u32 reg;
@@ -492,6 +496,9 @@ static void intel_th_gth_disable(struct intel_th_device *thdev,
 		cpu_relax();
 	}
 
+	if (outdrv->wait_empty)
+		outdrv->wait_empty(outdev);
+
 	/* clear force capture done for next captures */
 	iowrite32(0xfc, gth->base + REG_GTH_SCR2);
 
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 8b986ba160e4..74a6a4071e7f 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -20,6 +20,8 @@ enum {
 	INTEL_TH_SWITCH,
 };
 
+struct intel_th_device;
+
 /**
  * struct intel_th_output - descriptor INTEL_TH_OUTPUT type devices
  * @port:	output port number, assigned by the switch
@@ -27,6 +29,7 @@ enum {
  * @scratchpad:	scratchpad bits to flag when this output is enabled
  * @multiblock:	true for multiblock output configuration
  * @active:	true when this output is enabled
+ * @wait_empty:	wait for device pipeline to be empty
  *
  * Output port descriptor, used by switch driver to tell which output
  * port this output device corresponds to. Filled in at output device's
@@ -165,6 +168,7 @@ struct intel_th_driver {
 					   struct intel_th_output *output);
 	/* output ops */
 	irqreturn_t		(*irq)(struct intel_th_device *thdev);
+	void			(*wait_empty)(struct intel_th_device *thdev);
 	int			(*activate)(struct intel_th_device *thdev);
 	void			(*deactivate)(struct intel_th_device *thdev);
 	/* file_operations for those who want a device node */
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index a4f7a5b21d48..01408a0e2458 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -585,23 +585,14 @@ static int msc_configure(struct msc *msc)
  */
 static void msc_disable(struct msc *msc)
 {
-	unsigned long count;
 	u32 reg;
 
 	lockdep_assert_held(&msc->buf_mutex);
 
 	intel_th_trace_disable(msc->thdev);
 
-	for (reg = 0, count = MSC_PLE_WAITLOOP_DEPTH;
-	     count && !(reg & MSCSTS_PLE); count--) {
-		reg = ioread32(msc->reg_base + REG_MSU_MSC0STS);
-		cpu_relax();
-	}
-
-	if (!count)
-		dev_dbg(msc_dev(msc), "timeout waiting for MSC0 PLE\n");
-
 	if (msc->mode == MSC_MODE_SINGLE) {
+		reg = ioread32(msc->reg_base + REG_MSU_MSC0STS);
 		msc->single_wrap = !!(reg & MSCSTS_WRAPSTAT);
 
 		reg = ioread32(msc->reg_base + REG_MSU_MSC0MWP);
@@ -1380,6 +1371,22 @@ static const struct file_operations intel_th_msc_fops = {
 	.owner		= THIS_MODULE,
 };
 
+static void intel_th_msc_wait_empty(struct intel_th_device *thdev)
+{
+	struct msc *msc = dev_get_drvdata(&thdev->dev);
+	unsigned long count;
+	u32 reg;
+
+	for (reg = 0, count = MSC_PLE_WAITLOOP_DEPTH;
+	     count && !(reg & MSCSTS_PLE); count--) {
+		reg = __raw_readl(msc->reg_base + REG_MSU_MSC0STS);
+		cpu_relax();
+	}
+
+	if (!count)
+		dev_dbg(msc_dev(msc), "timeout waiting for MSC0 PLE\n");
+}
+
 static int intel_th_msc_init(struct msc *msc)
 {
 	atomic_set(&msc->user_count, -1);
@@ -1660,6 +1667,7 @@ static struct intel_th_driver intel_th_msc_driver = {
 	.probe	= intel_th_msc_probe,
 	.remove	= intel_th_msc_remove,
 	.irq		= intel_th_msc_interrupt,
+	.wait_empty	= intel_th_msc_wait_empty,
 	.activate	= intel_th_msc_activate,
 	.deactivate	= intel_th_msc_deactivate,
 	.fops	= &intel_th_msc_fops,
-- 
2.20.1

