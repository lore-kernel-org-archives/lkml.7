Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4445C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4292176D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 17:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZCly8ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfL1RTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 12:19:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46499 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL1RTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 12:19:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so15963447pgb.13;
        Sat, 28 Dec 2019 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FiMHugGI2SCi9C3dDQzjMOwRF2K4ZM/Z5Jm8OBdk0Go=;
        b=RZCly8ji31p7Xt4Hj6EkPS3N/kCphrM6mBe92jJuH4ze8P4XehMlOrBzu4vLwl2DBh
         UxNZorHnafSVoOGoaJZswMeYJxotcXUg9mFaqnTEzvAyCTt5Jy1ioG0Q+pc3xruykGKC
         OhF8CvmVkuf1WuQLPitVKHzCRkJsjnzEeQV6lnW4/Odfy+4Ah2j0HP2Ba14fCPGoy+lo
         dKchkjUWWTOIPjoyq3fzx+dWfHSEOnA5woAORiVCFRslmymAfNVqWz+a1XHew/w8h6Tc
         qgCRwtXKD2JkWQ0g4nY2ve1rCqASylKAr7nlx50y8Q0tqjEk4lu/w5MI+RmIxAkh5sAx
         nP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FiMHugGI2SCi9C3dDQzjMOwRF2K4ZM/Z5Jm8OBdk0Go=;
        b=W6CnqmCSChASjmetumxOO8bfu4mmEi7xoF59zBHeCwMkckBSD/DVjVCwsl4zGhVG2A
         JKrox5P239NZpKZjPgI+g7KP/DWFXleX2NGEbirLbI5fieeTX+4nFc1UTKA8C1P9aNcI
         8tUWkCGpL4qMOujjNvL9wfj26Q5VBVVyXorvM+mL1lyFwGXMBem8ZXo3ENbLuoDFlPJl
         1huY+EITiR+QKkfAQUdcj0fCQUKnKJMwxPPmXZpOT+PeIwmW+nHKIkEKBTzk/vHjikBM
         MeYN1vyHYkLXKOza5r+ehgh3LqUbsx5YIgqZIBEZN1zZPMgQAPT1wESiZrJuIdyjzr2B
         CcfQ==
X-Gm-Message-State: APjAAAU8HYnnyWVI315ksgVyELhVpsg1huO6rHmFUvRdC3r35m59rDFo
        ccJ/sPi1JEiut19pKudA1bE=
X-Google-Smtp-Source: APXvYqxjy3BTwgLF7BDkuN5JUeHsAIUKWbiir6L5CsL8HKEj3UN2B09QCkFrBemJGGf5KPtSwT2VYw==
X-Received: by 2002:a63:4f59:: with SMTP id p25mr60354435pgl.230.1577553547545;
        Sat, 28 Dec 2019 09:19:07 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id t65sm45802140pfd.178.2019.12.28.09.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 09:19:06 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, mripard@kernel.org, wens@csie.org,
        anarsoul@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] thermal: sun8i: Add hwmon support
Date:   Sat, 28 Dec 2019 17:19:04 +0000
Message-Id: <20191228171904.24618-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose sun8i thermal as a HWMON device.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 23a5f4aa4be4..619e75cb41b0 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -20,6 +20,8 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
+#include "thermal_hwmon.h"
+
 #define MAX_SENSOR_NUM	4
 
 #define FT_TEMP_MASK				GENMASK(11, 0)
@@ -477,6 +479,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 							     &ths_ops);
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
+
+		if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
+			dev_warn(tmdev->dev,
+				 "Failed to add hwmon sysfs attributes\n");
 	}
 
 	return 0;
-- 
2.17.1

