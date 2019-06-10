Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24309C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DDB2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560198350;
	bh=0wSO5gvb5yM9h8S0AX3Uqm/Y5dVidJey8BXinLilevM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KqY1e5xq+Izms3j1aH4ioE7Fb550+txUUdIvSxt2ywqjBGbdcPaMMhCudWnXM8NbX
	 tJPDOMr4qCEKYBOaw6nK7Veyo0XJ4xpYsEnXrsC86VOJrj/GX6CiCLvqzKd5tARnhQ
	 S3nWFImfrkdGIE4uYTfhUVkA+6L/TEkGa6Bb/3As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbfFJUZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389398AbfFJUZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:25:40 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2B92089E;
        Mon, 10 Jun 2019 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560198339;
        bh=0wSO5gvb5yM9h8S0AX3Uqm/Y5dVidJey8BXinLilevM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0rXUl6eksnQgeQcMPLGWHki7zAZJOuWZh99VZM+5CaiYsD8qMaVFz11UCUrPjbKS
         uMrw3HB9uI0eabAO9yn51Ma/MjxKXgCN/KRFSXpbTQ5obw1Dt+/C1XhysaBO59API6
         riU1LVUaUAHmvfaxU5dfg/7c2UsEf0uTA0cA0iT0=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/5] selftests/x86/vsyscall: Verify that vsyscall=none blocks execution
Date:   Mon, 10 Jun 2019 13:25:30 -0700
Message-Id: <a1ed0dda99e638f352e82f48b2d86737fd65ec5c.1560198181.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560198181.git.luto@kernel.org>
References: <cover.1560198181.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vsyscall=none accidentally still allowed vsyscalls, the test
wouldn't fail.  Fix it.

Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/test_vsyscall.c | 74 ++++++++++++++-------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 4c9a8d76dba0..aa59583e9aa7 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -49,21 +49,21 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 }
 
 /* vsyscalls and vDSO */
-bool should_read_vsyscall = false;
+bool vsyscall_map_r = false, vsyscall_map_x = false;
 
 typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-gtod_t vgtod = (gtod_t)VSYS(0xffffffffff600000);
+const gtod_t vgtod = (gtod_t)VSYS(0xffffffffff600000);
 gtod_t vdso_gtod;
 
 typedef int (*vgettime_t)(clockid_t, struct timespec *);
 vgettime_t vdso_gettime;
 
 typedef long (*time_func_t)(time_t *t);
-time_func_t vtime = (time_func_t)VSYS(0xffffffffff600400);
+const time_func_t vtime = (time_func_t)VSYS(0xffffffffff600400);
 time_func_t vdso_time;
 
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
-getcpu_t vgetcpu = (getcpu_t)VSYS(0xffffffffff600800);
+const getcpu_t vgetcpu = (getcpu_t)VSYS(0xffffffffff600800);
 getcpu_t vdso_getcpu;
 
 static void init_vdso(void)
@@ -107,7 +107,7 @@ static int init_vsys(void)
 	maps = fopen("/proc/self/maps", "r");
 	if (!maps) {
 		printf("[WARN]\tCould not open /proc/self/maps -- assuming vsyscall is r-x\n");
-		should_read_vsyscall = true;
+		vsyscall_map_r = true;
 		return 0;
 	}
 
@@ -133,12 +133,8 @@ static int init_vsys(void)
 		}
 
 		printf("\tvsyscall permissions are %c-%c\n", r, x);
-		should_read_vsyscall = (r == 'r');
-		if (x != 'x') {
-			vgtod = NULL;
-			vtime = NULL;
-			vgetcpu = NULL;
-		}
+		vsyscall_map_r = (r == 'r');
+		vsyscall_map_x = (x == 'x');
 
 		found = true;
 		break;
@@ -148,10 +144,8 @@ static int init_vsys(void)
 
 	if (!found) {
 		printf("\tno vsyscall map in /proc/self/maps\n");
-		should_read_vsyscall = false;
-		vgtod = NULL;
-		vtime = NULL;
-		vgetcpu = NULL;
+		vsyscall_map_r = false;
+		vsyscall_map_x = false;
 	}
 
 	return nerrs;
@@ -242,7 +236,7 @@ static int test_gtod(void)
 		err(1, "syscall gettimeofday");
 	if (vdso_gtod)
 		ret_vdso = vdso_gtod(&tv_vdso, &tz_vdso);
