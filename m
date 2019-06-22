Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5D3C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCE5206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="okf2msIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFVKFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:05:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37497 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFVKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:05:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA4mnp2095319
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:04:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA4mnp2095319
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561197889;
        bh=YO1m/y/8YVmn3eYEsNLgjJiHpvB3avjwVRoVLH0kaVE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=okf2msIxec/XjmlXz6Pm3OdViF1nmB8w3H7SJ3PkJAucAD8xxtJAT9NUPKREvfltT
         l5nHG2crcx2TQmmz2ujrr4Uqi++hs8rwVqg+jH8meV5InkhQMYLp4NrD9W6W8TuSrx
         t5t5npksL+DI+KOQS+gdelEHBvpxfxJ7Pg//m5uZHyoRMsj4wikd9mcQzFe8EJLP3A
         NC+dCSP4RoYpOEc9c4YT7MSKEHxQHjsntErmNrfsMj2BVsOmgbpaZ0NeQa5NiPlmz6
         2V1Jhe5kjuf9eMdM1ZcBk6nM2eOb8RUr1BW9JVhkkJtW7z1K7guYH0H4/mjlkMIgY/
         OguySANOzqgXw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA4lX82095316;
        Sat, 22 Jun 2019 03:04:47 -0700
Date:   Sat, 22 Jun 2019 03:04:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-1b6858d5a2eb2485761f06bd48055ed5bed08464@git.kernel.org>
Cc:     ak@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, hpa@zytor.com,
        chang.seok.bae@intel.com, ravi.v.shankar@intel.com,
        mingo@kernel.org
Reply-To: ravi.v.shankar@intel.com, mingo@kernel.org,
          chang.seok.bae@intel.com, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, luto@kernel.org, ak@linux.intel.com
In-Reply-To: <1557309753-24073-3-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-3-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] selftests/x86/fsgsbase: Test ptracer-induced GSBASE
 write
Git-Commit-ID: 1b6858d5a2eb2485761f06bd48055ed5bed08464
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

Commit-ID:  1b6858d5a2eb2485761f06bd48055ed5bed08464
Gitweb:     https://git.kernel.org/tip/1b6858d5a2eb2485761f06bd48055ed5bed08464
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:17 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:51 +0200

selftests/x86/fsgsbase: Test ptracer-induced GSBASE write

The test validates that the selector is not changed when a ptracer writes
the ptracee's GSBASE.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-3-git-send-email-chang.seok.bae@intel.com

---
 tools/testing/selftests/x86/fsgsbase.c | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index af85bd4752a5..b02ddce49bbb 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -23,6 +23,9 @@
 #include <pthread.h>
 #include <asm/ldt.h>
 #include <sys/mman.h>
+#include <stddef.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
 
 #ifndef __x86_64__
 # error This test is 64-bit only
@@ -367,6 +370,71 @@ static void test_unexpected_base(void)
 	}
 }
 
+#define USER_REGS_OFFSET(r) offsetof(struct user_regs_struct, r)
+
+static void test_ptrace_write_gsbase(void)
+{
+	int status;
+	pid_t child = fork();
+
+	if (child < 0)
+		err(1, "fork");
+
+	if (child == 0) {
+		printf("[RUN]\tPTRACE_POKE(), write GSBASE from ptracer\n");
+
+		/*
+		 * Use the LDT setup and fetch the GSBASE from the LDT
+		 * by switching to the (nonzero) selector (again)
+		 */
+		do_unexpected_base();
+		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0x7));
+
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != 0)
+			err(1, "PTRACE_TRACEME");
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	wait(&status);
+
+	if (WSTOPSIG(status) == SIGTRAP) {
+		unsigned long gs;
+		unsigned long gs_offset = USER_REGS_OFFSET(gs);
+		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
+
+		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
+
+		if (gs != 0x7) {
+			nerrs++;
+			printf("[FAIL]\tGS is not prepared with nonzero\n");
+			goto END;
+		}
+
+		if (ptrace(PTRACE_POKEUSER, child, base_offset, 0xFF) != 0)
+			err(1, "PTRACE_POKEUSER");
+
+		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
+
+		/*
+		 * In a non-FSGSBASE system, the nonzero selector will load
+		 * GSBASE (again). But what is tested here is whether the
+		 * selector value is changed or not by the GSBASE write in
+		 * a ptracer.
+		 */
+		if (gs != 0x7) {
+			nerrs++;
+			printf("[FAIL]\tGS changed to %lx\n", gs);
+		} else {
+			printf("[OK]\tGS remained 0x7\n");
+		}
+	}
+
+END:
+	ptrace(PTRACE_CONT, child, NULL, NULL);
+}
+
 int main()
 {
 	pthread_t thread;
@@ -423,5 +491,7 @@ int main()
 	if (pthread_join(thread, NULL) != 0)
 		err(1, "pthread_join");
 
+	test_ptrace_write_gsbase();
+
 	return nerrs == 0 ? 0 : 1;
 }
