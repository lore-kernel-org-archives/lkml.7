Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D7C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE8C222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="it17UP1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfJLGxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54912 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbfJLGxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so12349576wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SXf5g+t/yGsZp6ewuskUKxJwRRGrp4eeV2tieQBqK28=;
        b=it17UP1tuJNxRx1MPlsBRuOThRkCOSByRJWl935eKbc0QXiAITTY1+j5z3uN7yMoK4
         Q/+njkVzsLPkz7Qkvmbmg60GMPEJPwIAj0WUAQ5cZp9zXUNG3foLjlcL4hlqqAkUWhi0
         EQAixh0ZmbWGucRLbliLqVWWslJQ27R2g7b+ccvytkPZBIdVJw7ku47UCxBOmoBMf7tC
         twIsUj/nOY4JPpGlyyePc7IJFhjQjF3RqxZCr29EaivSr1inTJzKY2J9zG/rDjZ+QRX+
         FKWyglUysAr+neS1BuS9Cgr+jsvbOTB2PQYElC66AkOb8s+pzh2lDoxhfd2pQK7L4jz/
         D2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SXf5g+t/yGsZp6ewuskUKxJwRRGrp4eeV2tieQBqK28=;
        b=TB2ENjb1DdkBH6uGghZn3nI6RFQa864wD+WtfecULfV454i1iCAjXaQ9Beu8t5gBAi
         36OO8Hdx0DfAPBlQRMKQE1WxsrdrvDm66MHBJVfBFtu9rGnfA9Smp6GINC3LTPxayRTz
         Co58mSeurBTlc69CKayFcP4a3KBZVP+ngEok5oz7FXwTNeD0xAeiREdzCGxGZhJ/w/zX
         3SHs3VPlKiv+LZOj64p4QMFiFmts7yghmkaXp2YDwFKxmNw/6WwmRaF1ZYIA4lnN3bkV
         HK4d+hclPtxEZ1+DJA5ZcMKgb3adVGFh6xO++Fxxq+wIoMlP1cRjWHH3cqycCq0l+ZPg
         3FiA==
X-Gm-Message-State: APjAAAVtQoF3QBqpCUret2eiu6+jleCJ8Kq2j51gnUHHVkw84yITfaCc
        n7cwul5LY/j5yN/Ozdq8omDRgxNTpHM=
X-Google-Smtp-Source: APXvYqwkdJSZzhHSDIunTmjS5rUlLBt+0jAkqCweXENnqsASscFbwexotHqCFOpsPnFVjVQa/XUgHg==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr6499910wme.1.1570863191303;
        Fri, 11 Oct 2019 23:53:11 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 07/11] thermal: Move get_thermal_instance to the internal header
Date:   Sat, 12 Oct 2019 08:52:51 +0200
Message-Id: <20191012065255.23249-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is not used in other place than the thermal directory. It
does not make sense to export its definition in the global header as
there is no use of it.

Move its the definition in the internal header and allow better
self-encapsulation.

Take the opportunity to add the parameter names to make checkpatch
happy and remove the pointless stubs.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 5 +++++
 include/linux/thermal.h        | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c03a07164ca7..c75309d858ce 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -76,6 +76,11 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz);
 
 int get_tz_trend(struct thermal_zone_device *tz, int trip);
 
+struct thermal_instance *
+get_thermal_instance(struct thermal_zone_device *tz,
+		     struct thermal_cooling_device *cdev,
+		     int trip);
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a87f551d114d..4436addc0e83 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -415,8 +415,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
-struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
-		struct thermal_cooling_device *, int);
 void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 #else
@@ -474,10 +472,6 @@ static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-static inline struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
-	struct thermal_cooling_device *cdev, int trip)
-{ return ERR_PTR(-ENODEV); }
 static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
 { }
 static inline void thermal_notify_framework(struct thermal_zone_device *tz,
-- 
2.17.1

