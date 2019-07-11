Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90BC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E523F20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ok8sIZWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfGKVjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:39:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46472 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbfGKVji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:39:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so3673386plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xTYoybvYWHee/RFEpMdNa4wDHWkYkkBOifukpaMKMKE=;
        b=ok8sIZWdQ/jFVh/panVyfJtxBPWBijrFD2XMIe9u0Y8rfYhWfFPzh12uv+/9cyiY0D
         BJjkr7KrQv3R/SKG+WGR1RivVUxQUspmZwtrWsZfQbI/CLE1nygkCz6Rm6YH220z2pWo
         +Jq65hoKKSWboUAnZSmT3m7pp/lmd8Cc1MnMLejT1sODBWjPEGQTtEaghlfXuBG0fVvM
         TqGP+MI7ZridGqgSIICkq6CS/q40EKGMzIyGlt7GxMqIdFSzUeeUTEOSFFU6wuT5+avO
         hNdmwDWDl4hyW3t6bLdOEAR+DaPur9tRhMsuCaHw7dvCf2v3t/Dfj45/77qAcluc8ANb
         GUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xTYoybvYWHee/RFEpMdNa4wDHWkYkkBOifukpaMKMKE=;
        b=ZAS5+2g+Bmt4J9/GYjok/4StUKER1jkxQkTc2auFRaNsmah6PGYNcz97y7Tb+zyt2p
         KydmH8mXzCvUoUfoWZcuiPSNCbtHgq0j/8n6gqhvD+TzhA2qcUZ7mm8bT/GXc9T0bKkm
         HvHp2Mbb81CgMODV5Q7CkFIsUoicAKkRGOO1q79iIcKrn5aCH7JBfykZhI2fiGPmUuUQ
         NTbWYWG40RJ3HGfpKXV9JR3yn+MHVIWtnp31qydu9TutB3usXZhvz8fEqeU2po5TQBU4
         2ouqgwaYSATeRKyEQHHfSrPoJwKC4iKdCLSlA4H3MpADG4GYbsmuchyOFTo8aw9kNIwH
         myfA==
X-Gm-Message-State: APjAAAWz9k650mqS/TcxwPwu3TKTXBPtGX8f7pOtCCt4jzg6qaK6lHHe
        XYW9nHFDGYP9o2uHJ1La9Pgi3g==
X-Google-Smtp-Source: APXvYqzRSzMf4ft8tETWd0P9lKa+gwkBPTc0ATw6qo63CHiA4moGx+5kZuo6PMmwOPZKuyQMCWf8Rg==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr6576707plb.299.1562881178036;
        Thu, 11 Jul 2019 14:39:38 -0700 (PDT)
Received: from localhost.localdomain ([27.7.91.104])
        by smtp.gmail.com with ESMTPSA id w3sm5709795pgl.31.2019.07.11.14.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 14:39:37 -0700 (PDT)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     agross@kernel.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v5 5/5] soc: qcom: socinfo: Expose image information
Date:   Fri, 12 Jul 2019 03:09:11 +0530
Message-Id: <20190711213911.23180-6-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711213911.23180-1-vaishali.thakkar@linaro.org>
References: <20190711213911.23180-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The socinfo driver provides information about version of the various
images loaded in the system. Expose this to user space for debugging
purpose.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
Changes since v4:
	- Reduce number of duplicate image macros and functions
	- Introduce array for image info debugfs entries and use it
	  instead of open coding
Changes since v3:
        - Remove extra debugfs directory creation checks
Changes since v2:
        - None
Changes since v1:
        - None
---
 drivers/soc/qcom/socinfo.c | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 6a4795433d57..855353bed19e 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -34,0 +35,33 @@
