Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43563C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F006206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOduT06/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbgAIQD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731305AbgAIQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyxUQFf/o75wh5gN7bTB2ZufiMygHr9oF7Ozqff3HFc=;
        b=TOduT06/IHH9Gt+1lbdUuJTdE3wYtd4Wihj5kWITdo2sQ86xa1FOvqb1nQlxhwG5Th02B0
        Z2xnJDKER74B+7nscmHTt5Sjed3ktz/qPEKzshqywa+nwi89jtWIS4Raf56WP7ymsJPGNS
        EwVDyJocCtUFHfZQwRY9chP4eyDGJYg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-IisA219FPCCoeiSLrylNyA-1; Thu, 09 Jan 2020 11:03:49 -0500
X-MC-Unique: IisA219FPCCoeiSLrylNyA-1
Received: by mail-wm1-f69.google.com with SMTP id l11so884411wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyxUQFf/o75wh5gN7bTB2ZufiMygHr9oF7Ozqff3HFc=;
        b=UzezOvSnKqBmYmhm1/HKC7LrODpyNj/fKyT7EqumaEwSACdsbWntKbWQlGKbY4zbpr
         ergYV0Ckvh1ePC/XnXqOvoLR+snayLzipj+uCCIydbyrhBxu0vBLVLjCF0UCtGXRVcJ4
         ostfSISdmK8qZgv2daqEWmpYrLZMa3tCoszvl/X5St+dXTKc0b5VBR/HDUYVZXnoAWZW
         6zUlexUG8ntmJCq5KL3tGSMTxHS6Y9M0DOjMbZvQ4nC3eUE9PntQaH2xnauIRbS7IMg9
         YnUAkiPvCGLas4Bc1qlTnQ0HrqfDKY2aJcD+P6dmUXkqN20AJ+qZd0R6E5ImX9epWx4z
         G9FA==
X-Gm-Message-State: APjAAAUrn+pgai4SM8N3nq86lvG2JfjqB91XRGY+B4FsFmSDwhviQR+K
        nXNGpY6BxDmFoYt/G9dskdHjuxkdwxp1la0Kx5A08r4AMI5mn3vzyP4SCgdNxlUcBGnpueswRPQ
        +IV6eBcl7zwY09FSOpnOewLVi
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr11357632wrx.14.1578585828640;
        Thu, 09 Jan 2020 08:03:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqywh+nDZSYkZ7FzASPCFOYxPUVilYHzJUKHcQ0MT1oOqlc7tokvdArdaYIoBR2/85jfNJvqig==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr11357604wrx.14.1578585828381;
        Thu, 09 Jan 2020 08:03:48 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m126sm3321546wmf.7.2020.01.09.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:47 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 05/57] objtool: Add abstraction for computation of symbols offsets
Date:   Thu,  9 Jan 2020 16:02:08 +0000
Message-Id: <20200109160300.26150-6-jthierry@redhat.com>
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

The jump destination and relocation offset used previously are only
reliable on x86_64 architecture. We abstract these computations by calling
arch-dependent implementations.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T. Remove superfluous comment, replace other addend offsets
      with arch_dest_rela_offset]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch.h            |  6 ++++++
 tools/objtool/arch/x86/decode.c | 11 +++++++++++
 tools/objtool/check.c           | 18 ++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index ced3765c4f44..a9a50a25ca66 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -66,6 +66,8 @@ struct stack_op {
 	struct op_src src;
 };
 
+struct instruction;
+
 void arch_initial_func_cfi_state(struct cfi_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
@@ -75,4 +77,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+unsigned long arch_jump_destination(struct instruction *insn);
+
+unsigned long arch_dest_rela_offset(int addend);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032863a8..79ff33ffa6e0 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,6 +11,7 @@
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"
 
+#include "../../check.h"
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
@@ -66,6 +67,11 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
+unsigned long arch_dest_rela_offset(int addend)
+{
+	return addend + 4;
+}
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -497,3 +503,8 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
 	state->regs[16].base = CFI_CFA;
 	state->regs[16].offset = -8;
 }
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->len + insn->immediate;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 27e5380e0e0b..6a5f78cca27c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -564,13 +564,14 @@ static int add_jump_destinations(struct objtool_file *file)
 					       insn->len);
 		if (!rela) {
 			dest_sec = insn->sec;
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 		} else if (rela->sym->type == STT_SECTION) {
 			dest_sec = rela->sym->sec;
-			dest_off = rela->addend + 4;
+			dest_off = arch_dest_rela_offset(rela->addend);
 		} else if (rela->sym->sec->idx) {
 			dest_sec = rela->sym->sec;
-			dest_off = rela->sym->sym.st_value + rela->addend + 4;
+			dest_off = rela->sym->sym.st_value +
+				   arch_dest_rela_offset(rela->addend);
 		} else if (strstr(rela->sym->name, "_indirect_thunk_")) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
@@ -660,7 +661,7 @@ static int add_call_destinations(struct objtool_file *file)
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
 					       insn->len);
 		if (!rela) {
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 			insn->call_dest = find_symbol_by_offset(insn->sec,
 								dest_off);
 
@@ -673,14 +674,15 @@ static int add_call_destinations(struct objtool_file *file)
 			}
 
 		} else if (rela->sym->type == STT_SECTION) {
+			dest_off = arch_dest_rela_offset(rela->addend);
 			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
-								rela->addend+4);
+								dest_off);
 			if (!insn->call_dest ||
 			    insn->call_dest->type != STT_FUNC) {
-				WARN_FUNC("can't find call dest symbol at %s+0x%x",
+				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  rela->sym->sec->name,
-					  rela->addend + 4);
+					  dest_off);
 				return -1;
 			}
 		} else
@@ -771,7 +773,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (!insn->immediate)
 			continue;
 
-		dest_off = insn->offset + insn->len + insn->immediate;
+		dest_off = arch_jump_destination(insn);
 		if (dest_off == special_alt->new_off + special_alt->new_len) {
 			if (!fake_jump) {
 				WARN("%s: alternative jump to end of section",
-- 
2.21.0

