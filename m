Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9104FC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBEA205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DnXhnAXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbfDYTxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34124 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbfDYTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so380343pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5yAsUfu+K0x94KW8zQO1OsJicC/LEblGvw0y+dUj4Gg=;
        b=DnXhnAXbcovRu+0CGBkzzuPQh8eObKGQ/MdhX2PDaWFiTCyXJWeNBG4RJ8AzlgTaxr
         h7iAWDzE4abnil4zP6q3qsL0JqrtQ3J6pB7x8t0yRGQ677PO7czUL1Hdi3AmgK2jJM0D
         wtQLCvSnbU9A2DTxkt8Wymt8JQnInZvkgEP1Jqp9Lw9mLwUZ4idXPF9jIv70oildctTV
         uu1AbSPFKpNZYwN0Xt+1NZw+TLuR2ko9q3RI26Gw+d4vVPfzH1Ku6kXVpiR7yRw5C6+y
         v1/c40qGLX0ynv+tKaWspUoOKa1wuYOiPN/c9A/AickIMqAGpAdHj+ot/hUH7TRM/7PQ
         S1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5yAsUfu+K0x94KW8zQO1OsJicC/LEblGvw0y+dUj4Gg=;
        b=W1zNeCn/3Z9Q7cTHIXY9GAMWNrKcgdWPBEm/ruYZTJ4q738x1UHz8O2Srlfvdioaip
         69t52V2HwEEm45gmCaCXs+ywoqC5pjHMqTiVndmbBGMaNXRITWWTgCUbNhBBKfsXX5cH
         EBnvOjVj8l53ED0v4YsTm7xLPBJvlIIKJ9xTnMPRWP56gv2/2zIay5f9CYgReTjeYt2j
         nO+cA8aiwCJ4tJeb0GJehxiK/E1yQ2AT57Dz2Kai4CrgTdoOqGUr33hkndDONsWymIj8
         1ekD0tJ2Ou5CkTox+O2BCBd19D/+Dbhw/C+eSot0d6GL1oPffE2N+FgXKYjvFGeCQ4FC
         IDoQ==
X-Gm-Message-State: APjAAAWH612+J8DgumuDvtDkoSxCY6L2oYOR6vKXg7NENfn0CovEnJ1E
        bWZlqKaTZEHFfUCTUdaCKbhLPQ==
X-Google-Smtp-Source: APXvYqy0EX7NgV8ZEp32grjm36176gJY5Vj8hfOnO0CH5KHKkmA5akwNuvdPZ7K7fS3Sk4fsftT9Hw==
X-Received: by 2002:a63:5715:: with SMTP id l21mr11462755pgb.279.1556221997713;
        Thu, 25 Apr 2019 12:53:17 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/32] coresight: dynamic-replicator: Clean up error handling
Date:   Thu, 25 Apr 2019 13:52:42 -0600
Message-Id: <20190425195310.31562-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We fail to disable the clock in case of a failure during the
probe. Clean this up. Also, we are supposed to drop the pm reference
only when the probing is successful.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-dynamic-replicator.c  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 299667b887fc..fe176b987685 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -150,7 +150,7 @@ static const struct attribute_group *replicator_groups[] = {
 
 static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	int ret;
+	int ret = 0;
 	struct device *dev = &adev->dev;
 	struct resource *res = &adev->res;
 	struct coresight_platform_data *pdata = NULL;
@@ -180,12 +180,13 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Validity for the resource is already checked by the AMBA core */
 	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto out_disable_clk;
+	}
 
 	drvdata->base = base;
 	dev_set_drvdata(dev, drvdata);
-	pm_runtime_put(&adev->dev);
 
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
@@ -195,11 +196,18 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.groups = replicator_groups;
 	drvdata->csdev = coresight_register(&desc);
 
-	if (!IS_ERR(drvdata->csdev)) {
-		replicator_reset(drvdata);
-		return 0;
+	if (IS_ERR(drvdata->csdev)) {
+		ret = PTR_ERR(drvdata->csdev);
+		goto out_disable_clk;
 	}
-	return PTR_ERR(drvdata->csdev);
+
+	replicator_reset(drvdata);
+	pm_runtime_put(&adev->dev);
+
+out_disable_clk:
+	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
+		clk_disable_unprepare(drvdata->atclk);
+	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
2.17.1