-	if (vgtod)
+	if (vsyscall_map_x)
 		ret_vsys = vgtod(&tv_vsys, &tz_vsys);
 	if (sys_gtod(&tv_sys2, &tz_sys) != 0)
 		err(1, "syscall gettimeofday");
@@ -256,7 +250,7 @@ static int test_gtod(void)
 		}
 	}
 
-	if (vgtod) {
+	if (vsyscall_map_x) {
 		if (ret_vsys == 0) {
 			nerrs += check_gtod(&tv_sys1, &tv_sys2, &tz_sys, "vsyscall", &tv_vsys, &tz_vsys);
 		} else {
@@ -277,7 +271,7 @@ static int test_time(void) {
 	t_sys1 = sys_time(&t2_sys1);
 	if (vdso_time)
 		t_vdso = vdso_time(&t2_vdso);
-	if (vtime)
+	if (vsyscall_map_x)
 		t_vsys = vtime(&t2_vsys);
 	t_sys2 = sys_time(&t2_sys2);
 	if (t_sys1 < 0 || t_sys1 != t2_sys1 || t_sys2 < 0 || t_sys2 != t2_sys2) {
@@ -298,7 +292,7 @@ static int test_time(void) {
 		}
 	}
 
-	if (vtime) {
+	if (vsyscall_map_x) {
 		if (t_vsys < 0 || t_vsys != t2_vsys) {
 			printf("[FAIL]\tvsyscall failed (ret:%ld output:%ld)\n", t_vsys, t2_vsys);
 			nerrs++;
@@ -334,7 +328,7 @@ static int test_getcpu(int cpu)
 	ret_sys = sys_getcpu(&cpu_sys, &node_sys, 0);
 	if (vdso_getcpu)
 		ret_vdso = vdso_getcpu(&cpu_vdso, &node_vdso, 0);
-	if (vgetcpu)
+	if (vsyscall_map_x)
 		ret_vsys = vgetcpu(&cpu_vsys, &node_vsys, 0);
 
 	if (ret_sys == 0) {
@@ -373,7 +367,7 @@ static int test_getcpu(int cpu)
 		}
 	}
 
-	if (vgetcpu) {
+	if (vsyscall_map_x) {
 		if (ret_vsys) {
 			printf("[FAIL]\tvsyscall getcpu() failed\n");
 			nerrs++;
@@ -414,10 +408,10 @@ static int test_vsys_r(void)
 		can_read = false;
 	}
 
-	if (can_read && !should_read_vsyscall) {
+	if (can_read && !vsyscall_map_r) {
 		printf("[FAIL]\tWe have read access, but we shouldn't\n");
 		return 1;
-	} else if (!can_read && should_read_vsyscall) {
+	} else if (!can_read && vsyscall_map_r) {
 		printf("[FAIL]\tWe don't have read access, but we should\n");
 		return 1;
 	} else if (can_read) {
@@ -431,6 +425,37 @@ static int test_vsys_r(void)
 	return 0;
 }
 
+static int test_vsys_x(void)
+{
+	if (vsyscall_map_x) {
+		/* We already tested this adequately. */
+		return 0;
+	}
+
+	printf("[RUN]\tMake sure that vsyscalls really page fault\n");
+
+	bool can_exec;
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		vgtod(NULL, NULL);
+		can_exec = true;
+	} else {
+		can_exec = false;
+	}
+
+	if (can_exec) {
+		printf("[FAIL]\tExecuting the vsyscall did not page fault\n");
+		return 1;
+	} else if (segv_err & (1 << 4)) { /* INSTR */
+		printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
+		       segv_err);
+	} else {
+		printf("[FAILT]\tExecution failed with the wrong error: #PF(0x%lx)\n",
+		       segv_err);
+		return 1;
+	}
+
+	return 0;
+}
 
 #ifdef __x86_64__
 #define X86_EFLAGS_TF (1UL << 8)
@@ -462,7 +487,7 @@ static int test_emulation(void)
 	time_t tmp;
 	bool is_native;
 
-	if (!vtime)
+	if (!vsyscall_map_x)
 		return 0;
 
 	printf("[RUN]\tchecking that vsyscalls are emulated\n");
@@ -504,6 +529,7 @@ int main(int argc, char **argv)
 
 	sethandler(SIGSEGV, sigsegv, 0);
 	nerrs += test_vsys_r();
+	nerrs += test_vsys_x();
 
 #ifdef __x86_64__
 	nerrs += test_emulation();
-- 
2.21.0

