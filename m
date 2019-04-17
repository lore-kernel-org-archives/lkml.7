Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D442C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99CC21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="SFxb82mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfDQUE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:04:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58011 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:04:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HK3UTk4056062
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 13:03:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HK3UTk4056062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555531412;
        bh=GcMamOMWp3Z8wsQxkCYrf7I30NATUPWZVn8DD/wLGi4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SFxb82mQCJLzLHaeqGrCRHPjpJaUw1uyMG9uNrrYr7+6mJiNqHm+JACaXygUmYDuk
         2Y77E9g/uqCwLfCFGGWba8mZv1o4urueER4BcKl5ZDI06mO9M3MG+mYynMwQHgGbgH
         mCe95gr7UfVxTWkXGWjB/SWAmZAt6wdUuN6Sotgy2ea4sEGk8sRxcB+CK4HLXBFMdt
         M3JcR9mPZnXQ5XKLHizLX5HX2aOymhVdAFdUqroNLGYS7n2wus2ieYWiUyqpdXEZzE
         gLt3oOI7SP6VEhmMTKQCBCyK2655X41kZ9rwTLddGGRhYN5h8t57IKwyx+xw/xOs9B
         LzeoAF1aR1LcQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HK3Uja4056059;
        Wed, 17 Apr 2019 13:03:30 -0700
Date:   Wed, 17 Apr 2019 13:03:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-0336e04a6520bdaefdb0769d2a70084fa52e81ed@git.kernel.org>
Cc:     hpa@zytor.com, luto@kernel.org, bp@alien8.de, jpoimboe@redhat.com,
        tyhicks@canonical.com, tglx@linutronix.de, aarcange@redhat.com,
        longman@redhat.com, catalin.marinas@arm.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        jcm@redhat.com, paulus@samba.org, pauld@redhat.com,
        mingo@kernel.org, jkosina@suse.cz, will.deacon@arm.com,
        heiko.carstens@de.ibm.com, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jikos@kernel.org,
        rdunlap@infradead.org, steven.price@arm.com
Reply-To: mpe@ellerman.id.au, heiko.carstens@de.ibm.com,
          linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
          torvalds@linux-foundation.org, jikos@kernel.org,
          steven.price@arm.com, rdunlap@infradead.org, paulus@samba.org,
          pauld@redhat.com, mingo@kernel.org, jkosina@suse.cz,
          will.deacon@arm.com, catalin.marinas@arm.com,
          peterz@infradead.org, longman@redhat.com,
          gregkh@linuxfoundation.org, benh@kernel.crashing.org,
          jcm@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
          jpoimboe@redhat.com, tyhicks@canonical.com, aarcange@redhat.com,
          tglx@linutronix.de
In-Reply-To: <e4a161805458a5ec88812aac0307ae3908a030fc.1555085500.git.jpoimboe@redhat.com>
References: <e4a161805458a5ec88812aac0307ae3908a030fc.1555085500.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/speculation] s390/speculation: Support 'mitigations='
 cmdline option
Git-Commit-ID: 0336e04a6520bdaefdb0769d2a70084fa52e81ed
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

Commit-ID:  0336e04a6520bdaefdb0769d2a70084fa52e81ed
Gitweb:     https://git.kernel.org/tip/0336e04a6520bdaefdb0769d2a70084fa52e81ed
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Fri, 12 Apr 2019 15:39:31 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Apr 2019 21:37:29 +0200

s390/speculation: Support 'mitigations=' cmdline option

Configure s390 runtime CPU speculation bug mitigations in accordance
with the 'mitigations=' cmdline option.  This affects Spectre v1 and
Spectre v2.

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
Link: https://lkml.kernel.org/r/e4a161805458a5ec88812aac0307ae3908a030fc.1555085500.git.jpoimboe@redhat.com

---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 arch/s390/kernel/nospec-branch.c                | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ac7150a25a7a..1ae93872b79f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2514,7 +2514,7 @@
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
-			[X86,PPC] Control optional mitigations for CPU
+			[X86,PPC,S390] Control optional mitigations for CPU
 			vulnerabilities.  This is a set of curated,
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
@@ -2525,7 +2525,8 @@
 				expose users to several CPU vulnerabilities.
 				Equivalent to: nopti [X86,PPC]
 					       nospectre_v1 [PPC]
-					       nospectre_v2 [X86,PPC]
+					       nobp=0 [S390]
+					       nospectre_v2 [X86,PPC,S390]
 					       spectre_v2_user=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
 					       l1tf=off [X86]
diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index bdddaae96559..649135cbedd5 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/cpu.h>
 #include <asm/nospec-branch.h>
 
 static int __init nobp_setup_early(char *str)
@@ -58,7 +59,7 @@ early_param("nospectre_v2", nospectre_v2_setup_early);
 
 void __init nospec_auto_detect(void)
 {
-	if (test_facility(156)) {
+	if (test_facility(156) || cpu_mitigations_off()) {
 		/*
 		 * The machine supports etokens.
 		 * Disable expolines and disable nobp.
