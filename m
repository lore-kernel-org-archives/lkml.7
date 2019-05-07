Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F25C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF6220B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfEGK4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:56:16 -0400
Received: from foss.arm.com ([217.140.101.70]:50130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfEGKxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:53:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73D14EBD;
        Tue,  7 May 2019 03:53:52 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40E933F5AF;
        Tue,  7 May 2019 03:53:51 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 08/30] coresight: etb10: Clean up device specific data
Date:   Tue,  7 May 2019 11:52:35 +0100
Message-Id: <1557226378-10131-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track the coresight device instead of the real device.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 4ee4c80..3b333fb 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -66,7 +66,6 @@
 /**
  * struct etb_drvdata - specifics associated to an ETB component
  * @base:	memory mapped base address for this component.
- * @dev:	the device entity associated to this component.
  * @atclk:	optional clock for the core parts of the ETB.
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.etb" entry.
@@ -81,7 +80,6 @@
  */
 struct etb_drvdata {
 	void __iomem		*base;
-	struct device		*dev;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
@@ -227,7 +225,6 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 {
 	int ret;
-	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	switch (mode) {
 	case CS_MODE_SYSFS:
@@ -244,13 +241,14 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 	if (ret)
 		return ret;
 
-	dev_dbg(drvdata->dev, "ETB enabled\n");
+	dev_dbg(&csdev->dev, "ETB enabled\n");
 	return 0;
 }
 
 static void __etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
+	struct device *dev = &drvdata->csdev->dev;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -263,7 +261,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 	writel_relaxed(ffcr, drvdata->base + ETB_FFCR);
 
 	if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
-		dev_err(drvdata->dev,
+		dev_err(dev,
 		"timeout while waiting for completion of Manual Flush\n");
 	}
 
@@ -271,7 +269,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 	writel_relaxed(0x0, drvdata->base + ETB_CTL_REG);
 
 	if (coresight_timeout(drvdata->base, ETB_FFSR, ETB_FFSR_BIT, 1)) {
-		dev_err(drvdata->dev,
+		dev_err(dev,
 			"timeout while waiting for Formatter to Stop\n");
 	}
 
@@ -286,6 +284,7 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	u32 read_data, depth;
 	u32 read_ptr, write_ptr;
 	u32 frame_off, frame_endoff;
+	struct device *dev = &drvdata->csdev->dev;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -295,10 +294,10 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	frame_off = write_ptr % ETB_FRAME_SIZE_WORDS;
 	frame_endoff = ETB_FRAME_SIZE_WORDS - frame_off;
 	if (frame_off) {
-		dev_err(drvdata->dev,
+		dev_err(dev,
 			"write_ptr: %lu not aligned to formatter frame size\n",
 			(unsigned long)write_ptr);
-		dev_err(drvdata->dev, "frameoff: %lu, frame_endoff: %lu\n",
+		dev_err(dev, "frameoff: %lu, frame_endoff: %lu\n",
 			(unsigned long)frame_off, (unsigned long)frame_endoff);
 		write_ptr += frame_endoff;
 	}
@@ -365,7 +364,7 @@ static int etb_disable(struct coresight_device *csdev)
 	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "ETB disabled\n");
+	dev_dbg(&csdev->dev, "ETB disabled\n");
 	return 0;
 }
 
@@ -460,7 +459,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	 * chance to fix things.
 	 */
 	if (write_ptr % ETB_FRAME_SIZE_WORDS) {
-		dev_err(drvdata->dev,
+		dev_err(&csdev->dev,
 			"write_ptr: %lu not aligned to formatter frame size\n",
 			(unsigned long)write_ptr);
 
@@ -587,7 +586,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "ETB dumped\n");
+	dev_dbg(&drvdata->csdev->dev, "ETB dumped\n");
 }
 
 static int etb_open(struct inode *inode, struct file *file)
@@ -598,7 +597,7 @@ static int etb_open(struct inode *inode, struct file *file)
 	if (local_cmpxchg(&drvdata->reading, 0, 1))
 		return -EBUSY;
 
-	dev_dbg(drvdata->dev, "%s: successfully opened\n", __func__);
+	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
 	return 0;
 }
 
@@ -608,6 +607,7 @@ static ssize_t etb_read(struct file *file, char __user *data,
 	u32 depth;
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
+	struct device *dev = &drvdata->csdev->dev;
 
 	etb_dump(drvdata);
 
@@ -616,13 +616,14 @@ static ssize_t etb_read(struct file *file, char __user *data,
 		len = depth * 4 - *ppos;
 
 	if (copy_to_user(data, drvdata->buf + *ppos, len)) {
-		dev_dbg(drvdata->dev, "%s: copy_to_user failed\n", __func__);
+		dev_dbg(dev,
+			"%s: copy_to_user failed\n", __func__);
 		return -EFAULT;
 	}
 
 	*ppos += len;
 
-	dev_dbg(drvdata->dev, "%s: %zu bytes copied, %d bytes left\n",
+	dev_dbg(dev, "%s: %zu bytes copied, %d bytes left\n",
 		__func__, len, (int)(depth * 4 - *ppos));
 	return len;
 }
@@ -633,7 +634,7 @@ static int etb_release(struct inode *inode, struct file *file)
 						   struct etb_drvdata, miscdev);
 	local_set(&drvdata->reading, 0);
 
-	dev_dbg(drvdata->dev, "%s: released\n", __func__);
+	dev_dbg(&drvdata->csdev->dev, "%s: released\n", __func__);
 	return 0;
 }
 
@@ -737,7 +738,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
-- 
2.7.4

