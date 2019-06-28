Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64817C5B577
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C73C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683069;
	bh=AOTSC0ERz0ZyELd89rcvqDiP+btZ5n5XV/TUI7nV/To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZmah1PBLhx5M3/JIT+yK/0oNpvxpWHLLahiRdF/ctu/shAM6Pzoe2/p9q0GOjvql
	 JTTx/ei2p4EEHx9izLIL6lChY9JC4JYNa3vSZVi+2GUdtvon+SY8Pn6DMivCORyxB2
	 HmAo4wZidbvASQp63E4XSpFfDnDxuJLSCoG/GAmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfF1AvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:51:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44088 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfF1Aui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so2198071plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWl40JJRec3AP1nHupFxdHtA4pc1RCgM8962UeDAdXM=;
        b=Wky6AgPMZyeXYKLcoiMFGaKF00s8rpaS3hKNd8h3EfZE/M7N5P5yKluK9MKEVU++dp
         TnDbhhaTpfoK9RdqEcq+MGkrOTym9KHiN/TglPRh4vnGo+7chHnp8u/0w0uui34lKe9P
         HCwfAwp5ey/WGQ2tpUxbvZNy4bB/lIiJkLx6B/2tRTOkq8XXgRd6vhs2Px0/z3d8hb2s
         cYLLAtqSfykXRDYDPMhMQCCk6EJgQVegNWWT1zITD5plu6pdcoKZcLV9rAWYMGOaSaZz
         cEob0sB5cY7QxkVF0RudEYyAVZzybMBQd5VuBg/oc35byrwz5L99w5YLRgCtmDFAIHdi
         O+cA==
X-Gm-Message-State: APjAAAWcLuJ7Klr/76729/PJJmGzO7lOGGlxwX4tIYKYaso1qNLKXi62
        D/W+qLJYOjdw6Y5qU8uASG9MHA==
X-Google-Smtp-Source: APXvYqyLwX+p6fgvWh5NYctTzn19WNjQtb7Sm6XIwbf2Aa6bUJyo8MtGZ+3cP1p4CVTZ9Q17XZ2RRw==
X-Received: by 2002:a17:902:b186:: with SMTP id s6mr8000497plr.343.1561683037570;
        Thu, 27 Jun 2019 17:50:37 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id u134sm285578pfc.19.2019.06.27.17.50.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:36 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>
Subject: [PATCH 10/15] fpga: dfl: add id_table for dfl private feature driver
Date:   Thu, 27 Jun 2019 17:49:46 -0700
Message-Id: <20190628004951.6202-11-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

This patch adds id_table for each dfl private feature driver,
it allows to reuse same private feature driver to match and support
multiple dfl private features.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-afu-main.c | 14 ++++++++++++--
 drivers/fpga/dfl-fme-main.c | 11 ++++++++---
 drivers/fpga/dfl-fme-pr.c   |  7 ++++++-
 drivers/fpga/dfl-fme.h      |  3 ++-
 drivers/fpga/dfl.c          | 21 +++++++++++++++++++--
 drivers/fpga/dfl.h          | 21 +++++++++++++++------
 6 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 8b434a405498..65b3e895e364 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -435,6 +435,11 @@ port_hdr_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
 	return ret;
 }
 
