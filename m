Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D2622DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567597567;
	bh=i9BrEoVqV9CTOcIwZGpJ4tmN6Njby5luY7L+lyftqxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=09cYdkHyGO7gUKusBRTiOM4azaUna81d47ioP5O2P74jbiD/vKPi6sVTmzTh5MuaS
	 HmujZDdL1yJETzr2AbNZgKIVycOfBoM9mTKSwskN9+cL9rja+cgO7q3ou8gyvzvwz7
	 LBcNGh4x3CnxserbzylexFLMNJA9Ez+5G3au4p7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfIDLqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfIDLqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:46:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86AAF20820;
        Wed,  4 Sep 2019 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567597564;
        bh=i9BrEoVqV9CTOcIwZGpJ4tmN6Njby5luY7L+lyftqxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBxx4VXIJQ8pDwWp2+Udn2j49bsUCyS4O02V6SjiW4Yk/KDhiXpn2E/mOrswU5FJr
         MGUjnHZ9B8SX/AE9kwl829Wwx3MvGlCXfcK/lO53StjvVgULFkFM/+yBzCjfDM+hyQ
         de4+kszuD2OFpbiVqDtSKrMwlHGjsD5kcfeUZBag=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH -tip 1/2] x86: xen: insn: Decode XEN_EMULATE_PREFIX correctly
