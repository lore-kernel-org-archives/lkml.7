Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3E2C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3F1208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfFXJ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:56:20 -0400
Received: from foss.arm.com ([217.140.110.172]:44878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfFXJ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1816EC28;
        Mon, 24 Jun 2019 02:56:15 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9B163F71E;
        Mon, 24 Jun 2019 02:56:13 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC V3 03/18] objtool: Move registers and control flow to arch-dependent code
Date:   Mon, 24 Jun 2019 10:55:33 +0100
Message-Id: <20190624095548.8578-4-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624095548.8578-1-raphael.gault@arm.com>
References: <20190624095548.8578-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The control flow information and register macro definitions were based on
the x86_64 architecture but should be abstract so that each architecture
can define the correct values for the registers, especially the registers
related to the stack frame (Frame Pointer, Stack Pointer and possibly
Return Address).

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch/x86/include/arch_special.h | 36 +++++++++++++++++++
 tools/objtool/{ => arch/x86/include}/cfi.h    |  0
 tools/objtool/check.h                         |  1 +
 tools/objtool/special.c                       | 19 +---------
 4 files changed, 38 insertions(+), 18 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h
 rename tools/objtool/{ => arch/x86/include}/cfi.h (100%)

diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
new file mode 100644
index 000000000000..424ce47013e3
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -0,0 +1,36 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _X86_ARCH_SPECIAL_H
+#define _X86_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		13
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#define X86_FEATURE_POPCNT (4 * 32 + 23)
+#define X86_FEATURE_SMAP   (9 * 32 + 20)
+
+#endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/cfi.h b/tools/objtool/arch/x86/include/cfi.h
similarity index 100%
rename from tools/objtool/cfi.h
rename to tools/objtool/arch/x86/include/cfi.h
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index cb60b9acf5cf..c44f9fe40178 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -11,6 +11,7 @@
 #include "cfi.h"
 #include "arch.h"
 #include "orc.h"
+#include "arch_special.h"
 #include <linux/hashtable.h>
 
 struct insn_state {
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index fdbaa611146d..b8ccee1b5382 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -14,24 +14,7 @@
 #include "builtin.h"
 #include "special.h"
 #include "warn.h"
-
-#define EX_ENTRY_SIZE		12
-#define EX_ORIG_OFFSET		0
-#define EX_NEW_OFFSET		4
-
-#define JUMP_ENTRY_SIZE		16
-#define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		4
-
-#define ALT_ENTRY_SIZE		13
-#define ALT_ORIG_OFFSET		0
-#define ALT_NEW_OFFSET		4
-#define ALT_FEATURE_OFFSET	8
-#define ALT_ORIG_LEN_OFFSET	10
-#define ALT_NEW_LEN_OFFSET	11
-
-#define X86_FEATURE_POPCNT (4*32+23)
-#define X86_FEATURE_SMAP   (9*32+20)
+#include "arch_special.h"
 
 struct special_entry {
 	const char *sec;
-- 
2.17.1

