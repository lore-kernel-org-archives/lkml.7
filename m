Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C73120882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtBCgbp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfJUMPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:15:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35443 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfJUMPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:15:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so8333671pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=icSR5Ia8C4BY/f3U2+rIIkMs08i+QoePFXJHRUnWtH8=;
        b=qtBCgbp8DNzK+gpDpDW9X0cKqML0CGpQ4bSaNLGj9blAogVaQgmb2yQnayWfotrEgk
         Hlc1OI63l4JGYvX7jtcnuCj3DH6pgDy23RyzWkkuP/PWlsr2Cz0JL3+kU7fv2uG7B13e
         nPjC/6+HjZG9rrmcscVM/Udu9PEnbsZDZZv8aVVa2r37J9nc7UFccEGrzAfNlW39YJMQ
         bUvvmyo7//WvL1uRJD1bndSuSMFwKB5OAXW6UVaK4pekYbfRqB1qHY3RGbZ1mbD1+1Vv
         xwuc1N44r/BkKmnjlYLkocFFiZ68VG2wVutkt4L3pQfvOkWatXanfxAKDsBr4RGdpAzt
         +XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=icSR5Ia8C4BY/f3U2+rIIkMs08i+QoePFXJHRUnWtH8=;
        b=Y0IIWpjvKVkm86/gwotbNSkGdSY1TrUyRMfS22hTaeap3s7jBucTMHgFwtyibeXsAq
         vFu/Aezei+LW/ZG19LGbar5YSHTGNwgvX9Sukeddh1oLcVJ09nkAIqh2GTFzCBSKjP9U
         HdLsiaIvousAszdZSBNP+MYJtk8Q33wh5Mk9GhZMiwuGyViwttLBQ5+xT0/St+P6JJ84
         fAdkpCDrvOiBbhUFFgVY6GgVKofVrvzgvQgjgl+GdsFViBTWIGk2Z1+jo/cwD8M1CjSI
         244xyYymU8jcIDpmUe2gR/dxdfhhji+sTWrBMt0uFyhhxy7L96zhr/KipKH7IyenYijC
         8tUw==
X-Gm-Message-State: APjAAAWnjxfmJrWX3yLSGz7h5eTHevnExydUGic2jQB2VrVvUlNbUYfP
        x2ZSNaB7npkNevR1PnoQMu8TNzcKytH0PQ==
X-Google-Smtp-Source: APXvYqyEOLoX1K9LXhjZqp/OeP3RoV4ghS1oTP0COLYV5CJGuCwdBPAOSwGk9K3/jhxm/k+SO8++Hw==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr28713603pjr.4.1571660132274;
        Mon, 21 Oct 2019 05:15:32 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id r23sm15004545pgk.46.2019.10.21.05.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 05:15:31 -0700 (PDT)
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
Subject: [PATCH v5 3/6] cpufreq: Initialize the governors in core_initcall
Date:   Mon, 21 Oct 2019 17:45:12 +0530
Message-Id: <b98eae9b44eb2f034d7f5d12a161f5f831be1eb7.1571656015.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the cpufreq governors earlier to allow for earlier
performance control during the boot process.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

