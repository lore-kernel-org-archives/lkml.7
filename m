Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F789C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D330721835
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giCE0LR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfLBU2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:28:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38898 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfLBU22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:28:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so869925wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1somXtkHoxvC/VbspBH5qSIskfATKri+DPQIL3Oev+8=;
        b=giCE0LR4sDAsP3tAyxL+P7S3VCqgq4mJ5kRNNuKHc+i6sXaaPgntzv/F3DTBjX1TqX
         2CYDqVXBCpMrIbiOjElu2WiB+UVgK0iYUDnDAAboH607ksuVqLuJKfYfiVFxBPO/qB+f
         QYIz64fP3O3SJbB4F0r+QGj67bEwFB8H9a8iDt++UGDF8JvSsAzNKl86guiYx9xtxWhJ
         RLbA8F98G6G7yUIC797GERJG0wNSbVEYCui6361m2p1XOxxnm+9Yboq/uDF1ZfRLIeWj
         LRySFtB7c5iI2w7j+tM7d+URYkOhx9ROVsp8zT+FUtedNiEogHzy8WGEVw/n9RNagnvS
         K4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1somXtkHoxvC/VbspBH5qSIskfATKri+DPQIL3Oev+8=;
        b=MKeeLzE1Rgm4rtaFWUU1l9bRWmBm0vzzIfi1bUpbKDYBBkDenV1UmkMIIxoxRxUQTu
         l0BZw8gGsQ3+uIbP+YppKk9ku/R83minjWLcbEXNvZIwiTJia9wA5pkE5XuXEhrQSclf
         pQG1RsOKT1pYHKIaCTXw/V6Vmkc/lgLqI4MxZbcKZOAA9PyB3b/1kMpKVq3Avwm7F0c9
         GtuhwHvR2uBSfASGkna4brusxRhWJJTh5aM9BUVoV7GJRM6Ocs+BQLRsNRvze36BHn5y
         KyEoSBsU1kTUGxpaD6E8xQQdCRo/D/0M7GZFsT9CvqU8vB5N1cvYmT7kALZW4iFVpSpj
         f6pw==
X-Gm-Message-State: APjAAAUyiPKMJVczAL1pVBndR4iNvnG3m6qlw7ZbId8n6u+z+fNgZtIr
        V85LFWnSBQNazRrkeFo9Ti5rF39CzCU=
X-Google-Smtp-Source: APXvYqyRB4fpfJOy68WsHtJMDtjbja8mucHxwv8BK3z0oLKfXMWbg9waPUv+7avpWhWs9vzx/Q+XCw==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr900848wri.47.1575318506359;
        Mon, 02 Dec 2019 12:28:26 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8196:cbcc:fb2c:4975])
        by smtp.gmail.com with ESMTPSA id k20sm556456wmj.10.2019.12.02.12.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:28:25 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/4] thermal/drivers/cpu_cooling: Rename to cpufreq_cooling
Date:   Mon,  2 Dec 2019 21:28:15 +0100
Message-Id: <20191202202815.22731-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202202815.22731-1-daniel.lezcano@linaro.org>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we introduced the idle injection cooling device called
cpuidle_cooling, let's be consistent and rename the cpu_cooling to
cpufreq_cooling as this one mitigates with OPPs changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Makefile                             | 2 +-
 drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} (100%)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9c8aa2d4bd28..5c98472ffd8b 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -19,7 +19,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
 thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
 
 # cpufreq cooling
-thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
+thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
 thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 
 # clock cooling
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpufreq_cooling.c
similarity index 100%
rename from drivers/thermal/cpu_cooling.c
rename to drivers/thermal/cpufreq_cooling.c
-- 
2.17.1

