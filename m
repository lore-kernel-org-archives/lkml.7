Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02BEC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE08C214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567775657;
	bh=YxdWojc5fQhCsI3MCFNUb/S38/XJllDgwfcUjCixi7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUb7mCTqNtIv/dyqtts/zJV2vIF0KnXkq9MlB/1QvIUL7F+Qbp2lv/ZTPUR4+70xk
	 lnTbCpp9lSwCsCKfnRSSRoiSisWjP+0+1TByQN0gLwXi6Ie5D+5XuaAhWHkfFgfuyI
	 zfJt8YL4u7VVEDaUOeJPZLi5TBaNmzG0R+fk41mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393051AbfIFNOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbfIFNOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:14:16 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A55A207FC;
        Fri,  6 Sep 2019 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567775655;
        bh=YxdWojc5fQhCsI3MCFNUb/S38/XJllDgwfcUjCixi7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkKh5q5Aus2YgqR1dKqCz2etHrZWowX7W3djWGR1gL3U8RvdvMP18XVzrLm0PVhvq
         //NYVg8iMWghQpO3BWms/dSwsIM70WgaKZlAfM2MP0Ky5XqqK7Fgu+pZ8LCj27jCCE
         +I0vJVlcHcRe7KlsdYNQ1IBm+oyj6BNlkGQaS2bI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH -tip v4 3/4] x86: xen: insn: Decode Xen and KVM emulate-prefix signature
Date:   Fri,  6 Sep 2019 22:14:10 +0900
Message-Id: <156777564986.25081.4964537658500952557.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156777561745.25081.1205321122446165328.stgit@devnote2>
References: <156777561745.25081.1205321122446165328.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode Xen and KVM's emulate-prefix signature by x86 insn decoder.
It is called "prefix" but actually not x86 instruction prefix, so
this adds insn.emulate_prefix_size field instead of reusing
insn.prefixes.

If x86 decoder finds a special sequence of instructions of
XEN_EMULATE_PREFIX and 'ud2a; .ascii "kvm"', it just counts the
length, set insn.emulate_prefix_size and fold it with the next
instruction. In other words, the signature and the next instruction
is treated as a single instruction.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Changes in v4:
  - Use asm/emulate_prefix.h instead of xen/prefix.h
  - Fix to add emulate_prefix.h to the checkist of perf.
---
 arch/x86/include/asm/insn.h                 |    6 +++++
 arch/x86/lib/insn.c                         |   34 +++++++++++++++++++++++++++
 tools/arch/x86/include/asm/emulate_prefix.h |   14 +++++++++++
 tools/arch/x86/include/asm/insn.h           |    6 +++++
 tools/arch/x86/lib/insn.c                   |   34 +++++++++++++++++++++++++++
 tools/objtool/sync-check.sh                 |    3 ++
 tools/perf/check-headers.sh                 |    3 ++
 7 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/emulate_prefix.h

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 154f27be8bfc..5c1ae3eff9d4 100644
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
index 0b5862ba6a75..404279563891 100644
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
index 000000000000..70f5b98a5286
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
index 37a4c390750b..568854b14d0a 100644
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
index 79e048f1d902..0151dfc6da61 100644
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
index 0a832e265a50..9bd04bbed01e 100755
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
index e2e0f06c97d0..988b1879ec98 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -27,6 +27,7 @@ arch/x86/include/asm/disabled-features.h
 arch/x86/include/asm/required-features.h
 arch/x86/include/asm/cpufeatures.h
 arch/x86/include/asm/inat_types.h
+arch/x86/include/asm/emulate_prefix.h
 arch/x86/include/uapi/asm/prctl.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
@@ -115,7 +116,7 @@ check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B
 check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c	      '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c	      '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
+check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl

