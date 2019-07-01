Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604AAC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3641F2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGATyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:54:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727028AbfGATyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:54:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61JbAXJ081492
        for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2019 15:54:11 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfq503wh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 15:54:11 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 1 Jul 2019 20:54:10 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 20:54:07 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61Js6vL26542356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 19:54:06 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E973C6E053;
        Mon,  1 Jul 2019 19:54:05 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AAA56E04E;
        Mon,  1 Jul 2019 19:54:05 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 19:54:05 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, joel@jms.id.au,
        eduval@amazon.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v4 5/8] drivers/soc: xdma: Add PCI device configuration sysfs
Date:   Mon,  1 Jul 2019 14:53:56 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
References: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19070119-0016-0000-0000-000009C96867
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011361; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226037; UDB=6.00645423; IPR=6.01007250;
 MB=3.00027541; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-01 19:54:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070119-0017-0000-0000-000043DBA227
Message-Id: <1562010839-1113-6-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AST2500 has two PCI devices embedded. The XDMA engine can use either
device to perform DMA transfers. Users need the capability to choose
which device to use. This commit therefore adds a sysfs file that can
toggle the AST2500 and XDMA engine between the two PCI devices.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/soc/aspeed/aspeed-xdma.c | 103 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 622e3d9..72b4c4b 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -170,6 +170,7 @@ struct aspeed_xdma {
 	void *cmdq_vga_virt;
 	struct gen_pool *vga_pool;
 
+	char pcidev[4];
 	struct miscdevice misc;
 };
 
@@ -192,6 +193,10 @@ struct aspeed_xdma_client {
 	SCU_PCIE_CONF_VGA_EN_IRQ | SCU_PCIE_CONF_VGA_EN_DMA |
 	SCU_PCIE_CONF_RSVD;
 
+static char *_pcidev = "bmc";
+module_param_named(pcidev, _pcidev, charp, 0600);
+MODULE_PARM_DESC(pcidev, "Default PCI device used by XDMA engine for DMA ops");
+
 static void aspeed_scu_pcie_write(struct aspeed_xdma *ctx, u32 conf)
 {
 	u32 v = 0;
@@ -540,7 +545,7 @@ static int aspeed_xdma_release(struct inode *inode, struct file *file)
 	.release		= aspeed_xdma_release,
 };
 
-static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
+static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx, u32 conf)
 {
 	int rc;
 	u32 scu_conf = 0;
@@ -550,7 +555,7 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 	const u32 vga_sizes[4] = { 0x800000, 0x1000000, 0x2000000, 0x4000000 };
 	void __iomem *sdmc_base = ioremap(0x1e6e0000, 0x100);
 
-	aspeed_scu_pcie_write(ctx, aspeed_xdma_bmc_pcie_conf);
+	aspeed_scu_pcie_write(ctx, conf);
 
 	regmap_write(ctx->scu, SCU_BMC_CLASS_REV, SCU_BMC_CLASS_REV_XDMA);
 
@@ -609,10 +614,91 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 	return 0;
 }
 
+static int aspeed_xdma_change_pcie_conf(struct aspeed_xdma *ctx, u32 conf)
+{
+	int rc;
+
+	mutex_lock(&ctx->start_lock);
+	rc = wait_event_interruptible_timeout(ctx->wait,
+					      !test_bit(XDMA_IN_PRG,
+							&ctx->flags),
+					      msecs_to_jiffies(1000));
+	if (rc < 0) {
+		mutex_unlock(&ctx->start_lock);
+		return -EINTR;
+	}
+
+	/* Previous operation didn't complete; wake up waiters anyway. */
+	if (!rc)
+		wake_up_interruptible_all(&ctx->wait);
+
+	reset_control_assert(ctx->reset);
+	msleep(XDMA_RESET_TIME_MS);
+
+	aspeed_scu_pcie_write(ctx, conf);
+	msleep(XDMA_RESET_TIME_MS);
+
+	reset_control_deassert(ctx->reset);
+	msleep(XDMA_RESET_TIME_MS);
+
+	aspeed_xdma_init_eng(ctx);
+
+	mutex_unlock(&ctx->start_lock);
+
+	return 0;
+}
+
+static int aspeed_xdma_pcidev_to_conf(struct aspeed_xdma *ctx,
+				      const char *pcidev, u32 *conf)
+{
+	if (!strncasecmp(pcidev, "vga", 3)) {
+		*conf = aspeed_xdma_vga_pcie_conf;
+		return 0;
+	}
+
+	if (!strncasecmp(pcidev, "bmc", 3)) {
+		*conf = aspeed_xdma_bmc_pcie_conf;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t aspeed_xdma_show_pcidev(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%s\n", ctx->pcidev);
+}
+
+static ssize_t aspeed_xdma_store_pcidev(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	u32 conf;
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+	int rc = aspeed_xdma_pcidev_to_conf(ctx, buf, &conf);
+
+	if (rc)
+		return rc;
+
+	rc = aspeed_xdma_change_pcie_conf(ctx, conf);
+	if (rc)
+		return rc;
+
+	strncpy(ctx->pcidev, buf, 3);
+	return count;
+}
+static DEVICE_ATTR(pcidev, 0644, aspeed_xdma_show_pcidev,
+		   aspeed_xdma_store_pcidev);
+
 static int aspeed_xdma_probe(struct platform_device *pdev)
 {
 	int irq;
 	int rc;
+	u32 conf;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct aspeed_xdma *ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -668,7 +754,14 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	msleep(XDMA_RESET_TIME_MS);
 
-	rc = aspeed_xdma_init_mem(ctx);
+	if (aspeed_xdma_pcidev_to_conf(ctx, _pcidev, &conf)) {
+		conf = aspeed_xdma_bmc_pcie_conf;
+		strncpy(ctx->pcidev, "bmc", 3);
+	} else {
+		strncpy(ctx->pcidev, _pcidev, 3);
+	}
+
+	rc = aspeed_xdma_init_mem(ctx, conf);
 	if (rc) {
 		reset_control_assert(ctx->reset);
 		return rc;
@@ -691,6 +784,8 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	device_create_file(dev, &dev_attr_pcidev);
+
 	return 0;
 }
 
@@ -698,6 +793,8 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	device_remove_file(ctx->dev, &dev_attr_pcidev);
+
 	misc_deregister(&ctx->misc);
 	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
 		      XDMA_CMDQ_SIZE);
-- 
1.8.3.1

