Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D82C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF88F2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfIJMD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfIJMDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3ABB18C4265;
        Tue, 10 Sep 2019 12:03:55 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 038A260BE2;
        Tue, 10 Sep 2019 12:03:51 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:03:25 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH 3/6] selftests/clone3: use uint64_t for flags parameter
Message-ID: <3f7bd9f0446360f90f12b9e9d3af1de2f5133a81.1568116761.git.esyr@redhat.com>
References: <cover.1568116761.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568116761.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 10 Sep 2019 12:03:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flags parameter in both userspace and kernel clone args is 64-bit wide,
there's little reason to have it signed and 32-bit in tests.

* tools/testing/selftests/clone3/clone3.c: Include <inttypes.h> and
<stdint.h>.
(call_clone3): Change flags parameter type from int to uint64_t.
(test_clone3): Change flags parameter type from int to uint64_t; change
the format string that prints it accordingly.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/clone3/clone3.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 4f23a0c..1746a9b 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -4,8 +4,10 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
+#include <inttypes.h>
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/syscall.h>
@@ -36,7 +38,7 @@ static pid_t raw_clone(struct clone_args *args, size_t size)
 	return syscall(__NR_clone3, args, size);
 }
 
-static int call_clone3(int flags, size_t size, enum test_mode test_mode)
+static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 {
 	struct clone_args args = {0};
 	pid_t ppid = -1;
@@ -102,12 +104,13 @@ static int call_clone3(int flags, size_t size, enum test_mode test_mode)
 	return 0;
 }
 
-static int test_clone3(int flags, size_t size, int expected,
+static int test_clone3(uint64_t flags, size_t size, int expected,
 		       enum test_mode test_mode)
 {
 	int ret;
 
-	ksft_print_msg("[%d] Trying clone3() with flags 0x%x (size %d)\n",
+	ksft_print_msg("[%d] Trying clone3() with flags %#" PRIx64 " (size %d)"
+			"\n",
 			getpid(), flags, size);
 	ret = call_clone3(flags, size, test_mode);
 	ksft_print_msg("[%d] clone3() with flags says :%d expected %d\n",
-- 
2.1.4

