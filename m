Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212D5208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405622AbfITQWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:22:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52881 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404997AbfITQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLej-0004DK-In; Fri, 20 Sep 2019 18:21:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8798A1C0E3B;
        Fri, 20 Sep 2019 18:21:02 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:21:02 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tests: Add libperf automated test for 'make
 -C tools/perf build-test'
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190901124822.10132-4-jolsa@kernel.org>
References: <20190901124822.10132-4-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156899646246.24167.1384772520301168306.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9eab951f34dbd092ab520bda167f288899858306
Gitweb:        https://git.kernel.org/tip/9eab951f34dbd092ab520bda167f288899858306
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 01 Sep 2019 14:48:21 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 10 Sep 2019 14:33:32 +01:00

perf tests: Add libperf automated test for 'make -C tools/perf build-test'

Add a libperf build test, that is triggered when one does:

  $ make -C tools/perf build-test

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190901124822.10132-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 70c4847..6b3afed 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -327,6 +327,10 @@ make_kernelsrc_tools:
 	(make -C ../../tools $(PARALLEL_OPT) $(K_O_OPT) perf) > $@ 2>&1 && \
 	test -x $(KERNEL_O)/tools/perf/perf && rm -f $@ || (cat $@ ; false)
 
+make_libperf:
+	@echo "- make -C lib";
+	make -C lib clean >$@ 2>&1; make -C lib >>$@ 2>&1 && rm $@
+
 FEATURES_DUMP_FILE := $(FULL_O)/BUILD_TEST_FEATURE_DUMP
 FEATURES_DUMP_FILE_STATIC := $(FULL_O)/BUILD_TEST_FEATURE_DUMP_STATIC
 
@@ -365,5 +369,5 @@ $(foreach t,$(run),$(if $(findstring make_static,$(t)),\
 			$(eval $(t) := $($(t)) FEATURES_DUMP=$(FEATURES_DUMP_FILE))))
 endif
 
-.PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools
+.PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools make_libperf
 endif # ifndef MK
