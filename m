Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673EAC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 05:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CB020882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 05:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ys4E5Ao0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfL0Fc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 00:32:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39067 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfL0Fcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 00:32:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so14223385pfs.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 21:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akm4NfbJgAiIEKZHJ9zU6ThCpH8qtZ85+rrJ2Ji+w5w=;
        b=Ys4E5Ao0K33XCaNhJOZNGG9eB1LVmFEVbNik0eOadjtEdYVBg6XfirjuF26rOWP7wJ
         selaNF1Ku4vVNw3OPr/T4qBYMpvnbsD/vACg2AoSzOqhD3Eql1k/x84vD8Z7NaaXpOso
         twlspk/MZzFumGdwATJ+bq6wfL+RC/8BUi3ofUp6SMVYBwL3kHF3fNXw9lTzE+sPOfg1
         687E6VVlhERlRsvlslt/q+aG7LpxIK3ZR2gf+h2HUe9uaH5s9tkVTSEwa8AFSC08nziy
         9tosGaNqpkLQ5fKQ4AvHf2m2vgwGPZZQJanxHaVxlJ/85qMML5RMWtHxqtQ6uSGaYtU4
         iQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akm4NfbJgAiIEKZHJ9zU6ThCpH8qtZ85+rrJ2Ji+w5w=;
        b=onC71v+oaGSgoG1WkAmsedPP3p8mmqQlKA6ycbisfE5t1IefJOG0LKIOMPVFoKwwG4
         foepwj17i8r51rorGj/wJDgqmb1qArYVa1U6IsSQRrgMnAVjCWx5x9HYjU9gSPbxT9eD
         XhvIhc1sho2KTfci4n4E0jthly88eHmIbhEvriKj4W83a8SWwnrlJcQjynLSqshN+6td
         1iZPAk9CXsXelI21x/hDOz5zWR6SSUbjZM4t8cyNwDCo7softYLAS4EVg943rAqmpwJS
         LtoWjQ+E0D0Ps28en4XmcZNvLcuTuDAP43Q/Lm38v+p9lYLpemfJzm+oU8DuUzBrGuS5
         aGjg==
X-Gm-Message-State: APjAAAUp/LSa53BF/E7ycsBxnRMtbqWaXTUwyiU6yUtf2Ef82TrtQdXz
        VRmSknjPCEHJWR9BR9JX1ak4gA==
X-Google-Smtp-Source: APXvYqx+CMgYDl2dX4FUqA6dWXrSXTak++ViDH+hxj2wzDWUo0+9QhqR8sb9VKaph1DKqH2BCOwxLg==
X-Received: by 2002:a63:5809:: with SMTP id m9mr51181799pgb.26.1577424773541;
        Thu, 26 Dec 2019 21:32:53 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c22sm16789196pfo.50.2019.12.26.21.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 21:32:53 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 2/8] remoteproc: qcom: Introduce driver to store pil info in IMEM
Date:   Thu, 26 Dec 2019 21:32:09 -0800
Message-Id: <20191227053215.423811-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191227053215.423811-1-bjorn.andersson@linaro.org>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A region in IMEM is used to communicate load addresses of remoteproc to
post mortem debug tools. Implement a driver that can be used to store
this information in order to enable these tools to process collected
ramdumps.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added helper to probe defer clients
- Fixed logical bug in slot scan
- Added SPDX header in header file

 drivers/remoteproc/Kconfig         |   3 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/qcom_pil_info.c | 150 +++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_pil_info.h |   8 ++
 4 files changed, 162 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_pil_info.c
 create mode 100644 drivers/remoteproc/qcom_pil_info.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 94afdde4bc9f..0798602e355a 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -85,6 +85,9 @@ config KEYSTONE_REMOTEPROC
 	  It's safe to say N here if you're not interested in the Keystone
 	  DSPs or just want to use a bare minimum kernel.
 
+config QCOM_PIL_INFO
+	tristate
+
 config QCOM_RPROC_COMMON
 	tristate
 
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 00f09e658cb3..c1b46e9033cb 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
+obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
 obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom_pil_info.c
