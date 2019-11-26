Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E87EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7056820748
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKZIA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:00:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41013 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKZIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:00:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZVlc-00034N-7O; Tue, 26 Nov 2019 09:00:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 453C91C1D90;
        Tue, 26 Nov 2019 09:00:10 +0100 (CET)
Date:   Tue, 26 Nov 2019 08:00:10 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] ACPI/sleep: Convert acpi_wakeup_address into a function
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191119002121.4107-12-sean.j.christopherson@intel.com>
References: <20191119002121.4107-12-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157475521019.21853.633847484161211103.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/headers branch of tip:

Commit-ID:     a9760aba02b346e74fffe8e35e4f1e9067de5281
Gitweb:        https://git.kernel.org/tip/a9760aba02b346e74fffe8e35e4f1e9067de5281
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Mon, 18 Nov 2019 16:21:20 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 17:50:27 +01:00

ACPI/sleep: Convert acpi_wakeup_address into a function

Convert acpi_wakeup_address from a raw variable into a function so that
x86 can wrap its dereference of the real mode boot header in a function
instead of broadcasting it to the world via a #define.  This sets the
stage for a future patch to move the definition of acpi_wakeup_address()
out of asm/acpi.h and thus break acpi.h's dependency on asm/realmode.h.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191119002121.4107-12-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/acpi.h | 5 ++++-
 arch/ia64/kernel/acpi.c      | 2 --
 arch/x86/include/asm/acpi.h  | 5 ++++-
 drivers/acpi/sleep.c         | 4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index f886d4d..36d7003 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -38,7 +38,10 @@ int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 /* Low-level suspend routine. */
 extern int acpi_suspend_lowlevel(void);
 
-extern unsigned long acpi_wakeup_address;
+static inline unsigned long acpi_wakeup_address(void)
+{
+	return 0;
+}
 
 /*
  * Record the cpei override flag and current logical cpu. This is
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 70d1587..a563652 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -42,8 +42,6 @@ int acpi_lapic;
 unsigned int acpi_cpei_override;
 unsigned int acpi_cpei_phys_cpuid;
 
-unsigned long acpi_wakeup_address = 0;
-
 #define ACPI_MAX_PLATFORM_INTERRUPTS	256
 
 /* Array to record platform interrupt vectors for generic interrupt routing. */
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index bc9693c..57788ec 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -62,7 +62,10 @@ static inline void acpi_disable_pci(void)
 extern int (*acpi_suspend_lowlevel)(void);
 
 /* Physical address to resume after wakeup */
-#define acpi_wakeup_address ((unsigned long)(real_mode_header->wakeup_start))
+static inline unsigned long acpi_wakeup_address(void)
+{
+	return ((unsigned long)(real_mode_header->wakeup_start));
+}
 
 /*
  * Check if the CPU can handle C2 and deeper
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 9fa77d7..f5cca9f 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -63,9 +63,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
 	if (acpi_state == ACPI_STATE_S3) {
-		if (!acpi_wakeup_address)
+		if (!acpi_wakeup_address())
 			return -EFAULT;
-		acpi_set_waking_vector(acpi_wakeup_address);
+		acpi_set_waking_vector(acpi_wakeup_address());
 
 	}
 	ACPI_FLUSH_CPU_CACHE();