Date:   Wed,  4 Sep 2019 20:45:59 +0900
Message-Id: <156759755900.24473.5182879905681416105.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156759754770.24473.11832897710080799131.stgit@devnote2>
References: <156759754770.24473.11832897710080799131.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode XEN_EMULATE_PREFIX prefix by x86 insn decoder.
This treats a special sequence of instructions of XEN_EMULATE_PREFIX
as a prefix bytes in x86 insn decoder. User can test whether the
instruction has the XEN_EMULATE_PREFIX or not by insn_is_xen_prefixed().
Note that this prefix is treated as just a dummy prefix, so no affect
for decoding opcode and operand.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/insn.h             |    2 +
 arch/x86/include/asm/xen/interface.h    |    7 ++++-
 arch/x86/include/asm/xen/prefix.h       |   10 +++++++
 arch/x86/lib/insn.c                     |   43 +++++++++++++++++++++++++++++++
 tools/arch/x86/include/asm/insn.h       |    2 +
 tools/arch/x86/include/asm/xen/prefix.h |   10 +++++++
 tools/arch/x86/lib/insn.c               |   43 +++++++++++++++++++++++++++++++
 tools/objtool/sync-check.sh             |    3 +-
 8 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/xen/prefix.h
 create mode 100644 tools/arch/x86/include/asm/xen/prefix.h

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 154f27be8bfc..ac42efd4295a 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -128,6 +128,8 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+extern int insn_has_xen_prefix(struct insn *insn);
+
 /* Ensure this instruction is decoded completely */
 static inline int insn_complete(struct insn *insn)
 {
diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
index 62ca03ef5c65..fe33a9798708 100644
--- a/arch/x86/include/asm/xen/interface.h
+++ b/arch/x86/include/asm/xen/interface.h
@@ -379,12 +379,15 @@ struct xen_pmu_arch {
  * Prefix forces emulation of some non-trapping instructions.
  * Currently only CPUID.
  */
+#include <asm/xen/prefix.h>
+
 #ifdef __ASSEMBLY__
-#define XEN_EMULATE_PREFIX .byte 0x0f,0x0b,0x78,0x65,0x6e ;
+#define XEN_EMULATE_PREFIX .byte __XEN_EMULATE_PREFIX ;
 #define XEN_CPUID          XEN_EMULATE_PREFIX cpuid
 #else
-#define XEN_EMULATE_PREFIX ".byte 0x0f,0x0b,0x78,0x65,0x6e ; "
+#define XEN_EMULATE_PREFIX ".byte " __XEN_EMULATE_PREFIX_STR " ; "
 #define XEN_CPUID          XEN_EMULATE_PREFIX "cpuid"
+
 #endif
 
 #endif /* _ASM_X86_XEN_INTERFACE_H */
diff --git a/arch/x86/include/asm/xen/prefix.h b/arch/x86/include/asm/xen/prefix.h
new file mode 100644
index 000000000000..f901be0d7a95
--- /dev/null
+++ b/arch/x86/include/asm/xen/prefix.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_X86_XEN_PREFIX_H
+#define _TOOLS_ASM_X86_XEN_PREFIX_H
+
+#include <linux/stringify.h>
+
+#define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e
+#define __XEN_EMULATE_PREFIX_STR  __stringify(__XEN_EMULATE_PREFIX)
+
+#endif
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 0b5862ba6a75..310a609ee382 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -13,6 +13,9 @@
 #include <asm/inat.h>
 #include <asm/insn.h>
 
+/* For special Xen prefix */
+#include <asm/xen/prefix.h>
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
@@ -58,6 +61,42 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 		insn->addr_bytes = 4;
 }
 
+static const insn_byte_t xen_prefix[] = { __XEN_EMULATE_PREFIX };
+
+static int insn_xen_prefix(struct insn *insn, insn_byte_t b)
+{
+	struct insn_field *prefixes = &insn->prefixes;
+	size_t i;
+
+	for (i = 0; i < sizeof(xen_prefix); i++) {
+		b = peek_nbyte_next(insn_byte_t, insn, i);
+		if (b != xen_prefix[i])
+			goto err_out;
+	}
+
+	memcpy(prefixes->bytes, xen_prefix, 3);
+	prefixes->bytes[3] = xen_prefix[sizeof(xen_prefix) - 1];
+	prefixes->nbytes = sizeof(xen_prefix);
+	insn->next_byte += prefixes->nbytes;
+	prefixes->got = 1;
+
+	return 1;
+
+err_out:
+	return 0;
+}
+
+int insn_has_xen_prefix(struct insn *insn)
+{
+	if (unlikely(insn->prefixes.nbytes == sizeof(xen_prefix))) {
+		return !memcmp(insn->prefixes.bytes, xen_prefix, 3) &&
+			insn->prefixes.bytes[3] ==
+				xen_prefix[sizeof(xen_prefix) - 1];
+	}
+
+	return 0;
+}
+
 /**
  * insn_get_prefixes - scan x86 instruction prefix bytes
  * @insn:	&struct insn containing instruction
@@ -79,6 +118,10 @@ void insn_get_prefixes(struct insn *insn)
 	nb = 0;
 	lb = 0;
 	b = peek_next(insn_byte_t, insn);
+
+	if (insn_xen_prefix(insn, b))
+		return;
+
 	attr = inat_get_opcode_attribute(b);
 	while (inat_is_legacy_prefix(attr)) {
 		/* Skip if same prefix */
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 37a4c390750b..1c723fb5c6ee 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -128,6 +128,8 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+extern int insn_has_xen_prefix(struct insn *insn);
+
 /* Ensure this instruction is decoded completely */
 static inline int insn_complete(struct insn *insn)
 {
diff --git a/tools/arch/x86/include/asm/xen/prefix.h b/tools/arch/x86/include/asm/xen/prefix.h
new file mode 100644
index 000000000000..f901be0d7a95
--- /dev/null
+++ b/tools/arch/x86/include/asm/xen/prefix.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_X86_XEN_PREFIX_H
+#define _TOOLS_ASM_X86_XEN_PREFIX_H
+
+#include <linux/stringify.h>
+
+#define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e
+#define __XEN_EMULATE_PREFIX_STR  __stringify(__XEN_EMULATE_PREFIX)
+
+#endif
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 79e048f1d902..b34cd1cefb1c 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -13,6 +13,9 @@
 #include "../include/asm/inat.h"
 #include "../include/asm/insn.h"
 
+/* For special Xen prefix */
+#include "../include/asm/xen/prefix.h"
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
@@ -58,6 +61,42 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 		insn->addr_bytes = 4;
 }
 
+static const insn_byte_t xen_prefix[] = { __XEN_EMULATE_PREFIX };
+
+static int insn_xen_prefix(struct insn *insn, insn_byte_t b)
+{
+	struct insn_field *prefixes = &insn->prefixes;
+	size_t i;
+
+	for (i = 0; i < sizeof(xen_prefix); i++) {
+		b = peek_nbyte_next(insn_byte_t, insn, i);
+		if (b != xen_prefix[i])
+			goto err_out;
+	}
+
+	memcpy(prefixes->bytes, xen_prefix, 3);
+	prefixes->bytes[3] = xen_prefix[sizeof(xen_prefix) - 1];
+	prefixes->nbytes = sizeof(xen_prefix);
+	insn->next_byte += prefixes->nbytes;
+	prefixes->got = 1;
+
+	return 1;
+
+err_out:
+	return 0;
+}
+
+int insn_has_xen_prefix(struct insn *insn)
+{
+	if (unlikely(insn->prefixes.nbytes == sizeof(xen_prefix))) {
+		return !memcmp(insn->prefixes.bytes, xen_prefix, 3) &&
+			insn->prefixes.bytes[3] ==
+				xen_prefix[sizeof(xen_prefix) - 1];
+	}
+
+	return 0;
+}
+
 /**
  * insn_get_prefixes - scan x86 instruction prefix bytes
  * @insn:	&struct insn containing instruction
@@ -79,6 +118,10 @@ void insn_get_prefixes(struct insn *insn)
 	nb = 0;
 	lb = 0;
 	b = peek_next(insn_byte_t, insn);
+
+	if (insn_xen_prefix(insn, b))
+		return;
+
 	attr = inat_get_opcode_attribute(b);
 	while (inat_is_legacy_prefix(attr)) {
 		/* Skip if same prefix */
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 0a832e265a50..34143ea3d477 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -4,6 +4,7 @@
 FILES='
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
+arch/x86/include/asm/xen/prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 '
@@ -46,6 +47,6 @@ done
 check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
+check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/xen/prefix.h[\">]"'
 
 cd -

