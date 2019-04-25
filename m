Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A761BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B793B205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhdWvw2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfDYTzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46871 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbfDYTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so346731pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jtvY10kYu/UgXuic20owCvhI/8GuPQmjFeAnMENcPb8=;
        b=rhdWvw2WbI8ZwsgR9Ea2apCocBC3wDQ1cVKhXdexnzeN6Z+iKrfh7LE3/j40d4eiee
         TW+sKpplvu4XZtnIYooJkkk0Z6uQF3wB5LuIEZYY2Rbn998YaXwG1JXoNnJzMxiCRR2E
         VCLePDQHJEPx0fUO3LRMcO5XU12svsSixgpdgi7ZDdfvtXxUaAlKACO+Lk7gh9ETeIRl
         0vt35jTtZctGIUjr+qkzs/MGpP+8yfQyG+oT0UbtE7qZ13QHxbL07/8RrUCTLQWyifFl
         jYsXOJul+akM6ocN3RQKS+IRspcM9G8zzuKhJhd/tg6V7pMc8Pr2d2y3t64yWKV/d2fP
         D4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jtvY10kYu/UgXuic20owCvhI/8GuPQmjFeAnMENcPb8=;
        b=oCIbwcXt3mmu7TJ8cf36AfwBJi9cSsp1xGZOooajWHGXSfbJU0oxTjDQAlAO2T5AV+
         p9MCH9tvJ0X9MUis3lWKkIzh7h0rOMF4Dq8/gQNPFJykDrlgBUVLR2O1u0DrfiJwbMFT
         7Wyg/X9FW+CzJ2Q5nD9itzUUZNPLCszwbwsHTQ2ROTIt92ggo2GCkEwPsTktm+eCjgEG
         ERtiuJ5HPO2UdWmlzjspSag3U0KMHdn/sisrgmUg/fQVQQL80RHme6ePL0IVWKsnM/aA
         hibRZV2E2xRCDDSAImMfFH8MlupiI4NKmq3Bo1Ij2x/F4Ai6GrDXrAiOQ/12a1XN6lq0
         HI9A==
X-Gm-Message-State: APjAAAUJNtRSRxcOvrgzoSWVFJ3inRd6evI78HafLaEEKtLXnOL5ihgw
        Hsac01y3k5xrIMgkT2XhM7D9Sg==
X-Google-Smtp-Source: APXvYqylCdshzKzKT0G/5wy1Kpkd0MIIfGN4mXn5+tw1dm/rhT5T+jYy0XmZzTsnZt9ghrvcHabtfQ==
X-Received: by 2002:a63:115c:: with SMTP id 28mr39367291pgr.270.1556222007875;
        Thu, 25 Apr 2019 12:53:27 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:27 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/32] coresight: tmc: Cleanup power management
Date:   Thu, 25 Apr 2019 13:52:50 -0600
Message-Id: <20190425195310.31562-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Drop the power only if we were successful in probing the device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 647b6aa93554..c6a5462ebf27 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -432,8 +432,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
 	}
 
-	pm_runtime_put(&adev->dev);
-
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_tmc_groups;
@@ -476,6 +474,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	ret = misc_register(&drvdata->miscdev);
 	if (ret)
 		coresight_unregister(drvdata->csdev);
+	else
+		pm_runtime_put(&adev->dev);
 out:
 	return ret;
 }
-- 
2.17.1

