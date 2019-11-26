Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5502BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B8A20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfKZIAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:00:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfKZIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:00:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZVlc-00034M-2S; Tue, 26 Nov 2019 09:00:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1F2CC1C1D8F;
        Tue, 26 Nov 2019 09:00:10 +0100 (CET)
Date:   Tue, 26 Nov 2019 08:00:10 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] x86/ACPI/sleep: Move acpi_wakeup_address()
 definition into sleep.c, remove <asm/realmode.h> from <asm/acpi.h>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191119002121.4107-13-sean.j.christopherson@intel.com>
References: <20191119002121.4107-13-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157475521001.21853.838192988655814386.tip-bot2@tip-bot2>
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

Commit-ID:     7c8dfff8783bdc19696b563e01c588e81205ef15
Gitweb:        https://git.kernel.org/tip/7c8dfff8783bdc19696b563e01c588e81205ef15
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Mon, 18 Nov 2019 16:21:21 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 17:50:27 +01:00

x86/ACPI/sleep: Move acpi_wakeup_address() definition into sleep.c, remove <asm/realmode.h> from <asm/acpi.h>

Move the definition of acpi_wakeup_address() into sleep.c to break
linux/acpi.h's dependency (by way of asm/acpi.h) on asm/realmode.h.
Everyone and their mother includes linux/acpi.h, i.e. modifying
realmode.h results in a full kernel rebuild, which makes the already
inscrutable real mode boot code even more difficult to understand and is
positively rage inducing when trying to make changes to x86's boot flow.

[ mingo: Renamed acpi_wakeup_address() to acpi_get_wakeup_address(), as suggested by Borislav Petkov. ]

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191119002121.4107-13-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/acpi.h |  2 +-
 arch/x86/include/asm/acpi.h  |  6 +-----
 arch/x86/kernel/acpi/sleep.c | 11 +++++++++++
 drivers/acpi/sleep.c         |  4 ++--
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 36d7003..b66ba90 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -38,7 +38,7 @@ int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 /* Low-level suspend routine. */
 extern int acpi_suspend_lowlevel(void);
 
-static inline unsigned long acpi_wakeup_address(void)
+static inline unsigned long acpi_get_wakeup_address(void)
 {
 	return 0;
 }
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 57788ec..ca09764 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -13,7 +13,6 @@
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/mpspec.h>
-#include <asm/realmode.h>
 #include <asm/x86_init.h>
 
 #ifdef CONFIG_ACPI_APEI
@@ -62,10 +61,7 @@ static inline void acpi_disable_pci(void)
 extern int (*acpi_suspend_lowlevel)(void);
 
 /* Physical address to resume after wakeup */
-static inline unsigned long acpi_wakeup_address(void)
-{
-	return ((unsigned long)(real_mode_header->wakeup_start));
-}
+unsigned long acpi_get_wakeup_address(void);
 
 /*
  * Check if the CPU can handle C2 and deeper
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index ca13851..26b7256 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -27,6 +27,17 @@ static char temp_stack[4096];
 #endif
 
 /**
+ * acpi_get_wakeup_address - provide physical address for S3 wakeup
+ *
+ * Returns the physical address where the kernel should be resumed after the
+ * system awakes from S3, e.g. for programming into the firmware waking vector.
+ */
+unsigned long acpi_get_wakeup_address(void)
+{
+	return ((unsigned long)(real_mode_header->wakeup_start));
+}
+
+/**
  * x86_acpi_enter_sleep_state - enter sleep state
  * @state: Sleep state to enter.
  *
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index f5cca9f..6d3b2ea 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -63,9 +63,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
 	if (acpi_state == ACPI_STATE_S3) {
-		if (!acpi_wakeup_address())
+		if (!acpi_get_wakeup_address())
 			return -EFAULT;
-		acpi_set_waking_vector(acpi_wakeup_address());
+		acpi_set_waking_vector(acpi_get_wakeup_address());
 
 	}
 	ACPI_FLUSH_CPU_CACHE();
