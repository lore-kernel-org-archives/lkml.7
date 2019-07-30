Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5167C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC82A21726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455552;
	bh=lJKrCXn1co81eEgHMUMNPezUjHUOaXLO3Oaqss+yurA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KUw9mPFw5IAXCSqcVR0ux+JAIwCP1sA3q0I58gj3QVotr7Vx8MI7te8aO7OIF1hDS
	 JNOnUYZa7Oi3rqh/N7WN7N7xpKc8BaeKQ2UqGr/UjOdWZ7VFhbAP2qt1Cl1Y6s9T97
	 ntoZwb77LNpy4THDt+jtDCH40eBCHUjaZ97js4iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfG3C7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbfG3C7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620A6216C8;
        Tue, 30 Jul 2019 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455547;
        bh=lJKrCXn1co81eEgHMUMNPezUjHUOaXLO3Oaqss+yurA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEl9aN+9GQ8DJt446GkX7fY8uvZY+TA06PXYNrpTeaQ++500j8nAJ/oHJ8XttCjwm
         WkcYDgXOkMQR5tvmpUImAC9M7W9KFk8mFiiQn5JNV2+SDr9ytM2r7Y/TSLF9ptHbE/
         Q3ghdvvaX1Jl13PjDpF6NIh/687Y/KjF+XIBez/M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 051/107] libperf: Add build version support
Date:   Mon, 29 Jul 2019 23:55:14 -0300
Message-Id: <20190730025610.22603-52-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a shared library version, generating the following files:

  $ ll tools/perf/lib/libperf.so*
  libperf.so -> libperf.so.0.0.1
  libperf.so.0 -> libperf.so.0.0.1
  libperf.so.0.0.1

Committer testing:

One has to build just libbperf to get this, building perf so far doesn't
trigger this, i.e. I tried:

  $ make O=/tmp/build/perf -C tools/perf

And the files above were not created, so one has to do:

  $ make O=/tmp/build/perf -C tools/perf/lib/
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     /tmp/build/perf/libperf.so.0.0.1
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $ ls -la /tmp/build/perf/*.so.*
  lrwxrwxrwx. 1 acme acme    16 Jul 22 15:37 /tmp/build/perf/libperf.so.0 -> libperf.so.0.0.1
  -rwxrwxr-x. 1 acme acme 16368 Jul 22 15:37 /tmp/build/perf/libperf.so.0.0.1
  $

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile    | 20 +++++++++++++++++---
 tools/perf/lib/libperf.map |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/lib/libperf.map

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 33046e7c6a2a..cd571ec648ad 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Most of this file is copied from tools/lib/bpf/Makefile
 
+LIBPERF_VERSION = 0
+LIBPERF_PATCHLEVEL = 0
+LIBPERF_EXTRAVERSION = 1
+
 MAKEFLAGS += --no-print-directory
 
 ifeq ($(srctree),)
@@ -47,7 +51,13 @@ all:
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
-LIBPERF_SO := $(OUTPUT)libperf.so
+VERSION_SCRIPT := libperf.map
+
+PATCHLEVEL    = $(LIBPERF_PATCHLEVEL)
+EXTRAVERSION  = $(LIBPERF_EXTRAVERSION)
+VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
+
+LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
 LIBPERF_A  := $(OUTPUT)libperf.a
 LIBPERF_IN := $(OUTPUT)libperf-in.o
 
@@ -58,7 +68,11 @@ $(LIBPERF_A): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
 
 $(LIBPERF_SO): $(LIBPERF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so $^ -o $@
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
+                                    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libperf.so
+	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
+
 
 libs: $(LIBPERF_A) $(LIBPERF_SO)
 
@@ -67,7 +81,7 @@ all: fixdep
 
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so .*.d .*.cmd LIBPERF-CFLAGS
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS
 
 FORCE:
 
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
new file mode 100644
index 000000000000..a8e913988edf
--- /dev/null
+++ b/tools/perf/lib/libperf.map
@@ -0,0 +1,4 @@
+LIBPERF_0.0.1 {
+	local:
+		*;
+};
-- 
2.21.0

