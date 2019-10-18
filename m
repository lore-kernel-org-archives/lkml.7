Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E4CA9EA5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEB021897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0/ZDYAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632977AbfJRIw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:52:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38988 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632964AbfJRIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:52:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so3451102pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pOGwcMchIXdaRlZBtyBhTrAkf1RWijM6eAT3n0JAvC8=;
        b=W0/ZDYASOJLvNqpxJwakFyLljNCg9m3gU0qus8PbZv80d4MBYV61s6YgkTZ2o092HT
         l6Hox1rxqw02mP0hkE4dmTIBOWuWzQnun3CAx8iQoBX+ieOgLqXuGkwjkkOBDHTp5Ej+
         bSnCeOZpuByrGXv865yvZBGp5e3L4VUeAZx+58RmXzR2DvP9GDKFU1ygQ9w2uMVTfPcz
         smHMCtUiUzR34xEfz0yeFzUvh94kWKg6jMr4+OVdRPZ10fXTx3dQH2GQTaOGk6Ngx4Uk
         IMX2iqAmFPlLvk2rQBvqd8zGqL8L0dUK+Ga6BJIMHRfiL0VXN79mrWTRE45HPF/mmQAF
         dwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pOGwcMchIXdaRlZBtyBhTrAkf1RWijM6eAT3n0JAvC8=;
        b=HWjkpkHVQp+l+QzMEiAd+OubX/sqUePAOVS2VzOoPNdvi6++cdhaatUfAsYzqTbOaY
         LXgLLnAdgc/tiREQ77r6hnsfjjQ7AJ7Oz7h/IeXMAS/JvbooDSRfOX2E120MmTIflv8l
         atEQ8rOG9XBXAl7UQjnn20SHWHPhyJPM+boT4QEI3lWWKUHLJGfu792rNUES41/woyFQ
         YTyOzgx9jZs3cymUN44tf9tKACoiih7owfQfhb7/WjmwZxZgMV6o4ojKUHs/Dbo82NOo
         jA9BdWO0o9ce9+7s8ZS6UI/ZjaGCsGK/ARqRL7sVZuKrqYGJ7QxprWelfeBC/qgWMS2f
         zZ8A==
X-Gm-Message-State: APjAAAU7t/E44gfDvv6xZq37K7xD1fPEiZAmHeaXjLT4iwsoWrkdzFhF
        EQoQg5PaXc/GTK8i2/8sckGpWUWpAfqvvA==
X-Google-Smtp-Source: APXvYqwoQ5ESE21BX6wAak+ChcC8b4+hgljou3Np9qGufEF8scYDPgxmkBTLTmXkiWYDrLsXbM03IA==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id z14mr9466041pjr.40.1571388743507;
        Fri, 18 Oct 2019 01:52:23 -0700 (PDT)
Received: from localhost ([49.248.178.134])
        by smtp.gmail.com with ESMTPSA id c34sm5688183pgb.35.2019.10.18.01.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 01:52:23 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v4 3/6] cpufreq: Initialise the governors in core_initcall
Date:   Fri, 18 Oct 2019 14:22:00 +0530
Message-Id: <aa02366951fb174077a945761a7cda03d08acab5.1571387352.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the cpufreq governors earlier to allow for earlier
performance control during the boot process.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 2 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
 drivers/cpufreq/cpufreq_performance.c  | 2 +-
 drivers/cpufreq/cpufreq_powersave.c    | 2 +-
 drivers/cpufreq/cpufreq_userspace.c    | 2 +-
 kernel/sched/cpufreq_schedutil.c       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index b66e81c06a575..737ff3b9c2c09 100644
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
index dced033875bf8..82a4d37ddecb3 100644
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
index aaa04dfcacd9d..def9afe0f5b86 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -50,5 +50,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
 MODULE_LICENSE("GPL");
 
-fs_initcall(cpufreq_gov_performance_init);
+core_initcall(cpufreq_gov_performance_init);
 module_exit(cpufreq_gov_performance_exit);
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index c143dc237d878..1ae66019eb835 100644
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
index cbd81c58cb8f0..b43e7cd502c58 100644
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
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 86800b4d5453f..322ca8860f548 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -915,7 +915,7 @@ static int __init sugov_register(void)
 {
 	return cpufreq_register_governor(&schedutil_gov);
 }
-fs_initcall(sugov_register);
+core_initcall(sugov_register);
 
 #ifdef CONFIG_ENERGY_MODEL
 extern bool sched_energy_update;
-- 
2.17.1

