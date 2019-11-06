Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D9C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C854721D79
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKaw0thV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfKFN3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:29:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32950 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbfKFN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:29:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so18906698pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0/+bQx5JHQOuiZKynMK7gLFGYPX738NgMSopvzkwjoc=;
        b=vKaw0thV8SCCNxndmd8ReWx7owdb6CYDzHnrVasmMSUyjnLsYByCBUxwC6BIPwswFD
         9XVykLdF9C+khBoYg22d3yidwUdQjnFxZI1QZo+hN7LVFNoE+RquwAdieDc1JEsP/D8c
         lOVq3XwJmwgUTrDceyVfL+6lsrxT/7PhwOF3c5Shy0hIa/qI7y+OB1POpA13KVF+E5XO
         /KJ56h9Q26ntU1d4iQslEZ7bH/Tcbuv+SyBCGQnXnJO+6hbo9v8BeSKHUcbHhsMKVqfa
         VVul77IsGuDvX43/uBx8RamZRPHu/y0+k9/5G9FwIURfnsznL4L2F0uV5LNT3BT6aaCb
         13mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0/+bQx5JHQOuiZKynMK7gLFGYPX738NgMSopvzkwjoc=;
        b=TkARNgt8fFF8fXehVOXvHu7yCjU6HNLfeS52vk7+2uBZMhvugDsaMVhmjfqyY0QO87
         wqTb/8et5xiq0fTWdDcOKLlL+oACmMGVxzwiOZ6UUkAG71rMfIdt9IlAL8Wo9rPyUPfU
         vuZgE/ize6SjlgFUdLf5ykK/qJ5P7goDs3+PFQarHz4Ap9aBQPS/IqbPyYYLOr5hDNB5
         hgF+h1Tikz9hLBd2KTDq8fVwx1mn2rdsXHBPsLhujxGZNZHOPvLVF8B1PY7waSb5Wzwa
         il3mDUa72zn+QUs5j5U0xR88orFMe2GcOLKM933xYTapVJgavbaIZlOOQapEqMRJwnoF
         7mpw==
X-Gm-Message-State: APjAAAUaIc8R3UBFv4T8dVGIFS5n0G1ZYYzhhTNeGPalutETtH0XcvPT
        Ze7HmENG4+MzxFDIvvzBmXoXJGKepos+hA==
X-Google-Smtp-Source: APXvYqxvZgZab1KEfHyZn23Q8fAfHbj7kAdbsruoNK1+DZhbhLOnlkiWUa/oLodrwE6PPX4nAUw5wQ==
X-Received: by 2002:a63:1065:: with SMTP id 37mr2843407pgq.31.1573046955366;
        Wed, 06 Nov 2019 05:29:15 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id c9sm34805754pfb.114.2019.11.06.05.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:29:14 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 10/11] thermal: amlogic: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:26 +0530
Message-Id: <2fbace543c7a45799f29f87d9aee82f2ed1a7dbe.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'A' not described in 'amlogic_thermal_soc_calib_data'
linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'B' not described in 'amlogic_thermal_soc_calib_data'
linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'm' not described in 'amlogic_thermal_soc_calib_data'
linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'n' not described in 'amlogic_thermal_soc_calib_data'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/amlogic_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 8a9e9bc421c68..ccb1fe18e9931 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -67,7 +67,11 @@
 
 /**
  * struct amlogic_thermal_soc_calib_data
- * @A, B, m, n: calibration parameters
+ * @A: calibration parameters
+ * @B: calibration parameters
+ * @m: calibration parameters
+ * @n: calibration parameters
+ *
  * This structure is required for configuration of amlogic thermal driver.
  */
 struct amlogic_thermal_soc_calib_data {
-- 
2.17.1

