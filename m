Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119DFC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCF321BE6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKH3tIkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfHGFjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:39:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39850 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfHGFjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:39:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so38991469pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DHLSpNf1LsuJ1wDDF5wISNJL3XiKw5OPuws/j+9mEZ4=;
        b=oKH3tIkLcOj5q28FdagPOcCl8w1CPiQNdCAVUaqi/AaD/hNMH2zdiCwbcoQ03uypze
         IaOOoFZXCjw3UyiXTHidDRMzG62oDDK4nU4GhB07Yl/+8300sDfaDJ0vAmpHO2kMFpg5
         Y9V0Vi+ARHOiGQqL0Q0GRpkLQNXFykRRKoD8H2lMZ29hPJrqx5VD/RGdyMhd2BP0YrKl
         upPN/mSJxWgdE3Z2eoaHAelNrz8Gu8oiDPfrgCUHOc1Rwx2W/+++AD9nIae/fJKRMIM3
         +kHiSMB4w/q3t45uQlUAzjnmg2/36p8PklnCYc4H68lwnZvqy4b8113aaezP2AjdwBIf
         VHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DHLSpNf1LsuJ1wDDF5wISNJL3XiKw5OPuws/j+9mEZ4=;
        b=PHtQEukegZyPy/IaLrsUdfbYfqb6xQTdfwkTyAqLEyy4T9La91xVyDcIY5ONolvrBX
         3o06yfaiFhjied0Up6JOPEV7XzyJ7v/TEWzuInJvNon3WjYVyaPB5Ih+WhSOZ4jgQAdF
         67HNpDRGahafMiHFLe4cxdJ4MUWsXjiHc6vrf/PmrK33kN6PrbuWwVcETUoCT5xWNeoi
         SJxwZ0VTEEIX9g3qufixpcyuyLXjh6rFsWZxdv0QipBVqTGYZCenz+RNbSdoAzYGJQ8N
         M2+Br2esaJSq/1svAolqx82Bfp7bflXLsYHQhFCwstUTK/IwP0rY9eoEdFNjCFy1Ug95
         fwvg==
X-Gm-Message-State: APjAAAUWE3x+pg6ShIeyA0ADJC/ny1voW9yxdgqpMACu0sYzwphGjCQA
        m6iGCsrKAeYQU3ki34FwnDCF8A==
X-Google-Smtp-Source: APXvYqwUd+/t1/18/8l+XVokh3+ItPFBiNlUa9UXozM+ztWtnzV2TZs3IM70LQjnOiY+jk9Oscpzqg==
X-Received: by 2002:a63:4522:: with SMTP id s34mr6167748pga.362.1565156390665;
        Tue, 06 Aug 2019 22:39:50 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u7sm86070777pfm.96.2019.08.06.22.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 22:39:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 4/9] remoteproc: qcom: wcnss: Update IMEM PIL info on load
Date:   Tue,  6 Aug 2019 22:39:37 -0700
Message-Id: <20190807053942.9836-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807053942.9836-1-bjorn.andersson@linaro.org>
References: <20190807053942.9836-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the relocated base address and size in the PIL relocation info
structure in IMEM.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/Kconfig      |  1 +
 drivers/remoteproc/qcom_wcnss.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 2aa0743fc05b..3f976ce3df3c 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -185,6 +185,7 @@ config QCOM_WCNSS_PIL
 	depends on QCOM_SMEM
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select QCOM_MDT_LOADER
+	select QCOM_PIL_INFO
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index dc135754bb9c..9db9a3d25af4 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -27,6 +27,7 @@
 
 #include "qcom_common.h"
 #include "remoteproc_internal.h"
+#include "qcom_pil_info.h"
 #include "qcom_wcnss.h"
 
 #define WCNSS_CRASH_REASON_SMEM		422
@@ -145,10 +146,17 @@ void qcom_wcnss_assign_iris(struct qcom_wcnss *wcnss,
 static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+	int ret;
+
+	ret = qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
+			    wcnss->mem_region, wcnss->mem_phys,
+			    wcnss->mem_size, &wcnss->mem_reloc);
+	if (ret)
+		return ret;
+
+	qcom_pil_info_store("wcnss", wcnss->mem_reloc, wcnss->mem_size);
 
-	return qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
-			     wcnss->mem_region, wcnss->mem_phys,
-			     wcnss->mem_size, &wcnss->mem_reloc);
+	return 0;
 }
 
 static void wcnss_indicate_nv_download(struct qcom_wcnss *wcnss)
-- 
2.18.0

