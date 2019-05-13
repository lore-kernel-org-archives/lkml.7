Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2096E20850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1vBqM2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEMTaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:30:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34219 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfEMTaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:30:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id j24so11288455ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v5R43yf4/qed6bgDurPjUl3jOQa4Rl4O09rX4nZosQI=;
        b=n1vBqM2Wy+eX7IIQwl58KXauTGw8VuTEGAX0h49n6Y7x7DeOz7yckXoyzuskCHuZba
         1xAff9sl5Pn24Ww5EjGImQxE+Xjp0ZlEpFiRP2XtesR7J79ntNXSjy5FeLhv2J8vZg+s
         HvwlRlO1bFAQ2/iSrQsGbnUzYubUQ1MND9xOUp8qstnZys3tixpffazhGjpJm2B4Cs0K
         +wZIkTKzjh7afvMrsGBeVFajOFnWn4D56sbRZOF7ZTR2lA4wT3bBpQp+eeoG2HSjPOm7
         jEERqEEeDnlsjbgODSFVGzARt+Jknp8L9nxIOXc38jr5PsMUb8Vm3lVE80bFETDWU2ua
         nuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v5R43yf4/qed6bgDurPjUl3jOQa4Rl4O09rX4nZosQI=;
        b=Aqpu2McT8tS39p8xIE/R3jR5M9vA2M181Tv5yHS7UiQEaHn0ztr3ix/NVmDTt0ZL/D
         yYTpO1WjqrPM/+BpFdpVWuNhtp1DkbVY36/a7qvNz+BkDcN5f/VjpaT5lfEJnaJd6HWa
         pu0WowoKs6VpprJW99G8+Jhp+Qw4lP3S89XT7rowvdBl0oWxpMbp+nRfxYl3l+QdztVN
         0r5xYdnAYhL/yL+3NExa7voCdfD6oXI/GHUeQcfEf2L07FjqC9T3TTmc8UgbhEoDag/L
         fJt9SW0ccXkGhKwyfNw2Dc0xquAdhRhnvJPD2YXSSZct2U9Nc3VLf4jOq4SfXcn+6zkm
         JhLg==
X-Gm-Message-State: APjAAAXPiNTXTH0u0kWoSibfYtx0yVkZ3zLNwgKLnDJedHh/SW6Dk1ZB
        AauQuKpHoSYQh0T/EvvscM2c/w==
X-Google-Smtp-Source: APXvYqx2Vh1KSuzK1Is/V87g7ZsLmQej7M/ZhTd5zzA/N3YXZQ+9NtPLtW9JLqQfxVA+I0oz+0bQLw==
X-Received: by 2002:a2e:4701:: with SMTP id u1mr10153531lja.38.1557775404368;
        Mon, 13 May 2019 12:23:24 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:23 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/18] drivers: firmware: psci: Add hierarchical domain idle states converter
Date:   Mon, 13 May 2019 21:22:52 +0200
Message-Id: <20190513192300.653-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hierarchical CPU topology is used, but the OS initiated mode isn't
supported, we need to rely solely on the regular cpuidle framework to
manage the idle state selection, rather than using genpd and its governor.

For this reason, introduce a new PSCI DT helper function,
psci_dt_pm_domains_parse_states(), which parses and converts the
hierarchically described domain idle states from DT, into regular flattened
cpuidle states. The converted states are added to the existing cpuidle
driver's array of idle states, which make them available for cpuidle.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Some simplification of the code.

---
 drivers/firmware/psci/psci.h           |   5 ++
 drivers/firmware/psci/psci_pm_domain.c | 118 +++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index 00d2e3dcef49..c36e0e6649e9 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -3,6 +3,7 @@
 #ifndef __PSCI_H
 #define __PSCI_H
 
+struct cpuidle_driver;
 struct device_node;
 
 int psci_set_osi_mode(void);
@@ -13,8 +14,12 @@ void psci_set_domain_state(u32 state);
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 int psci_dt_init_pm_domains(struct device_node *np);
+int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
+		struct device_node *cpu_node, u32 *psci_states);
 #else
 static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
