Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C482C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395E0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjyiAvWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfDWN2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:28:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42903 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfDWN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:28:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id x13so3149763ljd.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmzrLG0HhMUllGPErHueXstJu/wyUlmgrIkCuicVsiY=;
        b=pjyiAvWpRnfInL1U8vVm5G28PPwIa7vHVRINhbLFwD7Hh8RLqG1XBvcg6uhiz5Q7I/
         oDN/v1CW3tmWtHRBfdLsTUhN3j1Ez8EdsbehRXTSLKgBkdXvWs6FxQ/neadA2MdMxyCv
         /T86u/ZwKidHvmiwKNAiXKqlT6ADVxSxocN6dT4P477jUUBupKtT35G3+nr8vkHzgvWd
         +6GveAO2cO7rhe58ZHp0+Kgisl4ilC3MIdSjLoHz7+E1PvM3J4aYUIFnfv5nb5ygA7N5
         5dlcgCZuU9fe0qw3ewVCgh0ZKTnuzxJOcl7hkfXbZa6WVywG4g0j32gsnzFs0ERahaVm
         My7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmzrLG0HhMUllGPErHueXstJu/wyUlmgrIkCuicVsiY=;
        b=ntauXEil469D0Wr+iRhXRPKlFPbJS6wGug4wGUK0dZT/Pw+29sR8mbaZG/QWXQMLmR
         ojydGNPqMiHkIMRsI2aT7fTwGUEimpMDRer+3wGjHvuozAYbjMpBRdYcckWlGdm81J5f
         8rZduKBtW2A3GcX7IN3F/hgJ4a6vXMQx5izqsVyXorI9kwYDuH+5Ej9p1dkXf1r8/OPO
         qKbZtHUx7JRO9SDI7g0LuilOUfrWFwYJafK232N01iFzPQ6owkxwRqmvo0Qo7Ml/ZPEs
         HbEypiMkSCb1Qxbc+ecEJqxyjX9ik74jEiA6n30au1IsJhIJNugptdmuqjXrD/EuNpx7
         7iLQ==
X-Gm-Message-State: APjAAAW11iG+iZ439BipnSG3yrbXcXje7ft4gm9YJHlGiJBj59lsjalm
        YUwPDChJUUQs6Qc8f6ivythodw==
X-Google-Smtp-Source: APXvYqxYn5AHIWe8NubgPi748hbhffjSbR78lCUgeNHQmIJgIs0nNxYDkCygfXs7mEYHaYNwQVCsrQ==
X-Received: by 2002:a2e:500d:: with SMTP id e13mr13748245ljb.169.1556026110607;
        Tue, 23 Apr 2019 06:28:30 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y206sm4617107lfc.72.2019.04.23.06.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:28:29 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 2/5] interconnect: Add of_icc_get_by_index() helper function
Date:   Tue, 23 Apr 2019 16:28:20 +0300
Message-Id: <20190423132823.7915-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423132823.7915-1-georgi.djakov@linaro.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same as the traditional of_icc_get() function, but the
difference is that it takes index as an argument, instead of name.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c  | 45 ++++++++++++++++++++++++++++--------
 include/linux/interconnect.h |  6 +++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 871eb4bc4efc..a7c3c262c974 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -295,9 +295,9 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 }
 
 /**
- * of_icc_get() - get a path handle from a DT node based on name
+ * of_icc_get_by_index() - get a path handle from a DT node based on index
  * @dev: device pointer for the consumer device
- * @name: interconnect path name
+ * @idx: interconnect path index
  *
  * This function will search for a path between two endpoints and return an
  * icc_path handle on success. Use icc_put() to release constraints when they
@@ -309,13 +309,12 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
  * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
  * when the API is disabled or the "interconnects" DT property is missing.
  */
-struct icc_path *of_icc_get(struct device *dev, const char *name)
+struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 {
 	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
 	struct icc_node *src_node, *dst_node;
 	struct device_node *np = NULL;
 	struct of_phandle_args src_args, dst_args;
-	int idx = 0;
 	int ret;
 
 	if (!dev || !dev->of_node)
@@ -335,12 +334,6 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 	 * lets support only global ids and extend this in the future if needed
 	 * without breaking DT compatibility.
 	 */
-	if (name) {
-		idx = of_property_match_string(np, "interconnect-names", name);
-		if (idx < 0)
-			return ERR_PTR(idx);
-	}
-
 	ret = of_parse_phandle_with_args(np, "interconnects",
 					 "#interconnect-cells", idx * 2,
 					 &src_args);
@@ -383,6 +376,38 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 
 	return path;
 }
+
+/**
+ * of_icc_get() - get a path handle from a DT node based on name
+ * @dev: device pointer for the consumer device
+ * @name: interconnect path name
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release constraints when they
+ * are not needed anymore.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically,
+ * but they don't have to.
+ *
+ * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
+struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	int idx = 0;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	if (name) {
+		idx = of_property_match_string(dev->of_node,
+					       "interconnect-names", name);
+		if (idx < 0)
+			return ERR_PTR(idx);
+	}
+
+	return of_icc_get_by_index(dev, idx);
+}
 EXPORT_SYMBOL_GPL(of_icc_get);
 
 /**
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index dc25864755ba..0e430b3b6519 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -28,6 +28,7 @@ struct device;
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
+struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -45,6 +46,11 @@ static inline struct icc_path *of_icc_get(struct device *dev,
 	return NULL;
 }
 
+struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }
