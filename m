Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4144E2071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTD/GPgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbfKTPqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:46:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41390 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732491AbfKTPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:46:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so14398339pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AgDAyNnziZ2/rpXVW+6uZm6qCS/g3MtXyy21omVhiKk=;
        b=TTD/GPgbVJlqWJezadRMyot/6RcSAW4tTnmkmdhwjB+qH876bPgz4yk5cS7IiGyP3K
         trLYX6i0Vl5wNDbXS6dOb4z3Jji0Zde+ZejgKmxq+3s/LVxGpRJbJv8Gl2YzYZ2azXgr
         J/YNU2VewuB697Ynqi/+TODfrCjqZ3gVhcTfO13sryD2gZlgriNpW636jt++tlGJQZQP
         d6nK84JZI6WOMBLBBUMqz4sR9NWbVcGQ2fRx3/ctZE88lH5y/l2gMKLwbSOxWVXk/j53
         atgnWdYX91MJ1T3R5xvOHUtLt7nF+uncFHBbik2aiHOtlUqjlO4/wzlwJ5J3nE2GEpua
         Fppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AgDAyNnziZ2/rpXVW+6uZm6qCS/g3MtXyy21omVhiKk=;
        b=cWm2g63D5yoec8wpXuUF06lclMOlNAc3Iw3GO+OdBEk7swGCUmEAL/98UzBQiVwPQK
         WSa61o8JC8YJB1/7vSWv503JN/97KH9JkiSXU+dq00f5rPAzkGqFvtuZXZzMmAsCuByI
         3Uw6rx4maXQEnLp+UNltQlLXOh6Pf0hTEJ0ZNn3pgnQx6Ub1Bt3nUEIuPOYVlKW4W7+s
         FS45dFSnu33iJQQyeMW2ulAUx+nCiTPnRj3TDPDe8iLq5++RyhSAOuoDYJalnpvSsECF
         mNOxFolmpo2+myJz8uDotdOj1NWyVdTCIyoQ9d28VrbSFgVQyg14/ewql/8j8oHzJQ3R
         lqiw==
X-Gm-Message-State: APjAAAWXg8r6jOlIi6hTWEj2G5WKdXGrbDgfvJvZipjoVCgNarj9Eo8y
        tOEJ9dUk1mWclKIUTwHgOaa741Y4K9S34Q==
X-Google-Smtp-Source: APXvYqyB7lY58RH7CXaXDrsbQa1IXAGZ2t49P4RvoB6lsC3HH+gC0HPsfAEo+5uM2xZEinvTSMklGw==
X-Received: by 2002:a62:e119:: with SMTP id q25mr4862880pfh.161.1574264765290;
        Wed, 20 Nov 2019 07:46:05 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id 136sm30313724pfb.49.2019.11.20.07.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:46:04 -0800 (PST)
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
Subject: [PATCH v2 10/11] thermal: amlogic: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:19 +0530
Message-Id: <139c9191f1a18d528b5f94376facf40291d28244.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
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
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/amlogic_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 8a9e9bc421c6..ccb1fe18e993 100644
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
2.20.1

