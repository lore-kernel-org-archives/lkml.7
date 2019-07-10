Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C1C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE5C2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQEtbqgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGJLqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:46:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43051 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGJLqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:46:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so1100332plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E7GcSL06EKocZd6MAQEqpVHgYClPW57nk4fTdNrfLes=;
        b=XQEtbqgI5cgEJf0rZPJ+RHECruns4dgTgAsoNFnDCAeOtr8qshkl1bxYaOmDTI+7Tf
         08hxYyOWtxGv+GLwRdpl9Qa9wqEiMnY3yViyXALarV/xYLol5P7O4R4evCbtL+rJcwk+
         ZksC3NWSwIftzuXX6zvV6wWc0g8CsClMQ/SC2aMm1tNrO2W0HdGXgXgcIAX5KPxlWN2I
         bzGd3we/6D/5K2LQ9r+HsGZURomaGJcmE2TQSgljwmy4HhIgBoEQ8W1dIQqVAxEOPQXb
         XFP2eJokrNakGV7KgMOMXDfa0AX0RBwuPtFS5c8ycWgDErNnqGlJn8X1XAzsmejFE0Se
         /UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E7GcSL06EKocZd6MAQEqpVHgYClPW57nk4fTdNrfLes=;
        b=Im5wOgQRT/hddnVrVogVvpsiHoU/XUycUcuAwMvc6XxlPdK9hVJoJ2y5+zypgsi4Fn
         Fi253oTiFyw7y15oCHpDt6JptnVAldEM7qQvKlo+wQ2yLBsTtpdueeNHP63P5od2JCNX
         Pg1xMT5VxbKK+Kvs8p9AX0M8iDOTEhdsdB/E6mvW1VeSJjSMBUl/4zvFBCUmkAOUXFDL
         VDWstEoIijG6I9XV/PTVP5/64MiMSb3CDSsBqjKEZ9EUoQo1j2jdU9sKLqGljjpIJW/g
         YIMcLX8+IY/KC/syXownjaw5gmUAFiLLdm4ONkqlQCycBTPL9QzTnFeOIrHYSTpK+vrE
         Yu7w==
X-Gm-Message-State: APjAAAXglyKajvSTWqbx4MXf8Qeidv0InA7qB811S6O+QUNYuMZiENNZ
        TWs8YaORad18e1aE5wKmBKRDg8NtohDoyA==
X-Google-Smtp-Source: APXvYqzwx+8EeHFffEXIFvoFOuecP4rBXizBq8vsKL6k/zuNVRpPi1MPCP7rAdrxe5n40/Df5lW9xw==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr39014082pll.310.1562759212947;
        Wed, 10 Jul 2019 04:46:52 -0700 (PDT)
Received: from localhost ([49.248.170.152])
        by smtp.gmail.com with ESMTPSA id q63sm2602413pfb.81.2019.07.10.04.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 04:46:52 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] thermal: Add some error messages
Date:   Wed, 10 Jul 2019 17:16:47 +0530
Message-Id: <0d3d6111f8a8bd199f1a5a5cd8c4e83e4f0690be.1562757659.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1562757659.git.amit.kucheria@linaro.org>
References: <cover.1562757659.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When registering a thermal zone device, we currently return -EINVAL in
four cases. This makes it a little hard to debug the real cause of the
failure.

Print some error messages to make it easier for developer to figure out
what happened.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 46cfb7de4eb28..95c3a4c649cf8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1238,17 +1238,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	int count;
 	struct thermal_governor *governor;
 
-	if (!type || strlen(type) == 0)
+	if (!type || strlen(type) == 0) {
+		pr_err("Error: No thermal zone type defined");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
+	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
+		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars",
+		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
+	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
+		pr_err("Error: Incorrect number of thermal trips");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (!ops)
+	if (!ops) {
+		pr_err("Error: Thermal zone device ops not defined");
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
-- 
2.17.1

