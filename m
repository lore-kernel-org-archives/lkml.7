Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9281BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650E3206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEVEszU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfLDJyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:54:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34706 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfLDJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:54:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so3140470pgf.1;
        Wed, 04 Dec 2019 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aTQ2WmgfLL0RKpED5qehF/7+sveySkG+bgQJgoV8etc=;
        b=gEVEszU2rEO5LtTSee+SJLa3xwahRpVX4g6r+WflHC3GAFzlRrmEM9Q1ZDYtBB00Fp
         YFoDyVLMsRLp1zs30FyWG+R7Spwx9P8aLkS22Bxn8YgE2vmWnrzBRX6ONYFXdiXtQrNW
         kq6AcXEpC1cejcu75sVx5iMahZ4S7ofWBJ5sYLFES59HA4ieJetY3argbcBJbiaVTGK8
         kwpOQlj0e9y9/wwmANAEHPjVm3vXD1vhOxZpo321ZCkVRObxd3NK/G1aoOH7TN/ow8lp
         FkJvGs0SWJlRPMEmM9iV4fpg58wv96RGZr1XYi1Rb32RWPxDa0oVQ7g6fyKKajVq2x7H
         tTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aTQ2WmgfLL0RKpED5qehF/7+sveySkG+bgQJgoV8etc=;
        b=YoGd2vrcbNLbXnC9Oz0FHo44vknHYe635Clu8DRX1vxH5AHpw7zc15rBkCiiRC4bXe
         XLgw/JHXr6Tx13QG1/5F0xzNO/ErlqpTTNZQFpsbDoZS04lFEG6KpBd4gfEoZP5nAeXY
         oAtYFtDlF/4DftBaRnYzOxug/YTM6NN0KZ9F6HIlKsVW1pSpeKuJf+mEs2N4kUNr6+Fx
         n5+n4vurFYdeycMWDnYlpsX024xSuALFHo2V1mh4N8T41h9VBuqgWpJyEgHMMC3uquL7
         EVqm1q+el+q28NgqwvcjJYffJ5IZkhk43hPeEIW5KVVqAychC7RDeU9xXJ/oETwyctjQ
         yifg==
X-Gm-Message-State: APjAAAVZQmK9lc5OLI74Je3aQJWZi4bltZHC50+cITwOsG63J7P+NgEg
        azb6g3VWXsfLA0pOlVsJsmc=
X-Google-Smtp-Source: APXvYqxl5TYVfNvBXy/dz9DmCKkQnMlInal4tLsT88gN5/HW47YmGT1ZDLDexAyox8Jsc6xH/LByBw==
X-Received: by 2002:a63:f04e:: with SMTP id s14mr2667068pgj.30.1575453261840;
        Wed, 04 Dec 2019 01:54:21 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k101sm5941687pjb.5.2019.12.04.01.54.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 01:54:21 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, baohua@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, baolin.wang7@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwspinlock: sirf: Remove redundant PM runtime functions
Date:   Wed,  4 Dec 2019 17:53:32 +0800
Message-Id: <222255194cd40b48a0ec2b7e351eda0983b38acc.1575452516.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1575452516.git.baolin.wang7@gmail.com>
References: <cover.1575452516.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575452516.git.baolin.wang7@gmail.com>
References: <cover.1575452516.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the hwspinlock core has changed the PM runtime to be optional, and
the SIRF hardware spinlock has no pm runtime requirement, thus remove
these redundant PM runtime functions.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 8cb5fd4..d62462e 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/hwspinlock.h>
@@ -56,7 +55,7 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct sirf_hwspinlock *hwspin;
 	struct hwspinlock *hwlock;
-	int idx, ret;
+	int idx;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
@@ -80,20 +79,9 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hwspin);
 
-	pm_runtime_enable(&pdev->dev);
-
-	ret = hwspin_lock_register(&hwspin->bank, &pdev->dev,
-				   &sirf_hwspinlock_ops, 0,
-				   HW_SPINLOCK_NUMBER);
-	if (ret)
-		goto reg_failed;
-
-	return 0;
-
-reg_failed:
-	pm_runtime_disable(&pdev->dev);
-
-	return ret;
+	return hwspin_lock_register(&hwspin->bank, &pdev->dev,
+				    &sirf_hwspinlock_ops, 0,
+				    HW_SPINLOCK_NUMBER);
 }
 
 static int sirf_hwspinlock_remove(struct platform_device *pdev)
@@ -107,8 +95,6 @@ static int sirf_hwspinlock_remove(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 
-- 
1.7.9.5

