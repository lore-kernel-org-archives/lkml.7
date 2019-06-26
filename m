Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829E9C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F112086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFZGyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:54:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41934 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfFZGyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:54:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437235|-1;CH=green;DM=SPAM|CONTINUE|true|0.86325-0.00405368-0.132696;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.EqHrgI6_1561532027;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EqHrgI6_1561532027)
          by smtp.aliyun-inc.com(10.147.43.95);
          Wed, 26 Jun 2019 14:53:52 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] perf annotate csky: Add perf annotate support
Date:   Wed, 26 Jun 2019 14:52:19 +0800
Message-Id: <d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561531557.git.han_mao@c-sky.com>
References: <cover.1561531557.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add basic arch initialization and instruction associate support
for csky.

perf annotate --stdio2
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
Cc: Guo Ren <guoren@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/csky/annotate/instructions.c | 48 ++++++++++++++++++++++++++++
 tools/perf/util/annotate.c                   |  5 +++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/perf/arch/csky/annotate/instructions.c

diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/arch/csky/annotate/instructions.c
new file mode 100644
index 0000000..5337bfb
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
index 79db038..eb2456e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -144,6 +144,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/arc/annotate/instructions.c"
 #include "arch/arm/annotate/instructions.c"
 #include "arch/arm64/annotate/instructions.c"
+#include "arch/csky/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
 #include "arch/s390/annotate/instructions.c"
@@ -163,6 +164,10 @@ static struct arch architectures[] = {
 		.init = arm64__annotate_init,
 	},
 	{
+		.name = "csky",
+		.init = csky__annotate_init,
+	},
+	{
 		.name = "x86",
 		.init = x86__annotate_init,
 		.instructions = x86__instructions,
-- 
2.7.4

