Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EEEC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C567F2238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rp7bZn35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbfGWWfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:35:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33802 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389612AbfGWWfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:35:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so13896494pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISDhy1lFnV9frfiPyjqolFGkkeA7zQy7U6U1fLUKzLo=;
        b=Rp7bZn35T+JvwV7+QL8xoDSQlaAjqcHc/tZR4YkCtTIwA8n8wayhgPQVWb9sD5E7g6
         dszvbClvBisaSBUQbBAt66RjSHa1MMgvh8+ZS6vXbZgB5PLlJWRysGVUfYe+1eUg9trh
         efdqJqz8EnjZcxqBcIJEtHqUL9jZmoiAnTcxr7A17djpPzN0BOjSpPMBqUHBpxl8gSPc
         O0pG33xSiQmnq9va+q87ygPc/o0TxFUzWRXeid8TBaRMdQ+8YJQ4E+MQIyYJyFiPZwiJ
         FAMFffHFF/gZANt0bI8fECO6AD9wN5C4nvhCxASZuhvHdlmVjSh74tFkmiMUvoIdHSj+
         vrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ISDhy1lFnV9frfiPyjqolFGkkeA7zQy7U6U1fLUKzLo=;
        b=rnjMCKje7odhcZOjKPTgV6ggHYpy+3ZI9OIja3KPN3ZnLlnMAhDcZ8e5LZptIXBB7Y
         Y3hzIAL/HMcCeAdjFeNW6ualDoRgc/y+6bgZc12MAr5JKH77vz0pJTWOfGp4fltrAWTD
         1byYGhQRDEBPRuZ9CgxcwwqB3C9EphwhMisKosTTVo0tEEpFi7s/AWuqs0jw5FneXnFL
         KfvxpYH1cC9aMTtL2QVj+laUfGraFaZxpU+yUZ5U3t4DJ6IIZwrht1TZU5GU6WenoNFX
         rggyfDRu7I/o2C1i/Ojsi+qBOAPGOmVRzjGZ1QGjMGUDEYGt9I8GyG1JudxvFvBDkshz
         VEpA==
X-Gm-Message-State: APjAAAUyUq/skeIS0Vg9cMquUbWkNawOUjwbrhEK0scTG3uZ2U2kgrEd
        iz3egpoh+U24GV9VvKOHOdiasg==
X-Google-Smtp-Source: APXvYqyk1yodnkhLdVAwBZxhmwgm/SRN+1VeCakDR+8+iCQae/FpVHlXgD9bw2X+AeRVJ7mKSJvRTw==
X-Received: by 2002:a63:1743:: with SMTP id 3mr338246pgx.435.1563921341327;
        Tue, 23 Jul 2019 15:35:41 -0700 (PDT)
Received: from localhost.localdomain ([115.99.187.56])
        by smtp.gmail.com with ESMTPSA id h16sm49036917pfo.34.2019.07.23.15.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:35:41 -0700 (PDT)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     agross@kernel.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v6 5/5] soc: qcom: socinfo: Expose image information
Date:   Wed, 24 Jul 2019 04:05:15 +0530
Message-Id: <20190723223515.27839-6-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
References: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The socinfo driver provides information about version of the various
images loaded in the system. Expose this to user space for debugging
purpose.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
Changes since v5:
	- No code changes, fix diff.context setting for formatting
          patches. Version 5 was adding context at the bottom of
          the file with 'git am'.
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
@@ -32,6 +32,39 @@
 #define SMEM_HW_SW_BUILD_ID            137
 
 #ifdef CONFIG_DEBUG_FS
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
 static const char *const pmic_models[] = {
 	[0]  = "Unknown PMIC model",
 	[9]  = "PM8994",
@@ -103,6 +136,13 @@ struct socinfo_params {
 	u32 hw_plat;
 	u32 fmt;
 };
+
+struct smem_image_version {
+	char name[SMEM_IMAGE_VERSION_NAME_SIZE];
+	char variant[SMEM_IMAGE_VERSION_VARIANT_SIZE];
+	char pad;
+	char oem[SMEM_IMAGE_VERSION_OEM_SIZE];
+};
 #endif /* CONFIG_DEBUG_FS */
 
 struct qcom_socinfo {
@@ -230,10 +270,37 @@ QCOM_OPEN(build_id, qcom_show_build_id);
 QCOM_OPEN(pmic_model, qcom_show_pmic_model);
 QCOM_OPEN(pmic_die_rev, qcom_show_pmic_die_revision);
 
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
 static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 				 struct socinfo *info)
 {
+	struct smem_image_version *versions;
+	struct dentry *dentry;
 	size_t size;
+	int i;
 
 	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
 
@@ -302,6 +369,23 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		DEBUGFS_ADD(info, build_id);
 		break;
 	}
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
 }
 
 static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
-- 
2.17.1

