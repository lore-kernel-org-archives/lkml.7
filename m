Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F82C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC23B207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSBiloH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfJNHI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:08:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40598 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbfJNHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:08:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so9847617pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Zl79/7idxE+IMncheCqMoc3DO2J1o16hyoOsq1ykglg=;
        b=TSBiloH8cU92qacgCVS0kzBRFN6TltVQzaXKFTSrUcjR0r3OBMXTFZc2mw+JMJB6H7
         zGn5wH2CJHsF14GFZ4h5rKwQEHdSNuVTIAfQ2I00iydhBl49QFLeaCX6+s6YF4oQO3pa
         thZMwkoutegGM0Y8gZ7SNCGo1QarTJz1I3suVEQQ2NmE4b/NVw+1qZJWeFxiywPbQZHs
         8I/YEBLZurx6neVEIxyakEmG5TlAP44NCHkslXPAVbJZu2dsVWiSkIU9/ed8E5bc1ufp
         /fgHpQ4Gpx6gjvnIU4AN5IvOC6pEriNm55V8tXEF+jKIZB9gowIGRmy+1F/ZSi4yiv6q
         ddfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Zl79/7idxE+IMncheCqMoc3DO2J1o16hyoOsq1ykglg=;
        b=Hikp0g1lKK0dPpzPmbe+QvcrjEywdGY6p2bDJpXur8aOaW0MPunTcAYN+d9OQVQVod
         jUDATIidaePeFa5p/UU88CyPCip0ZKfozgOJ3aq9OtkgiTOL2kMpaQH5jfT/xfwCpREb
         VL+7LCCFKLe+C+BOfU+OmnhIblBS98hyExa6D2/I+Q/byG7/6xrcNnTOLEToHtcDQRA7
         m9O4Kz3jBRI3aj9LoS1MrMDXrxoqU3rT9KN8BfqDozjUQyejttnQbWGZiF8b69G2zDDO
         K7TrijFXuXfvqoFumN6B7w0AIqkTJQkiv87rUwYnZPuC7KsR67bSlHG8B6zZmjZM1mKg
         l+YA==
X-Gm-Message-State: APjAAAVXbdAUJ7rDgWhfNTc2uELyoy/mhI+cJknKsYdaR8RlfHO/onsy
        FTGWzCdPuvk73fSodDA17+pXQQ==
X-Google-Smtp-Source: APXvYqxQb3C1sVvpu4CJn6/D9HYJ39s99IDUmrfJQOVPa+KmtT73tGHSz8Md3OBtes3vGRQXwrEABw==
X-Received: by 2002:a63:f44e:: with SMTP id p14mr30314447pgk.2.1571036906264;
        Mon, 14 Oct 2019 00:08:26 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p190sm20619948pfb.160.2019.10.14.00.08.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Oct 2019 00:08:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linus.walleij@linaro.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, baolin.wang@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hwspinlock: sprd: Remove redundant PM runtime implementation
Date:   Mon, 14 Oct 2019 15:07:45 +0800
Message-Id: <8fb54e417ee5833e09103fd1c286c4cf2f41ce69.1571036463.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1571036463.git.baolin.wang@linaro.org>
References: <cover.1571036463.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1571036463.git.baolin.wang@linaro.org>
References: <cover.1571036463.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the hwspinlock core has changed the PM runtime to be optional, thus
remove the redundant PM runtime implementation in the Spreadtrum hwlock
driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/sprd_hwspinlock.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index 44d69db..36dc803 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "hwspinlock_internal.h"
@@ -133,23 +132,10 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, sprd_hwlock);
-	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_hwspin_lock_register(&pdev->dev, &sprd_hwlock->bank,
-					&sprd_hwspinlock_ops, 0,
-					SPRD_HWLOCKS_NUM);
-	if (ret) {
-		pm_runtime_disable(&pdev->dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int sprd_hwspinlock_remove(struct platform_device *pdev)
-{
-	pm_runtime_disable(&pdev->dev);
-	return 0;
+	return devm_hwspin_lock_register(&pdev->dev, &sprd_hwlock->bank,
+					 &sprd_hwspinlock_ops, 0,
+					 SPRD_HWLOCKS_NUM);
 }
 
 static const struct of_device_id sprd_hwspinlock_of_match[] = {
@@ -160,7 +146,6 @@ static int sprd_hwspinlock_remove(struct platform_device *pdev)
 
 static struct platform_driver sprd_hwspinlock_driver = {
 	.probe = sprd_hwspinlock_probe,
-	.remove = sprd_hwspinlock_remove,
 	.driver = {
 		.name = "sprd_hwspinlock",
 		.of_match_table = of_match_ptr(sprd_hwspinlock_of_match),
-- 
1.7.9.5

