Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4615C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3BF2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9S59dYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfCTNTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37551 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfCTNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so1932870pfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=s/+Bl7ZGzK0cL5xDzP2iXR4sdWkOPpcYJr4QjVnhB2E=;
        b=b9S59dYTFY3WccOujlrOlQhCiFsoEOIbyiHxVdBpJxeap37XgzNDGATF3GRbLzzwo9
         +vDVTBBlbkPwvJjrD3YwLLakl082XP8sfOZ80/DtuO3cHdTZoojom1KHH3+uuXu29BBS
         2qFE1fsnmgkyaagnGQY9KagPpi5VtIWTQCqlt/E9Y4Uh0XLRFM1Pzr4bmTT8lI3AFH1k
         HEU9Chjhj53c1eTNnJUaRALmBkVeHjCpWJuKEPWSZ9YxEWiS0xJw9w0MfmWSa1G5QWEa
         UPFbEeFqq5NWZDGKcZZNCmjnZOIwbZRYHMwyK4Jycs5Yg0TRx0p+OhGjC1juCPhyWYiV
         DtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=s/+Bl7ZGzK0cL5xDzP2iXR4sdWkOPpcYJr4QjVnhB2E=;
        b=rXkK5sBaGhJw5+zzlssHXqL3z5bNkp/BAB3ZPlEdu6INLYpARQpD7iXJM7DMlnfn4V
         fprJyWLlae5Ba0oT4lxYXNrET6NgiStgWvq8WQAbtT5tgHmWT017UHprLqZ9hJP1eKbY
         xhBVkEsEms7Zle2SXbZSH5q93WMz9O5qTu9yew5O8ASlJVMSZJm1a9JaCSBEoieOCTuJ
         f0K2glkVsZSX+AHZCg5BDM1OjLqH49+PCs6VuW84mO2vxrIyZEHDFrgPhbGPIq36WpIR
         cAotJXC4f7pBOV03sKk87WE7jNpDAK8oLwPwFNFcSWxo+orik9brIRNncXARgGgPzNBY
         IPPQ==
X-Gm-Message-State: APjAAAWiy5qN76v81l3kGHSHzgcLt4Cw1tzYI1fVP/VivXofTy7oVfdU
        CKHsvnoV/6V3+24E3pRPImCrTPj1VPQ=
X-Google-Smtp-Source: APXvYqyEVb/h/lmL7667GXipAjIJty+zggDQ1gVHiGx/Y5mqTrWLQ33kXpqx9tE7J/ZI5b+tGfbZ1Q==
X-Received: by 2002:a63:6e02:: with SMTP id j2mr7397195pgc.229.1553087939194;
        Wed, 20 Mar 2019 06:18:59 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id b15sm7370229pfj.167.2019.03.20.06.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:18:58 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 08/23] drivers: thermal: tsens: Rename constants to prepare to merge with tsens-8974
Date:   Wed, 20 Mar 2019 18:47:48 +0530
Message-Id: <934cc97c81ebe8e5f19eb99ce5b37debcc15f585.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some #defines in tsens-v_0_1.c clash with those in tsens-8974.c. Prefix
them with 8916 to avoid the clash so we can merge the two files.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 88 +++++++++++++++----------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index d4ad4082c800..30909594b1cf 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -7,37 +7,37 @@
 #include "tsens.h"
 
 /* eeprom layout data for 8916 */
