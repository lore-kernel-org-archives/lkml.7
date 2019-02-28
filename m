Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186FAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C3D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgCMxxag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbfB1PAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:00:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40026 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733251AbfB1PAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:00:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so9685775lfi.7;
        Thu, 28 Feb 2019 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNKDDLvDNqZH4VwvR19aZX5uv9Bt1GBLcpk7zNUpUlc=;
        b=sgCMxxagNgVLa9vk1yEVZOaY89e9RvJeNdfcafyictss7x1IMeAfl57GzuZ1WDChXM
         ao/5/Qz1NgY6BwDlZVzh97QY+zLm/OFOEqx74wf+sqE8jMUP9FVPqG/tGU8vwL+MYZfV
         HPLsUUi9oFu5GV93M6j9lHQmQbQ759wFU8HHurVNYvBuQ5Ybgs7ErlJvVqQU15F5h10w
         0CsJQrK+ybeq1PjyATA5x1vSOrqS2ie5KbV2VbsdxdC8e4DA2B+4L3L0lQk/Sjr/BBBE
         M4gVaPDbVDntWrMpEtWAV8Q6n1k+ENYn7iXC3QuKuM0bhrWlTpsFWD/CAceOBC/f+UxB
         GRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNKDDLvDNqZH4VwvR19aZX5uv9Bt1GBLcpk7zNUpUlc=;
        b=a32xOnYpb5rbctF0gmu6RnzhF1Oyd/HV5TRzawC3rHETON4cmLi1iJEMjKA/1ej+Hp
         WCtAPxfYWFOzoGCN/7rAJBCoBZLoHdQb3SmrKnMXYXwmATldzbWIiuWl8CpnXrVLoPsX
         aokGoEaPVdi5vVcnPWLB5qcxRlW3uwVsV/dLBgqyObPCBhCBTlVsZatkXCWqfwnAUq+j
         cC8B86/NqV1Tqxb75YhjJnjpxKwAPL7IrKSF/3/hGSea3Q6SGwXxxCkEAmKN3kTfxTIH
         cDQUaB+1zxgXSFgTNhhKG8NVv/XtZPkyZT1yAggTvvhTDy+plu9gKZV0/ddJ98pOZXjS
         pVCA==
X-Gm-Message-State: AHQUAubyCMZDfRsufg1U57SmKOm2+/4ekDy/CKWA66OZWInTniDCX5ub
        sV0VOK8rKwKjSj6sQBacSF4=
X-Google-Smtp-Source: AHgI3IYxL/Fp2ROTpq+FQGyz1/VMbLfNaoUKzofO/WbFwJV6O0jvzv6PEESrxVhkhEpouE8EmjbfYQ==
X-Received: by 2002:a19:d1c7:: with SMTP id i190mr4416963lfg.149.1551366001661;
        Thu, 28 Feb 2019 07:00:01 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id z20sm4728309lff.87.2019.02.28.07.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:00:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/7] ARM: tegra: Add firmware calls required for suspend-resume on Tegra30
Date:   Thu, 28 Feb 2019 17:59:37 +0300
Message-Id: <20190228145937.27725-8-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228145937.27725-1-digetx@gmail.com>
References: <20190228145937.27725-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to suspend-resume CPU with Trusted Foundations firmware being
present on Tegra30, the LP1/LP2 boot vectors and CPU caches need to be
set up using the firmware calls and then suspend code shall avoid
re-disabling parts that were disabled by the firmware.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            | 49 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/reset-handler.S | 26 +++++++++++++++
 arch/arm/mach-tegra/sleep.S         | 14 ++++++---
 3 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1ad5719779b0..abf5f88778f4 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -33,11 +33,13 @@
 #include <soc/tegra/pmc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/idmap.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "pm.h"
