Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC8C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC35222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9cyjOZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJDXbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:31:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35907 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDXbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:31:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so4616798pgk.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/e8EWlo6oLC7kCwtiuv+KxxSwajNXvXX9ykyyY6BXQ=;
        b=A9cyjOZfmGNJRtBUCkiBi2TuxwF55Q/M0+hqtI34DENevjHtgY9umyIm7u36Iz0j+g
         Lkd4Ob68hSOl0uzuZTbsgLxNwwwb9nHDqlVVzndUFWVcTvi2G8I0/p/YuMAcd79CNQWO
         5SkxAMqekumVhVpWVAADypyDFqRazJQxzofpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/e8EWlo6oLC7kCwtiuv+KxxSwajNXvXX9ykyyY6BXQ=;
        b=m8ACbB5FdBQg7SzgExs/Hmcf7UsKiCTWLEsXf4SIznAfpFcIvwJlxBiRAKXu1qE+r6
         mLf6wBjGrb9DcmiXwF9Z50tJQgZ+tqc2hBUQoIxvUQ1TuAigtK6orICYWm4IxNhXrptP
         pilfXsdf8TtT+UfpBF/JXpT5BhvFw/Yrff78+QvEE3nDdfFXLihNdmt7BNED4qU5vGB5
         CGr8rfYbHLWUJkGIseshUwaNIeA6OH9fBjcctiAePTHa3KyiOkzlt66TunhiIBDJ8Efy
         tM4MJBF3tbNMfE6clN2IoPDpZZr+NuKJsC2MjMl8zt2EuW7HCWdFSe3CW/Rd43beKbns
         pE9Q==
X-Gm-Message-State: APjAAAVUlvjjxJuZbSH46sANWO9VqLrgu8HXqS0r9B1/ElNnLqqE05zy
        4p41LBDxbwBE/Wz9UB/Z/xmcdA==
X-Google-Smtp-Source: APXvYqy8JT/xvn3Mcha8YwAHzxwblBG3zVfUPB4cSLKRJxVmOvfKOSrnLLhHkWqixsEGTNN59npHyA==
X-Received: by 2002:a17:90a:8b8c:: with SMTP id z12mr20065560pjn.100.1570231894192;
        Fri, 04 Oct 2019 16:31:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g24sm7893668pfi.81.2019.10.04.16.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:31:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH] soc: qcom: llcc: Name regmaps to avoid collisions
Date:   Fri,  4 Oct 2019 16:31:32 -0700
Message-Id: <20191004233132.194336-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll end up with debugfs collisions if we don't give names to the
regmaps created inside this driver. Copy the template config over into
this function and give the regmap the same name as the resource name.

Fixes: 7f9c136216c7 ("soc: qcom: Add broadcast base for Last Level Cache Controller (LLCC)")
Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/llcc-slice.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index 9090ea12eaf3..aa342938c403 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -48,13 +48,6 @@
 
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
 
-static const struct regmap_config llcc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.fast_io = true,
-};
-
 /**
  * llcc_slice_getd - get llcc slice descriptor
  * @uid: usecase_id for the client
@@ -314,6 +307,12 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
 {
 	struct resource *res;
 	void __iomem *base;
+	static struct regmap_config llcc_regmap_config = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+		.fast_io = true,
+	};
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
 	if (!res)
@@ -323,6 +322,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 
+	llcc_regmap_config.name = name;
 	return devm_regmap_init_mmio(&pdev->dev, base, &llcc_regmap_config);
 }
 
-- 
Sent by a computer through tubes

