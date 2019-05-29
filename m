Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D6C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0A24032
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfE2SK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:10:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727556AbfE2SKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:10:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TI4iAv064889
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:10:22 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ssvtbdsb2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:10:22 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 29 May 2019 19:10:20 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 May 2019 19:10:16 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4TIAF3Q29884658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:10:15 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D233112063;
        Wed, 29 May 2019 18:10:15 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90125112064;
        Wed, 29 May 2019 18:10:14 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 May 2019 18:10:14 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, joel@jms.id.au,
        andrew@aj.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 5/8] drivers/soc: xdma: Add PCI device configuration sysfs
Date:   Wed, 29 May 2019 13:10:05 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052918-2213-0000-0000-00000397767E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011180; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210373; UDB=6.00635908; IPR=6.00991405;
 MB=3.00027105; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-29 18:10:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052918-2214-0000-0000-00005EA0676A
Message-Id: <1559153408-31190-6-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AST2500 has two PCI devices embedded. The XDMA engine can use either
device to perform DMA transfers. Users need the capability to choose
which device to use. This commit therefore adds two sysfs files that
toggle the AST2500 and XDMA engine between the two PCI devices.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/soc/aspeed/aspeed-xdma.c | 103 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 39f6545..ddd5e1e 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -143,6 +143,7 @@ struct aspeed_xdma {
 	void *cmdq_vga_virt;
 	struct gen_pool *vga_pool;
 
+	char pcidev[4];
 	struct miscdevice misc;
 };
 
@@ -165,6 +166,10 @@ struct aspeed_xdma_client {
 	SCU_PCIE_CONF_VGA_EN_IRQ | SCU_PCIE_CONF_VGA_EN_DMA |
 	SCU_PCIE_CONF_RSVD;
 
+static char *_pcidev = "vga";
+module_param_named(pcidev, _pcidev, charp, 0600);
+MODULE_PARM_DESC(pcidev, "Default PCI device used by XDMA engine for DMA ops");
+
 static void aspeed_scu_pcie_write(struct aspeed_xdma *ctx, u32 conf)
 {
 	u32 v = 0;
@@ -512,7 +517,7 @@ static int aspeed_xdma_release(struct inode *inode, struct file *file)
 	.release		= aspeed_xdma_release,
 };
 
-static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
+static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx, u32 conf)
 {
 	int rc;
 	u32 scu_conf = 0;
@@ -522,7 +527,7 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 	const u32 vga_sizes[4] = { 0x800000, 0x1000000, 0x2000000, 0x4000000 };
 	void __iomem *sdmc_base = ioremap(0x1e6e0000, 0x100);
 
-	aspeed_scu_pcie_write(ctx, aspeed_xdma_vga_pcie_conf);
+	aspeed_scu_pcie_write(ctx, conf);
 
 	regmap_read(ctx->scu, SCU_STRAP, &scu_conf);
 	ctx->vga_size = vga_sizes[FIELD_GET(SCU_STRAP_VGA_MEM, scu_conf)];
@@ -598,10 +603,91 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 	return rc;
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
+	/* previous op didn't complete, wake up waiters anyway */
+	if (!rc)
+		wake_up_interruptible_all(&ctx->wait);
+
+	reset_control_assert(ctx->reset);
+	msleep(10);
+
+	aspeed_scu_pcie_write(ctx, conf);
+	msleep(10);
+
+	reset_control_deassert(ctx->reset);
+	msleep(10);
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
+	if (!strcasecmp(pcidev, "vga")) {
+		*conf = aspeed_xdma_vga_pcie_conf;
+		return 0;
+	}
+
+	if (!strcasecmp(pcidev, "bmc")) {
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
+	return snprintf(buf, PAGE_SIZE - 1, "%s", ctx->pcidev);
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
+	strcpy(ctx->pcidev, buf);
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
@@ -657,7 +743,14 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	msleep(10);
 
-	rc = aspeed_xdma_init_mem(ctx);
+	if (aspeed_xdma_pcidev_to_conf(ctx, _pcidev, &conf)) {
+		conf = aspeed_xdma_vga_pcie_conf;
+		strcpy(ctx->pcidev, "vga");
+	} else {
+		strcpy(ctx->pcidev, _pcidev);
+	}
+
+	rc = aspeed_xdma_init_mem(ctx, conf);
 	if (rc) {
 		reset_control_assert(ctx->reset);
 		return rc;
@@ -682,6 +775,8 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	device_create_file(dev, &dev_attr_pcidev);
+
 	return 0;
 }
 
@@ -689,6 +784,8 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	device_remove_file(ctx->dev, &dev_attr_pcidev);
+
 	misc_deregister(&ctx->misc);
 	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
 		      XDMA_CMDQ_SIZE);
-- 
1.8.3.1

