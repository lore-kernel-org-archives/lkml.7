Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D992C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 22:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612702089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 22:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eC5o5148"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEAWec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 18:34:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60318 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfEAWeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 18:34:31 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41MS5M3013551
        for <linux-kernel@vger.kernel.org>; Wed, 1 May 2019 15:34:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=iahf2l2yW9zVsnHo/QQdvnMijX51fzwpDGNmIWN7kuw=;
 b=eC5o51483uh0t8WPEBNUvoa8Gh/4HC7k5Ur6W6ikrrR9uzi0LsQX+YKBHPSMybycE90I
 HxesUPXG4/RoW4Y9sE2iCDMSAFHwAjc96hY5djAvpZPyAvwPGblOtZ9pk45T9uOOPuaf
 pMkBU0VzvVhgZtZ6alICAn8+oMuXQJ8MbSs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s7e9xsahx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 15:34:29 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 May 2019 15:34:28 -0700
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 1F428D5E5499; Wed,  1 May 2019 15:34:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>, <sdasari@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] misc: aspeed-lpc-ctrl: make parameter optional
Date:   Wed, 1 May 2019 15:34:11 -0700
Message-ID: <20190501223411.1655854-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010138
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makiing memory-region and flash as optional parameter in device
tree if user needs to use these parameter through ioctl then
need to define in devicetree.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
index a024f8042259..332210e06e98 100644
--- a/drivers/misc/aspeed-lpc-ctrl.c
+++ b/drivers/misc/aspeed-lpc-ctrl.c
@@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 		unsigned long param)
 {
 	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
+	struct device *dev = file->private_data;
 	void __user *p = (void __user *)param;
 	struct aspeed_lpc_ctrl_mapping map;
 	u32 addr;
@@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 		if (map.window_id != 0)
 			return -EINVAL;
 
+		/* If memory-region is not described in device tree */
+		if (!lpc_ctrl->mem_size) {
+			dev_err(dev, "Didn't find reserved memory\n");
+			return -EINVAL;
+		}
+
 		map.size = lpc_ctrl->mem_size;
 
 		return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
@@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 
 		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
+			if (!lpc_ctrl->pnor_size) {
+				dev_err(dev, "Didn't find host pnor flash\n");
+				return -EINVAL;
+			}
 			addr = lpc_ctrl->pnor_base;
 			size = lpc_ctrl->pnor_size;
 		} else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
+			/* If memory-region is not described in device tree */
+			if (!lpc_ctrl->mem_size) {
+				dev_err(dev, "Didn't find reserved memory\n");
+				return -EINVAL;
+			}
 			addr = lpc_ctrl->mem_base;
 			size = lpc_ctrl->mem_size;
 		} else {
@@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 	if (!lpc_ctrl)
 		return -ENOMEM;
 
+	/* If flash is described in device tree then store */
 	node = of_parse_phandle(dev->of_node, "flash", 0);
 	if (!node) {
-		dev_err(dev, "Didn't find host pnor flash node\n");
-		return -ENODEV;
-	}
-
-	rc = of_address_to_resource(node, 1, &resm);
-	of_node_put(node);
-	if (rc) {
-		dev_err(dev, "Couldn't address to resource for flash\n");
-		return rc;
+		dev_dbg(dev, "Didn't find host pnor flash node\n");
+	} else {
+		rc = of_address_to_resource(node, 1, &resm);
+		of_node_put(node);
+		if (rc) {
+			dev_err(dev, "Couldn't address to resource for flash\n");
+			return rc;
+		}
 	}
 
 	lpc_ctrl->pnor_size = resource_size(&resm);
@@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, lpc_ctrl);
 
+	/* If memory-region is described in device tree then store */
 	node = of_parse_phandle(dev->of_node, "memory-region", 0);
 	if (!node) {
-		dev_err(dev, "Didn't find reserved memory\n");
-		return -EINVAL;
-	}
+		dev_dbg(dev, "Didn't find reserved memory\n");
+	} else {
+		rc = of_address_to_resource(node, 0, &resm);
+		of_node_put(node);
+		if (rc) {
+			dev_err(dev, "Couldn't address to resource for reserved memory\n");
+			return -ENOMEM;
+		}
 
-	rc = of_address_to_resource(node, 0, &resm);
-	of_node_put(node);
-	if (rc) {
-		dev_err(dev, "Couldn't address to resource for reserved memory\n");
-		return -ENOMEM;
+		lpc_ctrl->mem_size = resource_size(&resm);
+		lpc_ctrl->mem_base = resm.start;
 	}
 
-	lpc_ctrl->mem_size = resource_size(&resm);
-	lpc_ctrl->mem_base = resm.start;
-
 	lpc_ctrl->regmap = syscon_node_to_regmap(
 			pdev->dev.parent->of_node);
 	if (IS_ERR(lpc_ctrl->regmap)) {
@@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	dev_info(dev, "Loaded at %pr\n", &resm);
-
 	return 0;
 
 err:
-- 
2.17.1

