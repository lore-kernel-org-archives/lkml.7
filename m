Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75F5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA166207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8jqNvEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfI0HL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:11:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41294 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfI0HLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:11:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so702142plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JWJl6+k678lNhoIwgPT24JSdOgdcYLv3dPpKZNuhawQ=;
        b=e8jqNvEbhvr0kgtsFK625isW2I3jDhZSNomDeSga2oSYqTtT6RV+dW3pDm6Z3HXJ+9
         VwZc7ZzddAyp7VGQZ+t1szym8TCRuLxnvAT0WHpHyEZCyeekVFH/IFh3d9QbSVCzMEGW
         LTiZ1DuLVoVKGGC7tfWmtZc3H06WK4Fq36Dnt0ef98J49H8bvgehZ3rjL8hJuVE6F6Nh
         zA7Kj0j0nGE7B4kkI0By8EjHSSIp5pz9GqxNXTd2OKQbEQNO0XjYZ2Abcu2K2Ma1Mjf5
         fPo05WdTHPdOW4PC3PX+pawyJZq6F9nXCfhckU7KfbjS+u5Dg3A1+e//XI4nKGUYJn8L
         ZbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JWJl6+k678lNhoIwgPT24JSdOgdcYLv3dPpKZNuhawQ=;
        b=XH7PSA6k5ooPenyFRTVpy5aDMKkEp7jTSK02AJAILiUcCrQkh4yf3XILoJ4hE75zh8
         5UlDV05bIQpWyh/C8wqdGiiZg50cYVdcchxYI0zveDXMH/XiE8MYqmqMF4E/tp4R9pHi
         Bx1EhrpWjx3l/hnxIxQiUr1ONZ9HB7uAYR+gZNPLx+At3u0/EKwndKKiKzno2FvlQRVK
         M+XQfmmhMEPV+mefdhT61xiUMisgIMxIM/GfQpiQ3/IovECjUY+jpktkCct4Q9n5WCKv
         zZTMjfzV3DMvqRy3NGU2qcJmvmAweFeySzlwgdpg9rYFEdR/TRBzaeFpfRIsWc4eSUAH
         Jynw==
X-Gm-Message-State: APjAAAVGPkoagDxXtwv8SJrWI7Whv7QyDf/G+9oIGuTz9aRJ7l8dk48g
        lCYirPiVMccqHZpuLO1QwoiPGQ==
X-Google-Smtp-Source: APXvYqxdG3QqJXUbaky7WFyX4U95Cc00q0ixYEdLQ8wit0Qg1YQtygKQhRah3390SPIfZZk6fJeZ8w==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr3045391plp.0.1569568284057;
        Fri, 27 Sep 2019 00:11:24 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f74sm1733288pfa.34.2019.09.27.00.11.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 00:11:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] hwspinlock: sprd: Use devm_hwspin_lock_register() to register hwlock controller
Date:   Fri, 27 Sep 2019 15:10:47 +0800
Message-Id: <e8f1db04571f62298c7a4f72be803b9b9974d12d.1569567749.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569567749.git.baolin.wang@linaro.org>
References: <cover.1569567749.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1569567749.git.baolin.wang@linaro.org>
References: <cover.1569567749.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_hwspin_lock_register() to register the hwlock controller instead of
unregistering the hwlock controller explicitly when removing the device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/sprd_hwspinlock.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index e76c702..44d69db 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -135,8 +135,9 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sprd_hwlock);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = hwspin_lock_register(&sprd_hwlock->bank, &pdev->dev,
-				   &sprd_hwspinlock_ops, 0, SPRD_HWLOCKS_NUM);
+	ret = devm_hwspin_lock_register(&pdev->dev, &sprd_hwlock->bank,
+					&sprd_hwspinlock_ops, 0,
+					SPRD_HWLOCKS_NUM);
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
 		return ret;
@@ -147,9 +148,6 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 
 static int sprd_hwspinlock_remove(struct platform_device *pdev)
 {
-	struct sprd_hwspinlock_dev *sprd_hwlock = platform_get_drvdata(pdev);
-
-	hwspin_lock_unregister(&sprd_hwlock->bank);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
-- 
1.7.9.5

