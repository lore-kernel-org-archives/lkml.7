Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FFEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315A92177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfETUTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:19:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfETUTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:19:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KK7Mk5099248
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:19:53 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sm0jydpjq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:19:53 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 20 May 2019 21:19:52 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 May 2019 21:19:48 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4KKJlPC18874424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 20:19:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DD1FB2065;
        Mon, 20 May 2019 20:19:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62EBB2064;
        Mon, 20 May 2019 20:19:46 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 20 May 2019 20:19:46 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, joel@jms.id.au,
        andrew@aj.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 5/7] drivers/soc: xdma: Add debugfs entries
Date:   Mon, 20 May 2019 15:19:23 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052020-0040-0000-0000-000004F20B03
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011132; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206180; UDB=6.00633348; IPR=6.00987139;
 MB=3.00026974; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-20 20:19:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052020-0041-0000-0000-000008FE1E00
Message-Id: <1558383565-11821-6-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs entries for the relevant XDMA engine registers and for
dumping the AST2500 reserved memory space.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/soc/aspeed/aspeed-xdma.c | 96 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 002b571..c083173 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -147,6 +147,12 @@ struct aspeed_xdma {
 	struct list_head vga_blks_free;
 
 	struct miscdevice misc;
+	struct dentry *debugfs_dir;
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct debugfs_regset32 regset;
+	struct debugfs_reg32 regs[XDMA_NUM_DEBUGFS_REGS];
+#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
 };
 
 struct aspeed_xdma_client {
@@ -656,6 +662,92 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static ssize_t aspeed_xdma_debugfs_vga_read(struct file *file,
+					    char __user *buf, size_t len,
+					    loff_t *offset)
+{
+	int rc;
+	struct inode *inode = file_inode(file);
+	struct aspeed_xdma *ctx = inode->i_private;
+	void __iomem *vga = ioremap(ctx->vga_phys, ctx->vga_size);
+	loff_t offs = *offset;
+	void *tmp;
+
+	if (!vga)
+		return -ENOMEM;
+
+	if (len + offs > ctx->vga_size) {
+		iounmap(vga);
+		return -EINVAL;
+	}
+
+	tmp = kzalloc(len, GFP_KERNEL);
+	if (!tmp) {
+		iounmap(vga);
+		return -ENOMEM;
+	}
+
+	memcpy_fromio(tmp, vga + offs, len);
+
+	rc = copy_to_user(buf, tmp, len);
+	if (rc) {
+		iounmap(vga);
+		kfree(tmp);
+		return rc;
+	}
+
+	*offset = offs + len;
+
+	kfree(tmp);
+	iounmap(vga);
+
+	return len;
+}
+
+static const struct file_operations aspeed_xdma_debugfs_vga_fops = {
+	.owner	= THIS_MODULE,
+	.llseek	= generic_file_llseek,
+	.read	= aspeed_xdma_debugfs_vga_read,
+};
+
+static void aspeed_xdma_init_debugfs(struct aspeed_xdma *ctx)
+{
+	ctx->debugfs_dir = debugfs_create_dir(DEVICE_NAME, NULL);
+	if (IS_ERR_OR_NULL(ctx->debugfs_dir)) {
+		dev_warn(ctx->dev, "Failed to create debugfs directory.\n");
+		return;
+	}
+
+	debugfs_create_file("vga", 0444, ctx->debugfs_dir, ctx,
+			    &aspeed_xdma_debugfs_vga_fops);
+
+	ctx->regs[0].name = "addr";
+	ctx->regs[0].offset = XDMA_BMC_CMD_QUEUE_ADDR;
+	ctx->regs[1].name = "endp";
+	ctx->regs[1].offset = XDMA_BMC_CMD_QUEUE_ENDP;
+	ctx->regs[2].name = "writep";
+	ctx->regs[2].offset = XDMA_BMC_CMD_QUEUE_WRITEP;
+	ctx->regs[3].name = "readp";
+	ctx->regs[3].offset = XDMA_BMC_CMD_QUEUE_READP;
+	ctx->regs[4].name = "control";
+	ctx->regs[4].offset = XDMA_CTRL;
+	ctx->regs[5].name = "status";
+	ctx->regs[5].offset = XDMA_STATUS;
+
+	ctx->regset.regs = ctx->regs;
+	ctx->regset.nregs = XDMA_NUM_DEBUGFS_REGS;
+	ctx->regset.base = ctx->base;
+
+	debugfs_create_regset32("regs", 0444, ctx->debugfs_dir, &ctx->regset);
+}
+#else
+static void aspeed_xdma_init_debugfs(struct aspeed_xdma *ctx)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
+
 static void aspeed_xdma_free_vga_blks(struct aspeed_xdma *ctx)
 {
 	struct aspeed_xdma_vga_blk *free;
@@ -806,6 +898,8 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 	device_create_file(dev, &dev_attr_use_bmc);
 	device_create_file(dev, &dev_attr_use_vga);
 
+	aspeed_xdma_init_debugfs(ctx);
+
 	return 0;
 }
 
@@ -813,6 +907,8 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(ctx->debugfs_dir);
+
 	device_remove_file(ctx->dev, &dev_attr_use_vga);
 	device_remove_file(ctx->dev, &dev_attr_use_bmc);
 
-- 
1.8.3.1

