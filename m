Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F85ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EC221835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634021AbfJRMst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:48:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56814 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633997AbfJRMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:48:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLRg3-00078L-5U; Fri, 18 Oct 2019 14:48:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AADD51C03AB;
        Fri, 18 Oct 2019 14:48:18 +0200 (CEST)
Date:   Fri, 18 Oct 2019 12:48:18 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: xen: insn: Decode Xen and KVM emulate-prefix signature
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@alien8.de>, xen-devel@lists.xenproject.org,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <156777564986.25081.4964537658500952557.stgit@devnote2>
References: <156777564986.25081.4964537658500952557.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157140289854.29376.4430795054323201093.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4d65adfcd1196818659d3bd9b42dccab291e1751
Gitweb:        https://git.kernel.org/tip/4d65adfcd1196818659d3bd9b42dccab291e1751
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Fri, 06 Sep 2019 22:14:10 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Oct 2019 21:31:57 +02:00

x86: xen: insn: Decode Xen and KVM emulate-prefix signature

Decode Xen and KVM's emulate-prefix signature by x86 insn decoder.
It is called "prefix" but actually not x86 instruction prefix, so
this adds insn.emulate_prefix_size field instead of reusing
insn.prefixes.

If x86 decoder finds a special sequence of instructions of
XEN_EMULATE_PREFIX and 'ud2a; .ascii "kvm"', it just counts the
length, set insn.emulate_prefix_size and fold it with the next
instruction. In other words, the signature and the next instruction
is treated as a single instruction.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Link: https://lkml.kernel.org/r/156777564986.25081.4964537658500952557.stgit@devnote2
---
 arch/x86/include/asm/insn.h                 |  6 ++++-
 arch/x86/lib/insn.c                         | 34 ++++++++++++++++++++-
 tools/arch/x86/include/asm/emulate_prefix.h | 14 ++++++++-
 tools/arch/x86/include/asm/insn.h           |  6 ++++-
 tools/arch/x86/lib/insn.c                   | 34 ++++++++++++++++++++-
 tools/objtool/sync-check.sh                 |  3 +-
 tools/perf/check-headers.sh                 |  3 +-
 7 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/emulate_prefix.h

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 154f27b..5c1ae3e 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -45,6 +45,7 @@ struct insn {
 		struct insn_field immediate2;	/* for 64bit imm or seg16 */
 	};
 
+	int	emulate_prefix_size;
 	insn_attr_t attr;
 	unsigned char opnd_bytes;
 	unsigned char addr_bytes;
@@ -128,6 +129,11 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+static inline int insn_has_emulate_prefix(struct insn *insn)
+{
+	return !!insn->emulate_prefix_size;
+}
+
 /* Ensure this instruction is decoded completely */
 static inline int insn_complete(struct insn *insn)
 {
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 0b5862b..4042795 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -13,6 +13,8 @@
 #include <asm/inat.h>
 #include <asm/insn.h>
 
+#include <asm/emulate_prefix.h>
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
@@ -58,6 +60,36 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 		insn->addr_bytes = 4;
 }
 
