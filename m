Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A803C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF9C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHv5/3Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfB1MYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:24:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38449 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfB1MYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:24:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id g12so9653737wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=s/+Bl7ZGzK0cL5xDzP2iXR4sdWkOPpcYJr4QjVnhB2E=;
        b=FHv5/3QsYZsBwUeIBgPR5t5jkcQPpkYT+0oAjA7sbdOf4GNbAOAXyYZaek77Q/BZGG
         LSxBO4H40P62B2pFtiUD+8j6gk3Sx34QrrVN97TdKxBOSY/AIEMElPDoguGzfKhXJ2P4
         vVaH4hWmMpTdfW4dRlm+augjxfvQDhyoLLoT34K6NUkIdZF5f+qC8li/NDl7q6zORycZ
         t2/7KRKNLG/ZpBG6aPazAXpLWTwe64YeuwzJWmqW03jMeWJqWf2Ql2o6XdU32sNxwZ+2
         SBOvSz9CTpT9AamQgVf3+/RHljoufsLmDSbMattOmjLqxl+cYXPWz6tye1zkGcFz+8Nf
         cKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=s/+Bl7ZGzK0cL5xDzP2iXR4sdWkOPpcYJr4QjVnhB2E=;
        b=uVAgcaIVCFUfR7A/uI0Jchva+t5XT91SpxEUS9HzfdpJqBs6m8FUNdyJSDe+1Okrm+
         LzveRh8kwuNurABNoY0tVFVw4OjPvcZu+ldXAfAkbcwcsYH5o9DN0J3cMRElBTkR6scM
         RjlcoTOKts1aw8PwWyuUQ0v++MHmVwaBrvZdTNyP86jCzxxsXayxZP+SlurbUpkvLZJP
         uYhUwdv9QPPx3PPOHmQOIwPvkWdI7G7guCiCipjy9cMdk4O2uSNARDuzkfPCpg2NLl8o
         iwpK1VBy30U6eFEHIeA/D26BnqlrUprctRZ9HUjjVaXz91vWMRGnblvJTI6FHUHHTyd7
         8JvA==
X-Gm-Message-State: APjAAAXsPZlpG0linASH+U0NeLmN9/k4I40/d5DttxlzjLv7nWPpfvmG
        cpJYaVLLQy/rQdzE5LBGGCtr9T35B8Q=
X-Google-Smtp-Source: APXvYqzpqMkLlD2rVswHgBOHdBfKRUTOhVmVhAzPhlrJSTwW/6scoLaBlrvjJKPHmfqVZD8uX3zpxw==
X-Received: by 2002:adf:df0d:: with SMTP id y13mr5951104wrl.69.1551356670903;
        Thu, 28 Feb 2019 04:24:30 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id s3sm24901915wrt.81.2019.02.28.04.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:24:30 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 08/24] drivers: thermal: tsens: Rename constants to prepare to merge with tsens-8974
Date:   Thu, 28 Feb 2019 17:50:58 +0530
Message-Id: <eef3bfed4bd8e9b73e5c448c85c2cb71e3d7b9ea.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
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

