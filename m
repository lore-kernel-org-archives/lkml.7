Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A30C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D98218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfDLUjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfDLUjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:39:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9902381F19;
        Fri, 12 Apr 2019 20:39:52 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3219600C2;
        Fri, 12 Apr 2019 20:39:49 +0000 (UTC)
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Price <steven.price@arm.com>,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v2 2/5] x86/speculation: Support 'mitigations=' cmdline option
Date:   Fri, 12 Apr 2019 15:39:29 -0500
Message-Id: <6616d0ae169308516cfdf5216bedd169f8a8291b.1555085500.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1555085500.git.jpoimboe@redhat.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 12 Apr 2019 20:39:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure x86 runtime CPU speculation bug mitigations in accordance with
the 'mitigations=' cmdline option.  This affects Meltdown, Spectre v2,
Speculative Store Bypass, and L1TF.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++++-----
 arch/x86/kernel/cpu/bugs.c                      | 11 +++++++++--
 arch/x86/mm/pti.c                               |  4 +++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3ea92e075c64..3e33bd03441a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2545,15 +2545,20 @@
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
-			Control optional mitigations for CPU vulnerabilities.
-			This is a set of curated, arch-independent options, each
-			of which is an aggregation of existing arch-specific
-			options.
+			[X86] Control optional mitigations for CPU
+			vulnerabilities.  This is a set of curated,
+			arch-independent options, each of which is an
+			aggregation of existing arch-specific options.
 
 			off
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
 				expose users to several CPU vulnerabilities.
+				Equivalent to: nopti [X86]
+					       nospectre_v2 [X86]
+					       spectre_v2_user=off [X86]
+					       spec_store_bypass_disable=off [X86]
+					       l1tf=off [X86]
 
 			auto (default)
 				Mitigate all CPU vulnerabilities, but leave SMT
@@ -2561,12 +2566,13 @@
 				users who don't want to be surprised by SMT
 				getting disabled across kernel upgrades, or who
 				have other ways of avoiding SMT-based attacks.
-				This is the default behavior.
+				Equivalent to: (default behavior)
 
 			auto,nosmt
 				Mitigate all CPU vulnerabilities, disabling SMT
 				if needed.  This is for users who always want to
 				be fully mitigated, even if it means losing SMT.
+				Equivalent to: l1tf=flush,nosmt [X86]
 
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2da82eff0eb4..8043a21f36be 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -440,7 +440,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
+	    cpu_mitigations_off())
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
@@ -672,7 +673,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable")) {
+	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
+	    cpu_mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
 	} else {
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
@@ -1008,6 +1010,11 @@ static void __init l1tf_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
+	if (cpu_mitigations_off())
+		l1tf_mitigation = L1TF_MITIGATION_OFF;
+	else if (cpu_mitigations_auto_nosmt())
+		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+
 	override_cache_bits(&boot_cpu_data);
 
 	switch (l1tf_mitigation) {
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5d27172c683f..9c2463bc158f 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/cpu.h>
 
 #include <asm/cpufeature.h>
 #include <asm/hypervisor.h>
@@ -115,7 +116,8 @@ void __init pti_check_boottime_disable(void)
 		}
 	}
 
-	if (cmdline_find_option_bool(boot_command_line, "nopti")) {
+	if (cmdline_find_option_bool(boot_command_line, "nopti") ||
+	    cpu_mitigations_off()) {
 		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on command line.");
 		return;
-- 
2.17.2

