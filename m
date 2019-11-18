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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3F3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E412073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CANr8QSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfKRGsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:48:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32853 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfKRGr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:47:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so9175440pgn.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 22:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/h1ybl837ht0EnL0gUEEuZSFqHhEybC0Mbvz9GhgmXw=;
        b=CANr8QSW05k/eCeeQ4Jiuw0ioNIKS5NKoXpR9nVtXp3n9Qg2nlM2JkM0SYG2yfMAWN
         TN5toJiIa27eEtNfQNJK0r2GZ6h40ueuyiWMWIPKQJ3ACdfAQwA8R8UQ2ZPg5bwhpAOk
         1RoOA0Z187/E+1DgY2H3XPcUY7mRco3Yw4fOkw/lP6BPUxCBRoQAyA8abTSmKiGGPCKM
         rmQY+v4QKWcHlk6Hkj59Wx+LZ4bEmizD+fSBmnQA3xvj1w0ytYKq8qJWKvKvkXef/Of5
         P5SI35w6jjeZkVKm99Bg5uit/M+XvIFAXTCykiXgXElvyEF3ElvzliJDzs2TrOxNrJqf
         I1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/h1ybl837ht0EnL0gUEEuZSFqHhEybC0Mbvz9GhgmXw=;
        b=bfuxYrDEuzHeWcGJI/DBhpPMUgo4xzkze+GTJdZlQ8smHS/gF4nXaL1BMlur9ZM6pf
         M8WfYwRhWkVOrSck+crF+wAnE/4YvExyxTt/S6suO3zyUHKSMA6/i5nXbNJJg6xam18a
         am3k2sm3UQZfny3SxOQx38Te48wFNglRcKcrryV+1uFXFNTgdv0y4gK7BCo6SPd8Jca2
         rEKSxUMemWeL/UA8Ju1BJsxwhN6nBqCG1T4tXNSlGmL3B0l1jWq8w3mSo7DWzpPzEC2H
         /si8VOa9C5mrLPwRpdlfoRbfPGn0Fi5PqL5Hz5wbI2ounEYXBjlTFvCKUq4pK+DnD5Bf
         oDow==
X-Gm-Message-State: APjAAAWxkNzv6sPKBFmA/5Bc5vvq+5K9Qa4kY4HTXOuKainjXqWQnsue
        YDWRSqUy2CLWA44Z6RyibjA=
X-Google-Smtp-Source: APXvYqxOwQpJUgkd+9j127zC4l0Rx+E+0XxLIzEgn5DH/dIL+XBJ++v+3oN2+HM3r2QVsiycBImZnQ==
X-Received: by 2002:a63:5417:: with SMTP id i23mr31881836pgb.305.1574059678512;
        Sun, 17 Nov 2019 22:47:58 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id v3sm21728403pfi.26.2019.11.17.22.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 22:47:58 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 3/3] selftests/clone3: check that all pids are released on error paths
Date:   Sun, 17 Nov 2019 22:47:50 -0800
Message-Id: <20191118064750.408003-3-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191118064750.408003-1-avagin@gmail.com>
References: <20191118064750.408003-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regression test case for an issue when pids have not been
released on error paths.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/clone3/clone3_set_tid.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 9c19bae03661..c6309f5d7d88 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -160,7 +160,7 @@ int main(int argc, char *argv[])
 		ksft_exit_fail_msg("pipe() failed\n");
 
 	ksft_print_header();
-	ksft_set_plan(27);
+	ksft_set_plan(29);
 
 	f = fopen("/proc/sys/kernel/pid_max", "r");
 	if (f == NULL)
@@ -290,6 +290,18 @@ int main(int argc, char *argv[])
 	/* Let's create a PID 1 */
 	ns_pid = fork();
 	if (ns_pid == 0) {
+		/*
+		 * This and the next test cases check that all pid-s are
+		 * released on error paths.
+		 */
+		set_tid[0] = 43;
+		set_tid[1] = -1;
+		test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);
+
+		set_tid[0] = 43;
+		set_tid[1] = pid;
+		test_clone3_set_tid(set_tid, 2, 0, 0, 43, 0);
+
 		ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
 		set_tid[0] = 2;
 		test_clone3_set_tid(set_tid, 1, 0, 0, 2, 0);
@@ -366,7 +378,7 @@ int main(int argc, char *argv[])
 	if (!WIFEXITED(status))
 		ksft_test_result_fail("Child error\n");
 
-	ksft_cnt.ksft_pass += 4 - (ksft_cnt.ksft_fail - WEXITSTATUS(status));
+	ksft_cnt.ksft_pass += 6 - (ksft_cnt.ksft_fail - WEXITSTATUS(status));
 	ksft_cnt.ksft_fail = WEXITSTATUS(status);
 
 	if (ns3 == pid && ns2 == 42 && ns1 == 1)
-- 
2.23.0

