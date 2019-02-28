Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42770C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEA82171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNKVdDKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfB1OAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:00:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42058 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbfB1N7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id d14so17186397ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tetivCWSellxrqLjg5oJkokMZQX4qsIXobIakEVk0Q0=;
        b=VNKVdDKp77nYxziG1tXDB+1+YC00/86ektZ137JuDXUybb+p7BQWP/4Nds+yqaWlib
         rDjw3j1RqlhfUzBaH0AhhEP3Oal0r0XwMCa89QOTJGA8qt68/R7WnvbQg23bXvoPHmA1
         /+bIe0i+NlwTCQ1sv6umubGa15+P+2rAGbGXpMzM50QabTblZh6vh0GLMy2yhKPIinTK
         gvv1liY4PiqHQoOL24Lc50pUtriYV8B+8xRnBMe9TWpLa8IR32lR+o4JoTVyrb+DLU6P
         45yDEaBHUzdwLkw7YMe5csbeq8sqZ1TXrTHoviYLSuzSWdtpnTLoVac9lYSgmfg65C0L
         p1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tetivCWSellxrqLjg5oJkokMZQX4qsIXobIakEVk0Q0=;
        b=BGImdiMiG2pbufv7vC4ktScvXeJg57eBRDo8VXmSe1okrctlGjvxCpU3yvHI2E0rRN
         sn8XHlI/8zxGPgA54xOsd4RYwXv15lkVqJRcELkrk1JA/1ZEO0T7Y3MMGpschKqIijRA
         RfbbhahpSIGdVfP2koaRCVZhHrjDbJ4MFchr+bVSX0pHygBHC7bCHdOrmDs/Z5BTgK8U
         YlMvB9yUfexZPwtfa3m9lDDuJgqFz+Z5M+iY6k/mDUlV9UCBE5KUoX6Ad1n2u2knfzKO
         1jZCVA6sqzTNnzc1VnQVxeqe4JE2S6bH5u1BTFVVWJnQu5NXmbzzVCSXJyMdSwo1ZlTV
         KOmA==
X-Gm-Message-State: APjAAAWraYcM3jIoYnwVKemvOfu614/0U1HB8VEQAwTS7Gd4XFcQ0mEg
        DBovTQWlMsatPsS0HPB/8uEpoQ==
X-Google-Smtp-Source: APXvYqx5P/Vqp+ogLd3hKLL4ats904OggXBtyJF+UQCD1hAYH52E0UWO5ytjMCr4hSE78iI1sOvulQ==
X-Received: by 2002:a2e:2c0d:: with SMTP id s13mr5097543ljs.96.1551362372749;
        Thu, 28 Feb 2019 05:59:32 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v20sm4090265ljv.83.2019.02.28.05.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:59:32 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date:   Thu, 28 Feb 2019 14:59:17 +0100
Message-Id: <20190228135919.3747-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228135919.3747-1-ulf.hansson@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating through all the state nodes in DT, to find out how
many states that needs to be allocated, let's use the number already known
by the cpuidle driver. In this way we can drop the iteration altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d50b46a0528f..cbfc936d251c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
 {
-	int i, ret = 0, count = 0;
+	int i, ret = 0, num_state_nodes = drv->state_count - 1;
 	u32 *psci_states;
 	struct device_node *state_node;
 
-	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
-		count++;
-		of_node_put(state_node);
-	}
-
-	if (!count)
-		return -ENODEV;
-
-	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < num_state_nodes; i++) {
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
@@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
 
+	if (i != num_state_nodes) {
+		ret = -ENODEV;
+		goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1

