Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE35C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C499206E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGDylwQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLCAmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:42:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33541 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLCAmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:42:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so1439872lfl.0;
        Mon, 02 Dec 2019 16:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9kXKgBrYXH+hSm9TkMRosOtHlt6sNljimu1oTCcerc=;
        b=LGDylwQ1uES/B4cybQXOfkvOFEhf0Hm84ek9j4YkQe99WFBJwpYQTSlqLObeFSkH16
         iAs0jzYnz4icjgNDVq5kavQUC0NULbYVB0io3HZU0xzCpvekX8ZCwTilMv4rEdD/tBAZ
         tUN8PKZJRi6CPLqYRNbNGkK8/VwUm56feKkLYoLmnPZIpLijdC8GB0iNA1tbwkw0ge+J
         03GFZ5pLKRR/nzuUmtN6mvd4ITYfPCs6+7251TwM9a+wT8OJmSUQJYZDQ+DsazTMS5aD
         o0YjlkbOS2dL+y2Xw7RPjFCKi9qwrKJbgpwYFX8XEw96s/ssLcWxUoBS7ytHQQZPBMer
         5BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9kXKgBrYXH+hSm9TkMRosOtHlt6sNljimu1oTCcerc=;
        b=ucw5Elvt88/7JNhkP2WNjVJJv/P0nJAR0KfrXhRhqxGlK01DEbd0ay2JIofkMATwFC
         2jitXzkNsmfxetL+EoLWMshoI71JEuMtSjkgpofLrBEEwuYW8U0TDwgA0m2XQGsT8BSD
         cHR2m99Gkghj71/xxOi8+fRpAfK5SNb7YmlraMbbw4LjOLQWZJcv6y4nS9odMN+4ZCRw
         Shjr6CII7IH3v3nTySXMHzMoBhX4E+bkKcwU4lWmGnYiCV933dicGHCYxi58mxqQm9UB
         pr2xU+HOopVMCrlNoUafNwOhCiufGcaAIVBsB0Z88FVfi6HzgKRDF2BOz07c+Szlxjna
         4KSw==
X-Gm-Message-State: APjAAAU0GunRrDMrzcfpaKNRVRI7/md8e8t4ejGADh4LLg0WWcRDexnx
        vgJfA/+UTSa+ZrzIR/5n43E=
X-Google-Smtp-Source: APXvYqyCWZUYj7IQPwpmCQO5dZi3l3VfqdgaW/bUqPRVmQbxgEnXrSU1/qr8rk2oDFgLc2tLfKbcFw==
X-Received: by 2002:ac2:568d:: with SMTP id 13mr1002023lfr.113.1575333730737;
        Mon, 02 Dec 2019 16:42:10 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/19] arm: tegra20: cpuidle: Handle case where secondary CPU hangs on entering LP2
Date:   Tue,  3 Dec 2019 03:41:06 +0300
Message-Id: <20191203004116.11771-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that something may go wrong with the secondary CPU, in that
case it is much nicer to get a dump of the flow-controller state before
hanging machine.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 46 +++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 9672c619f4bc..f3a898f69a1d 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -83,14 +83,56 @@ static inline void tegra20_wake_cpu1_from_reset(void)
 }
 #endif
 
+static void tegra20_report_cpus_state(void)
+{
+	unsigned int cpu, lcpu;
+
+	pr_err("secondary CPU taking too long to park\n");
+
+	for_each_cpu(lcpu, cpu_possible_mask) {
+		cpu = cpu_logical_map(lcpu);
+
+		pr_err("cpu%u: online=%d flowctrl_csr=0x%08x\n",
+		       cpu, cpu_online(lcpu), flowctrl_read_cpu_csr(cpu));
+	}
+}
+
+static int tegra20_wait_for_secondary_cpu_parking(void)
+{
+	unsigned int retries = 3;
+
+	while (retries--) {
+		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
+
+		/*
+		 * The primary CPU0 core shall wait for the secondaries
+		 * shutdown in order to power-off CPU's cluster safely.
+		 * The timeout value depends on the current CPU frequency,
+		 * it takes about 40-150us  in average and over 1000us in
+		 * a worst case scenario.
+		 */
+		do {
+			if (tegra_cpu_rail_off_ready())
+				return 0;
+
+		} while (ktime_before(ktime_get(), timeout));
+
+		tegra20_report_cpus_state();
+	}
+
+	pr_err("timed out waiting secondaries to park\n");
+
+	return -ETIMEDOUT;
+}
+
 static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
 					   int index)
 {
 	bool ret;
 
-	while (!tegra_cpu_rail_off_ready())
-		cpu_relax();
+	if (tegra20_wait_for_secondary_cpu_parking())
+		return false;
 
 	ret = !tegra_pm_enter_lp2();
 
-- 
2.24.0

