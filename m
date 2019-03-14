Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF893C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0AC2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VcL7RStD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfCNGng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36394 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfCNGnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id n22so3192217pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Efw/h9eTUmSrpQZIt5XLwN4VOh2Yp4TaPqLXIdGnJE=;
        b=VcL7RStD7ZUOTVl184RkW56AOC5OcqHevP735305y843u+17laziRgHfgqbGKiwE3q
         +aFw0iSojIYAqnB9AMwRoWtlmWGH5F3SkUBMLj1yO3rhcyomSDvrEnZkUyckXDAcIZ9i
         0oqiWh25f7QEAYxUmF7FllPqrj06OP72PB2vqNEH2HirpWxjftj3Q/kiDbxUpu81X88u
         2gf1ssoQwtl5f6YBbkHk4LKoU0MCWPPVt5ahTurryAHhL+C7qfqHj/8MPfH9UrdFV0g4
         /TIi3GxmG3J4QV/DggNwDIAMjNe32yGBXN5TRLQX9DppzLWl47iiFN4qSlEAHcPWBRhp
         COAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Efw/h9eTUmSrpQZIt5XLwN4VOh2Yp4TaPqLXIdGnJE=;
        b=tIpMjPNecQ6Y16cm8MckBnyKfS0g/mJe+NNUeJmfNY1CnEYPYxEPgKdICeFlwrM8fC
         Jsjnfy98IDSXisSQzTp/kcFmpUmXkxjyNON86UJeC77D7z6QYHa4WmO/rxJSWAxmckl0
         HemtGnP2cxO37UfxzKMfWSNtnyFoESFdQkB/hTpvhORhGXgjJIllipud/wBvrrhh9Bjs
         pMx5B4CnJ6cyLBc/3EID6zHwj3GshTJGDG4mDyXwzvSTM8GSlIS4pC9x9UkZOhxq8lno
         y5vjQ+I2qMRtKlGhGjaLbpVDQYQnmSAR/G9agoA6XXg9Bx3AAhmQJzR2I9A7us3hmfeY
         Ullw==
X-Gm-Message-State: APjAAAUQph8O8di2AEO2iDG6d2TN59ub/Ev7q6YSdBh/wT83yad9mERN
        woU8062qTNpFEXcPy30a7uxxMA==
X-Google-Smtp-Source: APXvYqyaWFgdo3j0beXfgSjsZGeDZmkZ5WkqeQqgheNRssaXLqV1E5AceiX+pg5N/MznmLrqahh96g==
X-Received: by 2002:a63:6a88:: with SMTP id f130mr43285394pgc.114.1552545812067;
        Wed, 13 Mar 2019 23:43:32 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id q18sm21517128pgv.9.2019.03.13.23.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:43:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] x86/tsc: Update cpufreq transition notifier to handle multiple CPUs
Date:   Thu, 14 Mar 2019 12:12:51 +0530
Message-Id: <8a27342332bc467242f6ccdb4d4bd4d10f8aa552.1552545525.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core currently calls the cpufreq transition notifier
callback once for each affected CPU. This is going to change soon and
the cpufreq core will call the callback only once for each cpufreq
policy. The callback must look at the newly added field in struct
cpufreq_freqs, "cpus", which contains policy->related_cpus (both
online/offline CPUs) and perform per-cpu actions for them if any.

This patch updates time_cpufreq_notifier() to use the new "cpus" field,
update per-cpu data for all the related CPUs and call set_cyc2ns_scale()
for all online related_cpus.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/x86/kernel/tsc.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..587a6aa72f38 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -956,28 +956,37 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 				void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	unsigned long *lpj;
-
-	lpj = &boot_cpu_data.loops_per_jiffy;
-#ifdef CONFIG_SMP
-	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
-#endif
+	bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
+	unsigned long lpj;
+	int cpu;
 
 	if (!ref_freq) {
 		ref_freq = freq->old;
-		loops_per_jiffy_ref = *lpj;
 		tsc_khz_ref = tsc_khz;
+
+		if (boot_cpu)
+			loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
+		else
+			loops_per_jiffy_ref = cpu_data(cpumask_first(freq->cpus)).loops_per_jiffy;
 	}
+
 	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
 			(val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
-		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
-
+		lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
+
 		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
 			mark_tsc_unstable("cpufreq changes");
 
-		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
+		if (boot_cpu) {
+			boot_cpu_data.loops_per_jiffy = lpj;
+		} else {
+			for_each_cpu(cpu, freq->cpus)
+				cpu_data(cpu).loops_per_jiffy = lpj;
+		}
+
+		for_each_cpu_and(cpu, freq->cpus, cpu_online_mask)
+			set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
 	}
 
 	return 0;
-- 
2.21.0.rc0.269.g1a574e7a288b

