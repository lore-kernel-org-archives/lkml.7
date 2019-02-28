Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0031C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF8420C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5dc9YJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbfB1N7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:59:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39223 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbfB1N7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id g80so17201774ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XTL5kvu2ODR6s8WzbGt1Q9EGWFN00ZZECyFc5WKOL08=;
        b=v5dc9YJ2CfLXA88Ddg4mdr8OXTZWdV8R70YevFWUfu2VAN9Rybotd5gA5nzXDb6gT7
         ZLoVqbpcCW68+/GbRxNIeO0Q/qO9KbPtG3wwIVHw/xiMXN3fm+eI9683YYbfZGfdwZ94
         4KxI094X2myvVe84L6FSjJSGiwzf8aSQCuFCQKcOGtknhZ3BKbkNK30++qMcxYHYsXIJ
         LvLezvV4gropCpiWw7dRzW/ni27ZK0rip3bjrOw/g83OAkknUrab1jGopnDuHV+iRGIe
         tbP7xRud7elrzW1PRRsugDFX0ZmQhUqrwFq7W4Q95XsIG4QbZ4S9fS7eKK63VCw3QULE
         0t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XTL5kvu2ODR6s8WzbGt1Q9EGWFN00ZZECyFc5WKOL08=;
        b=Gn4ItGJ+xHs/Ow5t8sCL80KNakJuWcbSfcj1WcZD4/wH9BJCFxbOvWUJq7f6b+IcA+
         35H6VunS5kPY8gExtmJ0Hc9A7p8aTniavAKzx1UaZ+jWHD1ACN1j+AebA+KNlt0rw3O6
         RIYb5hKB5UZUhYOXq43k0S5DVOFsONpFxeUZGLejbBUCr1IvLz/WmthSdtj0AR/VuWxW
         5NNdQ2M45XxVOm3uxnCGtCQHo/MCX8TDwHZcZO9cjtfbchm2hv0vj0jik98v8cpID5qi
         iCnZdxgCNnk42xZJKqzr+hTKCbOxaKsJl/2Dv222WMaWnvetEfqV/HEEZlAtoEr3/H/H
         ot/g==
X-Gm-Message-State: AHQUAuYqHPnSznJ6jqCUO/R56scg6wzZ7Wy5VSyDVuOLKmvJRf1OGQ39
        9HUQRWBt7dqBSdmOfpwgTp0fMg==
X-Google-Smtp-Source: AHgI3IY2ox/XeGe6KsY5KJUJU6v/IZ2wfliDAnc848cYmdj8zrb5B2R5Xl4tkL4goYIX7vfo9L+BDw==
X-Received: by 2002:a2e:21d2:: with SMTP id h79mr4411563lji.39.1551362369923;
        Thu, 28 Feb 2019 05:59:29 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v20sm4090265ljv.83.2019.02.28.05.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:59:29 -0800 (PST)
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
Subject: [PATCH 3/7] drivers: firmware: psci: Split psci_dt_cpu_init_idle()
Date:   Thu, 28 Feb 2019 14:59:15 +0100
Message-Id: <20190228135919.3747-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228135919.3747-1-ulf.hansson@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's split the psci_dt_cpu_init_idle() function into two functions. This
makes the code clearer and provides better re-usability.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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

