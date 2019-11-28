Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655BC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF52B2178F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9hyxSMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK1Nsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:48:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41915 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1Nso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:48:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so31209891wrj.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hASZYFpvtuqMj2K9Ei/y6hgpj2q+o1mM77RhlWy+nlM=;
        b=i9hyxSMdXuLPXnJAJs9ZWGt2uHdPrIAytFfduuedVuEyINMo//Lzg5xsxzqpWPohGs
         NHBHrDvnfIsYCI3ppthFHJXFi8p6wrsMXd72bXnKBD2NQIjPv+qHrAoy1t4NYfiNfL3L
         LyPsENVFPLEZtpjWFHEJKMoiURSE6B3UbPSaxgoF3cSh8Ms2oprtqQuD+frRIX1pmQPC
         qEp+z6RftEsvK5EJ9nGb2TBP+VmuKU/PgV/Y/GyPqPdURFPde+H+ZPdaU/iCUpImxka9
         CmlCw60wSsu1WvpdpohBK1rfaFzDLjEFDz+iJLJe9/kap3+/7D2iIo9hQxdGUlzyei+C
         2ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hASZYFpvtuqMj2K9Ei/y6hgpj2q+o1mM77RhlWy+nlM=;
        b=uUGSkHk9+7rQevTbgi2ZKhZ9Gi1JmhjoaEchGuXlanTW4E+aKFAP1extXNXTKMPlxE
         ufGjg+O4OBx2rYbzNA2t6oabUkU+fT/gTzPmvktM5Oh8zORRAsvEwUlFhVxx72ld6xR1
         JAf4+DyHVMBoywSpN2eExUTKh0zdIj2AUHmIKf8qrXElzpl+a/AEvl+Mv7O3MvmsqFAP
         454y1nFFX2jJLQtqNwHnYihesasdXr0beurMZ7wzaOMoxX9MLwCj5TUmiPpW2fY3S2Ej
         Uom5jRgVm1qP2W2pK6Vh/Pf4yr+sY0cHi1Mb/4vs8ZO4l1TFUpEthdXA+iLWadGnNecD
         qxbw==
X-Gm-Message-State: APjAAAWsfDWIxS0i9smXlaR5lvONSY3pvEhi3Dao/mDkwvUWlWbuvfcc
        Wr9/Gw20tSE0GurlEge4/BqX3Y7eE6Q=
X-Google-Smtp-Source: APXvYqwUl/c9Ev2fwHT9rSRo/CPTNmXhORMjUF9rVGT2228iCfXD2eVVfpBiCL+T0UowPmk9L4UngA==
X-Received: by 2002:adf:f445:: with SMTP id f5mr26311139wrp.193.1574948920904;
        Thu, 28 Nov 2019 05:48:40 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m3sm8523734wrs.53.2019.11.28.05.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:48:40 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        agross@kernel.org, daidavid1@codeaurora.org, masneyb@onstation.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH 1/2] interconnect: Add a common standard aggregate function
Date:   Thu, 28 Nov 2019 15:48:38 +0200
Message-Id: <20191128134839.27606-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is one very standard aggregation method that is used by
several drivers. Let's add this as a common function, so that drivers
could just point to it, instead of copy/pasting code.

Suggested-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 10 ++++++++++
 include/linux/interconnect-provider.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 0e4852feb395..2633fd223875 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -221,6 +221,16 @@ static int apply_constraints(struct icc_path *path)
 	return ret;
 }
 
+int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_std_aggregate);
+
 /* of_icc_xlate_onecell() - Translate function using a single index.
  * @spec: OF phandle args to map into an interconnect node.
  * @data: private data (pointer to struct icc_onecell_data)
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 31440c921216..0c494534b4d3 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -92,6 +92,8 @@ struct icc_node {
 
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
+int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 struct icc_node *icc_node_create(int id);
 void icc_node_destroy(int id);
 int icc_link_create(struct icc_node *node, const int dst_id);
@@ -104,6 +106,12 @@ int icc_provider_del(struct icc_provider *provider);
 
 #else
 
+static inline int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	return -ENOTSUPP;
+}
+
 static inline struct icc_node *icc_node_create(int id)
 {
 	return ERR_PTR(-ENOTSUPP);