@@ -159,6 +161,28 @@ int tegra_cpu_do_idle(void)
 
 static int tegra_sleep_cpu(unsigned long v2p)
 {
+	/*
+	 * L2 cache disabling using kernel API only allowed when all
+	 * secondary CPU's are offline. Cache have to be disabled with
+	 * MMU-on if cache maintenance is done via Trusted Foundations
+	 * firmware. Note that CPUIDLE won't ever enter powergate on Tegra30
+	 * if any of secondary CPU's is online and this is the LP2-idle
+	 * code-path only for Tegra20/30.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
+	/*
+	 * Note that besides of setting up CPU reset vector this firmware
+	 * call may also do the following, depending on the FW version:
+	 *  1) Disable L2. But this doesn't matter since we already
+	 *     disabled the L2.
+	 *  2) Disable D-cache. This need to be taken into account in
+	 *     particular by the tegra_disable_clean_inv_dcache() which
+	 *     shall avoid the re-disable.
+	 */
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP2);
+
 	setup_mm_for_reboot();
 	tegra_sleep_cpu_finish(v2p);
 
@@ -197,6 +221,14 @@ void tegra_idle_lp2_last(void)
 
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op. This is always a no-op on Tegra114+.
+	 */
+	outer_resume();
+
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
@@ -215,6 +247,15 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 
 static int tegra_sleep_core(unsigned long v2p)
 {
+	/*
+	 * Cache have to be disabled with MMU-on if cache maintenance is done
+	 * via Trusted Foundations firmware. This is a no-op on Tegra114+.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP1);
+
 	setup_mm_for_reboot();
 	tegra_sleep_core_finish(v2p);
 
@@ -342,6 +383,14 @@ static int tegra_suspend_enter(suspend_state_t state)
 
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	switch (mode) {
 	case TEGRA_SUSPEND_LP1:
 		tegra_suspend_exit_lp1();
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 3bf202819534..19a609046547 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -20,6 +20,7 @@
 #include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 
+#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
@@ -76,6 +77,7 @@ ENTRY(tegra_resume)
 	orr	r1, r1, #1
 	str	r1, [r0]
 #endif
+	bl	tegra_resume_trusted_foundations
 
 #ifdef CONFIG_CACHE_L2X0
 	/* L2 cache resume & re-enable */
@@ -88,6 +90,30 @@ end_ca9_scu_l2_resume:
 
 	b	cpu_resume
 ENDPROC(tegra_resume)
+
+/*
+ *	tegra_resume_trusted_foundations
+ *
+ *	  Trusted Foundations firmware initialization.
+ *
+ *	Doesn't return if firmware presents.
+ *	Corrupted registers: r1, r2
+ */
+ENTRY(tegra_resume_trusted_foundations)
+	/* Check whether Trusted Foundations firmware presents. */
+	mov32	r2, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
+	ldr	r1, =__tegra_cpu_reset_handler_data_offset + \
+							RESET_DATA(TF_PRESENT)
+	ldr	r1, [r2, r1]
+	cmp	r1, #0
+	reteq	lr
+
+ .arch_extension sec
+	/* First call after suspend wakes firmware. No arguments required. */
+	smc	#0
+
+	b	cpu_resume
+ENDPROC(tegra_resume_trusted_foundations)
 #endif
 
 	.align L1_CACHE_SHIFT
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 5e3496753df1..1735ded5a812 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -49,8 +49,9 @@ ENTRY(tegra_disable_clean_inv_dcache)
 
 	/* Disable the D-cache */
 	mrc	p15, 0, r2, c1, c0, 0
+	tst	r2, #CR_C			@ see tegra_sleep_cpu()
 	bic	r2, r2, #CR_C
-	mcr	p15, 0, r2, c1, c0, 0
+	mcrne	p15, 0, r2, c1, c0, 0
 	isb
 
 	/* Flush the D-cache */
@@ -132,10 +133,13 @@ ENTRY(tegra_shut_off_mmu)
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
 	check_cpu_part_num 0xc09, r9, r10
-	movweq	r2, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	movteq	r2, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	moveq	r3, #0
-	streq	r3, [r2, #L2X0_CTRL]
+	retne	r0
+
+	mov32	r2, TEGRA_ARM_PERIF_BASE + 0x3000
+	ldr	r3, [r2, #L2X0_CTRL]
+	tst	r3, #L2X0_CTRL_EN		@ see tegra_sleep_cpu()
+	mov	r3, #0
+	strne	r3, [r2, #L2X0_CTRL]
 #endif
 	ret	r0
 ENDPROC(tegra_shut_off_mmu)
-- 
2.20.1

