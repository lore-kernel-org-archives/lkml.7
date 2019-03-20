Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2AFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7F62184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dukqm7Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfCTNSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:18:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36002 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfCTNSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:18:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so1805706pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TBXOh+qCZb1AbvhplyZXyYZ1SSUAH9q1meg8o/qp39A=;
        b=Dukqm7YyVqigrw6lDqctSEhs4I4uOFNaCkyh650aKW4VErIT6IyYo4JdyCOTAZzVqx
         Begg9lvVg1Qp04MW6PF/khuDMDyIVVn+C1xpRe9yUGH2dccr4FPap0UnHzDVTdtjOjxN
         RzRSwyDTYkb6wBiqGI+ubu3tWOeu9aSTHHfWwoLU4n6ZXBtMJm0CJtAaJ/O51673lv8S
         WMk2DYft4uGNl1H1TnWjxKEwATy8RrRfFn7AKYfOpQZopuABM8/tyjep1hZ5gBuz4PqP
         +Gw7Bl3OdyWOMsGxYQyq1tsdH1Xncp7n9lVeQRn5WnoMjGUqu+6BEEyUfqIokqh1WCc/
         jX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TBXOh+qCZb1AbvhplyZXyYZ1SSUAH9q1meg8o/qp39A=;
        b=Y7MqASJa4ZceSGBEtI8R+Vb9lCYvDrB9RlTRn7LZcOyB/sW8CGokwQIHHIC2Sf3ezt
         JJwRaOFfmfWgFMmz5nXl7ob0w0EjAewSdTJCSc/bT/Sg/FZSHx5jC7B5hplaFNRkGRYU
         LvO0DoATcbTZWq/fJRoxguSfIf/qQY65aOvUCNutsl71yVaLw7sqXjYSpDx2P630zCcE
         Zp20jGpjMDqctSLDvj7YkZVRZj5uNMopm4R6bGlJbsRli6E4E6qCuXPfDmcRegOkHEES
         nffTv6ZpFml4GSj2b8gQBmZlfWMLFRWGdo68+8JBop3r30pT0XhyavclGWPAb/MBqI/l
         3Qcw==
X-Gm-Message-State: APjAAAWjezXSjIL71F2/iCWBaoyNECdwRMJCP3J61xVtDN3twD9g65QU
        2zN0WJDD5/4YAAYoM/f/550Hjk6Zok4=
X-Google-Smtp-Source: APXvYqy7nez153SYADd3MZBc+TbCbOkMEU3qZ4JJ9PxLVlIEUP8rdhvr96Ztjrg3gW8UXgiI0R1QoQ==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr7242489pgl.16.1553087927781;
        Wed, 20 Mar 2019 06:18:47 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id n65sm6654476pfb.160.2019.03.20.06.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:18:46 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 06/23] drivers: thermal: tsens: Function prototypes should have argument names
Date:   Wed, 20 Mar 2019 18:47:46 +0530
Message-Id: <5789c6cda462269f443dfe05a561c098bd81c7ea.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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

