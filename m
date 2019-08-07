Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDAC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CAC21E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDiNfOYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfHGFkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:40:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43376 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfHGFju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:39:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so31939540pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vtVBkwA1h86i3IgqSipfDgtWxsjyT/oqz+jf2YjzTg0=;
        b=iDiNfOYEotcvnZDMgdSF14s4ZRODb3EgWflPP8UEq63YZ6JuonspSElpfLSHlmoxPo
         MX+ciKThLCRBrbSaIo1zbMQj2UuQ54eZQdhDOfsmP2assVHrNGLQSg+aH2QXqLcD1JyU
         +zWJ8soLGnEGo7wEmwfmXbfZ2sC54VvDaQAPdaBBZ+E6PJ5FPoGJK9uUWqPTnqaHYxPE
         gwhr+a5HX58ntzLFq/gUsB87gWlfl6RVnNf77xc0V01/fvK/whZvLUHku3r5Gc5wz/AF
         elNfZYSG+TyTdEf9pSPQQTl7I0IvBhnG31tHLDttd4QQkvoc9aNMWpX72GXnxKKGmrXn
         c1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vtVBkwA1h86i3IgqSipfDgtWxsjyT/oqz+jf2YjzTg0=;
        b=bF2WCG3xg3Q+sMMQJrz/sRjeHfmfHYu3oHZ1nomY2S/xon+/UOP/cpW8O6SMfkspmN
         aVQTN0l9ac57eXn1JQCsxlrsAekWBTedJsF4y3ddkoleLCJz0pPEhDBQyDTpAAKweIsf
         1eXVBn9J65ocv+ouyiJE2lWgaEaFEmgWevnxcOD/qRyO2VGD8JEAfewexrIOoWpqzdvF
         1u2sA2EqBuhF8leqMv9F5WZ2jmuD8DDHAv5PA1LkfZduptihz9/RrK7D+3UwJ2Y9eo6Z
         HkS95RK/b4SBVsD2dLUr/LwEel5D7wdts/Q9FyBxigZ76Zyepg3BQmBU6fBmae6+cV7a
         PiYQ==
X-Gm-Message-State: APjAAAU5ko4ZfbaO9iz9N2R2DkAgxvxcUGuz507q/BicdaR+F7uVOQ+p
        eQv0WukQj1gxCqss2a9JoUsBsw==
X-Google-Smtp-Source: APXvYqzYQWYWNf5ijMzlNvQnGiClXZkVi04WghDqhwDQYKzd6NeApOL9QtUEQkEmhvej3QVDF3ZkNw==
X-Received: by 2002:a17:902:ac87:: with SMTP id h7mr6812117plr.36.1565156389577;
        Tue, 06 Aug 2019 22:39:49 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u7sm86070777pfm.96.2019.08.06.22.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 22:39:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 3/9] remoteproc: qcom: pas: Update IMEM PIL info on load
Date:   Tue,  6 Aug 2019 22:39:36 -0700
Message-Id: <20190807053942.9836-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807053942.9836-1-bjorn.andersson@linaro.org>
References: <20190807053942.9836-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the sysmon_name as identifier and store the relocated base address
and size of the memory region in the PIL reloation info structure in
IMEM.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/Kconfig         |  1 +
 drivers/remoteproc/qcom_q6v5_pas.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index b88d74632d39..2aa0743fc05b 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -136,6 +136,7 @@ config QCOM_Q6V5_PAS
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index db4b3c4bacd7..bfb622d36cb3 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -23,6 +23,7 @@
 #include <linux/soc/qcom/smem_state.h>
 
 #include "qcom_common.h"
+#include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
 #include "remoteproc_internal.h"
 
@@ -52,6 +53,7 @@ struct qcom_adsp {
 	int pas_id;
 	int crash_reason_smem;
 	bool has_aggre2_clk;
+	const char *info_name;
 
 	struct completion start_done;
 	struct completion stop_done;
@@ -70,11 +72,17 @@ struct qcom_adsp {
 static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	int ret;
 
-	return qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
-			     adsp->mem_region, adsp->mem_phys, adsp->mem_size,
-			     &adsp->mem_reloc);
+	ret = qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
+			    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
+			    &adsp->mem_reloc);
+	if (ret)
+		return ret;
 
+	qcom_pil_info_store(adsp->info_name, adsp->mem_reloc, adsp->mem_size);
+
+	return 0;
 }
 
 static int adsp_start(struct rproc *rproc)
@@ -278,6 +286,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->rproc = rproc;
 	adsp->pas_id = desc->pas_id;
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
+	adsp->info_name = desc->sysmon_name;
 	platform_set_drvdata(pdev, adsp);
 
 	ret = adsp_alloc_memory_region(adsp);
-- 
2.18.0

