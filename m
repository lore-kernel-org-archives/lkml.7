Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8C020685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mx7tfKFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfDWN2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:28:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43728 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfDWN2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:28:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id f18so13492012lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBZVH8tY60kvdDXDwV8aJHdGVIEg5lBCBmcPhKf9y2Y=;
        b=mx7tfKFCrLM+my8sDW7dzzb2SBOnGloSVzmUgLj2SrdsqiYsq+Uq1lnU07zY7h6C5e
         y0YhFrKkNWfdkTfdMdlbNuKmiaMApa4h+ey7j9Jz639toJrjKFCByOrQXzoM/XHNorPX
         XJxuAJhHm0Tv57dwC1lVcrZvp1gxj1OPAsHwveMyKCONalWR2wAGlI6E1Q94EM+yggSP
         XsQNCgnxVz1nZZPTFmuMjHl8RLk2dSsx/7CxPZg8ylVSR+MMKw2rAlrD8vOBAYJhThDL
         taL/1wBYpNLKnmLsVnUxn7DEHk9MjQ3LCh0f9wXjbuB6Jk14ibwh/E24H+FkhD6mc00m
         s6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBZVH8tY60kvdDXDwV8aJHdGVIEg5lBCBmcPhKf9y2Y=;
        b=D7lnX3NtqSCB63meRW1JfHZDEnsr+z/M767fCIaXui1vBEmY0kPF3fIrtxNRlaX1tJ
         n/jvuXOvTzbJcGBRPD79RsIRnpkGwOwtbdtTRsMp1T2HMZUllzO11Vb5acNORrYL8tXA
         AUPcCuPxhWr35mdvNRlgElSAB3ceHJP5Tx6m9Ly0ohC5qJWEL5r04uIbswJI4it7I2ZU
         mhDHFmlULDOB/zIXlFUKqjUwUhAzAJbsXLl2i2aNrJ/qehn77Qa+evA9zOb/Ed61taVE
         wZ5RzfarNcOZ6HbY+W0vEqtiehbf8WFn+guAvxKnjUj9JyUfV88287Mvj7yStqF0b4oJ
         GZJg==
X-Gm-Message-State: APjAAAXby3oJuwgNc+Q6iLv+i0HhDlXYcmt58fy8nJA/itwj5q1XcJL2
        JJS0ZyCN329Vx/j/24n5r5be6Q==
X-Google-Smtp-Source: APXvYqzNAQqhTw6N2yoD4Bz5LuIxZwqCEb1c1WFtTJ4PtefGrEYIIRNvEmZZ8vqvnt1FgOHQdMxjbA==
X-Received: by 2002:a2e:1203:: with SMTP id t3mr3028829lje.180.1556026117559;
        Tue, 23 Apr 2019 06:28:37 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y206sm4617107lfc.72.2019.04.23.06.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:28:36 -0700 (PDT)
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
Subject: [PATCH v2 5/5] cpufreq: dt: Add support for interconnect bandwidth scaling
Date:   Tue, 23 Apr 2019 16:28:23 +0300
Message-Id: <20190423132823.7915-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423132823.7915-1-georgi.djakov@linaro.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
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
index bde28878725b..8a20f4d0243e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -16,6 +16,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -98,6 +99,7 @@ static int resources_available(void)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct icc_path *cpu_path;
 	int ret = 0;
 	const char *name;
 
@@ -124,6 +126,19 @@ static int resources_available(void)
 
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
@@ -203,10 +218,18 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	opp_table = dev_pm_opp_set_paths(cpu_dev);
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
+	dev_pm_opp_put_paths(opp_table);
 out_put_regulator:
 	if (name)
 		dev_pm_opp_put_regulators(opp_table);
