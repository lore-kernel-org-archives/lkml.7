Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1B7C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1530D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B6RHNGrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfJHXpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:45:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36679 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfJHXpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:45:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so196919pgk.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6+fgv7o5Mc/zUQb4lUQ0sPjn9LWoOyx6TnpyyZahZg=;
        b=B6RHNGrOm07WuboIxNb1d1jtA7CxE+Hg4E/LLnretKo9zn+WzF/8/gnt7eHlHC7kuV
         a6O5MtzttqIam4d9/Sfwv7663+um+CwN1uJMQAk6inURP47Sw3biIBa5adylsqJrHD7k
         eAh0rhspz/fShqdgLZyVDhAKqUlBvWElg4vrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6+fgv7o5Mc/zUQb4lUQ0sPjn9LWoOyx6TnpyyZahZg=;
        b=FpwVG0mtNqfOcNToJL/pFBsXj6wXy4ubJMZBhubaD7rbvnH9i0puVhSIvobUvHEkNq
         9O1hPMdFoNzMrXZQ5kMggR/DICr6REx1MvlkqaLgdb8ogWJjEVCUugKCeJ9sY+IQLOLF
         AY5P9Lplu0Ub0VgKt/wKh9DAgjR2ZzALv1RaGS4a5vwwRB22YX6pSjXdWmSaDwGzVcX+
         bEAkBLM8gzxWTLLZThS/xGvr7CkoHaNwf/VL6DO9SO/BMxgw9NhfVCDUGr21glb2GKal
         isietZonC2uVIVHqDXlZ+9PWiOp7dXyaBfT5Iv0lgwp+iaRdXnhC+EQnUdDa689QtVIN
         bu5Q==
X-Gm-Message-State: APjAAAVqUK3WAgYVVYHT2rqnVlCJag9JDjsJYnZ0it6m57SZbH/PLTFS
        VYvCTzIbSJ0K5Q/d8IJYctBKyg==
X-Google-Smtp-Source: APXvYqyhBo3fTurEQKhDAY4F2lAq09MkB0eqZgCj9Vojx0DdkadMQ+Ue0N/CEyFcdaBCAoLbQXbrFA==
X-Received: by 2002:a63:eb08:: with SMTP id t8mr1120368pgh.49.1570578307734;
        Tue, 08 Oct 2019 16:45:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s202sm210671pfs.24.2019.10.08.16.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:45:07 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 1/2] soc: qcom: llcc: Name regmaps to avoid collisions
Date:   Tue,  8 Oct 2019 16:45:04 -0700
Message-Id: <20191008234505.222991-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191008234505.222991-1-swboyd@chromium.org>
References: <20191008234505.222991-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll end up with debugfs collisions if we don't give names to the
regmaps created by this driver. Change the name of the config before
registering it so we don't collide in debugfs.

Fixes: 7f9c136216c7 ("soc: qcom: Add broadcast base for Last Level Cache Controller (LLCC)")
Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/llcc-slice.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index 9090ea12eaf3..4a6111635f82 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -48,7 +48,7 @@
 
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
 
-static const struct regmap_config llcc_regmap_config = {
+static struct regmap_config llcc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -323,6 +323,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 
+	llcc_regmap_config.name = name;
 	return devm_regmap_init_mmio(&pdev->dev, base, &llcc_regmap_config);
 }
 
-- 
Sent by a computer through tubes

