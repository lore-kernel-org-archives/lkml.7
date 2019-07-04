Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51E6C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F3B218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQT7MrQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfGDHgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:36:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45419 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfGDHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:36:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so2485771pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxHtLXc14HRc+q+EFuMAl2ixyKPfQQHRTF5mh6/bpEU=;
        b=IQT7MrQxceoW2i6DY1x54dzHxcQi4hu0k1Vm4r8RLMVDMIPYHzWdczor/7fo2jJ3Tx
         XRmbkYtpnWpqCx89MVVgU+ew0PmZZFLGzSfJVar1i2+5uXREv6Ty3D4/aItVDZ0NpMAm
         a0iNpxKioP+JcNoutryTVaWaP8EuFx3cyiWDvr742vz90dyY298fqT8QNDpW9NgcqNX6
         kU0iBVrBYL88ifOm8R1pPNuAkJIjuK7oqBNDxByqF2vSKwUWdQmQ3NMcWNu4JukZbeC2
         urQmq39fn4u+FU8RfVRTYnQvCp7ZqtR7brCH4Mro+mLrTD8/nwsZHDEAOsBnkSJa59j3
         eNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxHtLXc14HRc+q+EFuMAl2ixyKPfQQHRTF5mh6/bpEU=;
        b=rJ2sjMh8j0Gif4G5XKfuMBz4TGn/Lo17YBoTkKPpvX7XcQIS+NYdUs9QJyiq/z2MUX
         l1m200zicj5OmsO6xHnLcryp/RDrj/LdVMUzaCyazrqDSFwaqmO3ZrxIVm/epC/tgUpK
         D9S85aDO5H9NUUMTHzsO0HqpgqcrtGq2syDEsTJyz0jJ6EazDKDd6fo3LMDxDeKpTLzJ
         DTRy/nLeois+P0zQLlJKxeewZ/m38Uw6A2u4hPoMVIjRyOBACSH7PGRsy6RLWTVidzpG
         83BCMAKvSzYMLR/qVrI5r4nkhbKhtXx6J0QT9zFCD6MicawF/FcQcKyWHwmxHEXAjfrX
         gJOQ==
X-Gm-Message-State: APjAAAVW2C2DqcGB33Nvt/1Ru/BpmeMMk3674jjRFo+CaRFy7EnBFdvL
        Bq3AXE43nTvC2oPQa4LSSlj5JA==
X-Google-Smtp-Source: APXvYqwkmQ/EgJ72Z8r4ELy4G/Od0hZ/PUmuyn00NnFPK2Dro5ouYEK4n6QoV1blMw9HxTQ55TFLTw==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr18097327pjb.30.1562225807852;
        Thu, 04 Jul 2019 00:36:47 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id d12sm4515059pfd.96.2019.07.04.00.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 00:36:47 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 6/7] cpufreq: intel_pstate: Reuse refresh_frequency_limits()
Date:   Thu,  4 Jul 2019 13:06:22 +0530
Message-Id: <c588d6e72ba6516191129fb89a7972b30280992b.1562210705.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1562210705.git.viresh.kumar@linaro.org>
References: <cover.1562210705.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of intel_pstate_update_max_freq() is quite similar to
refresh_frequency_limits(), lets reuse it.

Finding minimum of policy->user_policy.max and policy->cpuinfo.max_freq
in intel_pstate_update_max_freq() is redundant as cpufreq_set_policy()
will call the ->verify() callback of intel-pstate driver, which will do
this comparison anyway and so dropping it from
intel_pstate_update_max_freq() doesn't harm.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c      | 3 ++-
 drivers/cpufreq/intel_pstate.c | 7 +------
 include/linux/cpufreq.h        | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 81117e4d43cc..091789e868ee 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1116,7 +1116,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 	return ret;
 }
 
-static void refresh_frequency_limits(struct cpufreq_policy *policy)
+void refresh_frequency_limits(struct cpufreq_policy *policy)
 {
 	struct cpufreq_policy new_policy;
 
@@ -1133,6 +1133,7 @@ static void refresh_frequency_limits(struct cpufreq_policy *policy)
 
 	up_write(&policy->rwsem);
 }
+EXPORT_SYMBOL(refresh_frequency_limits);
 
 static void handle_update(struct work_struct *work)
 {
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f2ff5de988c1..cc27d4c59dca 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -898,7 +898,6 @@ static void intel_pstate_update_policies(void)
 static void intel_pstate_update_max_freq(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-	struct cpufreq_policy new_policy;
 	struct cpudata *cpudata;
 
 	if (!policy)
@@ -908,11 +907,7 @@ static void intel_pstate_update_max_freq(unsigned int cpu)
 	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
 
-	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
-	new_policy.min = min(policy->user_policy.min, new_policy.max);
-
-	cpufreq_set_policy(policy, &new_policy);
+	refresh_frequency_limits(policy);
 
 	cpufreq_cpu_release(policy);
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95425941f46d..1fa37b675a80 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -207,6 +207,7 @@ void cpufreq_cpu_release(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 int cpufreq_set_policy(struct cpufreq_policy *policy,
 		       struct cpufreq_policy *new_policy);
+void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);
-- 
2.21.0.rc0.269.g1a574e7a288b