+#define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
+#define SMEM_IMAGE_VERSION_SIZE                4096
+#define SMEM_IMAGE_VERSION_NAME_SIZE           75
+#define SMEM_IMAGE_VERSION_VARIANT_SIZE        20
+#define SMEM_IMAGE_VERSION_OEM_SIZE            32
+
+/*
+ * SMEM Image table indices
+ */
+#define SMEM_IMAGE_TABLE_BOOT_INDEX     0
+#define SMEM_IMAGE_TABLE_TZ_INDEX       1
+#define SMEM_IMAGE_TABLE_RPM_INDEX      3
+#define SMEM_IMAGE_TABLE_APPS_INDEX     10
+#define SMEM_IMAGE_TABLE_MPSS_INDEX     11
+#define SMEM_IMAGE_TABLE_ADSP_INDEX     12
+#define SMEM_IMAGE_TABLE_CNSS_INDEX     13
+#define SMEM_IMAGE_TABLE_VIDEO_INDEX    14
+#define SMEM_IMAGE_VERSION_TABLE       469
+
+/*
+ * SMEM Image table names
+ */
+static const char *const socinfo_image_names[] = {
+	[SMEM_IMAGE_TABLE_ADSP_INDEX] = "adsp",
+	[SMEM_IMAGE_TABLE_APPS_INDEX] = "apps",
+	[SMEM_IMAGE_TABLE_BOOT_INDEX] = "boot",
+	[SMEM_IMAGE_TABLE_CNSS_INDEX] = "cnss",
+	[SMEM_IMAGE_TABLE_MPSS_INDEX] = "mpss",
+	[SMEM_IMAGE_TABLE_RPM_INDEX] = "rpm",
+	[SMEM_IMAGE_TABLE_TZ_INDEX] = "tz",
+	[SMEM_IMAGE_TABLE_VIDEO_INDEX] = "video",
+};
+
@@ -105,0 +139,7 @@ struct socinfo_params {
+
+struct smem_image_version {
+	char name[SMEM_IMAGE_VERSION_NAME_SIZE];
+	char variant[SMEM_IMAGE_VERSION_VARIANT_SIZE];
+	char pad;
+	char oem[SMEM_IMAGE_VERSION_OEM_SIZE];
+};
@@ -232,0 +273,24 @@ QCOM_OPEN(pmic_die_rev, qcom_show_pmic_die_revision);
+#define DEFINE_IMAGE_OPS(type)					\
+static int show_image_##type(struct seq_file *seq, void *p)		  \
+{								  \
+	struct smem_image_version *image_version = seq->private;  \
+	seq_puts(seq, image_version->type);			  \
+	seq_puts(seq, "\n");					  \
+	return 0;						  \
+}								  \
+static int open_image_##type(struct inode *inode, struct file *file)	  \
+{									  \
+	return single_open(file, show_image_##type, inode->i_private); \
+}									  \
+									  \
+static const struct file_operations qcom_image_##type##_ops = {	  \
+	.open = open_image_##type,					  \
+	.read = seq_read,						  \
+	.llseek = seq_lseek,						  \
+	.release = single_release,					  \
+}
+
+DEFINE_IMAGE_OPS(name);
+DEFINE_IMAGE_OPS(variant);
+DEFINE_IMAGE_OPS(oem);
+
@@ -235,0 +300,2 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
+	struct smem_image_version *versions;
+	struct dentry *dentry;
@@ -236,0 +303 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
+	int i;
@@ -304,0 +372,17 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
+
+	versions = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_IMAGE_VERSION_TABLE,
+				 &size);
+
+	for (i = 0; i < ARRAY_SIZE(socinfo_image_names); i++) {
+		if (!socinfo_image_names[i])
+			continue;
+
+		dentry = debugfs_create_dir(socinfo_image_names[i],
+					    qcom_socinfo->dbg_root);
+		debugfs_create_file("name", 0400, dentry, &versions[i],
+				    &qcom_image_name_ops);
+		debugfs_create_file("variant", 0400, dentry, &versions[i],
+				    &qcom_image_variant_ops);
+		debugfs_create_file("oem", 0400, dentry, &versions[i],
+				    &qcom_image_oem_ops);
+	}
-- 
2.17.1