+static const insn_byte_t xen_prefix[] = { __XEN_EMULATE_PREFIX };
+static const insn_byte_t kvm_prefix[] = { __KVM_EMULATE_PREFIX };
+
+static int __insn_get_emulate_prefix(struct insn *insn,
+				     const insn_byte_t *prefix, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (peek_nbyte_next(insn_byte_t, insn, i) != prefix[i])
+			goto err_out;
+	}
+
+	insn->emulate_prefix_size = len;
+	insn->next_byte += len;
+
+	return 1;
+
+err_out:
+	return 0;
+}
+
+static void insn_get_emulate_prefix(struct insn *insn)
+{
+	if (__insn_get_emulate_prefix(insn, xen_prefix, sizeof(xen_prefix)))
+		return;
+
+	__insn_get_emulate_prefix(insn, kvm_prefix, sizeof(kvm_prefix));
+}
+
 /**
  * insn_get_prefixes - scan x86 instruction prefix bytes
  * @insn:	&struct insn containing instruction
@@ -76,6 +108,8 @@ void insn_get_prefixes(struct insn *insn)
 	if (prefixes->got)
 		return;
 
+	insn_get_emulate_prefix(insn);
+
 	nb = 0;
 	lb = 0;
 	b = peek_next(insn_byte_t, insn);
diff --git a/tools/arch/x86/include/asm/emulate_prefix.h b/tools/arch/x86/include/asm/emulate_prefix.h
new file mode 100644
index 0000000..70f5b98
--- /dev/null
+++ b/tools/arch/x86/include/asm/emulate_prefix.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_EMULATE_PREFIX_H
+#define _ASM_X86_EMULATE_PREFIX_H
+
+/*
+ * Virt escape sequences to trigger instruction emulation;
+ * ideally these would decode to 'whole' instruction and not destroy
+ * the instruction stream; sadly this is not true for the 'kvm' one :/
+ */
+
+#define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e  /* ud2 ; .ascii "xen" */
+#define __KVM_EMULATE_PREFIX  0x0f,0x0b,0x6b,0x76,0x6d	/* ud2 ; .ascii "kvm" */
+
+#endif
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 37a4c39..568854b 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -45,6 +45,7 @@ struct insn {
 		struct insn_field immediate2;	/* for 64bit imm or seg16 */
 	};
 
+	int	emulate_prefix_size;
 	insn_attr_t attr;
 	unsigned char opnd_bytes;
 	unsigned char addr_bytes;
@@ -128,6 +129,11 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+static inline int insn_has_emulate_prefix(struct insn *insn)
+{
+	return !!insn->emulate_prefix_size;
+}
+
 /* Ensure this instruction is decoded completely */
 static inline int insn_complete(struct insn *insn)
 {
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 79e048f..0151dfc 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -13,6 +13,8 @@
 #include "../include/asm/inat.h"
 #include "../include/asm/insn.h"
 
+#include "../include/asm/emulate_prefix.h"
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
@@ -58,6 +60,36 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 		insn->addr_bytes = 4;
 }
 
+static const insn_byte_t xen_prefix[] = { __XEN_EMULATE_PREFIX };
+static const insn_byte_t kvm_prefix[] = { __KVM_EMULATE_PREFIX };
+
+static int __insn_get_emulate_prefix(struct insn *insn,
+				     const insn_byte_t *prefix, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (peek_nbyte_next(insn_byte_t, insn, i) != prefix[i])
+			goto err_out;
+	}
+
+	insn->emulate_prefix_size = len;
+	insn->next_byte += len;
+
+	return 1;
+
+err_out:
+	return 0;
+}
+
+static void insn_get_emulate_prefix(struct insn *insn)
+{
+	if (__insn_get_emulate_prefix(insn, xen_prefix, sizeof(xen_prefix)))
+		return;
+
+	__insn_get_emulate_prefix(insn, kvm_prefix, sizeof(kvm_prefix));
+}
+
 /**
  * insn_get_prefixes - scan x86 instruction prefix bytes
  * @insn:	&struct insn containing instruction
@@ -76,6 +108,8 @@ void insn_get_prefixes(struct insn *insn)
 	if (prefixes->got)
 		return;
 
+	insn_get_emulate_prefix(insn);
+
 	nb = 0;
 	lb = 0;
 	b = peek_next(insn_byte_t, insn);
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 0a832e2..9bd04bb 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -4,6 +4,7 @@
 FILES='
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
+arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 '
@@ -46,6 +47,6 @@ done
 check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
+check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
 
 cd -
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index cea13cb..499235a 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -28,6 +28,7 @@ arch/x86/include/asm/disabled-features.h
 arch/x86/include/asm/required-features.h
 arch/x86/include/asm/cpufeatures.h
 arch/x86/include/asm/inat_types.h
+arch/x86/include/asm/emulate_prefix.h
 arch/x86/include/uapi/asm/prctl.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
@@ -116,7 +117,7 @@ check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B
 check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c	      '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c	      '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
+check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
