Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AE3206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AD95Xnzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbgAIQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:04:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731296AbgAIQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUQsxLHZdxOzSqZcrip37lVsIDHbyPZSVWhfrajhS7w=;
        b=AD95XnznR98uYbtZ+bbNpUiKiy8FkW7ZqRDi760G6Gf3orHzmqMSH9nf5PRysdO16GHG3+
        1at8s1GJdqLs0DrdnweEcSxh8E0SUTCsK6h3BqpoywNVWTP63j7NacV5o+ZJQ7x1pG3RR4
        QYc40lBQp7b+uRw2HazN89J3RitLavs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-N92JGBg_MLOZgBVJltSR8w-1; Thu, 09 Jan 2020 11:03:52 -0500
X-MC-Unique: N92JGBg_MLOZgBVJltSR8w-1
Received: by mail-wm1-f70.google.com with SMTP id z2so615642wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUQsxLHZdxOzSqZcrip37lVsIDHbyPZSVWhfrajhS7w=;
        b=dXKLwh3CxNawuNu+iWm1Q4b02ng/YYupJZmuofkQLX8KrD9Ba3UfuGPqW4xiuE1d5P
         oN359uc24VcW/P3advKAyKFnDVO+S8GOaVTUPDbhwNZEEmp3DFGDMjhSK54nCYtvCh+O
         rOvMcNU/LxAuCWUMaw9zQKNGUk1tOEvCilxth/jEayQEpibmn6kyc5yf62gUTn/ELrRF
         nQ1HxUulx20uVru2QBHepg3Gi4T5QgzCNVZZsu2WS6C1bN8hyPYdecasHrE42RiRWsAa
         qzXqlL1Up03gLcZswz5GaRH8NtChOkfha1yROYq8rovZgCBuqI+I6Nk1RN6XbnFZMtDD
         Jx/Q==
X-Gm-Message-State: APjAAAUFzro7sw+0MVpaRTrcS49iS6Oj3XvFuIDZKdzaQHaA5OwlrWg+
        2LyupUI7NIiMQrmo9QMs0E4H72ZxuuFGafYQ5wpPOlJ89vWRQ2BM30JJI5xH0DkcKOnqI/lh2Pi
        03rysOCT/HIv5I+JnCPQLHELj
X-Received: by 2002:a1c:730d:: with SMTP id d13mr5646508wmb.126.1578585831427;
        Thu, 09 Jan 2020 08:03:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3yDnYzwz4QZqxuPmNwe/gs/CcDoWlTDjZeGXTzwLU8hTdjO+MTW0olGHnh14bqNw8fn6M5w==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr5646471wmb.126.1578585831111;
        Thu, 09 Jan 2020 08:03:51 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m126sm3321546wmf.7.2020.01.09.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:50 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 07/57] objtool: orc: Refactor ORC API for other architectures to implement.
Date:   Thu,  9 Jan 2020 16:02:10 +0000
Message-Id: <20200109160300.26150-8-jthierry@redhat.com>
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

The ORC unwinder is only supported on x86 at the moment and should thus be
in the x86 architecture code. In order not to break the whole structure in
case another architecture decides to support the ORC unwinder via objtool,
move the implementation be done in the architecture dependent code.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T. Rebase on orc name changes,
      Move arch_orc_read_unwind_hints() to orc.h,
      Reword commit message to use imperative language]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Build                     |   2 -
 tools/objtool/arch/x86/Build            |   2 +
 tools/objtool/{ => arch/x86}/orc_dump.c |   4 +-
 tools/objtool/{ => arch/x86}/orc_gen.c  | 104 ++++++++++++++++++++++--
 tools/objtool/check.c                   |  99 +---------------------
 tools/objtool/orc.h                     |   5 +-
 6 files changed, 109 insertions(+), 107 deletions(-)
 rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
 rename tools/objtool/{ => arch/x86}/orc_gen.c (66%)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 8dc4f0848362..d069d26d97fa 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -2,8 +2,6 @@ objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
 objtool-y += check.o
-objtool-y += orc_gen.o
-objtool-y += orc_dump.o
 objtool-y += elf.o
 objtool-y += special.o
 objtool-y += objtool.o
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 7c5004008e97..e43fd6fa0ee1 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,4 +1,6 @@
 objtool-y += decode.o
+objtool-y += orc_dump.o
+objtool-y += orc_gen.o
 
 inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = ../arch/x86/lib/x86-opcode-map.txt
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/arch/x86/orc_dump.c
similarity index 98%
rename from tools/objtool/orc_dump.c
rename to tools/objtool/arch/x86/orc_dump.c
index 13ccf775a83a..cfe8f96bdd68 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/arch/x86/orc_dump.c
@@ -4,8 +4,8 @@
  */
 
 #include <unistd.h>
-#include "orc.h"
-#include "warn.h"
+#include "../../orc.h"
+#include "../../warn.h"
 
 static const char *reg_name(unsigned int reg)
 {
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/arch/x86/orc_gen.c
similarity index 66%
rename from tools/objtool/orc_gen.c
rename to tools/objtool/arch/x86/orc_gen.c
index 29bee7bd212a..e8be41a1bf94 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/arch/x86/orc_gen.c
@@ -6,11 +6,11 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "orc.h"
-#include "check.h"
-#include "warn.h"
+#include "../../orc.h"
+#include "../../check.h"
+#include "../../warn.h"
 
-int orc_init(struct objtool_file *file)
+int arch_orc_init(struct objtool_file *file)
 {
 	struct instruction *insn;
 
@@ -116,7 +116,7 @@ static int orc_create_entry(struct section *u_sec, struct section *ip_relasec,
 	return 0;
 }
 
-int orc_create_sections(struct objtool_file *file)
+int arch_orc_create_sections(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
 	struct section *sec, *u_sec, *ip_relasec;
@@ -209,3 +209,97 @@ int orc_create_sections(struct objtool_file *file)
 
 	return 0;
 }
+
+int arch_orc_read_unwind_hints(struct objtool_file *file)
+{
+	struct section *sec, *relasec;
+	struct rela *rela;
+	struct unwind_hint *hint;
+	struct instruction *insn;
+	struct cfi_reg *cfa;
+	int i;
+
+	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
+	if (!sec)
+		return 0;
+
+	relasec = sec->rela;
+	if (!relasec) {
+		WARN("missing .rela.discard.unwind_hints section");
+		return -1;
+	}
+
+	if (sec->len % sizeof(struct unwind_hint)) {
+		WARN("struct unwind_hint size mismatch");
+		return -1;
+	}
+
+	file->hints = true;
+
+	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
+		hint = (struct unwind_hint *)sec->data->d_buf + i;
+
+		rela = find_rela_by_dest(sec, i * sizeof(*hint));
+		if (!rela) {
+			WARN("can't find rela for unwind_hints[%d]", i);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("can't find insn for unwind_hints[%d]", i);
+			return -1;
+		}
+
+		cfa = &insn->state.cfa;
+
+		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
+			insn->save = true;
+			continue;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
+			insn->restore = true;
+			insn->hint = true;
+			continue;
+		}
+
+		insn->hint = true;
+
+		switch (hint->sp_reg) {
+		case ORC_REG_UNDEFINED:
+			cfa->base = CFI_UNDEFINED;
+			break;
+		case ORC_REG_SP:
+			cfa->base = CFI_SP;
+			break;
+		case ORC_REG_BP:
+			cfa->base = CFI_BP;
+			break;
+		case ORC_REG_SP_INDIRECT:
+			cfa->base = CFI_SP_INDIRECT;
+			break;
+		case ORC_REG_R10:
+			cfa->base = CFI_R10;
+			break;
+		case ORC_REG_R13:
+			cfa->base = CFI_R13;
+			break;
+		case ORC_REG_DI:
+			cfa->base = CFI_DI;
+			break;
+		case ORC_REG_DX:
+			cfa->base = CFI_DX;
+			break;
+		default:
+			WARN_FUNC("unsupported unwind_hint sp base reg %d",
+				  insn->sec, insn->offset, hint->sp_reg);
+			return -1;
+		}
+
+		cfa->offset = hint->sp_offset;
+		insn->state.type = hint->type;
+		insn->state.end = hint->end;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dd155095251c..2c5ccf61510a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1167,99 +1167,6 @@ static int add_jump_table_alts(struct objtool_file *file)
 	return 0;
 }
 
-static int read_unwind_hints(struct objtool_file *file)
-{
-	struct section *sec, *relasec;
-	struct rela *rela;
-	struct unwind_hint *hint;
-	struct instruction *insn;
-	struct cfi_reg *cfa;
-	int i;
-
-	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
-	if (!sec)
-		return 0;
-
-	relasec = sec->rela;
-	if (!relasec) {
-		WARN("missing .rela.discard.unwind_hints section");
-		return -1;
-	}
-
-	if (sec->len % sizeof(struct unwind_hint)) {
-		WARN("struct unwind_hint size mismatch");
-		return -1;
-	}
-
-	file->hints = true;
-
-	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
-		hint = (struct unwind_hint *)sec->data->d_buf + i;
-
-		rela = find_rela_by_dest(sec, i * sizeof(*hint));
-		if (!rela) {
-			WARN("can't find rela for unwind_hints[%d]", i);
-			return -1;
-		}
-
-		insn = find_insn(file, rela->sym->sec, rela->addend);
-		if (!insn) {
-			WARN("can't find insn for unwind_hints[%d]", i);
-			return -1;
-		}
-
-		cfa = &insn->state.cfa;
-
-		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
-			insn->save = true;
-			continue;
-
-		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
-			insn->restore = true;
-			insn->hint = true;
-			continue;
-		}
-
-		insn->hint = true;
-
-		switch (hint->sp_reg) {
-		case ORC_REG_UNDEFINED:
-			cfa->base = CFI_UNDEFINED;
-			break;
-		case ORC_REG_SP:
-			cfa->base = CFI_SP;
-			break;
-		case ORC_REG_BP:
-			cfa->base = CFI_BP;
-			break;
-		case ORC_REG_SP_INDIRECT:
-			cfa->base = CFI_SP_INDIRECT;
-			break;
-		case ORC_REG_R10:
-			cfa->base = CFI_R10;
-			break;
-		case ORC_REG_R13:
-			cfa->base = CFI_R13;
-			break;
-		case ORC_REG_DI:
-			cfa->base = CFI_DI;
-			break;
-		case ORC_REG_DX:
-			cfa->base = CFI_DX;
-			break;
-		default:
-			WARN_FUNC("unsupported unwind_hint sp base reg %d",
-				  insn->sec, insn->offset, hint->sp_reg);
-			return -1;
-		}
-
-		cfa->offset = hint->sp_offset;
-		insn->state.type = hint->type;
-		insn->state.end = hint->end;
-	}
-
-	return 0;
-}
 
 static int read_retpoline_hints(struct objtool_file *file)
 {
@@ -1359,7 +1266,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = read_unwind_hints(file);
+	ret = arch_orc_read_unwind_hints(file);
 	if (ret)
 		return ret;
 
@@ -2481,11 +2388,11 @@ int check(const char *_objname, bool orc)
 	}
 
 	if (orc) {
-		ret = orc_init(&file);
+		ret = arch_orc_init(&file);
 		if (ret < 0)
 			goto out;
 
-		ret = orc_create_sections(&file);
+		ret = arch_orc_create_sections(&file);
 		if (ret < 0)
 			goto out;
 
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
index cd44417487e4..ffda072cf4ad 100644
--- a/tools/objtool/orc.h
+++ b/tools/objtool/orc.h
@@ -10,8 +10,9 @@
 
 struct objtool_file;
 
-int orc_init(struct objtool_file *file);
-int orc_create_sections(struct objtool_file *file);
+int arch_orc_init(struct objtool_file *file);
+int arch_orc_create_sections(struct objtool_file *file);
+int arch_orc_read_unwind_hints(struct objtool_file *file);
 
 int orc_dump(const char *objname);
 
-- 
2.21.0

