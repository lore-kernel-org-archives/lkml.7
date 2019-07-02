Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ECAC0650E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D13206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034528;
	bh=fUxD0Jat8tuNrd30NBRuSl6fEb+qL0jvXcSgqFn/1aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mrB3juHI27r45ffYgksTDRb7MMyJQsmuB60rguqupHSkey8Szefaqd0E7ErUC2vdo
	 fZocPnbq01vzXVD6RfN1NakhFRmQqcFDDdAHAVx3VuJiCqhyGWA9KZ+F8XX31kH50f
	 yd0FqCoKl07xzGB1SJ+tXbRfCRi7/90Fcm4EN5jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGBC2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbfGBC2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AEC321851;
        Tue,  2 Jul 2019 02:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034522;
        bh=fUxD0Jat8tuNrd30NBRuSl6fEb+qL0jvXcSgqFn/1aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXeQLQI1bKE9rqAra0tZaP4EhA+BzO0tmBI5YvHehvKQrbqHRQTJ2EX9Q/Z9lR9o8
         qbnMAVJUTtVKaG7x5Z14iFpG0j7oH/Aigc4MT5dIM3PnFWrx76Je9cTXtGMmYy32d9
         vHjPv+HNmp5S21Ctl1hovujMh+itWIyAGKvrl9zw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-csky@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 42/43] perf annotate: Add csky support
Date:   Mon,  1 Jul 2019 23:26:15 -0300
Message-Id: <20190702022616.1259-43-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

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
 tools/perf/arch/csky/annotate/instructions.c | 48 ++++++++++++++++++++
 tools/perf/util/annotate.c                   |  5 ++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/perf/arch/csky/annotate/instructions.c

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
-- 
2.20.1

