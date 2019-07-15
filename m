Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA5C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15279206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201222;
	bh=PY7O1vt4sVPl0/z6TsrweZ+1V0tp8VpBE8ulpMVstdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=skyZaABfBTaWpwMRktfpq8+8Vb+GW1fZsCrSuApinqSxLgErDLyzxUM3izdURTcS1
	 3+Ny5kBr+Vn/xqUERTbQ1V3Vl5zCaYVDX0zqXom4pVrUY0RGs7ilxf3ygmV6ROEUvW
	 8zBn0qcu0V8GQSJIwbTZjfN+eEqGVo0uEXhpSTD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403876AbfGOOdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391060AbfGOOdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:33:37 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4267920C01;
        Mon, 15 Jul 2019 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201216;
        bh=PY7O1vt4sVPl0/z6TsrweZ+1V0tp8VpBE8ulpMVstdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZhuLa94vZ0zxapkP04dXfAgq71Dn1JhutLIzBBU9kzt6fta/ERp2ZDrSrc+Kbr7F
         ARKyILkWM0JHywE/wyeBvmeecqdWQcAQRftKrM2oeYFiX9w+EzEhOi8SoKTlRvAQ+S
         ITGkZtlKpgmpDENfE38u+amzK4mYqqnBiSS4jPD4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 080/105] clocksource/drivers/exynos_mct: Increase priority over ARM arch timer
Date:   Mon, 15 Jul 2019 10:28:14 -0400
Message-Id: <20190715142839.9896-80-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715142839.9896-1-sashal@kernel.org>
References: <20190715142839.9896-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 6282edb72bed5324352522d732080d4c1b9dfed6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 4 ++--
 include/linux/cpuhotplug.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index d55c30f6981d..aaf5bfa9bd9c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -211,7 +211,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
 
 static struct clocksource mct_frc = {
 	.name		= "mct-frc",
-	.rating		= 400,
+	.rating		= 450,	/* use value higher than ARM arch timer */
 	.read		= exynos4_frc_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -466,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 450;
+	evt->rating = 500;	/* use value higher than ARM arch timer */
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6376e2dcb0b7..348ecf5553ba 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -115,10 +115,10 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
+	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
-	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_METAG_TIMER_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
-- 
2.20.1