+static const struct dfl_feature_id port_hdr_id_table[] = {
+	{.id = PORT_FEATURE_ID_HEADER,},
+	{0,}
+};
+
 static const struct dfl_feature_ops port_hdr_ops = {
 	.init = port_hdr_init,
 	.uinit = port_hdr_uinit,
@@ -495,6 +500,11 @@ static void port_afu_uinit(struct platform_device *pdev,
 	sysfs_remove_files(&pdev->dev.kobj, port_afu_attrs);
 }
 
+static const struct dfl_feature_id port_afu_id_table[] = {
+	{.id = PORT_FEATURE_ID_AFU,},
+	{0,}
+};
+
 static const struct dfl_feature_ops port_afu_ops = {
 	.init = port_afu_init,
 	.uinit = port_afu_uinit,
@@ -502,11 +512,11 @@ static const struct dfl_feature_ops port_afu_ops = {
 
 static struct dfl_feature_driver port_feature_drvs[] = {
 	{
-		.id = PORT_FEATURE_ID_HEADER,
+		.id_table = port_hdr_id_table,
 		.ops = &port_hdr_ops,
 	},
 	{
-		.id = PORT_FEATURE_ID_AFU,
+		.id_table = port_afu_id_table,
 		.ops = &port_afu_ops,
 	},
 	{
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 8b2a33760483..38c6342e1865 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -158,6 +158,11 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 	return -ENODEV;
 }
 
+static const struct dfl_feature_id fme_hdr_id_table[] = {
+	{.id = FME_FEATURE_ID_HEADER,},
+	{0,}
+};
+
 static const struct dfl_feature_ops fme_hdr_ops = {
 	.init = fme_hdr_init,
 	.uinit = fme_hdr_uinit,
@@ -166,12 +171,12 @@ static const struct dfl_feature_ops fme_hdr_ops = {
 
 static struct dfl_feature_driver fme_feature_drvs[] = {
 	{
-		.id = FME_FEATURE_ID_HEADER,
+		.id_table = fme_hdr_id_table,
 		.ops = &fme_hdr_ops,
 	},
 	{
-		.id = FME_FEATURE_ID_PR_MGMT,
-		.ops = &pr_mgmt_ops,
+		.id_table = fme_pr_mgmt_id_table,
+		.ops = &fme_pr_mgmt_ops,
 	},
 	{
 		.ops = NULL,
diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index cd94ba870094..52f1745dfb25 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -483,7 +483,12 @@ static long fme_pr_ioctl(struct platform_device *pdev,
 	return ret;
 }
 
-const struct dfl_feature_ops pr_mgmt_ops = {
+const struct dfl_feature_id fme_pr_mgmt_id_table[] = {
+	{.id = FME_FEATURE_ID_PR_MGMT,},
+	{0}
+};
+
+const struct dfl_feature_ops fme_pr_mgmt_ops = {
 	.init = pr_mgmt_init,
 	.uinit = pr_mgmt_uinit,
 	.ioctl = fme_pr_ioctl,
diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
index de207556b70a..7a021c483e9b 100644
--- a/drivers/fpga/dfl-fme.h
+++ b/drivers/fpga/dfl-fme.h
@@ -35,6 +35,7 @@ struct dfl_fme {
 	struct dfl_feature_platform_data *pdata;
 };
 
-extern const struct dfl_feature_ops pr_mgmt_ops;
+extern const struct dfl_feature_ops fme_pr_mgmt_ops;
+extern const struct dfl_feature_id fme_pr_mgmt_id_table[];
 
 #endif /* __DFL_FME_H */
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 28d61b611165..1bb2b582e4b0 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -14,6 +14,8 @@
 
 #include "dfl.h"
 
+#define DRV_VERSION	"0.8"
+
 static DEFINE_MUTEX(dfl_id_mutex);
 
 /*
@@ -281,6 +283,21 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
 	return ret;
 }
 
+static bool dfl_feature_drv_match(struct dfl_feature *feature,
+				  struct dfl_feature_driver *driver)
+{
+	const struct dfl_feature_id *ids = driver->id_table;
+
+	if (ids) {
+		while (ids->id) {
+			if (ids->id == feature->id)
+				return true;
+			ids++;
+		}
+	}
+	return false;
+}
+
 /**
  * dfl_fpga_dev_feature_init - init for sub features of dfl feature device
  * @pdev: feature device.
@@ -301,8 +318,7 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 
 	while (drv->ops) {
 		dfl_fpga_dev_for_each_feature(pdata, feature) {
-			/* match feature and drv using id */
-			if (feature->id == drv->id) {
+			if (dfl_feature_drv_match(feature, drv)) {
 				ret = dfl_feature_instance_init(pdev, pdata,
 								feature, drv);
 				if (ret)
@@ -1178,3 +1194,4 @@ module_exit(dfl_fpga_exit);
 MODULE_DESCRIPTION("FPGA Device Feature List (DFL) Support");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 3c5dc3a13b0b..fbc57f0f76ef 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -30,8 +30,8 @@
 /* plus one for fme device */
 #define MAX_DFL_FEATURE_DEV_NUM    (MAX_DFL_FPGA_PORT_NUM + 1)
 
-/* Reserved 0x0 for Header Group Register and 0xff for AFU */
-#define FEATURE_ID_FIU_HEADER		0x0
+/* Reserved 0xfe for Header Group Register and 0xff for AFU */
+#define FEATURE_ID_FIU_HEADER		0xfe
 #define FEATURE_ID_AFU			0xff
 
 #define FME_FEATURE_ID_HEADER		FEATURE_ID_FIU_HEADER
@@ -169,13 +169,22 @@ void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops);
 int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
 
 /**
- * struct dfl_feature_driver - sub feature's driver
+ * struct dfl_feature_id - dfl private feature id
  *
- * @id: sub feature id.
- * @ops: ops of this sub feature.
+ * @id: unique dfl private feature id.
  */
-struct dfl_feature_driver {
+struct dfl_feature_id {
 	u64 id;
+};
+
+/**
+ * struct dfl_feature_driver - dfl private feature driver
+ *
+ * @id_table: id_table for dfl private features supported by this driver.
+ * @ops: ops of this dfl private feature driver.
+ */
+struct dfl_feature_driver {
+	const struct dfl_feature_id *id_table;
 	const struct dfl_feature_ops *ops;
 };
 
-- 
2.22.0

