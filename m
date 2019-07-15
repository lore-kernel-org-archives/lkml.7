Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7189C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05572173C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225143;
	bh=te6zX5EdTK+XU4jm14IyahV8zEsrziV9fd/Jvoa+n08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WFkd50kXAJrN6lbg/S7BNKm5MEFTqCX9q1ZUFjVQvvMuOS/hwJII7oWsfR+bckR7S
	 TAfuTUGNxHs96UaoweuavJqxUvf9Atg1MFxfGWcQPlnd4K9DaEKGVUeaDGCczJQQPe
	 su/gEQ1HWT05IOmBwwo5F69IygGxJeA8duH8bQTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfGOVMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730409AbfGOVMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:12:21 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5AD621738;
        Mon, 15 Jul 2019 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225140;
        bh=te6zX5EdTK+XU4jm14IyahV8zEsrziV9fd/Jvoa+n08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kscMI0qSHPH6kLJqcFa34NyEv93mbYD4yldaGsdgcg9BkcxIS3ilpapbstATV5lBC
         URi6uL6IkPdun+P5FMQieDAz/4K6rbB2JLNGeajz6aD8oesy6OmrpdTg4pSn7mq4UG
         B3qZrNI+gZTc9EJCpfyBaW1hJP+rV9GY5bd8FxIY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 01/28] perf tools: Introduce rlimit__bump_memlock() helper
Date:   Mon, 15 Jul 2019 18:11:33 -0300
Message-Id: <20190715211200.10984-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 create mode 100644 tools/perf/util/rlimit.c
 create mode 100644 tools/perf/util/rlimit.h

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
-- 
2.21.0

