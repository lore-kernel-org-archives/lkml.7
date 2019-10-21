Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79238CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 22:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DAD2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 22:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfJUW4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:56:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37968 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfJUW4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 18:56:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgbD-0003Sn-Ma; Tue, 22 Oct 2019 00:56:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D17D51C0086;
        Tue, 22 Oct 2019 00:56:26 +0200 (CEST)
Date:   Mon, 21 Oct 2019 22:56:26 -0000
From:   "tip-bot2 for Thomas Hellstrom" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/vmware: Fix platform detection VMWARE_PORT macro
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191021172403.3085-3-thomas_os@shipmail.org>
References: <20191021172403.3085-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Message-ID: <157169858645.29376.17154756298339377463.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6fee2a0be0ecae939d4b6cd8297d88b5cbb61654
Gitweb:        https://git.kernel.org/tip/6fee2a0be0ecae939d4b6cd8297d88b5cbb61654
Author:        Thomas Hellstrom <thellstrom@vmware.com>
AuthorDate:    Mon, 21 Oct 2019 19:24:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Oct 2019 00:51:44 +02:00

x86/cpu/vmware: Fix platform detection VMWARE_PORT macro

The platform detection VMWARE_PORT macro uses the VMWARE_HYPERVISOR_PORT
definition, but expects it to be an integer. However, when it was moved
to the new vmware.h include file, it was changed to be a string to better
fit into the VMWARE_HYPERCALL set of macros. This obviously breaks the
platform detection VMWARE_PORT functionality.

Change the VMWARE_HYPERVISOR_PORT and VMWARE_HYPERVISOR_PORT_HB
definitions to be integers, and use __stringify() for their stringified
form when needed.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b4dd4f6e3648 ("Add a header file for hypercall definitions")
Link: https://lkml.kernel.org/r/20191021172403.3085-3-thomas_os@shipmail.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/vmware.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 3caac90..ac9fc51 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -4,6 +4,7 @@
 
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
+#include <linux/stringify.h>
 
 /*
  * The hypercall definitions differ in the low word of the %edx argument
@@ -20,8 +21,8 @@
  */
 
 /* Old port-based version */
-#define VMWARE_HYPERVISOR_PORT    "0x5658"
-#define VMWARE_HYPERVISOR_PORT_HB "0x5659"
+#define VMWARE_HYPERVISOR_PORT    0x5658
+#define VMWARE_HYPERVISOR_PORT_HB 0x5659
 
 /* Current vmcall / vmmcall version */
 #define VMWARE_HYPERVISOR_HB   BIT(0)
@@ -29,7 +30,7 @@
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; "	\
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
 		      "inl (%%dx), %%eax",				\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
@@ -39,7 +40,8 @@
  * HB and OUT bits set.
  */
 #define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep outsb", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
+		      "rep outsb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 
@@ -48,7 +50,8 @@
  * HB bit set.
  */
 #define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep insb", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
+		      "rep insb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif
