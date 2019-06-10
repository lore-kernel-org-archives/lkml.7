Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D6CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEBB20862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK94e/9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbfFJQsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:48:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38766 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfFJQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:48:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id g13so15410761edu.5;
        Mon, 10 Jun 2019 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bj9lNf33fh+rEtf8sXE10188oYg8Fc5GxZhdI5k3+ac=;
        b=pK94e/9gXlvUnvPlAyWj6gAf6ahQhVrDkoAk+AGCKQlTc7vwcoi/TnhTNEw/rvNjCM
         K87jqnpVYee6JHIe2XqxL8Gq5SrhjJkHyc6GErrRuGdoj89CXCv1gS1vTYppC5XuyKgY
         4nvjQJv/Iud/pXsa8Uv2iBmona9KdJxs7cZBJKOgjhBt0Ectx2eVC+d3McKoL9SFgvC9
         CVIBomvJfjQNMEYjw+WfJKMQhWrgVIrfMSkjAh+3p1ljEV7Sl9oa53CyQ91uQN71XE7n
         LVGN0FOYA8T04V83Y/XJe+ojclAvV7y03nCAbNSCTfXJrLqgcwMVQDs/sdXAsHmnsfIJ
         WaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bj9lNf33fh+rEtf8sXE10188oYg8Fc5GxZhdI5k3+ac=;
        b=abeJFb/o1l/rPxBCzIQGJ+uB3ccDWTgY4USLkZN9gATbTlzL2KFMI/xMFXiXgW2S58
         rC7wboruhk/1J99cB4CxOMN2/53wnMtXCV4xr0bHqA+4dXX+8q2T6/YnTZxauKcwqBjF
         sDiefOOpixRwu/uqZxpCLUzUwPLxIYne7Uk7sysA2IPJZHljZxQ8f/RFgV1SzOK/r+nR
         xjCfeVtGceP1yVss6un5GuVXj6pIusI9aZ+Eb5e5I3/qYwSc4Uo/EBH6YYgpBQvmtc/q
         6eMg2V2c7rZgAJe4U7qLldbOYR/bg///a0YfedOPmFGkP+K39TsDBHHE8mt+QkmHgumM
         Swig==
X-Gm-Message-State: APjAAAUrAZyHX75rn7K5goKuzlbGK7XzUVHTv9L0h7EzFqFcWc33hL4A
        mUVIw4BjykIpt81ETNAultY=
X-Google-Smtp-Source: APXvYqzPRWzNAr7IXt52ycrVXrYxEmVy+7ufhNIVNLKFOKLq8NHcZW8DDnSm7FHJ27DMnHgSeYMK/w==
X-Received: by 2002:a17:906:2ad5:: with SMTP id m21mr58646614eje.55.1560185306374;
        Mon, 10 Jun 2019 09:48:26 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id a9sm3075799edc.44.2019.06.10.09.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:48:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] clocksource/drivers/tegra: Add verbose definition for 1MHz constant
Date:   Mon, 10 Jun 2019 19:43:59 +0300
Message-Id: <20190610164400.11830-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190610164400.11830-1-digetx@gmail.com>
References: <20190610164400.11830-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all 1MHz literals to a verbose constant for better readability.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index a7fa12488066..2a428fdf702f 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -44,6 +44,8 @@
 #define TIMER1_IRQ_IDX		0
 #define TIMER10_IRQ_IDX		10
 
+#define TIMER_1MHz		1000000
+
 static u32 usec_config;
 static void __iomem *timer_reg_base;
 
@@ -158,7 +160,7 @@ static unsigned long tegra_delay_timer_read_counter_long(void)
 
 static struct delay_timer tegra_delay_timer = {
 	.read_current_timer = tegra_delay_timer_read_counter_long,
-	.freq = 1000000,
+	.freq = TIMER_1MHz,
 };
 #endif
 
@@ -224,7 +226,7 @@ static inline unsigned long tegra_rate_for_timer(struct timer_of *to,
 	 * parent clock.
 	 */
 	if (tegra20)
-		return 1000000;
+		return TIMER_1MHz;
 
 	return timer_of_rate(to);
 }
@@ -313,11 +315,11 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 		}
 	}
 
-	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
+	sched_clock_register(tegra_read_sched_clock, 32, TIMER_1MHz);
 
 	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
-				    "timer_us", 1000000,
-				    300, 32, clocksource_mmio_readl_up);
+				    "timer_us", TIMER_1MHz, 300, 32,
+				    clocksource_mmio_readl_up);
 	if (ret)
 		pr_err("failed to register clocksource: %d\n", ret);
 
-- 
2.21.0

