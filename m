Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C705C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21EC2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywD5FOQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbfB1M23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:28:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40620 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbfB1M2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:28:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so21759729wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=z0Pv9W6V6xAvYLrMMAqJDtvisCVEQyxnavBeNRE47KI=;
        b=ywD5FOQqyHAsy5hEya0LE005z0b0ITcXsfVom/AHXpRCx/3zasTFfE5FHi1tiwBdm5
         OasMo9oTGyELYXBY87otuAIrCt9g+2VSTjtOO1lfOdXXSDsNbw7JwOp3syYhILOsi1I7
         Qu/yINJYHEKhHD1PZYGpUWUZ3abLBF6CEqOLtIhb/f50+2rKu0Oayhhj3tTiIefQYVrO
         wIOB3tKhlRYR0q4pTGta01gh6O5ISVrPcWYsGPoUHTLdxBpNh8PVABitcxlii2Mxr37m
         ehKPRTKVX8RhfWJ/YgeqrVh7f9SPpmHyLRBu0yKOzy9d+WCWVuBoa4nPSNr7Vifyp7Gt
         rk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=z0Pv9W6V6xAvYLrMMAqJDtvisCVEQyxnavBeNRE47KI=;
        b=K9T+24vzR/kiT2BdyWGRhGH/uUTEvrYH1norXB3BjuKSIAEciniIUN/pmF6UoF4cxj
         k8U3Ak8MedAUVcRuAQFE6fYCnkrvcKwCQMl0nmApttEf4f57ysdcTcUGMrkAWFhSORNu
         XtHqlcaCYB2sCRS01kzEv8ReXhlS5lnka1b6DmvRQ2Y55AQUTXnHZMVNjx/wm2BdpuYc
         qJ814PLAS9/L0SrXoHka0mxJz3RtCwW76ic43vK9Rpp4HN5vnkiehVOytJNKVYeLY23G
         vfHET04JdyA+J21JPhTIn9U7ppQNxSXP1VvHdvPyBAmEeDlir5Szd1uEB+XeQv5Xjc3/
         DsxA==
X-Gm-Message-State: APjAAAXVYXglOicciquUIbSI7w0dF8zBaxrN/qIofIJNdhFYn/oSfeEJ
        nkrqzGalGlzxXS9FZaXixxXTORltUIk=
X-Google-Smtp-Source: APXvYqyVEcnr+RS0VqL1Tr6nvEC8878k3vp8lZJN6DalyxCzkSHTJk8NELmMmzHTn0fmEOMjH/lrow==
X-Received: by 2002:adf:f845:: with SMTP id d5mr6588103wrq.113.1551356902264;
        Thu, 28 Feb 2019 04:28:22 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id u134sm4656970wmf.21.2019.02.28.04.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:28:21 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 24/24] drivers: thermal: tsens: Move calibration constants to header file
Date:   Thu, 28 Feb 2019 17:51:14 +0530
Message-Id: <0942161bb30c6eb9fb57cd480ac21a31f4ee0c68.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow calibration routines to correctly include the constants
from anywhere and allow more code sharing.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 5 -----
 drivers/thermal/qcom/tsens.h        | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 5db1aa441910..0fcfe6b30c55 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,11 +12,6 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define CAL_DEGC_PT1		30
-#define CAL_DEGC_PT2		120
-#define SLOPE_FACTOR		1000
-#define SLOPE_DEFAULT		3200
-
 char *qfprom_read(struct device *dev, const char *cname)
 {
 	struct nvmem_cell *cell;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 4a37da63afa2..88d1ccfbc019 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -9,6 +9,11 @@
 #define ONE_PT_CALIB		0x1
 #define ONE_PT_CALIB2		0x2
 #define TWO_PT_CALIB		0x3
+#define CAL_DEGC_PT1		30
+#define CAL_DEGC_PT2		120
+#define SLOPE_FACTOR		1000
+#define SLOPE_DEFAULT		3200
+
 
 #include <linux/thermal.h>
 #include <linux/regmap.h>
-- 
2.17.1

