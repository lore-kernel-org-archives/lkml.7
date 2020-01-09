Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87712C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D012073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRMp1G0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgAIQFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732960AbgAIQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paPYD98fP2vtMtxm6JwVilmzUTcQhBJ0i4er0etHTlI=;
        b=hRMp1G0qDTfHiISHT4xUrlDTFdw/yf5Td5qSnzOy+DvGrLmjBlBc2nZ2+cqPUZflDJqGb8
        20MDEhXNYky+VAuNqUx9Zqg7p16czFQn0wct20HejgWTkbp22w4pB5T2byQ9j+q8DQimuj
        XGnlZy35ey0X8X89JQu3peGoipyeUP4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-j35AYU3iM-K1QviVYotSxA-1; Thu, 09 Jan 2020 11:05:12 -0500
X-MC-Unique: j35AYU3iM-K1QviVYotSxA-1
Received: by mail-wr1-f72.google.com with SMTP id j13so3034737wrr.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paPYD98fP2vtMtxm6JwVilmzUTcQhBJ0i4er0etHTlI=;
        b=bn/0Q/ZrklBdAdQoUu3B4aNj+Y2yYq2afBiM2AsvpEHdQtZ95JBppOcqDRtQXYjp/e
         mACyalKOBhxe28rxbkHs64y568BLF3eYjldPkXeZR6b8o2NZpqaPb96Z285L6ueVi2Bb
         ezM/qiCd7Q8hk18OdchO2+dfHyn0pUPnoYwJxsnvg02XgKkVVOT5T6Ev7mGjO/flCoaY
         TmFsftl/K4HFF+QWmk1Bkm4iCgLRI/EhS/7kqMxzhRxdM4ZFHXcJQtJr6TaZHLYf9gYF
         WKfsaq4JR73HW5r4TnnycXL81ha6DufLcMPSTC4kil95oxrHGP1uGlOkMFV3ASx3rGHx
         c4Cg==
X-Gm-Message-State: APjAAAWKSXDu3ShigeG5pyrS0Qx7PKfQHCEFLcXOARgqHXcwv5VhwlKE
        J99kPBKMx2jqkt+INgFyGvO4rqw5fhjwwiPuuLgbPSV8wnhrm/A4kkuCQ+/F9D5uuulKUcw96YK
        bFhqMZBJrMgaSqNvrDyG8cNSg
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr11107409wrk.53.1578585911063;
        Thu, 09 Jan 2020 08:05:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGtV8Ry02kUzdgkMc5mjIbvbd8qI1FNNyDK/gxNDOK9K/FQSxV7d/la71ePxNsc07Fc7+xbg==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr11107372wrk.53.1578585910720;
        Thu, 09 Jan 2020 08:05:10 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id d16sm9285303wrg.27.2020.01.09.08.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:09 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 19/57] objtool: arm64: Add required implementation for supporting the aarch64 architecture in objtool.
Date:   Thu,  9 Jan 2020 16:02:22 +0000
Message-Id: <20200109160300.26150-20-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Provide implementation for the arch-dependent functions that are called by
the main check function of objtool.

Provide an empty squeleton for the aarch64 decoder that shall be
completed in later patches.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T.: Use enum for instruction type,
       Remove orc functions,
       Remove x86 feature macros from arm64 header,
       Split decoder over multiple patches,
       Use SPDX identifiers]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/Build                |   5 +
 tools/objtool/arch/arm64/arch_special.c       |  15 +++
 tools/objtool/arch/arm64/bit_operations.c     |  69 ++++++++++
 tools/objtool/arch/arm64/decode.c             | 127 ++++++++++++++++++
 .../objtool/arch/arm64/include/arch_special.h |  21 +++
 .../arch/arm64/include/bit_operations.h       |  31 +++++
 tools/objtool/arch/arm64/include/cfi_regs.h   |  44 ++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  15 +++
 8 files changed, 327 insertions(+)
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/arch_special.c
 create mode 100644 tools/objtool/arch/arm64/bit_operations.c
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch_special.h
 create mode 100644 tools/objtool/arch/arm64/include/bit_operations.h
 create mode 100644 tools/objtool/arch/arm64/include/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/insn_decode.h

diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Build
new file mode 100644
index 000000000000..2a554af43e96
--- /dev/null
+++ b/tools/objtool/arch/arm64/Build
@@ -0,0 +1,5 @@
+objtool-y += arch_special.o
+objtool-y += bit_operations.o
+objtool-y += decode.o
+
+CFLAGS_decode.o += -I$(OUTPUT)arch/arm64/lib
diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
new file mode 100644
index 000000000000..5239489c9c57
--- /dev/null
+++ b/tools/objtool/arch/arm64/arch_special.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "../../special.h"
+
+int arch_add_jump_table_dests(struct objtool_file *file,
+			      struct instruction *insn)
+{
+	return 0;
+}
+
+struct rela *arch_find_switch_table(struct objtool_file *file,
+				    struct instruction *insn)
+{
+	return NULL;
+}
diff --git a/tools/objtool/arch/arm64/bit_operations.c b/tools/objtool/arch/arm64/bit_operations.c
new file mode 100644
index 000000000000..cd44138956bb
--- /dev/null
+++ b/tools/objtool/arch/arm64/bit_operations.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdio.h>
+#include <stdlib.h>
+#include "bit_operations.h"
+
+#include "../../warn.h"
+
+u64 replicate(u64 x, int size, int n)
+{
+	u64 ret = 0;
+
+	while (n >= 0) {
+		ret = (ret | x) << size;
+		n--;
+	}
+	return ret | x;
+}
+
+u64 ror(u64 x, int size, int shift)
+{
+	int m = shift % size;
+
+	if (shift == 0)
+		return x;
+	return ZERO_EXTEND((x >> m) | (x << (size - m)), size);
+}
+
+int highest_set_bit(u32 x)
+{
+	int i;
+
+	for (i = 31; i >= 0; i--, x <<= 1)
+		if (x & 0x80000000)
+			return i;
+	return 0;
+}
+
+/* imms and immr are both 6 bit long */
+__uint128_t decode_bit_masks(unsigned char N, unsigned char imms,
+			     unsigned char immr, bool immediate)
+{
+	u64 tmask, wmask;
+	u32 diff, S, R, esize, welem, telem;
+	unsigned char levels = 0, len = 0;
+
+	len = highest_set_bit((N << 6) | ((~imms) & ONES(6)));
+	levels = ZERO_EXTEND(ONES(len), 6);
+
+	if (immediate && ((imms & levels) == levels)) {
+		WARN("unknown instruction");
+		return -1;
+	}
+
+	S = imms & levels;
+	R = immr & levels;
+	diff = ZERO_EXTEND(S - R, 6);
+
+	esize = 1 << len;
+	diff = diff & ONES(len);
+
+	welem = ZERO_EXTEND(ONES(S + 1), esize);
+	telem = ZERO_EXTEND(ONES(diff + 1), esize);
+
+	wmask = replicate(ror(welem, esize, R), esize, 64 / esize);
+	tmask = replicate(telem, esize, 64 / esize);
+
+	return ((__uint128_t)wmask << 64) | tmask;
+}
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
new file mode 100644
index 000000000000..4d0ab2acca27
--- /dev/null
+++ b/tools/objtool/arch/arm64/decode.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+
+#include "insn_decode.h"
+#include "cfi_regs.h"
+#include "bit_operations.h"
+
+#include "../../check.h"
+#include "../../arch.h"
+#include "../../elf.h"
+#include "../../warn.h"
+
+bool arch_callee_saved_reg(unsigned char reg)
+{
+	switch (reg) {
+	case CFI_R19:
+	case CFI_R20:
+	case CFI_R21:
+	case CFI_R22:
+	case CFI_R23:
+	case CFI_R24:
+	case CFI_R25:
+	case CFI_R26:
+	case CFI_R27:
+	case CFI_R28:
+	case CFI_FP:
+	case CFI_R30:
+		return true;
+	default:
+		return false;
+	}
+}
+
+void arch_initial_func_cfi_state(struct cfi_state *state)
+{
+	int i;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->regs[i].offset = 0;
+	}
+
+	/* initial CFA (call frame address) */
+	state->cfa.base = CFI_SP;
+	state->cfa.offset = 0;
+}
+
+unsigned long arch_dest_rela_offset(int addend)
+{
+	return addend;
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->immediate;
+}
+
+static int is_arm64(struct elf *elf)
+{
+	switch (elf->ehdr.e_machine) {
+	case EM_AARCH64: //0xB7
+		return 1;
+	default:
+		WARN("unexpected ELF machine type %x",
+		     elf->ehdr.e_machine);
+		return 0;
+	}
+}
+
+/*
+ * static int (*arm_decode_class)(u32 instr,
+ *				 unsigned int *len,
+ *				 enum insn_type *type,
+ *				 unsigned long *immediate,
+ *				 struct list_head *ops_list);
+ */
+static arm_decode_class aarch64_insn_class_decode_table[NR_INSN_CLASS] = {
+	NULL,
+};
+
+/*
+ * Arm A64 Instruction set' decode groups (based on op0 bits[28:25]):
+ * Ob0000 - Reserved
+ * 0b0001/0b001x - Unallocated
+ * 0b100x - Data Processing -- Immediate
+ * 0b101x - Branch, Exception Gen., System Instructions.
+ * 0bx1x0 - Loads and Stores
+ * 0bx101 - Data Processing -- Registers
+ * 0bx111 - Data Processing -- Scalar Floating-Points, Advanced SIMD
+ */
+
+int arch_decode_instruction(struct elf *elf, struct section *sec,
+			    unsigned long offset, unsigned int maxlen,
+			    unsigned int *len, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
+{
+	arm_decode_class decode_fun;
+	int arm64 = 0;
+	u32 insn = 0;
+	int res;
+
+	*len = 4;
+	*immediate = 0;
+
+	//test architucture (make sure it is arm64)
+	arm64 = is_arm64(elf);
+	if (arm64 != 1)
+		return -1;
+
+	//retrieve instruction (from sec->data->offset)
+	insn = *(u32 *)(sec->data->d_buf + offset);
+
+	//dispatch according to encoding classes
+	decode_fun = aarch64_insn_class_decode_table[INSN_CLASS(insn)];
+	if (decode_fun)
+		res = decode_fun(insn, type, immediate, ops_list);
+	else
+		res = -1;
+
+	if (res)
+		WARN_FUNC("Unsupported instruction", sec, offset);
+	return res;
+}
diff --git a/tools/objtool/arch/arm64/include/arch_special.h b/tools/objtool/arch/arm64/include/arch_special.h
new file mode 100644
index 000000000000..a82a9b3e51df
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch_special.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ARM64_ARCH_SPECIAL_H
+#define _ARM64_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		8
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		12
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _ARM64_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/arm64/include/bit_operations.h b/tools/objtool/arch/arm64/include/bit_operations.h
new file mode 100644
index 000000000000..8554adb0df70
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/bit_operations.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _BIT_OPERATIONS_H
+#define _BIT_OPERATIONS_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <linux/types.h>
+
+#define ONES(N)			(((__uint128_t)1 << (N)) - 1)
+#define ZERO_EXTEND(X, N)	((X) & ONES(N))
+#define EXTRACT_BIT(X, N)	(((X) >> (N)) & ONES(1))
+#define SIGN_EXTEND(X, N)	sign_extend((X), (N))
+
+static inline unsigned long sign_extend(unsigned long x, int nbits)
+{
+	return ((~0UL + (EXTRACT_BIT(x, nbits - 1) ^ 1)) << nbits) | x;
+}
+
+u64 replicate(u64 x, int size, int n);
+
+u64 ror(u64 x, int size, int shift);
+
+int highest_set_bit(u32 x);
+
+__uint128_t decode_bit_masks(unsigned char N,
+			     unsigned char imms,
+			     unsigned char immr,
+			     bool immediate);
+
+#endif /* _BIT_OPERATIONS_H */
diff --git a/tools/objtool/arch/arm64/include/cfi_regs.h b/tools/objtool/arch/arm64/include/cfi_regs.h
new file mode 100644
index 000000000000..d48f41e7890b
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/cfi_regs.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#define CFI_R0			0
+#define CFI_R1			1
+#define CFI_R2			2
+#define CFI_R3			3
+#define CFI_R4			4
+#define CFI_R5			5
+#define CFI_R6			6
+#define CFI_R7			7
+#define CFI_R8			8
+#define CFI_R9			9
+#define CFI_R10			10
+#define CFI_R11			11
+#define CFI_R12			12
+#define CFI_R13			13
+#define CFI_R14			14
+#define CFI_R15			15
+#define CFI_R16			16
+#define CFI_R17			17
+#define CFI_R18			18
+#define CFI_R19			19
+#define CFI_R20			20
+#define CFI_R21			21
+#define CFI_R22			22
+#define CFI_R23			23
+#define CFI_R24			24
+#define CFI_R25			25
+#define CFI_R26			26
+#define CFI_R27			27
+#define CFI_R28			28
+#define CFI_R29			29
+#define CFI_FP			CFI_R29
+#define CFI_BP			CFI_FP
+#define CFI_R30			30
+#define CFI_LR			CFI_R30
+#define CFI_SP			31
+
+#define CFI_NUM_REGS		32
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
new file mode 100644
index 000000000000..c56b72ac4633
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ARM_INSN_DECODE_H
+#define _ARM_INSN_DECODE_H
+
+#include "../../../arch.h"
+
+#define NR_INSN_CLASS	16
+#define INSN_CLASS(opcode)	(((opcode) >> 25) & (NR_INSN_CLASS - 1))
+
+typedef int (*arm_decode_class)(u32 instr, enum insn_type *type,
+				unsigned long *immediate,
+				struct list_head *ops_list);
+
+#endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

