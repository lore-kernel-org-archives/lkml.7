Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E890C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259D32085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLOnMQXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfCNGnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44581 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfCNGna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id h34so3304171pgh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gau8qlK9lYlCkFsnqnqItN7NoeHxD4E7ZSFErNPXgA4=;
        b=RLOnMQXkHi2HZm4bmQA0sLNXWNQW0CH3U3TiMA50yPp92jnLFhTjR+yd+dyTIWwMuX
         +0oeC9HkNf2ixELn3+rAYVsWVA71CR57dJ6RM1vqxcLMTFzJc/tLNTcLE7dgC2z6me8/
         EBrpOdgzVVgR8sysX8SVNbf3us+Gc05qvHGJ8midp2dXjnav8aGf3zJlRaJKOZP55FRx
         KgjqyV7f0vib6WBR6o5z38x8tsSi7g/r0S3OXN9aSXkavdejG+uRJM4N9LLD8AG7we1s
         J5CtTKAcnTjLOhKxStNjuc5E0dGEu0u80Ws4jtuqScH6JUj7NVGdMfI9GmQlfxhsfyPg
         UDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gau8qlK9lYlCkFsnqnqItN7NoeHxD4E7ZSFErNPXgA4=;
        b=MUMtlg8YDLuNaD11utaqv1GpKlW3ba3N/A2uulD5s9FG/QbZIiVJJrN9T7gXse0kdH
         8LWHQa5g7lr84QZzXxnAau1Eoc88wWAPrKFgM9VHDfd87YqEzri4A9DHjbM+4nFOH2WU
         56e6lE+1R9cLi0+z3cMqLAOAa9lokRQMsX7J4G9C2/cQwoxDwPnoiJOPrfn5D5Q9+IYg
         sD4mQwbMUrF5DMqIeFiCAd0kYHgmAUxpIvLNHhWNDcTIh4oaDctEl/DyBVrsl7ruxazr
         vhpJhfHD+yQb1Z4rdlCCOyMMn/1pMN08za0CINZcQNZRckAOsGEbJIkPH+4g4vzceAvD
         gZtA==
X-Gm-Message-State: APjAAAW9B48CbrnBlJI/I3a2EJmFQrFUxUVuQmKe0BfXXTKQuTMYUGr/
        sMJmVh2jivZ7NwIi/13tpxr9Yg==
X-Google-Smtp-Source: APXvYqxbSJZzzKsaof7Eb4IMfSCrTvkAry2FOR9NZQQQWjLabmBf38M5lS34sLRpQAjaPQpsyzIRbA==
X-Received: by 2002:a62:b61a:: with SMTP id j26mr47461072pff.151.1552545809013;
        Wed, 13 Mar 2019 23:43:29 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id o5sm13049375pgc.16.2019.03.13.23.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:43:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] sparc64: Update cpufreq transition notifier to handle multiple CPUs
Date:   Thu, 14 Mar 2019 12:12:50 +0530
Message-Id: <f4eb2ed1e473ca9bb4c0a9ace27d816f4840f531.1552545525.git.viresh.kumar@linaro.org>
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

This patch updates sparc64_cpufreq_notifier() to use the new "cpus" field
and update per-cpu data for all the related CPUs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/sparc/kernel/time_64.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 3eb77943ce12..23544646695f 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -653,19 +653,23 @@ static int sparc64_cpufreq_notifier(struct notifier_block *nb, unsigned long val
 				    void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	unsigned int cpu = freq->cpu;
-	struct freq_table *ft = &per_cpu(sparc64_freq_table, cpu);
+	unsigned int cpu;
+	struct freq_table *ft;
 
-	if (!ft->ref_freq) {
-		ft->ref_freq = freq->old;
-		ft->clock_tick_ref = cpu_data(cpu).clock_tick;
-	}
-	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
-	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
-		cpu_data(cpu).clock_tick =
-			cpufreq_scale(ft->clock_tick_ref,
-				      ft->ref_freq,
-				      freq->new);
+	for_each_cpu(cpu, freq->cpus) {
+		ft = &per_cpu(sparc64_freq_table, cpu);
+
+		if (!ft->ref_freq) {
+			ft->ref_freq = freq->old;
+			ft->clock_tick_ref = cpu_data(cpu).clock_tick;
+		}
+
+		if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+		    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
+			cpu_data(cpu).clock_tick =
+				cpufreq_scale(ft->clock_tick_ref, ft->ref_freq,
+					      freq->new);
+		}
 	}
 
 	return 0;
-- 
2.21.0.rc0.269.g1a574e7a288b

