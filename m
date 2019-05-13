Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DFAC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5E22070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihwtaKGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfEMTXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:23:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45538 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbfEMTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:23:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id r76so12042380lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F5AEltUKfed5w7dHNisHSX8S1wBzU63rf2dZ2cHwfSs=;
        b=ihwtaKGHm5HWQDkvQkty6/m7be/aDE2Ue2EF8h2aUL7J5q3dbOjBQl/7riCd7391Bk
         6mt4yavZncehbr1dqBkKzd5+XE6F5UVYInUI/aMbhArbPszaqyttf3MVOOEailuYdP3R
         fucpydZkU9Xe7taVXR0KfQZCmk+WPepu9Fz5czOMEkZzxq0cyv/O9xzdwPbelTwhxiAt
         AgLFcBQz4OuHsSIHPRYM79Mx2eXRaijBK738WDXPRnaM8wcxzwaXGNHAtjVqh3N6NVfn
         PALPweQK2a7Hw+qtF1599CtdwmhaZJP3Loxm6jMlG87c2/LPW1b4sxzN22fBdrGhOVkv
         xgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F5AEltUKfed5w7dHNisHSX8S1wBzU63rf2dZ2cHwfSs=;
        b=EEj0eYX2xG8jtxfK6gt62U5VgpDqMs2DNcVLVlK6af+vVDbYj8pGENGnn5ZcASNWC0
         xo/+bJbveSYjrObQP+Qs9U8L0BRFd+0YNl6840dVHgTM0hiFJH9ONkc/iE37XWLwS1fS
         qO05CNKq6bFgZMz9/PiY/6259ynpasIGyIGchRg1FDchrtwXx5HYnr2Gk52Yah7B16lm
         wTgIvFTpCbiFiR+PcbtA1q7ndGGoQs8a5wFx6tFMzVoolA9ebmES41rm62TAazHVnnds
         BfJ82jvVj+ovkLv56JJyWub8iw0V4U4kmDZ8kxGBXkC3TMm6luhMzpk1WW6XK7whlc7y
         BFVQ==
X-Gm-Message-State: APjAAAVBtnS7CQ6r0O90/NA0dnktRWeMtnGtEQG5dJEz2V5pRRnN+EJG
        cuHJ0UwSMWpTqGOd6WzXCH2cQg==
X-Google-Smtp-Source: APXvYqxS293Cibnm8BvM4OA/7mePaZMMHGVjPn5T9aLCXEe34R5mqSI/nCjgK/Ib9ssZWuTZNP1Trw==
X-Received: by 2002:a2e:c41:: with SMTP id o1mr8693546ljd.23.1557775391156;
        Mon, 13 May 2019 12:23:11 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:10 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/18] cpuidle: dt: Support hierarchical CPU idle states
Date:   Mon, 13 May 2019 21:22:45 +0200
Message-Id: <20190513192300.653-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Currently CPU's idle states are represented in a flattened model, via the
"cpu-idle-states" binding from within the CPU's device nodes.

Support the hierarchical layout during parsing and validating of the CPU's
idle states. This is simply done by calling the new OF helper,
of_get_cpu_state_node().

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- None.

---
 drivers/cpuidle/dt_idle_states.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index add9569636b5..97ad25399ca8 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -114,8 +114,7 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
 	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
 	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
 		cpu_node = of_cpu_device_node_get(cpu);
-		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-						   idx);
+		curr_state_node = of_get_cpu_state_node(cpu_node, idx);
 		if (state_node != curr_state_node)
 			valid = false;
 
@@ -173,7 +172,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 	cpu_node = of_cpu_device_node_get(cpumask_first(cpumask));
 
 	for (i = 0; ; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		if (!state_node)
 			break;
 
-- 
2.17.1

