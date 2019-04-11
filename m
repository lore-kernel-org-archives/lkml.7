Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D245C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E772184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AlVkf+E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfDKX4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:56:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42620 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfDKX4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:56:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so4166594plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=O+tzz1N2dA3PqWQsD5R9a0ieeurGuOtKWgnbSEuym3k=;
        b=AlVkf+E93kYdnBE692nOXwpvzxQazo/A22ynGlzrjuOKNFuTlVkp1ZjO1VcqbImYyI
         I6IPKhtniRrjyemR3lyhredTb4Bg+fbMi5zrFIcl79VwVKCXopYCWdL+8daeSiJg9HqE
         kmcdjy0cSfI8UmjKhxkIfxJ9rde9BOsw25L8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=O+tzz1N2dA3PqWQsD5R9a0ieeurGuOtKWgnbSEuym3k=;
        b=ozcqUyCOyGn96/BfAYRnsxXjcWhUNN6BOgWaSsr09aGrRU8RxsgSHdbPDpFelEgcPP
         ceCeG0D1Xlmnt4Z7WFfEoxM9JM68yRVehgD4O2yc7ry4C+pSOLxxZoVpl8YzWsU48S05
         CGyZvEDHcD/fhBtidvWNfTLoFEJPD2SG5crIlzqab2s/9TJPSs+TYbYtRe1U+bGSRycz
         W6KkcWmo4Di00R9Q7Kzgqko1rBfqCPqYwf8HMm7s/DWrrs4f95E9Ua5r6EpOtPiDFAtv
         rMH9Je59n154kskcW+b0FVVADL96gKHyDlxh0bGOAbdNw9OlihyWpoqRLpn3fKIK+lD+
         59bw==
X-Gm-Message-State: APjAAAXllgRTb6zfAPqeYegfQpQD4No8axgF33IRMO8cIx/Eb1LUVkp+
        GlIdNOlf10FBI73lTsL/g5Y9sg==
X-Google-Smtp-Source: APXvYqyG/NO9kQdUyw0AU3LMhxcWlYKqcxXKG+nJnkpsrm2X8dBSmBOAC4pEm1omIhXYYXcjpBpNQQ==
X-Received: by 2002:a17:902:9006:: with SMTP id a6mr52018290plp.259.1555026993965;
        Thu, 11 Apr 2019 16:56:33 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h8sm55293553pfo.149.2019.04.11.16.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 16:56:32 -0700 (PDT)
Date:   Thu, 11 Apr 2019 16:56:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Tycho Andersen <tycho@tycho.ws>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Handle namespace failures gracefully
Message-ID: <20190411235631.GA31624@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running without USERNS or PIDNS the seccomp test would hang since
it was waiting forever for the child to trigger the user notification
since it seems the glibc() abort handler makes a call to getpid(),
which would trap again. This changes the getpid filter to getppid, and
makes sure ASSERTs execute to stop from spawning the listener.

Reported-by: Shuah Khan <shuah@kernel.org>
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 43 ++++++++++---------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index f69d2ee29742..3a280b7efc87 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3079,9 +3079,9 @@ TEST(user_notification_basic)
 
 	/* Check that we get -ENOSYS with no listener attached */
 	if (pid == 0) {
-		if (user_trap_syscall(__NR_getpid, 0) < 0)
+		if (user_trap_syscall(__NR_getppid, 0) < 0)
 			exit(1);
-		ret = syscall(__NR_getpid);
+		ret = syscall(__NR_getppid);
 		exit(ret >= 0 || errno != ENOSYS);
 	}
 
@@ -3096,12 +3096,12 @@ TEST(user_notification_basic)
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
 
 	/* Check that the basic notification machinery works */
-	listener = user_trap_syscall(__NR_getpid,
+	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	/* Installing a second listener in the chain should EBUSY */
-	EXPECT_EQ(user_trap_syscall(__NR_getpid,
+	EXPECT_EQ(user_trap_syscall(__NR_getppid,
 				    SECCOMP_FILTER_FLAG_NEW_LISTENER),
 		  -1);
 	EXPECT_EQ(errno, EBUSY);
@@ -3110,7 +3110,7 @@ TEST(user_notification_basic)
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
-		ret = syscall(__NR_getpid);
+		ret = syscall(__NR_getppid);
 		exit(ret != USER_NOTIF_MAGIC);
 	}
 
@@ -3128,7 +3128,7 @@ TEST(user_notification_basic)
 	EXPECT_GT(poll(&pollfd, 1, -1), 0);
 	EXPECT_EQ(pollfd.revents, POLLOUT);
 
-	EXPECT_EQ(req.data.nr,  __NR_getpid);
+	EXPECT_EQ(req.data.nr,  __NR_getppid);
 
 	resp.id = req.id;
 	resp.error = 0;
@@ -3160,7 +3160,7 @@ TEST(user_notification_kill_in_middle)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getpid,
+	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
@@ -3172,7 +3172,7 @@ TEST(user_notification_kill_in_middle)
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
-		ret = syscall(__NR_getpid);
+		ret = syscall(__NR_getppid);
 		exit(ret != USER_NOTIF_MAGIC);
 	}
 
@@ -3282,7 +3282,7 @@ TEST(user_notification_closed_listener)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getpid,
+	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
@@ -3293,7 +3293,7 @@ TEST(user_notification_closed_listener)
 	ASSERT_GE(pid, 0);
 	if (pid == 0) {
 		close(listener);
-		ret = syscall(__NR_getpid);
+		ret = syscall(__NR_getppid);
 		exit(ret != -1 && errno != ENOSYS);
 	}
 
@@ -3316,14 +3316,15 @@ TEST(user_notification_child_pid_ns)
 
 	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
 
-	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0)
-		exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
+		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 	EXPECT_EQ(req.pid, pid);
@@ -3355,7 +3356,8 @@ TEST(user_notification_sibling_pid_ns)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
@@ -3368,7 +3370,7 @@ TEST(user_notification_sibling_pid_ns)
 		ASSERT_GE(pid2, 0);
 
 		if (pid2 == 0)
-			exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
+			exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 
 		EXPECT_EQ(waitpid(pid2, &status, 0), pid2);
 		EXPECT_EQ(true, WIFEXITED(status));
@@ -3377,11 +3379,11 @@ TEST(user_notification_sibling_pid_ns)
 	}
 
 	/* Create the sibling ns, and sibling in it. */
-	EXPECT_EQ(unshare(CLONE_NEWPID), 0);
-	EXPECT_EQ(errno, 0);
+	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
+	ASSERT_EQ(errno, 0);
 
 	pid2 = fork();
-	EXPECT_GE(pid2, 0);
+	ASSERT_GE(pid2, 0);
 
 	if (pid2 == 0) {
 		ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
@@ -3389,7 +3391,7 @@ TEST(user_notification_sibling_pid_ns)
 		 * The pid should be 0, i.e. the task is in some namespace that
 		 * we can't "see".
 		 */
-		ASSERT_EQ(req.pid, 0);
+		EXPECT_EQ(req.pid, 0);
 
 		resp.id = req.id;
 		resp.error = 0;
@@ -3419,14 +3421,15 @@ TEST(user_notification_fault_recv)
 
 	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
 
-	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0)
-		exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
+		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 
 	/* Do a bad recv() */
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, NULL), -1);
-- 
2.17.1


-- 
Kees Cook
