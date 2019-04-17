Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFADFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7421773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="ue5yJS/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfDQUC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:02:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDQUC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:02:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HK23GV4055651
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 13:02:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HK23GV4055651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555531324;
        bh=be7zZfo7JbM9ULHFq4WzQ1BrnmBNaUKtKDKqbJaKn9g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ue5yJS/V2pxcP3T3h3UbPeRHH66NktTBmOB2AgGMW+TKEX7VRElKCPldg67ijkOHm
         ABNcNWwxxfncKAIDOUNIg2Z8erVu2pXWPKIj4yjVc17+A8G1kB3zLAitx2ey8/lNox
         u6R/GDTxtohGWP0Hhc3hLlfpMXl8J3Z1MyOUiszXL1WqyBW1vHY9pYXHQI0nLayfY7
         E8jkNYvvGpAlOUqMs4eaH1ejVFhjV6232cmhJf6i2H6s4gdCq85WBPIXOvMJcU41Jc
         Yu0F3TjbO3BktL/8AH94/IwWymH73yw2I8QVy4jEkj385gShDq1M2tYOeRD4uqagO4
         UEK0oAwi3TMGw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HK22pA4055648;
        Wed, 17 Apr 2019 13:02:02 -0700
Date:   Wed, 17 Apr 2019 13:02:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-d68be4c4d31295ff6ae34a8ddfaa4c1a8ff42812@git.kernel.org>
Cc:     mingo@kernel.org, luto@kernel.org, jikos@kernel.org,
        will.deacon@arm.com, benh@kernel.crashing.org,
        schwidefsky@de.ibm.com, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, mpe@ellerman.id.au,
        aarcange@redhat.com, longman@redhat.com, jcm@redhat.com,
        paulus@samba.org, catalin.marinas@arm.com, jpoimboe@redhat.com,
        jkosina@suse.cz, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        pauld@redhat.com, rdunlap@infradead.org, tyhicks@canonical.com,
        steven.price@arm.com, heiko.carstens@de.ibm.com, bp@alien8.de,
        peterz@infradead.org
Reply-To: will.deacon@arm.com, benh@kernel.crashing.org, jikos@kernel.org,
          mingo@kernel.org, luto@kernel.org, hpa@zytor.com,
          aarcange@redhat.com, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
          torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
          jpoimboe@redhat.com, jkosina@suse.cz,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          longman@redhat.com, paulus@samba.org, jcm@redhat.com,
          catalin.marinas@arm.com, steven.price@arm.com, bp@alien8.de,
          heiko.carstens@de.ibm.com, peterz@infradead.org,
          pauld@redhat.com, rdunlap@infradead.org, tyhicks@canonical.com
In-Reply-To: <6616d0ae169308516cfdf5216bedd169f8a8291b.1555085500.git.jpoimboe@redhat.com>
References: <6616d0ae169308516cfdf5216bedd169f8a8291b.1555085500.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/speculation] x86/speculation: Support 'mitigations='
 cmdline option
Git-Commit-ID: d68be4c4d31295ff6ae34a8ddfaa4c1a8ff42812
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d68be4c4d31295ff6ae34a8ddfaa4c1a8ff42812
Gitweb:     https://git.kernel.org/tip/d68be4c4d31295ff6ae34a8ddfaa4c1a8ff42812
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Fri, 12 Apr 2019 15:39:29 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Apr 2019 21:37:28 +0200

x86/speculation: Support 'mitigations=' cmdline option

Configure x86 runtime CPU speculation bug mitigations in accordance with
the 'mitigations=' cmdline option.  This affects Meltdown, Spectre v2,
Speculative Store Bypass, and L1TF.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz> (on x86)
Reviewed-by: Jiri Kosina <jkosina@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/6616d0ae169308516cfdf5216bedd169f8a8291b.1555085500.git.jpoimboe@redhat.com

---
 Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++++-----
 arch/x86/kernel/cpu/bugs.c                      | 11 +++++++++--
 arch/x86/mm/pti.c                               |  4 +++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 720ffa9c4e04..779ddeb2929c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2514,15 +2514,20 @@
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
@@ -2530,12 +2535,13 @@
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
index 01874d54f4fd..435c078c2948 100644
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
@@ -996,6 +998,11 @@ static void __init l1tf_select_mitigation(void)
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
index 4fee5c3003ed..5890f09bfc19 100644
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
