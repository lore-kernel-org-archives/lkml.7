Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED4C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98BE2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfIJSCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:02:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfIJSCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:02:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6816310F2E82;
        Tue, 10 Sep 2019 18:02:08 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-20.ams2.redhat.com [10.36.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F4DA5C21E;
        Tue, 10 Sep 2019 18:02:05 +0000 (UTC)
Date:   Tue, 10 Sep 2019 19:01:39 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH v2 1/6] selftests/clone3: convert test modes into an enum
Message-ID: <96cf2b235f525321a562e9727b3fa0b05675efe8.1568138393.git.esyr@redhat.com>
References: <cover.1568138393.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568138393.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Tue, 10 Sep 2019 18:02:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* tools/testing/selftests/clone3/clone3.c (CLONE3_ARGS_NO_TEST,
CLONE3_ARGS_ALL_0, CLONE3_ARGS_ALL_1): Change into an enum.
(call_clone3): Change test_mode parameter type to enum test_mode;
use switch statement for actions that dependent on test_mode selection.
(test_clone3): Change test_mode parameter type to enum test_mode.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/clone3/clone3.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index a0f1989..7b65ee5 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -24,16 +24,18 @@
 /* V1 includes set_tid */
 #define CLONE3_ARGS_SIZE_V1 72
 
-#define CLONE3_ARGS_NO_TEST 0
-#define CLONE3_ARGS_ALL_0 1
-#define CLONE3_ARGS_ALL_1 2
+enum test_mode {
+	CLONE3_ARGS_NO_TEST,
+	CLONE3_ARGS_ALL_0,
+	CLONE3_ARGS_ALL_1,
+};
 
 static pid_t raw_clone(struct clone_args *args, size_t size)
 {
 	return syscall(__NR_clone3, args, size);
 }
 
-static int call_clone3(int flags, size_t size, int test_mode)
+static int call_clone3(int flags, size_t size, enum test_mode test_mode)
 {
 	struct clone_args args = {0};
 	pid_t ppid = -1;
@@ -46,7 +48,8 @@ static int call_clone3(int flags, size_t size, int test_mode)
 	if (size == 0)
 		size = sizeof(struct clone_args);
 
-	if (test_mode == CLONE3_ARGS_ALL_0) {
+	switch (test_mode) {
+	case CLONE3_ARGS_ALL_0:
 		args.flags = 0;
 		args.pidfd = 0;
 		args.child_tid = 0;
@@ -56,7 +59,9 @@ static int call_clone3(int flags, size_t size, int test_mode)
 		args. stack_size = 0;
 		args.tls = 0;
 		args.set_tid = 0;
-	} else if (test_mode == CLONE3_ARGS_ALL_1) {
+		break;
+
+	case CLONE3_ARGS_ALL_1:
 		args.flags = 1;
 		args.pidfd = 1;
 		args.child_tid = 1;
@@ -66,6 +71,7 @@ static int call_clone3(int flags, size_t size, int test_mode)
 		args. stack_size = 1;
 		args.tls = 1;
 		args.set_tid = 1;
+		break;
 	}
 
 	pid = raw_clone(&args, size);
@@ -91,7 +97,8 @@ static int call_clone3(int flags, size_t size, int test_mode)
 	return 0;
 }
 
-static int test_clone3(int flags, size_t size, int expected, int test_mode)
+static int test_clone3(int flags, size_t size, int expected,
+		       enum test_mode test_mode)
 {
 	int ret;
 
-- 
2.1.4

