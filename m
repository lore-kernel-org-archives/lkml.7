Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2F7C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4338A25792
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nRvz2Cb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE3KvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:51:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53708 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfE3KvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:51:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190530105100euoutp029f34ca3e430f3c5ce8a929a0d98fd5ec~jcGGqgilx2661026610euoutp02T
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:51:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190530105100euoutp029f34ca3e430f3c5ce8a929a0d98fd5ec~jcGGqgilx2661026610euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559213460;
        bh=vdaZS4yfBCb1935LeDCfNjU3VfSTXBG/EFyAbIYcM8o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nRvz2Cb7/dcltK7xJZcAnGH/ZzI0UIVgK6O78CF42QfZcpDMA41XP3azVl5Em2qwl
         S+F1bYESlQox7eOf1x7PacnsSIFBL7mL5xWqHJLKQ3K24ZNUO2t8EISfhBimL1V8GB
         7COTo8KOGcLxC24GFhoxAWgyUStB05capfo4yn9g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190530105100eucas1p113f0aa31e8140ba1803e60ee56578bea~jcGGNiEyi1817318173eucas1p1r;
        Thu, 30 May 2019 10:51:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B0.E5.04377.395BFEC5; Thu, 30
        May 2019 11:50:59 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190530105059eucas1p1d9c911a5ba2ae412166cd8866deb725e~jcGFcTsbr1065610656eucas1p1y;
        Thu, 30 May 2019 10:50:59 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-39-5cefb5934d0e
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AF.3B.04140.395BFEC5; Thu, 30
        May 2019 11:50:59 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PSB003AECSQ2880@eusync3.samsung.com>;
        Thu, 30 May 2019 11:50:59 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3] clocksource: exynos_mct: Increase priority over ARM arch
 timer
Date:   Thu, 30 May 2019 12:50:43 +0200
Message-id: <20190530105043.29965-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7djP87qTt76PMdgzwcxi44z1rBbXvzxn
        tZj3Wdbi/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26xedNUZgdOj02rOtk87lzbw+bx7tw5
        do/NS+o9+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK+PD08PsBUvFK553/GJuYLwj3MXIySEh
        YCLx/8M9xi5GLg4hgRWMEqduf2eHcD4zSszetJ8Vpmr//xtsEIlljBLbb6xjhnD+M0o8uLGa
        HaSKTcBQouttFxuILSKQLfHs+00mkCJmgS4midsLD4AVCQuESOw6dY0FxGYRUJXYseY0I4jN
        K2Ar8f3bIxaIdfISqzccANsgIfCXVaL9/jWgSRxAjovEvS/BEDUyEpcnd7NA1DQzSjw8t5Yd
        wulhlLjcNIMRospa4vDxi2BPMAvwSUzaNp0ZYhCvREebEESJh8TmS5/BwkICsRKXD8VOYBRf
        wMiwilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDWTv87/mUH464/SYcYBTgYlXh4J+S/
        ixFiTSwrrsw9xCjBwawkwvtzOVCINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs
        1NSC1CKYLBMHp1QDI3tNJLcRw7aFt35PWPM3VPH21BdHb52vn/I0T0qp827KrP+HQnQPfA5U
        nrz/+G67VTKPuB52sNT+K4o+zG4f/j//a/Shz7PWv1j733epqbXdQo4gl8lKR/4IifXH2lSl
        Nfxg13L68X6dBKO+unW8o+/rTlvF+0dKTuxnOJDTtmOHp/X2TRMuFyqxFGckGmoxFxUnAgC9
        6d8OsQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsVy+t/xq7qTt76PMXj1kdti44z1rBbXvzxn
        tZj3Wdbi/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26xedNUZgdOj02rOtk87lzbw+bx7tw5
        do/NS+o9+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK+PD08PsBUvFK553/GJuYLwj3MXIySEh
        YCKx//8Nti5GLg4hgSWMEl+3zmKBcBqZJFa/WckCUsUmYCjR9baLDcQWEciWmLz2EVgRs0AP
        k0T71d/sIAlhgRCJXaeugTWwCKhK7FhzmhHE5hWwlfj+7RELxDp5idUbDjBPYORawMiwilEk
        tbQ4Nz232EivODG3uDQvXS85P3cTIzBQth37uWUHY9e74EOMAhyMSjy8E/LfxQixJpYVV+Ye
        YpTgYFYS4f25HCjEm5JYWZValB9fVJqTWnyIUZqDRUmct0PgYIyQQHpiSWp2ampBahFMlomD
        U6qBcX/u07sturUvxT8f0GRSXWJ9++eNbu39ep+Loi709v46fSJHfL3LjfwnTGGKAeZtIZHL
        ewRvuaY+S6rjct3XVqVsIV8o52i+atfa+Tfv1S1pX6JpztRbuPvjcuMYnmcb9s7dIZvQ7L2n
        MWb6kf97kw29s0NVLll2rVy88I7AM2vXyfH7JoktVGIpzkg01GIuKk4EAGaE5QsQAgAA
X-CMS-MailID: 20190530105059eucas1p1d9c911a5ba2ae412166cd8866deb725e
CMS-TYPE: 201P
X-CMS-RootMailID: 20190530105059eucas1p1d9c911a5ba2ae412166cd8866deb725e
References: <CGME20190530105059eucas1p1d9c911a5ba2ae412166cd8866deb725e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
v3: rephrased commit message, rebased onto v5.2-rc1

v2: https://patchwork.kernel.org/patch/10863101/
   added comments about the relation to ARM architected timer
    rebased onto v5.1-rc1

v1: https://patchwork.kernel.org/patch/10814921/
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
index e78281d07b70..53fb48de9589 100644
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
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_TEGRA_TIMER_STARTING,
-- 
2.17.1