+static inline int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
+		struct device_node *cpu_node, u32 *psci_states) { return 0; }
 #endif
 #endif
 
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
index 3c6ca846caf4..3aa645dba81b 100644
--- a/drivers/firmware/psci/psci_pm_domain.c
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -14,6 +14,10 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+
+#include <asm/cpuidle.h>
 
 #include "psci.h"
 
@@ -104,6 +108,53 @@ static void psci_pd_free_states(struct genpd_power_state *states,
 	kfree(states);
 }
 
+static int psci_pd_enter_pc(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int idx)
+{
+	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, idx);
+}
+
+static void psci_pd_enter_s2idle_pc(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int idx)
+{
+	psci_pd_enter_pc(dev, drv, idx);
+}
+
+static void psci_pd_convert_states(struct cpuidle_state *idle_state,
+			u32 *psci_state, struct genpd_power_state *state)
+{
+	u32 *state_data = state->data;
+	u64 target_residency_us = state->residency_ns;
+	u64 exit_latency_us = state->power_on_latency_ns +
+			state->power_off_latency_ns;
+
+	*psci_state = *state_data;
+	do_div(target_residency_us, 1000);
+	idle_state->target_residency = target_residency_us;
+	do_div(exit_latency_us, 1000);
+	idle_state->exit_latency = exit_latency_us;
+	idle_state->enter = &psci_pd_enter_pc;
+	idle_state->enter_s2idle = &psci_pd_enter_s2idle_pc;
+	idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
+	strncpy(idle_state->name, to_of_node(state->fwnode)->name,
+		CPUIDLE_NAME_LEN - 1);
+	strncpy(idle_state->desc, to_of_node(state->fwnode)->name,
+		CPUIDLE_NAME_LEN - 1);
+}
+
+static bool psci_pd_is_provider(struct device_node *np)
+{
+	struct psci_pd_provider *pd_prov, *it;
+
+	list_for_each_entry_safe(pd_prov, it, &psci_pd_providers, link) {
+		if (pd_prov->node == np)
+			return true;
+	}
+
+	return false;
+}
+
 static int psci_pd_init(struct device_node *np)
 {
 	struct generic_pm_domain *pd;
@@ -265,4 +316,71 @@ int psci_dt_init_pm_domains(struct device_node *np)
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
 	return ret;
 }
+
+int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, u32 *psci_states)
+{
+	struct genpd_power_state *pd_states;
+	struct of_phandle_args args;
+	int ret, pd_state_count, i, state_idx, psci_idx;
+	u32 cpu_psci_state = psci_states[drv->state_count - 2];
+	struct device_node *np = of_node_get(cpu_node);
+
+
+	/* Walk the CPU topology to find compatible domain idle states. */
+	while (np) {
+		ret = of_parse_phandle_with_args(np, "power-domains",
+					"#power-domain-cells", 0, &args);
+		of_node_put(np);
+		if (ret)
+			return 0;
+
+		np = args.np;
+
+		/* Verify that the node represents a psci pd provider. */
+		if (!psci_pd_is_provider(np)) {
+			of_node_put(np);
+			return 0;
+		}
+
+		/* Parse for compatible domain idle states. */
+		ret = psci_pd_parse_states(np, &pd_states, &pd_state_count);
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
+
+		i = 0;
+		while (i < pd_state_count) {
+
+			state_idx = drv->state_count;
+			if (state_idx >= CPUIDLE_STATE_MAX) {
+				pr_warn("exceeding max cpuidle states\n");
+				of_node_put(np);
+				return 0;
+			}
+
+			/* WFI state is not part of psci_states. */
+			psci_idx = state_idx - 1 + i;
+			psci_pd_convert_states(&drv->states[state_idx + i],
+					&psci_states[psci_idx], &pd_states[i]);
+
+			/*
+			 * In the hierarchical CPU topology the master PM domain
+			 * idle state's DT property, "arm,psci-suspend-param",
+			 * don't contain the bits for the idle state of the CPU,
+			 * let's add those here.
+			 */
+			psci_states[psci_idx] |= cpu_psci_state;
+			pr_debug("psci-power-state %#x index %d\n",
+				psci_states[psci_idx], psci_idx);
+
+			drv->state_count++;
+			i++;
+		}
+		psci_pd_free_states(pd_states, pd_state_count);
+	}
+
+	return 0;
+}
 #endif
-- 
2.17.1

