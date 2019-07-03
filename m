Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F6AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8509F21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mGIZ32Xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGCObM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:31:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:31:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EUhnG3327371
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:30:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EUhnG3327371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164244;
        bh=81ITF5dckdrW/ARPcWsImVFzm1NqFtIWApIUoUxVpUs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mGIZ32XkE3n1k2Vblbl18TbjfidYpqZah0gs5OuVj4GB9jbq1U8PrgRH92Mt53vHK
         T+wGRb83tld31qt7Ci88Pood44Q3sCQeqtZUF0dCvVNF4AhpIuH1EJFbnYNmsR21uR
         rkYAD0wL1PgEj5uq3HQFj3323KsVtiRVbDbIbs4yoLiNV62DaFTyPRANVub1lJ3hXK
         8nV2N6MDmQelaeDOmZOstyaGEjulSa+fj8dPI0R7d4h26g6Yg7uD+ZrFb/vi2DI0hI
         U5oYEM9bTtj3ZU/qitf0wU8Z7Y5W2ccac/wq+O0au5vrJesBOaGn0gKMaIB/OsDPNv
         TkPWtVo60S2dA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EUgfn3327365;
        Wed, 3 Jul 2019 07:30:42 -0700
Date:   Wed, 3 Jul 2019 07:30:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mao Han <tipbot@zytor.com>
Message-ID: <tip-aa23aa55166c2865ac430168c4b9d405cf8c6980@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, guoren@kernel.org, hpa@zytor.com,
        han_mao@c-sky.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          han_mao@c-sky.com, namhyung@kernel.org, guoren@kernel.org,
          acme@redhat.com, jolsa@redhat.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com>
References: <d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Add csky support
Git-Commit-ID: aa23aa55166c2865ac430168c4b9d405cf8c6980
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

Commit-ID:  aa23aa55166c2865ac430168c4b9d405cf8c6980
Gitweb:     https://git.kernel.org/tip/aa23aa55166c2865ac430168c4b9d405cf8c6980
Author:     Mao Han <han_mao@c-sky.com>
AuthorDate: Wed, 26 Jun 2019 14:52:19 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Jul 2019 22:50:41 -0300

perf annotate: Add csky support

This patch add basic arch initialization and instruction associate
support for the csky CPU architecture.

E.g.:

  $ perf annotate --stdio2
  Samples: 161  of event 'cpu-clock:pppH', 4000 Hz, Event count (approx.):
  40250000, [percent: local period]
  test_4() /usr/lib/perf-test/callchain_test
  Percent

              Disassembly of section .text:

              00008420 <test_4>:
            test_4():
                subi  sp, sp, 4
                st.w  r8, (sp, 0x0)
                mov   r8, sp
                subi  sp, sp, 8
                subi  r3, r8, 4
                movi  r2, 0
                st.w  r2, (r3, 0x0)
              ↓ br    2e
  100.00  14:   subi  r3, r8, 4
                ld.w  r2, (r3, 0x0)
                subi  r3, r8, 8
                st.w  r2, (r3, 0x0)
                subi  r3, r8, 4
                ld.w  r3, (r3, 0x0)
                addi  r2, r3, 1
                subi  r3, r8, 4
                st.w  r2, (r3, 0x0)
          2e:   subi  r3, r8, 4
                ld.w  r2, (r3, 0x0)
                lrw   r3, 0x98967f    // 8598 <main+0x28>
                cmplt r3, r2
              ↑ bf    14
                mov   r0, r0
                mov   r0, r0
                mov   sp, r8
                ld.w  r8, (sp, 0x0)
                addi  sp, sp, 4
              ← rts

Signed-off-by: Mao Han <han_mao@c-sky.com>
Acked-by: Guo Ren <guoren@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-csky@vger.kernel.org
Link: http://lkml.kernel.org/r/d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/csky/annotate/instructions.c | 48 ++++++++++++++++++++++++++++
 tools/perf/util/annotate.c                   |  5 +++
 2 files changed, 53 insertions(+)

diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/arch/csky/annotate/instructions.c
new file mode 100644
index 000000000000..5337bfb7d5fc
--- /dev/null
+++ b/tools/perf/arch/csky/annotate/instructions.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/compiler.h>
+
+static struct ins_ops *csky__associate_ins_ops(struct arch *arch,
+					       const char *name)
+{
+	struct ins_ops *ops = NULL;
+
+	/* catch all kind of jumps */
+	if (!strcmp(name, "bt") ||
+	    !strcmp(name, "bf") ||
+	    !strcmp(name, "bez") ||
+	    !strcmp(name, "bnez") ||
+	    !strcmp(name, "bnezad") ||
+	    !strcmp(name, "bhsz") ||
+	    !strcmp(name, "bhz") ||
+	    !strcmp(name, "blsz") ||
+	    !strcmp(name, "blz") ||
+	    !strcmp(name, "br") ||
+	    !strcmp(name, "jmpi") ||
+	    !strcmp(name, "jmp"))
+		ops = &jump_ops;
+
+	/* catch function call */
+	if (!strcmp(name, "bsr") ||
+	    !strcmp(name, "jsri") ||
+	    !strcmp(name, "jsr"))
+		ops = &call_ops;
+
+	/* catch function return */
+	if (!strcmp(name, "rts"))
+		ops = &ret_ops;
+
+	if (ops)
+		arch__associate_ins_ops(arch, name, ops);
+	return ops;
+}
+
+static int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	arch->initialized = true;
+	arch->objdump.comment_char = '/';
+	arch->associate_instruction_ops = csky__associate_ins_ops;
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2d08c4b62c63..ec7aaf31c2b2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -145,6 +145,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/arc/annotate/instructions.c"
 #include "arch/arm/annotate/instructions.c"
 #include "arch/arm64/annotate/instructions.c"
+#include "arch/csky/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
 #include "arch/s390/annotate/instructions.c"
@@ -163,6 +164,10 @@ static struct arch architectures[] = {
 		.name = "arm64",
 		.init = arm64__annotate_init,
 	},
+	{
+		.name = "csky",
+		.init = csky__annotate_init,
+	},
 	{
 		.name = "x86",
 		.init = x86__annotate_init,
