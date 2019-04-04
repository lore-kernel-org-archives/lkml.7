Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D7EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488F120693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfDDQpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:45:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfDDQpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:45:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 939ED30832C9;
        Thu,  4 Apr 2019 16:45:22 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7568C608EB;
        Thu,  4 Apr 2019 16:45:17 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RFC 5/5] arm64/speculation: Add support for 'cpu_spec_mitigations=' cmdline options
Date:   Thu,  4 Apr 2019 11:44:15 -0500
Message-Id: <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1554396090.git.jpoimboe@redhat.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 04 Apr 2019 16:45:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure arm64 runtime CPU speculation bug mitigations in accordance
with the 'cpu_spec_mitigations=' cmdline options.  This affects
Meltdown and Speculative Store Bypass.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 arch/arm64/kernel/cpu_errata.c                  | 4 ++++
 arch/arm64/kernel/cpufeature.c                  | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e838af96daa4..0b54385ee7a8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2553,11 +2553,13 @@
 			off
 				Disable all speculative CPU mitigations.
 				Equivalent to: nopti [x86, powerpc]
+					       kpti=0 [arm64]
 					       nospectre_v1 [powerpc]
 					       nospectre_v2 [x86, powerpc, s390]
 					       spectre_v2_user=off [x86]
 					       nobp=0 [s390]
 					       spec_store_bypass_disable=off [x86, powerpc]
+					       ssbd=force-off [arm64]
 					       l1tf=off [x86]
 
 			auto (default)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9950bb0cbd52..db8d27e3fb1c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -19,6 +19,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
 #include <linux/types.h>
+#include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
@@ -385,6 +386,9 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 		return false;
 	}
 
+	if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
+		ssbd_state = ARM64_SSBD_FORCE_DISABLE;
+
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4061de10cea6..4512b582d50f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -25,6 +25,7 @@
 #include <linux/stop_machine.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
@@ -978,6 +979,11 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		__kpti_forced = -1;
 	}
 
+	if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF) {
+		str = "cpu_spec_mitigations=off";
+		__kpti_forced = -1;
+	}
+
 	/* Forced? */
 	if (__kpti_forced) {
 		pr_info_once("kernel page table isolation forced %s by %s\n",
-- 
2.17.2

