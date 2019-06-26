Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE02BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D458216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQ5btisT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfFZOrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43482 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfFZOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so3043131wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GnURz9uBDl/JIVDRIJyHSxWewLcsuwU4f5F+HbyZmEk=;
        b=KQ5btisTZtuBgX3s5dqhAy9z1WRj8n9/5MKEJo4MF5cUOEuJVWT59lzvSJli34Ae21
         iV7BM1IiLxpZjlXc4U/PSvZ0uTGm9C1OZag5uvgAmapx1x4Z+V0pcz3mdcWVQiyefhE/
         pJOaSeG9yj1LRqoqtf/oUXu4I8DMt8P9IC8Ti3lz+/yJeUME9lJAGcMBF/L2i2WF5yWm
         NTQeR3ueMzafid23YxD4WI0WnHBygKBjhcibBdd836MnpUbCNQ6ELTN7KeiQW6f42nTX
         7qXi5g5P7fzqqBl2oX8lGke2ZK1QriMJLHGxHDpiwjEB6jG6B/W6SfU/gQWUU1T8wCTD
         B7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GnURz9uBDl/JIVDRIJyHSxWewLcsuwU4f5F+HbyZmEk=;
        b=lp+OJeuWwPKjx3rCFkpkSEawprXCo3igetXKhx4vvZ02mOEUEIjUauz1TnZzKOYi3H
         hb9/CFd7+HTG2o/ILs+UF0FvUnwQ0FUaOUy7gdTtNlTSKUqRv51/Wigioz9ofhBNwrWL
         hSMYkmz6TIJ0b4EJ3PtiB2Ip5a1BZRmzWVI8J41WTgRMHKxrNiSocQ/DY15Vzkz5Et9g
         H+bzMjkI24F/KQ0CxsHiuQ8jmQaK9RxzFHoTbNrsNtLA11XffC7dbWRctm79dZiFbrMw
         IrPd9aZEDUc8Ec4PmKab5zXqNGE7deGx8mHGepRmE6EKva2/Hv/2lu0YYPZe4aKnNtgQ
         IBPQ==
X-Gm-Message-State: APjAAAWgIFH6WQze49Cfgahi3YJA9yI1wqNeAPoAtLURsm7dW4ujToHd
        wc/XK/wR4iUHZYiQIh2ohURv5Q==
X-Google-Smtp-Source: APXvYqwwouIsWhDWc6BkFntC79BsmzDpRrHtrTK+mkPNbfBFrxQaW7YY2H0Ua1xIsJZ/0Bwx0wvhpA==
X-Received: by 2002:adf:ce88:: with SMTP id r8mr4325093wrn.42.1561560438445;
        Wed, 26 Jun 2019 07:47:18 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Guo Ren <ren_guo@c-sky.com>, Joseph Lo <josephl@nvidia.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hoan Tran <Hoan@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES)
Subject: [PATCH 04/25] clocksource/drivers/exynos_mct: Increase priority over ARM arch timer
Date:   Wed, 26 Jun 2019 16:46:30 +0200
Message-Id: <20190626144651.16742-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Exynos SoCs based on CA7/CA15 have 2 timer interfaces: custom Exynos MCT
(Multi Core Timer) and standard ARM Architected Timers.

There are use cases, where both timer interfaces are used simultanously.
One of such examples is using Exynos MCT for the main system timer and
ARM Architected Timers for the KVM and virtualized guests (KVM requires
arch timers).

Exynos Multi-Core Timer driver (exynos_mct) must be however started
before ARM Architected Timers (arch_timer), because they both share some
common hardware blocks (global system counter) and turning on MCT is
needed to get ARM Architected Timer working properly.

To ensure selecting Exynos MCT as the main system timer, increase MCT
timer rating. To ensure proper starting order of both timers during
suspend/resume cycle, increase MCT hotplug priority over ARM Archictected
Timers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 4 ++--
 include/linux/cpuhotplug.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 34bd250d46c6..6aa10cbc1d59 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -209,7 +209,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
 
 static struct clocksource mct_frc = {
 	.name		= "mct-frc",
-	.rating		= 400,
+	.rating		= 450,	/* use value higher than ARM arch timer */
 	.read		= exynos4_frc_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -464,7 +464,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 450;
+	evt->rating = 500;	/* use value higher than ARM arch timer */
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 5c6062206760..87c211adf49e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -116,10 +116,10 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
+	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
-	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_TEGRA_TIMER_STARTING,
-- 
2.17.1