new file mode 100644
index 000000000000..b0897ae9eae5
--- /dev/null
+++ b/drivers/remoteproc/qcom_pil_info.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019 Linaro Ltd.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/slab.h>
+
+struct pil_reloc_entry {
+	char name[8];
+	__le64 base;
+	__le32 size;
+} __packed;
+
+#define PIL_INFO_SIZE	200
+#define PIL_INFO_ENTRIES (PIL_INFO_SIZE / sizeof(struct pil_reloc_entry))
+
+struct pil_reloc {
+	struct device *dev;
+	struct regmap *map;
+	u32 offset;
+	int val_bytes;
+
+	struct pil_reloc_entry entries[PIL_INFO_ENTRIES];
+};
+
+static struct pil_reloc *_reloc;
+static DEFINE_MUTEX(reloc_mutex);
+
+/**
+ * qcom_pil_info_store() - store PIL information of image in IMEM
+ * @image:	name of the image
+ * @base:	base address of the loaded image
+ * @size:	size of the loaded image
+ */
+void qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
+{
+	struct pil_reloc_entry *entry;
+	int idx = -1;
+	int i;
+
+	mutex_lock(&reloc_mutex);
+	if (!_reloc)
+		goto unlock;
+
+	for (i = 0; i < PIL_INFO_ENTRIES; i++) {
+		if (!_reloc->entries[i].name[0]) {
+			if (idx == -1)
+				idx = i;
+			continue;
+		}
+
+		if (!strncmp(_reloc->entries[i].name, image, 8)) {
+			idx = i;
+			goto found;
+		}
+	}
+
+	if (idx == -1) {
+		dev_warn(_reloc->dev, "insufficient PIL info slots\n");
+		goto unlock;
+	}
+
+found:
+	entry = &_reloc->entries[idx];
+	stracpy(entry->name, image);
+	entry->base = base;
+	entry->size = size;
+
+	regmap_bulk_write(_reloc->map, _reloc->offset + idx * sizeof(*entry),
+			  entry, sizeof(*entry) / _reloc->val_bytes);
+
+unlock:
+	mutex_unlock(&reloc_mutex);
+}
+EXPORT_SYMBOL_GPL(qcom_pil_info_store);
+
+/**
+ * qcom_pil_info_available() - query if the pil info is probed
+ *
+ * Return: boolean indicating if the pil info device is probed
+ */
+bool qcom_pil_info_available(void)
+{
+	return !!_reloc;
+}
+EXPORT_SYMBOL_GPL(qcom_pil_info_available);
+
+static int pil_reloc_probe(struct platform_device *pdev)
+{
+	struct pil_reloc *reloc;
+
+	reloc = devm_kzalloc(&pdev->dev, sizeof(*reloc), GFP_KERNEL);
+	if (!reloc)
+		return -ENOMEM;
+
+	reloc->dev = &pdev->dev;
+	reloc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(reloc->map))
+		return PTR_ERR(reloc->map);
+
+	if (of_property_read_u32(pdev->dev.of_node, "offset", &reloc->offset))
+		return -EINVAL;
+
+	reloc->val_bytes = regmap_get_val_bytes(reloc->map);
+	if (reloc->val_bytes < 0)
+		return -EINVAL;
+
+	regmap_bulk_write(reloc->map, reloc->offset, reloc->entries,
+			  sizeof(reloc->entries) / reloc->val_bytes);
+
+	mutex_lock(&reloc_mutex);
+	_reloc = reloc;
+	mutex_unlock(&reloc_mutex);
+
+	return 0;
+}
+
+static int pil_reloc_remove(struct platform_device *pdev)
+{
+	mutex_lock(&reloc_mutex);
+	_reloc = NULL;
+	mutex_unlock(&reloc_mutex);
+
+	return 0;
+}
+
+static const struct of_device_id pil_reloc_of_match[] = {
+	{ .compatible = "qcom,pil-reloc-info" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pil_reloc_of_match);
+
+static struct platform_driver pil_reloc_driver = {
+	.probe = pil_reloc_probe,
+	.remove = pil_reloc_remove,
+	.driver = {
+		.name = "qcom-pil-reloc-info",
+		.of_match_table = pil_reloc_of_match,
+	},
+};
+module_platform_driver(pil_reloc_driver);
+
+MODULE_DESCRIPTION("Qualcomm PIL relocation info");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/remoteproc/qcom_pil_info.h b/drivers/remoteproc/qcom_pil_info.h
new file mode 100644
index 000000000000..0372602fae1d
--- /dev/null
+++ b/drivers/remoteproc/qcom_pil_info.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __QCOM_PIL_INFO_H__
+#define __QCOM_PIL_INFO_H__
+
+void qcom_pil_info_store(const char *image, phys_addr_t base, size_t size);
+bool qcom_pil_info_available(void);
+
+#endif
-- 
2.24.0

