Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32271C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056822147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708763;
	bh=xju/LHAt3005uCQggonRohIWeYbULyao7d8LtBo5Qkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQ/DvtbG8GHLEX6mjVuONFS0EBJNp/lwBM5wbpud+cI2SuLgI4Aoj5iXl49+ZGlyj
	 lv1SsxqLOTGkraSohqVy2lLtCMiA1NF8yuOiFrU+oFSM1j0BMrSUg1nj1aqXtBpFC8
	 56Z/mlSxUwwhSGZ2vV8luUuWibPPSTXFlLa2t+gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfGULcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FA71300CA39;
        Sun, 21 Jul 2019 11:32:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 080195D9D3;
        Sun, 21 Jul 2019 11:32:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 72/79] libperf: Add tests support
Date:   Sun, 21 Jul 2019 13:24:59 +0200
Message-Id: <20190721112506.12306-73-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 21 Jul 2019 11:32:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding simple test framework, now empty.

Link: http://lkml.kernel.org/n/tip-62jm3ylb5o3d5tq8scbuk0sd@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Makefile                 |  7 ++++-
 tools/perf/lib/include/internal/tests.h | 19 +++++++++++++
 tools/perf/lib/tests/Makefile           | 38 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/lib/include/internal/tests.h
 create mode 100644 tools/perf/lib/tests/Makefile

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index e69014a76971..b5547b725a17 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -109,6 +109,11 @@ all: fixdep
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
+	$(Q)$(MAKE) -C tests clean
+
+tests:
+	$(Q)$(MAKE) -C tests
+	$(Q)$(MAKE) -C tests run
 
 $(LIBPERF_PC):
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
@@ -150,4 +155,4 @@ install: install_lib install_headers install_pkgconfig
 
 FORCE:
 
-.PHONY: all install clean FORCE
+.PHONY: all install clean tests FORCE
diff --git a/tools/perf/lib/include/internal/tests.h b/tools/perf/lib/include/internal/tests.h
new file mode 100644
index 000000000000..b7a20cd24ee1
--- /dev/null
+++ b/tools/perf/lib/include/internal/tests.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_TESTS_H
+#define __LIBPERF_INTERNAL_TESTS_H
+
+#include <stdio.h>
+
+#define __T_START fprintf(stdout, "- running %s...", __FILE__)
+#define __T_OK    fprintf(stdout, "OK\n")
+#define __T_FAIL  fprintf(stdout, "FAIL\n")
+
+#define __T(text, cond)                                                          \
+do {                                                                             \
+	if (!(cond)) {                                                           \
+		fprintf(stderr, "FAILED %s:%d %s\n", __FILE__, __LINE__, text);  \
+		return -1;                                                       \
+	}                                                                        \
+} while (0)
+
+#endif /* __LIBPERF_INTERNAL_TESTS_H */
diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
new file mode 100644
index 000000000000..de951ae38dea
--- /dev/null
+++ b/tools/perf/lib/tests/Makefile
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+TESTS =
+
+TESTS_SO := $(addsuffix -so,$(TESTS))
+TESTS_A  := $(addsuffix -a,$(TESTS))
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+all:
+
+include $(srctree)/tools/scripts/Makefile.include
+
+INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include
+
+$(TESTS_A): FORCE
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a
+
+$(TESTS_SO): FORCE
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) -lperf
+
+all: $(TESTS_A) $(TESTS_SO)
+
+run:
+	@echo "running static:"
+	@for i in $(TESTS_A); do ./$$i; done
+	@echo "running dynamic:"
+	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
+
+clean:
+	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
+
+.PHONY: all clean FORCE
-- 
2.21.0

