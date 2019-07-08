Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C46C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A39216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzGyscHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405357AbfGHV7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:59:36 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40957 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfGHV7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:59:36 -0400
Received: by mail-pf1-f201.google.com with SMTP id z1so11092263pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iwXqAOstZTSVx3TA6RgLM0LHwuLg0WP4ZTSqRQ8WuoI=;
        b=qzGyscHmT5Ai5NC2MchCM/hXO/6I2ur/XskIYUNPAc3yEa4ad/mi6HHc0yqwnhB+iy
         vpimDgZTLh4D6L5UC7ekRzl6kQa8jcOFCnoiSs9+7lcT2rh4yKFzsyv0uU5GSYbHwyB8
         2+dE1+J7Em/wx+UwTYFs8At5SFvy2BtaiaQReMaO/xPWruQra+LQK3i4+mi/hovHpRD1
         R1Innewbr/OQBy6wYdqwbOwAFpRcKS4WCpLxXw6sp4q4P0ylXIbepZjwgcV5M49nm7dB
         ZHWPr7KkGxXCA8ryApkQcR3rkSYCa3n4rXXmm/4Oc2HQl40zcMDdjXfbzUBRtUkaeiI8
         a6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iwXqAOstZTSVx3TA6RgLM0LHwuLg0WP4ZTSqRQ8WuoI=;
        b=tMTb+yFnSANq1Dl15GDyrBJpAhAnjqd+RcTQcl90zAv+eHKma5d59ocVwkbsaL9Dhc
         POreO+ZpWObVDcbSpGJK9o1sr1nUN384N5rORN789SOaCKFyOyjuJoieKUHTx7MQ4YZ8
         k78uj7bVI9hpr30X9dKLdCcDUmwyazMen3vPhc5GlhrKPaTWGleVd5O2Iu5kW1bVeTPw
         fI8WccTGEhlGClpkMyBz2+nt5Ww/YNfXf3EgGpPs55vCFLSWdjU7BOMeSYdhJRoR4hYf
         F7NydLHL2VTIgHekxmkurF4W62sMk0k5+IBogDDQHozFH5SLDAsmFBIR8FzuO2OHnrmf
         ZWlA==
X-Gm-Message-State: APjAAAUT1z40Q8TUhjXtpMmSfTahXTy2J2QMYiOYUyEAp1B6IlPMfOCq
        AtUXgnPBgvPsMv5YUompU+V4Km80
X-Google-Smtp-Source: APXvYqxnFHO9Ns7EQIVIkklw4Hg8IQLg8M9/RP6YzpVmssBcUirQMZ31liBbsiDnUfWXtflqrhKINJon
X-Received: by 2002:a63:10a:: with SMTP id 10mr26624012pgb.281.1562623174891;
 Mon, 08 Jul 2019 14:59:34 -0700 (PDT)
Date:   Mon,  8 Jul 2019 14:59:28 -0700
Message-Id: <20190708215928.167905-1-nums@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] Fix perf-hooks test for sanitizers
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf-hooks test fails with Address Sanitizer and Memory
Sanitizer builds because it purposefully generates a segfault.
Checking if these sanitizers are active when running this test
will allow the perf-hooks test to pass.

This can be replicated by running (from the tip directory):

make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=address \
-DADDRESS_SANITIZER=1"

then running tools/perf/perf test 55

Fix past to pass:
The raised signal was changed from SIGSEGV to SIGILL to get the test 
to pass on our local machines which use clang 4.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/tests/perf-hooks.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index a693bcf017ea..3f5f4b28cf01 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -7,7 +7,14 @@
 #include "util.h"
 #include "perf-hooks.h"
 
-static void sigsegv_handler(int sig __maybe_unused)
+#if defined(ADDRESS_SANITIZER) || defined(MEMORY_SANITIZER) || \
+defined(THREAD_SANITIZER) || defined(SAFESTACK_SANITIZER)
+#define USE_SIGNAL 1
+#else
+#define USE_SIGNAL 0
+#endif
+
+static void signal_handler(int sig __maybe_unused)
 {
 	pr_debug("SIGSEGV is observed as expected, try to recover.\n");
 	perf_hooks__recover();
@@ -25,6 +32,9 @@ static void the_hook(void *_hook_flags)
 	*hook_flags = 1234;
 
 	/* Generate a segfault, test perf_hooks__recover */
+#if USE_SIGNAL
+	raise(SIGILL);
+#endif
 	*p = 0;
 }
 
@@ -32,7 +42,7 @@ int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unuse
 {
 	int hook_flags = 0;
 
-	signal(SIGSEGV, sigsegv_handler);
+	signal(USE_SIGNAL ? SIGILL : SIGSEGV, signal_handler);
 	perf_hooks__set_hook("test", the_hook, &hook_flags);
 	perf_hooks__invoke_test();
 
-- 
2.22.0.410.gd8fdbe21b5-goog

