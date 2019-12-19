Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A27424676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLSMT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:19:57 -0500
Received: from foss.arm.com ([217.140.110.172]:38056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfLSMTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:19:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 380E931B;
        Thu, 19 Dec 2019 04:19:54 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1BD33F719;
        Thu, 19 Dec 2019 04:19:51 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, james.morse@arm.com,
        hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com,
        linux@armlinux.org.uk, davem@davemloft.net,
        sparclinux@vger.kernel.org, hch@infradead.org
Subject: [RFC PATCH v3 12/12] sparc64: smp: use generic SMP stop common code
Date:   Thu, 19 Dec 2019 12:19:05 +0000
Message-Id: <20191219121905.26905-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219121905.26905-1-cristian.marussi@arm.com>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sparc64 use the generic SMP-stop logic provided by common code
unified smp_send_stop() function.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 arch/sparc/Kconfig         |  1 +
 arch/sparc/kernel/smp_64.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index eb24cb1afc11..9fedb79209d7 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -95,6 +95,7 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_USE_COMMON_SMP_STOP
 
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 9b4506373353..87a9f3c96193 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1537,7 +1537,12 @@ static void stop_this_cpu(void *dummy)
 	prom_stopself();
 }
 
-void smp_send_stop(void)
+void arch_smp_cpus_stop_complete(void)
+{
+	smp_call_function(stop_this_cpu, NULL, 0);
+}
+
+void arch_smp_stop_call(cpumask_t *cpus, unsigned int __unused)
 {
 	int cpu;
 
@@ -1546,10 +1551,7 @@ void smp_send_stop(void)
 #ifdef CONFIG_SERIAL_SUNHV
 		sunhv_migrate_hvcons_irq(this_cpu);
 #endif
-		for_each_online_cpu(cpu) {
-			if (cpu == this_cpu)
-				continue;
-
+		for_each_cpu(cpu, cpus) {
 			set_cpu_online(cpu, false);
 #ifdef CONFIG_SUN_LDOMS
 			if (ldom_domaining_enabled) {
@@ -1562,8 +1564,7 @@ void smp_send_stop(void)
 #endif
 				prom_stopcpu_cpuid(cpu);
 		}
-	} else
-		smp_call_function(stop_this_cpu, NULL, 0);
+	}
 }
 
 /**
-- 
2.17.1

