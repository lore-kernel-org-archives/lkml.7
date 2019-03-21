Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D85AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96C6218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e0fbHj9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfCUI0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:26:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56146 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:26:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190321082622euoutp01658f2584e566d134acd619948b8c3815~N691gE2qL1264712647euoutp01X;
        Thu, 21 Mar 2019 08:26:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190321082622euoutp01658f2584e566d134acd619948b8c3815~N691gE2qL1264712647euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553156782;
        bh=tK3dFDo394dHVOQMaheFxwPLAYuS6TqHsBB57CFPBpc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=e0fbHj9mfYGWpV/ISk177qQy0xr+Xc5GWR6v7tJlzu1kjORbTxWH4NGKXFvTJbfh+
         XnuRLWofAKhgP1EQhKHhTkbK4bNXOAVlLzaOKNdYfsXYpPvziVVBPsv3DphNc24cVr
         AaDpaRuICn5s3gBil3hbRN9pb7A4v7z/Sh8c3WT0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190321082622eucas1p161baac2343ba17b9289b63cc1384cc8a~N691J1qO22707227072eucas1p1E;
        Thu, 21 Mar 2019 08:26:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A4.FD.04806.DAA439C5; Thu, 21
        Mar 2019 08:26:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e~N690jtpUI2999929999eucas1p1C;
        Thu, 21 Mar 2019 08:26:21 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-9f-5c934aadb264
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 06.15.04284.DAA439C5; Thu, 21
        Mar 2019 08:26:21 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0POP00AZFJFSJP40@eusync4.samsung.com>;
        Thu, 21 Mar 2019 08:26:21 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] clocksource: exynos_mct: Increase priority over ARM arch
 timer
Date:   Thu, 21 Mar 2019 09:26:08 +0100
Message-id: <20190321082608.21366-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7djPc7prvSbHGKy4am6xccZ6VovrX56z
        Wsz7LGtx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbfYvGkqswOnx6ZVnWwed67tYfN4d+4c
        u8fmJfUefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlbF80WKWgi6hipXHKxoYN/N3MXJySAiY
        SKz7+52ti5GLQ0hgBaPE2vdnWEESQgKfGSU+fIiDKVryZxczRNEyRonJX+9AOf8ZJb7NPsgM
        UsUmYCjR9baLDcQWEciWePb9JhNIEbNAF5PE7YUH2EESwgIhEk0LN4LZLAKqEr9W9oE18ArY
        Shx8dYkZYp28xOoNB6Dsv6wSH2+EQNguEgc+X2GHsGUkOjsOgi2QEGhmlHh4bi07hNPDKHG5
        aQYjRJW1xOHjF8EeYhbgk5i0bTrQVA6gOK9ER5sQRImHxK8L25ghfo6VmLPvFvsERvEFjAyr
        GMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAiPt9L/jX3cw7vuTdIhRgINRiYc3wmFSjBBr
        YllxZe4hRgkOZiURXhPbyTFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YW
        pBbBZJk4OKUaGJf+b7+/asX8Fa9yL97v7660vaybtXCnjcbsG0kHXwR+eF5xPFqkS+zmHq+p
        v6ZYa+VFtQZZPQoQ/PXrzkbta1uZNh+UMvox49EnFhHZ3PJ7X1t3T7Wo36Y588eBgGM3+GIv
        mmieVnn4O7dArrNiYaXkbsG1//lNHkbrGO698iR7QU2K3kIznTVKLMUZiYZazEXFiQAmeuHz
        sAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsVy+t/xa7prvSbHGCxolLbYOGM9q8X1L89Z
        LeZ9lrU4f34Du8Wmx9dYLS7vmsNmMeP8PiaLtUfuslts3jSV2YHTY9OqTjaPO9f2sHm8O3eO
        3WPzknqPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyli+aDFLQZdQxcrjFQ2Mm/m7GDk5JARM
        JJb82cXcxcjFISSwhFFi7rUfUE4jk8SPzSvYQarYBAwlut52sYHYIgLZEpPXPmIBKWIW6GGS
        aL/6G6xIWCBEomnhRjCbRUBV4tfKPrAGXgFbiYOvLjFDrJOXWL3hAPMERq4FjAyrGEVSS4tz
        03OLDfWKE3OLS/PS9ZLzczcxAsNk27Gfm3cwXtoYfIhRgINRiYd3gcmkGCHWxLLiytxDjBIc
        zEoivCa2k2OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1
        MHYZW73Sz2Rn3nLnyPGDC2Lc7ljsXKy6yFj/tIHl9LfHVW0yq4vsnXbf5eHauzl+7ek+31l6
        8mvvXbu7fMsNNwO5s2sjmp90SadpLIvNr/grz66xTlyl/Jb6yclrN+beP2ZzOKuTa09Z1fed
        amt5p595lNXy/Exsvt/hYveFr39dm3PRSOGPeLgSS3FGoqEWc1FxIgBUCV5+DwIAAA==
X-CMS-MailID: 20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e
CMS-TYPE: 201P
X-CMS-RootMailID: 20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e
References: <CGME20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos Multi-Core Timer driver (exynos_mct) must be started before ARM
Architected Timers (arch_timer), because they both share some common
hardware blocks (global system counter) and turning on MCT is needed
to get ARM Architected Timer working properly. Increase MCT timer rating
and hotplug priority over ARM Archictected timer driver to achieve that.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
v2: added comments about the relation to ARM arch timer
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

