Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A458C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581F32147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inRvYdF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCMJAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:00:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42552 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfCMJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:00:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id v3so796614ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRuCf454mnzXB+DyjyFfFPdMgMq/C5zdWzQg4oC5VkU=;
        b=inRvYdF2URJMHy6DjIr+GhGLMU3P1FzqcqtEDRK4JChuFpTLPGpOXtV+RO7/5dckAL
         jpeGejyWeb/QXvr0zUbCfzv5imaWuFE8wlhpWlFxqC8uX5ShsK5sWeKiHgO8TEXRm1kj
         mqT+DHt8hKej3THaZPN8rbwK1rMZYmYkyAGrcCnAMoqRxxNnJykTIdVW1fQYmKs7gZln
         +R0hIrYLWqWlsKlY0LeNuBvvrVJQKFJR6/+GH7XKRikBbsWDbg1AqOKFIRinz1/qSmVm
         WCvKsymK5Mv7aT4QBueq3B5eBZpjEXka9bfjlOqe7cbZPc4fU+Dto10G8lkRcRDJdQtd
         6YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRuCf454mnzXB+DyjyFfFPdMgMq/C5zdWzQg4oC5VkU=;
        b=P2aJ3WEzaXAg8iDnCitlRGOC7Bb4iaFW+2MhYHTnOwQTSZIrva5pfHvOGph6Zkxhl6
         b2cjy8+Y//7yqSsR33Vn5QaXZnZHNxtsH31cS+TJLZgJEGnVvXsBRkiCPVfaKsYYEUHe
         BN+MUVKOx9EUwyhkrhpo+05E+tDXi+scJ70uXdT1ggQc5MaFK+ysXkwF74N5d5UwTKyg
         K6UDtVg0HLUr19YMo2qCSwFqwIfq0FbSms08Xc9gHBhS9TC8KXvqK+k0eWvcM8tlEit+
         hlsbFdgT74qtaCb5D9AodbGdkR6W8yWc4HM6gxReLYUyj6UkNXh8doIwbgNk/nRmXz3l
         Lg6A==
X-Gm-Message-State: APjAAAVulx5v6cwWyOZspaCGaWlOp1rFDjIUUCKVxzeoRwqrLKTdjANv
        TI734EQ02VF0P0Xf9GCsBgQZgA==
X-Google-Smtp-Source: APXvYqy+0kI5lN5r3CDxfcKdZ5X2ac9IRFzw80Mxsj4mGpyXAGd5SfKIalXwYLiag6G79eZLggdkjA==
X-Received: by 2002:a2e:8585:: with SMTP id b5mr22362278lji.125.1552467623334;
        Wed, 13 Mar 2019 02:00:23 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u15sm1701986lja.73.2019.03.13.02.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 02:00:22 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 4/4] cpufreq: dt: Add support for interconnect bandwidth scaling
Date:   Wed, 13 Mar 2019 11:00:10 +0200
Message-Id: <20190313090010.20534-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313090010.20534-1-georgi.djakov@linaro.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to clocks and regulators, some devices can scale the bandwidth
of their on-chip interconnect - for example between CPU and DDR memory. Add
support for that, so that platforms which support it can make use of it.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..30fed0fc266d 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -17,6 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -100,6 +101,7 @@ static int resources_available(void)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct icc_path *cpu_path;
 	int ret = 0;
 	const char *name;
 
@@ -126,6 +128,19 @@ static int resources_available(void)
 
 	clk_put(cpu_clk);
 
+	cpu_path = of_icc_get(cpu_dev, NULL);
+	ret = PTR_ERR_OR_ZERO(cpu_path);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(cpu_dev, "defer icc path: %d\n", ret);
+		else
+			dev_err(cpu_dev, "failed to get icc path: %d\n", ret);
+
+		return ret;
+	}
+
+	icc_put(cpu_path);
+
 	name = find_supply_name(cpu_dev);
 	/* Platform doesn't require regulator */
 	if (!name)
@@ -205,10 +220,18 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	opp_table = dev_pm_opp_set_path(cpu_dev, NULL);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_err(cpu_dev, "Failed to set interconnect path for cpu%d: %d\n",
+			policy->cpu, ret);
+		goto out_put_regulator;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto out_put_regulator;
+		goto out_put_path;
 	}
 
 	priv->reg_name = name;
@@ -288,6 +311,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	kfree(priv);
+out_put_path:
+	dev_pm_opp_put_path(opp_table);
 out_put_regulator:
 	if (name)
 		dev_pm_opp_put_regulators(opp_table);