-#define BASE0_MASK	0x0000007f
-#define BASE1_MASK	0xfe000000
-#define BASE0_SHIFT	0
-#define BASE1_SHIFT	25
-
-#define S0_P1_MASK	0x00000f80
-#define S1_P1_MASK	0x003e0000
-#define S2_P1_MASK	0xf8000000
-#define S3_P1_MASK	0x000003e0
-#define S4_P1_MASK	0x000f8000
-
-#define S0_P2_MASK	0x0001f000
-#define S1_P2_MASK	0x07c00000
-#define S2_P2_MASK	0x0000001f
-#define S3_P2_MASK	0x00007c00
-#define S4_P2_MASK	0x01f00000
-
-#define S0_P1_SHIFT	7
-#define S1_P1_SHIFT	17
-#define S2_P1_SHIFT	27
-#define S3_P1_SHIFT	5
-#define S4_P1_SHIFT	15
-
-#define S0_P2_SHIFT	12
-#define S1_P2_SHIFT	22
-#define S2_P2_SHIFT	0
-#define S3_P2_SHIFT	10
-#define S4_P2_SHIFT	20
-
-#define CAL_SEL_MASK	0xe0000000
-#define CAL_SEL_SHIFT	29
+#define MSM8916_BASE0_MASK	0x0000007f
+#define MSM8916_BASE1_MASK	0xfe000000
+#define MSM8916_BASE0_SHIFT	0
+#define MSM8916_BASE1_SHIFT	25
+
+#define MSM8916_S0_P1_MASK	0x00000f80
+#define MSM8916_S1_P1_MASK	0x003e0000
+#define MSM8916_S2_P1_MASK	0xf8000000
+#define MSM8916_S3_P1_MASK	0x000003e0
+#define MSM8916_S4_P1_MASK	0x000f8000
+
+#define MSM8916_S0_P2_MASK	0x0001f000
+#define MSM8916_S1_P2_MASK	0x07c00000
+#define MSM8916_S2_P2_MASK	0x0000001f
+#define MSM8916_S3_P2_MASK	0x00007c00
+#define MSM8916_S4_P2_MASK	0x01f00000
+
+#define MSM8916_S0_P1_SHIFT	7
+#define MSM8916_S1_P1_SHIFT	17
+#define MSM8916_S2_P1_SHIFT	27
+#define MSM8916_S3_P1_SHIFT	5
+#define MSM8916_S4_P1_SHIFT	15
+
+#define MSM8916_S0_P2_SHIFT	12
+#define MSM8916_S1_P2_SHIFT	22
+#define MSM8916_S2_P2_SHIFT	0
+#define MSM8916_S3_P2_SHIFT	10
+#define MSM8916_S4_P2_SHIFT	20
+
+#define MSM8916_CAL_SEL_MASK	0xe0000000
+#define MSM8916_CAL_SEL_SHIFT	29
 
 static int calibrate_8916(struct tsens_priv *priv)
 {
@@ -54,27 +54,27 @@ static int calibrate_8916(struct tsens_priv *priv)
 	if (IS_ERR(qfprom_csel))
 		return PTR_ERR(qfprom_csel);
 
-	mode = (qfprom_csel[0] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
+	mode = (qfprom_csel[0] & MSM8916_CAL_SEL_MASK) >> MSM8916_CAL_SEL_SHIFT;
 	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
 
 	switch (mode) {
 	case TWO_PT_CALIB:
-		base1 = (qfprom_cdata[1] & BASE1_MASK) >> BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & S2_P2_MASK) >> S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
+		base1 = (qfprom_cdata[1] & MSM8916_BASE1_MASK) >> MSM8916_BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & MSM8916_S0_P2_MASK) >> MSM8916_S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & MSM8916_S1_P2_MASK) >> MSM8916_S1_P2_SHIFT;
+		p2[2] = (qfprom_cdata[1] & MSM8916_S2_P2_MASK) >> MSM8916_S2_P2_SHIFT;
+		p2[3] = (qfprom_cdata[1] & MSM8916_S3_P2_MASK) >> MSM8916_S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[1] & MSM8916_S4_P2_MASK) >> MSM8916_S4_P2_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = ((base1 + p2[i]) << 3);
 		/* Fall through */
 	case ONE_PT_CALIB2:
-		base0 = (qfprom_cdata[0] & BASE0_MASK);
-		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
+		base0 = (qfprom_cdata[0] & MSM8916_BASE0_MASK);
+		p1[0] = (qfprom_cdata[0] & MSM8916_S0_P1_MASK) >> MSM8916_S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & MSM8916_S1_P1_MASK) >> MSM8916_S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[0] & MSM8916_S2_P1_MASK) >> MSM8916_S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & MSM8916_S3_P1_MASK) >> MSM8916_S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[1] & MSM8916_S4_P1_MASK) >> MSM8916_S4_P1_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p1[i] = (((base0) + p1[i]) << 3);
 		break;
-- 
2.17.1

