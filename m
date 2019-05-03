Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB4C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35D52087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfECIqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:46:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:5536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfECIpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811556"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:31 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 08/22] intel_th: msu: Start handling IRQs
Date:   Fri,  3 May 2019 11:44:41 +0300
Message-Id: <20190503084455.23436-9-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We intend to use the interrupt to detect Last Block condition in the MSU
driver, which we can use for double-buffering software-managed data
transfers.

Add an interrupt handler to the MSU driver.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c     | 32 ++++++++++++++
 drivers/hwtracing/intel_th/intel_th.h |  4 +-
 drivers/hwtracing/intel_th/msu.c      | 64 ++++++++++++++++++++++++++-
 drivers/hwtracing/intel_th/msu.h      |  8 ++++
 4 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 0205fca4c606..750aa9d6f849 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -826,6 +826,28 @@ static const struct file_operations intel_th_output_fops = {
 	.llseek	= noop_llseek,
 };
 
+static irqreturn_t intel_th_irq(int irq, void *data)
+{
+	struct intel_th *th = data;
+	irqreturn_t ret = IRQ_NONE;
+	struct intel_th_driver *d;
+	int i;
+
+	for (i = 0; i < th->num_thdevs; i++) {
+		if (th->thdev[i]->type != INTEL_TH_OUTPUT)
+			continue;
+
+		d = to_intel_th_driver(th->thdev[i]->dev.driver);
+		if (d && d->irq)
+			ret |= d->irq(th->thdev[i]);
+	}
+
+	if (ret == IRQ_NONE)
+		pr_warn_ratelimited("nobody cared for irq\n");
+
+	return ret;
+}
+
 /**
  * intel_th_alloc() - allocate a new Intel TH device and its subdevices
  * @dev:	parent device
@@ -865,6 +887,12 @@ intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
 			th->resource[nr_mmios++] = devres[r];
 			break;
 		case IORESOURCE_IRQ:
+			err = devm_request_irq(dev, devres[r].start,
+					       intel_th_irq, IRQF_SHARED,
+					       dev_name(dev), th);
+			if (err)
+				goto err_chrdev;
+
 			if (th->irq == -1)
 				th->irq = devres[r].start;
 			break;
@@ -891,6 +919,10 @@ intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
 
 	return th;
 
+err_chrdev:
+	__unregister_chrdev(th->major, 0, TH_POSSIBLE_OUTPUTS,
+			    "intel_th/output");
+
 err_ida:
 	ida_simple_remove(&intel_th_ida, th->id);
 
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index db3ad8ca1c48..59038215489a 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -8,6 +8,8 @@
 #ifndef __INTEL_TH_H__
 #define __INTEL_TH_H__
 
+#include <linux/irqreturn.h>
+
 /* intel_th_device device types */
 enum {
 	/* Devices that generate trace data */
@@ -160,7 +162,7 @@ struct intel_th_driver {
 	void			(*disable)(struct intel_th_device *thdev,
 					   struct intel_th_output *output);
 	/* output ops */
-	void			(*irq)(struct intel_th_device *thdev);
+	irqreturn_t		(*irq)(struct intel_th_device *thdev);
 	int			(*activate)(struct intel_th_device *thdev);
 	void			(*deactivate)(struct intel_th_device *thdev);
 	/* file_operations for those who want a device node */
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 8ff326c0c406..3716d312a4ee 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -102,6 +102,7 @@ struct msc_iter {
  */
 struct msc {
 	void __iomem		*reg_base;
+	void __iomem		*msu_base;
 	struct intel_th_device	*thdev;
 
 	struct list_head	win_list;
@@ -122,7 +123,8 @@ struct msc {
 
 	/* config */
 	unsigned int		enabled : 1,
-				wrap	: 1;
+				wrap	: 1,
+				do_irq	: 1;
 	unsigned int		mode;
 	unsigned int		burst_len;
 	unsigned int		index;
@@ -476,6 +478,40 @@ static void msc_buffer_clear_hw_header(struct msc *msc)
 	}
 }
 
+static int intel_th_msu_init(struct msc *msc)
+{
+	u32 mintctl, msusts;
+
+	if (!msc->do_irq)
+		return 0;
+
+	mintctl = ioread32(msc->msu_base + REG_MSU_MINTCTL);
+	mintctl |= msc->index ? M1BLIE : M0BLIE;
+	iowrite32(mintctl, msc->msu_base + REG_MSU_MINTCTL);
+	if (mintctl != ioread32(msc->msu_base + REG_MSU_MINTCTL)) {
+		dev_info(msc_dev(msc), "MINTCTL ignores writes: no usable interrupts\n");
+		msc->do_irq = 0;
+		return 0;
+	}
+
+	msusts = ioread32(msc->msu_base + REG_MSU_MSUSTS);
+	iowrite32(msusts, msc->msu_base + REG_MSU_MSUSTS);
+
+	return 0;
+}
+
+static void intel_th_msu_deinit(struct msc *msc)
+{
+	u32 mintctl;
+
+	if (!msc->do_irq)
+		return;
+
+	mintctl = ioread32(msc->msu_base + REG_MSU_MINTCTL);
+	mintctl &= msc->index ? ~M1BLIE : ~M0BLIE;
+	iowrite32(mintctl, msc->msu_base + REG_MSU_MINTCTL);
+}
+
 /**
  * msc_configure() - set up MSC hardware
  * @msc:	the MSC device to configure
@@ -1295,6 +1331,21 @@ static int intel_th_msc_init(struct msc *msc)
 	return 0;
 }
 
+static irqreturn_t intel_th_msc_interrupt(struct intel_th_device *thdev)
+{
+	struct msc *msc = dev_get_drvdata(&thdev->dev);
+	u32 msusts = ioread32(msc->msu_base + REG_MSU_MSUSTS);
+	u32 mask = msc->index ? MSUSTS_MSC1BLAST : MSUSTS_MSC0BLAST;
+
+	if (!(msusts & mask)) {
+		if (msc->enabled)
+			return IRQ_HANDLED;
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static const char * const msc_mode[] = {
 	[MSC_MODE_SINGLE]	= "single",
 	[MSC_MODE_MULTI]	= "multi",
@@ -1500,10 +1551,19 @@ static int intel_th_msc_probe(struct intel_th_device *thdev)
 	if (!msc)
 		return -ENOMEM;
 
+	res = intel_th_device_get_resource(thdev, IORESOURCE_IRQ, 1);
+	if (!res)
+		msc->do_irq = 1;
+
 	msc->index = thdev->id;
 
 	msc->thdev = thdev;
 	msc->reg_base = base + msc->index * 0x100;
+	msc->msu_base = base;
+
+	err = intel_th_msu_init(msc);
+	if (err)
+		return err;
 
 	err = intel_th_msc_init(msc);
 	if (err)
@@ -1520,6 +1580,7 @@ static void intel_th_msc_remove(struct intel_th_device *thdev)
 	int ret;
 
 	intel_th_msc_deactivate(thdev);
+	intel_th_msu_deinit(msc);
 
 	/*
 	 * Buffers should not be used at this point except if the
@@ -1533,6 +1594,7 @@ static void intel_th_msc_remove(struct intel_th_device *thdev)
 static struct intel_th_driver intel_th_msc_driver = {
 	.probe	= intel_th_msc_probe,
 	.remove	= intel_th_msc_remove,
+	.irq		= intel_th_msc_interrupt,
 	.activate	= intel_th_msc_activate,
 	.deactivate	= intel_th_msc_deactivate,
 	.fops	= &intel_th_msc_fops,
diff --git a/drivers/hwtracing/intel_th/msu.h b/drivers/hwtracing/intel_th/msu.h
index 9cc8aced6116..e8cb819a3804 100644
--- a/drivers/hwtracing/intel_th/msu.h
+++ b/drivers/hwtracing/intel_th/msu.h
@@ -11,6 +11,7 @@
 enum {
 	REG_MSU_MSUPARAMS	= 0x0000,
 	REG_MSU_MSUSTS		= 0x0008,
+	REG_MSU_MINTCTL		= 0x0004, /* MSU-global interrupt control */
 	REG_MSU_MSC0CTL		= 0x0100, /* MSC0 control */
 	REG_MSU_MSC0STS		= 0x0104, /* MSC0 status */
 	REG_MSU_MSC0BAR		= 0x0108, /* MSC0 output base address */
@@ -28,6 +29,8 @@ enum {
 
 /* MSUSTS bits */
 #define MSUSTS_MSU_INT	BIT(0)
+#define MSUSTS_MSC0BLAST	BIT(16)
+#define MSUSTS_MSC1BLAST	BIT(24)
 
 /* MSCnCTL bits */
 #define MSC_EN		BIT(0)
@@ -36,6 +39,11 @@ enum {
 #define MSC_MODE	(BIT(4) | BIT(5))
 #define MSC_LEN		(BIT(8) | BIT(9) | BIT(10))
 
+/* MINTCTL bits */
+#define MICDE		BIT(0)
+#define M0BLIE		BIT(16)
+#define M1BLIE		BIT(24)
+
 /* MSC operating modes (MSC_MODE) */
 enum {
 	MSC_MODE_SINGLE	= 0,
-- 
2.20.1

