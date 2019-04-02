Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C072070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hgQwXNXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfDBDCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:02:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10869 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDBDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:02:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca2d0d60000>; Mon, 01 Apr 2019 20:02:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 20:02:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 01 Apr 2019 20:02:48 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 03:02:47 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 2 Apr 2019 03:02:47 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca2d0d60001>; Mon, 01 Apr 2019 20:02:47 -0700
From:   Joseph Lo <josephl@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Joseph Lo <josephl@nvidia.com>
Subject: [PATCH] clocksource/drivers/tegra: rework for compensation of suspend time
Date:   Tue, 2 Apr 2019 11:02:34 +0800
Message-ID: <20190402030234.13488-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554174166; bh=2ffVDPP19TqcMnkkmBgeyiuu4J2QKW9TZqmxJnfo62w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=hgQwXNXF0l2WHPPdobCCwJE8pxEYsA/s+B5gBdO/tX8ffJDLVl31fZjs+xK313L00
         HmIdCz6HJsvM+iBYkLp7FMju4WCD7WlfotlZCywrHvViqTLtYJ2i899vIjNuadIC8b
         ygmM8d+3uBIYc4A5rDRUpNqtywlXSdI+l6yPXBX7TuTnCn05BZAqmCI0x9IEsPIwxx
         iiA8RT7x45CJcY0Dm5okMrqebB7ttzIigcm2oAl+9AuetKbZW1HaAw88+puUuSKl5g
         qqIJsulFnZx9C/h6IojI6KAOvLWkQlvwMkweM+K3m35f0xU99X0n2ntV5EhEcBgpYb
         p/JpkAx2Fk1mQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the clocksource framework has the support for suspend time
compensation. Re-work the driver to use that, so we can reduce the
duplicate code.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/clocksource/timer-tegra20.c | 63 +++++++++--------------------
 1 file changed, 20 insertions(+), 43 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/time=
r-tegra20.c
index fdb3d795a409..919b3568c495 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -60,9 +60,6 @@
 static u32 usec_config;
 static void __iomem *timer_reg_base;
 #ifdef CONFIG_ARM
-static void __iomem *rtc_base;
-static struct timespec64 persistent_ts;
-static u64 persistent_ms, last_persistent_ms;
 static struct delay_timer tegra_delay_timer;
 #endif
=20
@@ -199,40 +196,30 @@ static unsigned long tegra_delay_timer_read_counter_l=
ong(void)
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
 }
=20
+static struct timer_of suspend_rtc_to =3D {
+	.flags =3D TIMER_OF_BASE | TIMER_OF_CLOCK,
+};
+
 /*
  * tegra_rtc_read - Reads the Tegra RTC registers
  * Care must be taken that this funciton is not called while the
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-static u64 tegra_rtc_read_ms(void)
+static u64 tegra_rtc_read_ms(struct clocksource *cs)
 {
-	u32 ms =3D readl(rtc_base + RTC_MILLISECONDS);
-	u32 s =3D readl(rtc_base + RTC_SHADOW_SECONDS);
+	u32 ms =3D readl(timer_of_base(&suspend_rtc_to) + RTC_MILLISECONDS);
+	u32 s =3D readl(timer_of_base(&suspend_rtc_to) + RTC_SHADOW_SECONDS);
 	return (u64)s * MSEC_PER_SEC + ms;
 }
=20
-/*
- * tegra_read_persistent_clock64 -  Return time from a persistent clock.
- *
- * Reads the time from a source which isn't disabled during PM, the
- * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec64.
- * Care must be taken that this funciton is not called while the
- * tegra_rtc driver could be executing to avoid race conditions
- * on the RTC shadow register
- */
-static void tegra_read_persistent_clock64(struct timespec64 *ts)
-{
-	u64 delta;
-
-	last_persistent_ms =3D persistent_ms;
-	persistent_ms =3D tegra_rtc_read_ms();
-	delta =3D persistent_ms - last_persistent_ms;
-
-	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
-	*ts =3D persistent_ts;
-}
+static struct clocksource suspend_rtc_clocksource =3D {
+	.name	=3D "tegra_suspend_timer",
+	.rating	=3D 200,
+	.read	=3D tegra_rtc_read_ms,
+	.mask	=3D CLOCKSOURCE_MASK(32),
+	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
 #endif
=20
 static int tegra_timer_common_init(struct device_node *np, struct timer_of=
 *to)
@@ -385,25 +372,15 @@ static int __init tegra_init_timer(struct device_node=
 *np)
=20
 static int __init tegra20_init_rtc(struct device_node *np)
 {
-	struct clk *clk;
+	int ret;
=20
-	rtc_base =3D of_iomap(np, 0);
-	if (!rtc_base) {
-		pr_err("Can't map RTC registers\n");
-		return -ENXIO;
-	}
+	ret =3D timer_of_init(np, &suspend_rtc_to);
+	if (ret)
+		return ret;
=20
-	/*
-	 * rtc registers are used by read_persistent_clock, keep the rtc clock
-	 * enabled
-	 */
-	clk =3D of_clk_get(np, 0);
-	if (IS_ERR(clk))
-		pr_warn("Unable to get rtc-tegra clock\n");
-	else
-		clk_prepare_enable(clk);
+	clocksource_register_hz(&suspend_rtc_clocksource, 1000);
=20
-	return register_persistent_clock(tegra_read_persistent_clock64);
+	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
 #endif
--=20
2.21.0

