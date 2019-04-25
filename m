Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE06C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC95206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wp3ppGlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbfDYTzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41304 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbfDYTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so430000pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4WlHnFG5egtduagk/Bt1xYutlfv3Ip/YBn9x1XM4EU=;
        b=Wp3ppGlGiFVO1Vn9eXRcx8g5nX2CdbRPP1OODDgBj1aA9gkpvgu5BF7wRkz0LK/HgM
         1/YBfJTtGSU6YiZpXXMCiqNdn78hPT79tA70DCpP3P3L/xsaySxL688Sn7n0IQsm36f+
         ghAbYg329ozozMR1jhqJVasLZgVipC29M97EvTRcPXA9juKwq01mj9yPgyHGa33O+HWS
         hk9niM8eb+xtSvwC9rBIKMOn8G6M2o8sjePEfElDpC/f0K+Lk1Gdkvy4CHvEoWQ2jjQ+
         9y/rS2olswu8UoKHXeIqfuqx57AsvKZwV0OJXdGbeYo//7bYz6RrSaLyK6qi8ViZGxgc
         jM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4WlHnFG5egtduagk/Bt1xYutlfv3Ip/YBn9x1XM4EU=;
        b=sYC/4Qi2a/0U54wHhS/eQWPmXkfLedSyYZ+Wedapzk/pYUB1IRKOySVFwsG09TWbt+
         divWQaXDKXXkVm9kxnkO3JWscfNGnYlcB0lX2PWDOdwMwSd72gr9vRAELMkaTwUDWOz4
         SeoqeBFOfj8ZS4vPHpgPnV4XBqjbm8ekuJ4w//Gmzm3XUEh2MkQF06JrPkqi8tEJbohu
         7JVae3oF896LEH/HdkEzdo87ZemzbVvyBjri2WPaTI+ABsp5FFMfdG1Ltw+H93fF/QYN
         DVbEN5WQi/NzaxrBdvYclzDbLGtZaxZ6amOiNoUFnjyGSz8xOQqUGuqT4yzJofxkDfVF
         6XWg==
X-Gm-Message-State: APjAAAXL3ouhMsPIZ22aBRhO4mVwljbVrant69FHkIwUGd0s1nQzWPmo
        TH4BDuYu6P1OSCKVzNjQd5Utsw6eLbk=
X-Google-Smtp-Source: APXvYqzCXxSNX6agw2C1AlK6FYMDJQqNMTrYTX3FZ6en+0eL+1vypGX3Kldy/P04Ern3+PsT8IVvqA==
X-Received: by 2002:aa7:8208:: with SMTP id k8mr8119903pfi.69.1556222004179;
        Thu, 25 Apr 2019 12:53:24 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:23 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/32] coresight: etb10: Cleanup power management
Date:   Thu, 25 Apr 2019 13:52:47 -0600
Message-Id: <20190425195310.31562-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We drop the power before we complete the probe successfully. We
are supposed to drop it only when we are successful. Also, probing
the etb_buffer_length happens with the power turned up. So we don't
need to do that again in the helper.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 105782ea64c7..13c0a601d3be 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -93,17 +93,9 @@ struct etb_drvdata {
 static int etb_set_buffer(struct coresight_device *csdev,
 			  struct perf_output_handle *handle);
 
-static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
+static inline unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
 {
-	u32 depth = 0;
-
-	pm_runtime_get_sync(drvdata->dev);
-
-	/* RO registers don't need locking */
-	depth = readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
-
-	pm_runtime_put(drvdata->dev);
-	return depth;
+	return readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
 }
 
 static void __etb_enable_hw(struct etb_drvdata *drvdata)
@@ -720,7 +712,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	spin_lock_init(&drvdata->spinlock);
 
 	drvdata->buffer_depth = etb_get_buffer_depth(drvdata);
-	pm_runtime_put(&adev->dev);
 
 	if (drvdata->buffer_depth & 0x80000000)
 		return -EINVAL;
@@ -747,6 +738,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto err_misc_register;
 
+	pm_runtime_put(&adev->dev);
 	return 0;
 
 err_misc_register:
-- 
2.17.1

