Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD3D21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADrxohoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfFZOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37242 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfFZOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so3076014wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cbSVQ22cXPOUgxve/+oaGWixu1F5XT9Nb/A3w74S+UE=;
        b=ADrxohoqxEA4hrkpsvA4KMOL9BPGGlrCiOlq/QZCevYKtpGMvxsSL52rFciR/q43DH
         F29Dg//dFlpDIO6EW1kiVSMeZktpL6pUM+nPBO4Ta8KaKFNthzMQ+3UnrxXX2IAFvNsr
         ttT1a1yAE4ZYsswIxky/yPdZFa0xdNutsvaa7q1rCZB6Mzvx8a1dAp8X311VyQDuF6Zi
         ASDFEI2fS3zPRj/Oudpv83ZAyCn7TXnh1n1wRQRZqwDtSfV2x+hLtzMc3LBCCHr+Nuqm
         LeJImWUPEKNBYULG7dzAKjxQPA5NoxP0pg+H0e98H0YnqSdUozrUrvMT1aq1d9c+Z4h3
         UeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cbSVQ22cXPOUgxve/+oaGWixu1F5XT9Nb/A3w74S+UE=;
        b=Ep4eSjbYrPtEt79a7RIJvfkRrOYtq4NM92wb9VyP18wEAdqe7F8Vf0/ClmoxmmRcsc
         YCQSjSxowPTHXMFK5zY4VijUIPHTIQSn7cFDtIXCVe5PsivzgiB/KVQKPDPTLEkFMQ9y
         XyI8INIE3nXIvqy75X9U2ZfUzC78wN1ovz1bMLHkxR9dRqb9bo0ZpELwE2YDHoOzeYUA
         JapX4Ve7PO/8sTMP3BiDTMk+bZsFD6VRP24xNkP3eYPIu6532FoDca9EL9bz3sfV/KM3
         uRxpxyBXoqOCYfu5wDjSLJ9Qx85ELN6jBEoaulJl4zvI/WlSuhftJItsXAdRQdWVNrgK
         RFeg==
X-Gm-Message-State: APjAAAUiAUbKYKX9NXgjfoJCE7h14oxmoynONP3PR+xpLTMYXXVZ/ktV
        Dna1Bl2rfzDxTQi6zP5yAnvDFA==
X-Google-Smtp-Source: APXvYqzTjIqk61G6aHfR2ZgD6gNM87lxfg/p2FltiDAPAz0K8FYGcNPE/L6KykeVG6B+7+bxPjBNFg==
X-Received: by 2002:adf:ce88:: with SMTP id r8mr4326334wrn.42.1561560458255;
        Wed, 26 Jun 2019 07:47:38 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM ARCHITECTED
        TIMER DRIVER)
Subject: [PATCH 15/25] clocksource/drivers/arm_arch_timer: Extract elf_hwcap use to arch-helper
Date:   Wed, 26 Jun 2019 16:46:41 +0200
Message-Id: <20190626144651.16742-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Murray <andrew.murray@arm.com>

Different mechanisms are used to test and set elf_hwcaps between ARM
and ARM64, this results in the use of ifdeferry in this file when
setting/testing for the EVTSTRM hwcap.

Let's improve readability by extracting this to an arch helper.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/arch_timer.h    | 10 ++++++++++
 arch/arm64/include/asm/arch_timer.h  | 13 +++++++++++++
 drivers/clocksource/arm_arch_timer.c | 15 ++-------------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 4b66ecd6be99..99175812d903 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -4,6 +4,7 @@
 
 #include <asm/barrier.h>
 #include <asm/errno.h>
+#include <asm/hwcap.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -124,6 +125,15 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	isb();
 }
 
+static inline void arch_timer_set_evtstrm_feature(void)
+{
+	elf_hwcap |= HWCAP_EVTSTRM;
+}
+
+static inline bool arch_timer_have_evtstrm_feature(void)
+{
+	return elf_hwcap & HWCAP_EVTSTRM;
+}
 #endif
 
 #endif
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 50b3ab7ded4f..a847a3ee6cab 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -20,6 +20,7 @@
 #define __ASM_ARCH_TIMER_H
 
 #include <asm/barrier.h>
+#include <asm/hwcap.h>
 #include <asm/sysreg.h>
 
 #include <linux/bug.h>
@@ -240,4 +241,16 @@ static inline int arch_timer_arch_init(void)
 	return 0;
 }
 
+static inline void arch_timer_set_evtstrm_feature(void)
+{
+	cpu_set_named_feature(EVTSTRM);
+#ifdef CONFIG_COMPAT
+	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
+#endif
+}
+
+static inline bool arch_timer_have_evtstrm_feature(void)
+{
+	return cpu_have_named_feature(EVTSTRM);
+}
 #endif
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5c69c9a9a6a4..3c8afcd3444c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -804,14 +804,7 @@ static void arch_timer_evtstrm_enable(int divider)
 	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
 			| ARCH_TIMER_VIRT_EVT_EN;
 	arch_timer_set_cntkctl(cntkctl);
-#ifdef CONFIG_ARM64
-	cpu_set_named_feature(EVTSTRM);
-#else
-	elf_hwcap |= HWCAP_EVTSTRM;
-#endif
-#ifdef CONFIG_COMPAT
-	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
-#endif
+	arch_timer_set_evtstrm_feature();
 	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 }
 
@@ -1040,11 +1033,7 @@ static int arch_timer_cpu_pm_notify(struct notifier_block *self,
 	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
 		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
 
-#ifdef CONFIG_ARM64
-		if (cpu_have_named_feature(EVTSTRM))
-#else
-		if (elf_hwcap & HWCAP_EVTSTRM)
-#endif
+		if (arch_timer_have_evtstrm_feature())
 			cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 	}
 	return NOTIFY_OK;
-- 
2.17.1

