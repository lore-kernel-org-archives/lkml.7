Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71546C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA1D216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfETUVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:21:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbfETUVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:21:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KK7xIU011696;
        Mon, 20 May 2019 16:21:03 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sm2m315hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 16:21:02 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4KJbcLI014553;
        Mon, 20 May 2019 19:39:10 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2sj9p3k7w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 19:39:10 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4KKJjFt34210286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 20:19:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA3C5B2068;
        Mon, 20 May 2019 20:19:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DCD9B2064;
        Mon, 20 May 2019 20:19:45 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 20 May 2019 20:19:45 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, joel@jms.id.au,
        andrew@aj.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 4/7] drivers/soc: xdma: Add PCI device configuration sysfs
Date:   Mon, 20 May 2019 15:19:22 -0500
Message-Id: <1558383565-11821-5-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
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

The AST2500 has two PCI devices embedded. The XDMA engine can use either
device to perform DMA transfers. Users need the capability to choose
which device to use. This commit therefore adds two sysfs files that
toggle the AST2500 and XDMA engine between the two PCI devices.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/soc/aspeed/aspeed-xdma.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 2162ca0..002b571 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -667,6 +667,64 @@ static void aspeed_xdma_free_vga_blks(struct aspeed_xdma *ctx)
 	}
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
+static ssize_t aspeed_xdma_use_bmc(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int rc;
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+
+	rc = aspeed_xdma_change_pcie_conf(ctx, aspeed_xdma_bmc_pcie_conf);
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
+	rc = aspeed_xdma_change_pcie_conf(ctx, aspeed_xdma_vga_pcie_conf);
+	return rc ?: count;
+}
+static DEVICE_ATTR(use_vga, 0200, NULL, aspeed_xdma_use_vga);
+
 static int aspeed_xdma_probe(struct platform_device *pdev)
 {
 	int irq;
@@ -745,6 +803,9 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	device_create_file(dev, &dev_attr_use_bmc);
+	device_create_file(dev, &dev_attr_use_vga);
+
 	return 0;
 }
 
@@ -752,6 +813,9 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	device_remove_file(ctx->dev, &dev_attr_use_vga);
+	device_remove_file(ctx->dev, &dev_attr_use_bmc);
+
 	misc_deregister(&ctx->misc);
 
 	aspeed_xdma_free_vga_blks(ctx);
-- 
1.8.3.1

