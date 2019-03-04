Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2DD20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfCDVh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:37:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726615AbfCDVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:37:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24Lb2m6138381
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 16:37:17 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r1c3c80bq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:37:17 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 4 Mar 2019 21:37:16 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 21:37:12 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24LbBGX60031068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 21:37:11 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57CA6136059;
        Mon,  4 Mar 2019 21:37:11 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93313136055;
        Mon,  4 Mar 2019 21:37:10 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 21:37:10 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        jk@ozlabs.org, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 4/6] drivers/misc: xdma: Add PCI device configuration sysfs
Date:   Mon,  4 Mar 2019 15:36:58 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19030421-0012-0000-0000-000017143498
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010705; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01169658; UDB=6.00611233; IPR=6.00950286;
 MB=3.00025831; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-04 21:37:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030421-0013-0000-0000-000056681F8F
Message-Id: <1551735420-16202-5-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040151
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
 drivers/misc/aspeed-xdma.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/misc/aspeed-xdma.c b/drivers/misc/aspeed-xdma.c
index 16235b3..0a1a093 100644
--- a/drivers/misc/aspeed-xdma.c
+++ b/drivers/misc/aspeed-xdma.c
@@ -645,6 +645,66 @@ static void aspeed_xdma_free_vga_blks(struct aspeed_xdma *ctx)
 	}
 }
 
+static int aspeed_xdma_change_pcie_conf(struct aspeed_xdma *ctx, u32 val)
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
+	regmap_update_bits(ctx->scu, SCU_PCIE_CONF,
+			   SCU_PCIE_CONF_VGA_EN | SCU_PCIE_CONF_BMC_EN,
+			   val);
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
+static ssize_t aspeed_xdma_use_bmc(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int rc;
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+
+	rc = aspeed_xdma_change_pcie_conf(ctx, SCU_PCIE_CONF_BMC_EN);
+	return rc ?: count;
+}
+static DEVICE_ATTR(use_bmc, 0200, NULL, aspeed_xdma_use_bmc);
+
+static ssize_t aspeed_xdma_use_vga(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int rc;
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+
+	rc = aspeed_xdma_change_pcie_conf(ctx, SCU_PCIE_CONF_VGA_EN);
+	return rc ?: count;
+}
+static DEVICE_ATTR(use_vga, 0200, NULL, aspeed_xdma_use_vga);
+
 static int aspeed_xdma_probe(struct platform_device *pdev)
 {
 	int irq;
@@ -723,6 +783,9 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	device_create_file(dev, &dev_attr_use_bmc);
+	device_create_file(dev, &dev_attr_use_vga);
+
 	return 0;
 }
 
@@ -730,6 +793,9 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	device_remove_file(ctx->dev, &dev_attr_use_vga);
+	device_remove_file(ctx->dev, &dev_attr_use_bmc);
+
 	misc_deregister(&ctx->misc);
 
 	aspeed_xdma_free_vga_blks(ctx);
-- 
1.8.3.1

