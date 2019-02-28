Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7640FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60AD214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YND+ZKL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfB1MWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:22:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36438 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbfB1MWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:22:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so21746051wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TBXOh+qCZb1AbvhplyZXyYZ1SSUAH9q1meg8o/qp39A=;
        b=YND+ZKL1El4SaHUXtZf3iLiXMQQOmZ4ljgDODkfErUTUT3v9AfMIN6A3G91lJNOvmW
         2pIBfv/Y0GOHUt8Uv0w/pwZUF27yuJPXnkzXmQwp1NewwyY3KPNk3G030Ese5XZoNHdv
         I9uo5ZrZ8HOuHaW3loRqGy+uZhUH+Vkn1+5eMSJf3GyoYieMXWcoHX5t7EpidH/N7J13
         tLLuVcw4ZMFVFn3xph73TTGkTUt4JwG8dtg2IoyD9KJqMHzpAnZY9lnue6JbNCf/rlnA
         xmCloe1GwY1DyLhgspRrD7P69FnHJoVvic7EbkWZXcpG55tEGZIi1KVMVDlYwgd6dYCC
         SlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TBXOh+qCZb1AbvhplyZXyYZ1SSUAH9q1meg8o/qp39A=;
        b=Z3IG4LXLC68viTc05HD0VDPtUsJOwAk9UtzP3X00amDNgy2a/P+rd2KK8wQOrfsSMB
         GBxpruzqzBttVJpo1Yrt8LvOZhTLGVkF/X3KQyCRUdj6T1kYHAX+p8jbtjCbn4RjCPPc
         OwY3WbDA14eQeRqgVSASlblPkqSXMpTIThJJIyMoreBY/Xr8tLji8rn3BUknLtlF8R0Z
         oaN4CwgXCzQnrBFysI0Qb+isL/Or9T4H4UgMSeqSdLGJFzxqadm/sqgmsxegtQJ8W6cR
         AeKdB/eroAym796Eh7MweZohazXLHoFo+EGnbUVxtGRm6SFHTbeOfu5CXlKmTxJcI5HS
         XUCw==
X-Gm-Message-State: APjAAAUnE/a4qordTnsfyuEy8tIgxjo2cNAtJQTmOTFg5fnKF5pK6hIf
        AsL7tLx04Mx8Ox7uSqgLowFC2UPoeHg=
X-Google-Smtp-Source: APXvYqzsXsCC2MjkNXcy4XcaJHveE2M1gmxrA6N94Uern0KtT9hjoMvloRnD/QMHuuV82aOUmIMHNQ==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr6475622wrq.17.1551356528189;
        Thu, 28 Feb 2019 04:22:08 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id x74sm7618775wmf.22.2019.02.28.04.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:22:07 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 06/24] drivers: thermal: tsens: Function prototypes should have argument names
Date:   Thu, 28 Feb 2019 17:50:56 +0530
Message-Id: <d60e24ac848607a8bf2815fd5daf7379c280f39d.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_patch complains a lot as follows:

WARNING: function definition argument 'struct tsens_priv *' should also have an identifier name
+       int (*init)(struct tsens_priv *);

Fix it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 61ca2905ee7a..4d6a406f8dca 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -47,15 +47,15 @@ struct tsens_sensor {
  */
 struct tsens_ops {
 	/* mandatory callbacks */
-	int (*init)(struct tsens_priv *);
-	int (*calibrate)(struct tsens_priv *);
-	int (*get_temp)(struct tsens_priv *, int, int *);
+	int (*init)(struct tsens_priv *priv);
+	int (*calibrate)(struct tsens_priv *priv);
+	int (*get_temp)(struct tsens_priv *priv, int i, int *temp);
 	/* optional callbacks */
-	int (*enable)(struct tsens_priv *, int);
-	void (*disable)(struct tsens_priv *);
-	int (*suspend)(struct tsens_priv *);
-	int (*resume)(struct tsens_priv *);
-	int (*get_trend)(struct tsens_priv *, int, enum thermal_trend *);
+	int (*enable)(struct tsens_priv *priv, int i);
+	void (*disable)(struct tsens_priv *priv);
+	int (*suspend)(struct tsens_priv *priv);
+	int (*resume)(struct tsens_priv *priv);
+	int (*get_trend)(struct tsens_priv *priv, int i, enum thermal_trend *trend);
 };
 
 enum reg_list {
@@ -111,10 +111,10 @@ struct tsens_priv {
 	struct tsens_sensor		sensor[0];
 };
 
-char *qfprom_read(struct device *, const char *);
-void compute_intercept_slope(struct tsens_priv *, u32 *, u32 *, u32);
-int init_common(struct tsens_priv *);
-int get_temp_common(struct tsens_priv *, int, int *);
+char *qfprom_read(struct device *dev, const char *cname);
+void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
+int init_common(struct tsens_priv *priv);
+int get_temp_common(struct tsens_priv *priv, int i, int *temp);
 
 /* TSENS v1 targets */
 extern const struct tsens_plat_data data_8916, data_8974, data_8960;
-- 
2.17.1

