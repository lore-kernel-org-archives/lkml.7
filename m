Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6109AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356722073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwQG4Y4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKRGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:47:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42714 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfKRGr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:47:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so9881682pfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 22:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2q1X71G2F9ogvEiNMzRBPTVvugNQ98J/RkFcfMnV5l8=;
        b=RwQG4Y4LfJbbqnf+V2FUH58y984DNZKbHPGhNQWEhjLgfbxhDKG5/9smqzS/EYNKpn
         gmeMXYAtrkD1Lg6hzZjWQl2lx/nluvJLY4MDWJPaX4YUNNAdrPKYom/A3oN4WypZ5sRg
         sSgU/QT38wEQahGYgToWCWnLFUMIrW2vDL7jRSjO5r6RPQvAJV3wmkgVr6xR5PdcfLoY
         tubrh0341XmOHbMRzFp7FCDFge+9RXP/Wf2yLWLEm6j6Dhl4zC37N1FVYozC02LfFSjJ
         zSY4giNcaML1l/+hSdgId2tTh8ikbVIzGQv25PRhBvQ/9ioZpInYuh10aJgExezI2B7G
         j6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2q1X71G2F9ogvEiNMzRBPTVvugNQ98J/RkFcfMnV5l8=;
        b=h/KZGKF2Gq/Ib5fQ4adttYrGj8yKVyD+QBvEWNXqJRbYzE1pFc9kRCBt3xRaUvZvEM
         rgEGiUA/LcwM/tFMrwwzr5mMUK0Vpt3O2flZ0cPlWMignBBju5aq7B5i572I9Ku9yYL6
         wGdHklamnMYtQE7xeHcv4WeEyE25HPeCInWuPP67/9fVZogowuG71cu7t1fkh163dWNy
         2s82+DYcAx0CTzBqlwvDkXjV9SsxG4dhVpzhTm1Fj6r/fX45iGS3ZWoxfHVs7VQmHzbF
         7LW9QR3FvvwfNRs7kM6bmcSXMdFLCiLXeK7kvN1UX3yHFXr3DpoFOi6QJ4ih86AZAry4
         y4cg==
X-Gm-Message-State: APjAAAXm/1bnVXj42iZBHHNtNy1Y9WtckdQswxKBwmlTFeWyJBfRsPQE
        jOsENsGht2YeWwwquJBO7lCgjdGYTpA=
X-Google-Smtp-Source: APXvYqxhcwaWeMHp99PwjDhXGdR9jyB6uOBJYNUFEUjLYBZXlxJZQ/wUynaZ3twLfocyX3WY/Umbzw==
X-Received: by 2002:a65:628f:: with SMTP id f15mr30205410pgv.91.1574059676543;
        Sun, 17 Nov 2019 22:47:56 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id v3sm21728403pfi.26.2019.11.17.22.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 22:47:56 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 1/3] selftests/clone3: flush stdout and stderr before clone3() and _exit()
Date:   Sun, 17 Nov 2019 22:47:48 -0800
Message-Id: <20191118064750.408003-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffers have to be flushed before clone3() to avoid double messages in
the log.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/clone3/clone3_selftests.h |  2 ++
 tools/testing/selftests/clone3/clone3_set_tid.c   | 15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index e5a62dfef67a..c8899e773c8e 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -29,6 +29,8 @@ struct clone_args {
 
 static pid_t sys_clone3(struct clone_args *args, size_t size)
 {
+	fflush(stdout);
+	fflush(stderr);
 	return syscall(__NR_clone3, args, size);
 }
 
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 3480e1c46983..e93369dcfe3b 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -30,6 +30,13 @@
 static int pipe_1[2];
 static int pipe_2[2];
 
+static void child_exit(int ret)
+{
+	fflush(stdout);
+	fflush(stderr);
+	_exit(ret);
+}
+
 static int call_clone3_set_tid(pid_t *set_tid,
 			       size_t set_tid_size,
 			       int flags,
@@ -84,8 +91,8 @@ static int call_clone3_set_tid(pid_t *set_tid,
 		}
 
 		if (set_tid[0] != getpid())
-			_exit(EXIT_FAILURE);
-		_exit(exit_code);
+			child_exit(EXIT_FAILURE);
+		child_exit(exit_code);
 	}
 
 	if (expected_pid == 0 || expected_pid == pid) {
@@ -249,7 +256,7 @@ int main(int argc, char *argv[])
 	pid = fork();
 	if (pid == 0) {
 		ksft_print_msg("Child has PID %d\n", getpid());
-		_exit(EXIT_SUCCESS);
+		child_exit(EXIT_SUCCESS);
 	}
 	if (waitpid(pid, &status, 0) < 0)
 		ksft_exit_fail_msg("Waiting for child %d failed", pid);
@@ -309,7 +316,7 @@ int main(int argc, char *argv[])
 		 */
 		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, true);
 
-		_exit(ksft_cnt.ksft_pass);
+		child_exit(ksft_cnt.ksft_pass);
 	}
 
 	close(pipe_1[1]);
-- 
2.23.0

