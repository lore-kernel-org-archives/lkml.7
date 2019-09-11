Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00910ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7639206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/hNxA2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfIKWct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:32:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36187 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfIKWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:32:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so10789233plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OSYcY8IBbPXHFII/5CsrnXT8+IaVG+jk8Oh4t4Zn6xA=;
        b=o/hNxA2gr0vDUeX9kntmZsI+c644sUOFOjeuCT21i22ln2dgMqCeD+ac/azR80Ssz1
         FeA575pCuqYEFUSjPfrcnwZ2dY+6oq8PyzemYUloMch5Qsw7ZJKxtaEPMaRLZi1yacCh
         dwCK84LSrzklc9yE0pL3xJawW8MODGsnOCLi07pY4uM53SKgRSvuXqnMtwfhgJZk4Jxj
         P0aNX8We7coIMq3hfcxnM7tef1PTGpkgpeOUycGITRBuG/Zq3MsfCHWrriPK+TuIY4u0
         F+L/B7RfsqFnS7zRnnPWV40L4TgtLk7vMsnVXcnsg7uzoXeMmD41j3ZfC3BYib3uB7Mn
         acNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OSYcY8IBbPXHFII/5CsrnXT8+IaVG+jk8Oh4t4Zn6xA=;
        b=JygX35mXv35CoLmQ2Mqg19GSJJcpfKYXnkIvmyXAtx9ZwMNQPZZR37CiKRDOqwoylJ
         Rk6kNC1C2bg1SF3OZKeRaQNsKQ9Z164UWCHMhlImAYOXMTEICapJ5ROnpQQVR7mBXalr
         euLAJSkY3oYIqinacsg2rUHopSmXWry3e2xCcKg9HSlFzIS3CLSkvKYLVAMQYTgLtlAO
         XZBkEl6ZeJkUGTUafRDPbJFs+86Uf6J3wB8AeBnnmtoNxNLuO0HheD4AoZnf0EnDIzjU
         i/iSWsq8gVC9VNaN1o4FY8ggYAnqJeTmGxs1FDMsIRsx2Ea9+0ZIS4Iu9ppbBU0j/GUd
         2NGA==
X-Gm-Message-State: APjAAAXZRu3aAgjnRDf2fZzb+GBuMjHIN/MefVhw87k8B7PxkHKU0Y+v
        +t0v8f8d0+SgNz6BW1jgqGr2k/3DWKwRRA==
X-Google-Smtp-Source: APXvYqzvuQibd2D6UfQ//STmLBnUmZhqs5HY1ImusyRyrxLJ/G1YruEWbLPZRbhabAyr6M3Iq1nTrw==
X-Received: by 2002:a17:902:7792:: with SMTP id o18mr37634234pll.73.1568241167291;
        Wed, 11 Sep 2019 15:32:47 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id v5sm22415190pfv.76.2019.09.11.15.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:32:46 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 2/5] cpufreq: Initialise the governors in core_initcall
Date:   Thu, 12 Sep 2019 04:02:31 +0530
Message-Id: <6ac50a647b8b9ee4af70a33fab10bb5df4a6b5ff.1568240476.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the cpufreq governors earlier to allow for earlier
performance control during the boot process.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 2 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
 drivers/cpufreq/cpufreq_performance.c  | 2 +-
 drivers/cpufreq/cpufreq_powersave.c    | 2 +-
 drivers/cpufreq/cpufreq_userspace.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index b66e81c06a57..737ff3b9c2c0 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -346,7 +346,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return CPU_FREQ_GOV_CONSERVATIVE;
 }
 
-fs_initcall(cpufreq_gov_dbs_init);
+core_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index dced033875bf..82a4d37ddecb 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -483,7 +483,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return CPU_FREQ_GOV_ONDEMAND;
 }
 
-fs_initcall(cpufreq_gov_dbs_init);
+core_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index aaa04dfcacd9..def9afe0f5b8 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -50,5 +50,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
 MODULE_LICENSE("GPL");
 
-fs_initcall(cpufreq_gov_performance_init);
+core_initcall(cpufreq_gov_performance_init);
 module_exit(cpufreq_gov_performance_exit);
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index c143dc237d87..1ae66019eb83 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -43,7 +43,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_powersave;
 }
 
-fs_initcall(cpufreq_gov_powersave_init);
+core_initcall(cpufreq_gov_powersave_init);
 #else
 module_init(cpufreq_gov_powersave_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index cbd81c58cb8f..b43e7cd502c5 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -147,7 +147,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_userspace;
 }
 
-fs_initcall(cpufreq_gov_userspace_init);
+core_initcall(cpufreq_gov_userspace_init);
 #else
 module_init(cpufreq_gov_userspace_init);
 #endif
-- 
2.17.1

