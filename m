Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BAC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EFA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9ISHTff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405728AbfFKQmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:42:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35910 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405693AbfFKQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:42:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so9838710lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqRvC4t/KJZ7EpjmV+PMrX0EoO+pq9e/AYZP8BykWf4=;
        b=q9ISHTff+JXNactLIbp/cZNGUfme34QpdPii/dK3d2ci5PhrRRWD8LOVWRaRc9DPAY
         SJfTgnlx4OA2BZqEtFswt8syvTAhzsKCe4AHfHoylNHoAN4DNOKt4J6DXGdOHsgmC0Eg
         dmGCDoyB1JfW7nzUP6DhfZWLuzH8v1jGp9UTEvO+NX8iz1MHELgjxWaPL4kPQVp4J1dg
         XDFlUKJ+nFG1ifwMPXnppezjuK8dXZmF+gBmoHcl9ZyKVblJZJ5jBuKEkUwUvhDITOan
         wR41W0f5lqylnttgbwSkVuuse+H+x44KHohtVjV2RZvjl4qoafNY66Dal4I7XLAFhC0k
         YCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqRvC4t/KJZ7EpjmV+PMrX0EoO+pq9e/AYZP8BykWf4=;
        b=ABAUIJufSmtTHBuA8uTxpNTM4Mz/21J8FDUCxshV381dU0xtxlkweFYds6PwgOuOGF
         9UtuHch08lVPGqIkxxr1xfCBo/LBA204G7Jqw7bcDn03JnYVd+y0yhTAScLHdAe024+L
         LBtN/j4jVIhvlwa/RXASJpCpP/nO5MCtceFpI1z4euRAZCH3g0Z0lniOXW+cbL419BFd
         kPDw5FBq3x91CiRF0EhaKm+NJcfD8jshdXsTkGQpjbAlaVbpCBOezfJFc4yKrktJh8lp
         hB2befMPluKO90g0rDS+wvndAUeZDfv1uIZbTTWCSV5keqqmViDmGJaPZvqKoDFGkJyG
         TlbQ==
X-Gm-Message-State: APjAAAVL7RCORW7bquH/QLyGKX6T3ugf80qR5FZjDqdyHCN5yCUtr7Od
        68DgDKYbt/cUARyBF6i4aFcBFQ==
X-Google-Smtp-Source: APXvYqzTJ7hxLn04ZvDtmGZaQC3jNGDbykdGpc6OSGsqBmyC6WdppQuhSLfe6bCmR7AYE18fn7D1XQ==
X-Received: by 2002:a19:6519:: with SMTP id z25mr37756963lfb.73.1560271332028;
        Tue, 11 Jun 2019 09:42:12 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r14sm2616772lff.44.2019.06.11.09.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 09:42:11 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 4/5] interconnect: qcom: Add interconnect SMD over SMD driver
Date:   Tue, 11 Jun 2019 19:41:56 +0300
Message-Id: <20190611164157.24656-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611164157.24656-1-georgi.djakov@linaro.org>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qualcomm SoCs, there is a remote processor, which controls some of
the Network-On-Chip interconnect resources. Other CPUs express their needs
by communicating with this processor. Add a driver to handle communication
with this remote processor.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v3:
- New patch.

 drivers/interconnect/qcom/Kconfig   |  9 ++++
 drivers/interconnect/qcom/Makefile  |  2 +
 drivers/interconnect/qcom/smd-rpm.c | 72 +++++++++++++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.h | 15 ++++++
 4 files changed, 98 insertions(+)
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index e76e3e248c41..b0eade1da5d5 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -9,6 +9,7 @@ config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM || COMPILE_TEST
+	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
 	  platforms.
@@ -20,3 +21,11 @@ config INTERCONNECT_QCOM_SDM845
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
 	  platforms.
+
+config INTERCONNECT_QCOM_SMD_RPM
+	tristate "Qualcomm SMD RPM interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM || COMPILE_TEST
+	help
+	  This is a driver for communicating interconnect related configuration
+	  details with a remote processor (RPM) on Qualcomm platforms.
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 059ff325ee6c..67dafb783dec 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -2,6 +2,8 @@
 
 qnoc-qcs404-objs			:= qcs404.o
 qnoc-sdm845-objs			:= sdm845.o
+icc-smd-rpm-objs			:= smd-rpm.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
new file mode 100644
index 000000000000..af22c0a293e6
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPM over SMD communication wrapper for interconnects
+ *
+ * Copyright (C) 2019 Linaro Ltd
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smd-rpm.h>
+
+#include "smd-rpm.h"
+
+#define RPM_KEY_BW		0x00007762
+
+static struct qcom_smd_rpm *icc_smd_rpm;
+
+struct icc_rpm_smd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+bool qcom_icc_rpm_smd_available(void)
+{
+	if (!icc_smd_rpm)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_available);
+
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
+{
+	struct icc_rpm_smd_req req = {
+		.key = cpu_to_le32(RPM_KEY_BW),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(val),
+	};
+
+	return qcom_rpm_smd_write(icc_smd_rpm, ctx, rsc_type, id, &req,
+				  sizeof(req));
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
+
+static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
+{
+	icc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
+
+	if (!icc_smd_rpm) {
+		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct platform_driver qcom_interconnect_rpm_smd_driver = {
+	.driver = {
+		.name		= "icc_smd_rpm",
+	},
+	.probe = qcom_icc_rpm_smd_probe,
+};
+module_platform_driver(qcom_interconnect_rpm_smd_driver);
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm SMD RPM interconnect proxy driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:icc_smd_rpm");
diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
new file mode 100644
index 000000000000..ca9d0327b8ac
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
+#define __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
+
+#include <linux/soc/qcom/smd-rpm.h>
+
+bool qcom_icc_rpm_smd_available(void);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+
+#endif
