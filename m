Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E4CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39042171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZKTNnD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfCMIhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:37:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44178 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfCMIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:37:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id u9so784575lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fqLAcdPj/NLZOrfZZI3kgT4b9oSplDLhcdYfEWYk7f0=;
        b=PZKTNnD2nwwHzJ7qoJoJQv4NDheskpbJ1YxcSM9eJF4owUl/WfZng6DstF/znQ8x8B
         pDEo/pJ61thVr5M/+qqLUAkj0+OBtXQmLuwrGxf8WSVHw+IiaOlDqV1fsXTjNCKgAnQb
         TJzEXazOl8YtWqn5cOuHlqSFQO2jQXIoQrLaXx9VcX1FNUp8cauGDy/4rLGCUvJ8sxZ0
         yxM5fF/CvN6YRxRRiq8FvpO/JGQb9QX2B1LfzOKTw7H1qQlBUuh408M+G0j74Gxi+xsP
         Tj/lfMCSQb/y/txQziLhAwYHSbtcWmjdMsHdd5LP0Jn9TS5jwo4vy2Z9wpRpmN50a57J
         jIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fqLAcdPj/NLZOrfZZI3kgT4b9oSplDLhcdYfEWYk7f0=;
        b=A0BjdOssTKENm/ihNC0mL8/3dKdL3H3sZ9THenrX8JQmF2u0kU9uDib3QtoTSwohun
         fZouqR6tXe6wXJWyvbUBLzT4LcV0bb8BCV+KSRCa5juJ6VUIbcig38SDTXgNtoqhLxs8
         Gd9GuW3WS0fTENwgVlMSsHFyqvjj8Y+bpdZHNQwiOZPlfTMJkb9Nr0kJ87Hsd5NbnLJM
         85y4ewW0MSRxa3gNihbRQEe67bD2p6TVVrpHiFI6JOZPKfooJIf7bplVKwkYKL5RU7ap
         AlYyG5GtrAvlSs6IeIKbvBUCIvJZX89E/xLK54B0sYboPVeAKaVQKSlKWktF8kpFlO+i
         70xg==
X-Gm-Message-State: APjAAAVwvpLnX2lWv0huCfmRKC1tzMPFDSueY3JlH0/NOdVSvV7MmVIS
        vFeshV3mLzskT9fesd4GAszCiA==
X-Google-Smtp-Source: APXvYqw0YNNaw6inULtc2yUsTyMmfoNTgmT4UYRb7G0yq3HhG73gLEOmrT21PpBm2ilWoX4z2aWjGw==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr1139636lfk.25.1552466229393;
        Wed, 13 Mar 2019 01:37:09 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a23sm1707716ljd.20.2019.03.13.01.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 01:37:08 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] drivers: firmware: psci: Split psci_dt_cpu_init_idle()
Date:   Wed, 13 Mar 2019 09:36:57 +0100
Message-Id: <20190313083659.7100-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190313083659.7100-1-ulf.hansson@linaro.org>
References: <20190313083659.7100-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's split the psci_dt_cpu_init_idle() function into two functions. This
makes the code clearer and provides better re-usability.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index c80ec1d03274..9788bfc1cf8b 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -270,9 +270,26 @@ static int __init psci_features(u32 psci_func_id)
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 
+static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+{
+	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
+
+	if (err) {
+		pr_warn("%pOF missing arm,psci-suspend-param property\n", np);
+		return err;
+	}
+
+	if (!psci_power_state_is_valid(*state)) {
+		pr_warn("Invalid PSCI power state %#x\n", *state);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 {
-	int i, ret, count = 0;
+	int i, ret = 0, count = 0;
 	u32 *psci_states;
 	struct device_node *state_node;
 
@@ -291,29 +308,16 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
-		u32 state;
-
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
+		of_node_put(state_node);
 
-		ret = of_property_read_u32(state_node,
-					   "arm,psci-suspend-param",
-					   &state);
-		if (ret) {
-			pr_warn(" * %pOF missing arm,psci-suspend-param property\n",
-				state_node);
-			of_node_put(state_node);
+		if (ret)
 			goto free_mem;
-		}
 
-		of_node_put(state_node);
-		pr_debug("psci-power-state %#x index %d\n", state, i);
-		if (!psci_power_state_is_valid(state)) {
-			pr_warn("Invalid PSCI power state %#x\n", state);
-			ret = -EINVAL;
-			goto free_mem;
-		}
-		psci_states[i] = state;
+		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1

