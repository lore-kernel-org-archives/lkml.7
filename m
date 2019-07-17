Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D03DC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DF5217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R7DpYzbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfGQWtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:49:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQWto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:49:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMn77K1721124
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:49:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMn77K1721124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563403748;
        bh=mEsc60L5fMB3luZERNg/M17SqMWzNavg4/33oaS13X8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=R7DpYzbreM8NMKnvu9W5+2xHhh2lW3exLfqbW4x4hH9ntc8YSsdiWmDsnfNw7RR0b
         MF8qt/2KM5AKbQ4/UUh3OcWJQMjXkQi2+ZBkK4EwqA2M7hqFISqrLh+jcIiZhl3JCK
         Zj7XgAtI0Y+xJLYBNyE+iL/y6IawSnMtNO51W0sN1xlrQEn0ETKPA7tOVpSdHqt+Br
         40O3fEirm1RbBHdg0DlCShR4doyuyHmRBJhO8zsyzUoUgwDmVt8RuwT8yNalsp/GNy
         7JDSs0iMWniB+Wc77SriStmmlsrXju0V6E1lSsssnKYl2eS/HJTHeQ1WWkWdxFBv/P
         sd0+atph50c2Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMn7tS1721121;
        Wed, 17 Jul 2019 15:49:07 -0700
Date:   Wed, 17 Jul 2019 15:49:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-muvqef2i7n6pzqbmu7tn2d2y@git.kernel.org>
Cc:     acme@redhat.com, ast@kernel.org, jolsa@kernel.org,
        daniel@iogearbox.net, adrian.hunter@intel.com, tglx@linutronix.de,
        namhyung@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net,
          jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Introduce rlimit__bump_memlock()
 helper
Git-Commit-ID: 4975223b8156c14f0537dcde1554f050fb4d29bf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4975223b8156c14f0537dcde1554f050fb4d29bf
Gitweb:     https://git.kernel.org/tip/4975223b8156c14f0537dcde1554f050fb4d29bf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 9 Jul 2019 14:49:26 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 14:59:11 -0300

perf tools: Introduce rlimit__bump_memlock() helper

Just like the BPF guys did when faced with failures with map creation,
etc, i.e. their solution is:

  tools/testing/selftests/bpf/bpf_rlimit.h

For perf use this function in 'perf test' and in 'perf trace'.

Make it bump to 4 times the current value, if it fails twice the current
value and if it still fails, warn that things like BPF map creation may
fail, to help in diagnosing the problem.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-muvqef2i7n6pzqbmu7tn2d2y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build    |  1 +
 tools/perf/util/rlimit.c | 29 +++++++++++++++++++++++++++++
 tools/perf/util/rlimit.h |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index d7e3b008a613..14f812bb07a7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -20,6 +20,7 @@ perf-y += parse-events.o
 perf-y += perf_regs.o
 perf-y += path.o
 perf-y += print_binary.o
+perf-y += rlimit.o
 perf-y += argv_split.o
 perf-y += rbtree.o
 perf-y += libstring.o
diff --git a/tools/perf/util/rlimit.c b/tools/perf/util/rlimit.c
new file mode 100644
index 000000000000..13521d392a22
--- /dev/null
+++ b/tools/perf/util/rlimit.c
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+
+#include "util/debug.h"
+#include "util/rlimit.h"
+#include <sys/time.h>
+#include <sys/resource.h>
+
+/*
+ * Bump the memlock so that we can get bpf maps of a reasonable size,
+ * like the ones used with 'perf trace' and with 'perf test bpf',
+ * improve this to some specific request if needed.
+ */
+void rlimit__bump_memlock(void)
+{
+	struct rlimit rlim;
+
+	if (getrlimit(RLIMIT_MEMLOCK, &rlim) == 0) {
+		rlim.rlim_cur *= 4;
+		rlim.rlim_max *= 4;
+
+		if (setrlimit(RLIMIT_MEMLOCK, &rlim) < 0) {
+			rlim.rlim_cur /= 2;
+			rlim.rlim_max /= 2;
+
+			if (setrlimit(RLIMIT_MEMLOCK, &rlim) < 0)
+				pr_debug("Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc\n");
+		}
+	}
+}
diff --git a/tools/perf/util/rlimit.h b/tools/perf/util/rlimit.h
new file mode 100644
index 000000000000..9f59d8e710a3
--- /dev/null
+++ b/tools/perf/util/rlimit.h
@@ -0,0 +1,6 @@
+#ifndef __PERF_RLIMIT_H_
+#define __PERF_RLIMIT_H_
+/* SPDX-License-Identifier: LGPL-2.1 */
+
+void rlimit__bump_memlock(void);
+#endif // __PERF_RLIMIT_H_
