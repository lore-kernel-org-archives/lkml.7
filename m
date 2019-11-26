Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCAEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F3720722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfKZIAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:00:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41021 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfKZIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:00:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZVli-00036z-Va; Tue, 26 Nov 2019 09:00:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 418FD1C1D9A;
        Tue, 26 Nov 2019 09:00:12 +0100 (CET)
Date:   Tue, 26 Nov 2019 08:00:12 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] x86/efi: Explicitly include realmode.h to handle
 RM trampoline quirk
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191119002121.4107-2-sean.j.christopherson@intel.com>
References: <20191119002121.4107-2-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157475521216.21853.12780177309493436431.tip-bot2@tip-bot2>
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

Commit-ID:     950e3ce5372c474066ccfc66f424be6bc2828c99
Gitweb:        https://git.kernel.org/tip/950e3ce5372c474066ccfc66f424be6bc2828c99
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Mon, 18 Nov 2019 16:21:10 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 17:50:26 +01:00

x86/efi: Explicitly include realmode.h to handle RM trampoline quirk

Explicitly include asm/realmode.h, which is needed to handle a real mode
trampoline quirk in efi_free_boot_services(), instead of picking it up
by way of linux/acpi.h.  acpi.h will soon stop including realmode.h so
that changing realmode.h doesn't require a full kernel rebuild.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191119002121.4107-2-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 3b9fd67..f9ef5c5 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -16,6 +16,7 @@
 #include <asm/efi.h>
 #include <asm/uv/uv.h>
 #include <asm/cpu_device_id.h>
+#include <asm/realmode.h>
 #include <asm/reboot.h>
 
 #define EFI_MIN_RESERVE 5120
