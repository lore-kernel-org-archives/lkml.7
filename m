Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D838206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cw2pKt+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgAIQFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49816 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728333AbgAIQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mml1mzhjK5wtC17nLrEN5fR+Z9py7ETGWVYItyxd8Hw=;
        b=Cw2pKt+uCS6ccZ3pbvbq+lPxL76Ehlews1z8KMHDikFhryLwngZ0AQGZlhsJNcIFHuMJLg
        f17bFjEfGk5jAIrUVYA8i7L5tjzHKPrrZYn1VEMWGz2vNWagtA33Y5FKmC8hMWJXRmmjjA
        z03bHc2nbTOA/lqyt4If/7/YWJFlZMw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-0svSFX6FP6GaJ0z4bIEDQQ-1; Thu, 09 Jan 2020 11:05:44 -0500
X-MC-Unique: 0svSFX6FP6GaJ0z4bIEDQQ-1
Received: by mail-wr1-f69.google.com with SMTP id z14so3074870wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mml1mzhjK5wtC17nLrEN5fR+Z9py7ETGWVYItyxd8Hw=;
        b=KP1YI649o2pqOP9rY8pQh267yMoq/wiZDUdVmCY1AVVkjj8hjrpi4393Y8IzSZ7cM4
         fuc9OZPp9rIhi5FugUU7TdFvl4v1wxSLWqKn2tfiuD05MQT6Yga931fSCUZGGOf0zuYQ
         Kj+Ce4+XRTWDhe0YuebxCpkTU6ppTj0vpyH3wadMKQBPvokn7wrCQ3YneA9W6CsiVLza
         EqklD9Jkv6TOr1j6sDbRJiA9OmdGe1uqrSIN3hPqTj9FQUMFUEKCyvRZe42gS3fNH0lf
         wSZs8qGiEyVbCA90Emry2nkxYZbxtAsMSjuuyp+KJn5Mn8kN1UvLE0wJFG/f5wWDsy7w
         67xw==
X-Gm-Message-State: APjAAAUL7MpLS07JtP8MGIacUu8L/yVS6h69iX3+06Bug1H6JC5VZ6xO
        K5js/RRGB+4Hu+6sSZyE2oYG0kfXe9D/bMtHWZZF+plnFHshciMPlBA8uJThqLP1Fpc43Ytw4Fl
        UKTUTobq0YVy6+Qu5IPA8kkcu
X-Received: by 2002:a1c:2089:: with SMTP id g131mr5957476wmg.63.1578585943126;
        Thu, 09 Jan 2020 08:05:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyw4kwWJhsfey2tGM6eLUUWESwCEkAPg51xba9MD4w398rYCfFbg3NiYZBgdd7WT6pDYqRluw==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr5957442wmg.63.1578585942891;
        Thu, 09 Jan 2020 08:05:42 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id a16sm8545544wrt.37.2020.01.09.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:42 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 20/57] objtool: arm64: Decode unknown instructions
Date:   Thu,  9 Jan 2020 16:02:23 +0000
Message-Id: <20200109160300.26150-21-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For aarch64, it is possible to have byte sequences that aren't valid
opcodes in the code sections. Do not report an error when the decoder
finds such a sequence, but make sure that those bytes cannot be reached
in the execution flow.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch.h                          |  1 +
 tools/objtool/arch/arm64/decode.c             | 22 ++++++++++++++++++-
 .../objtool/arch/arm64/include/insn_decode.h  |  7 ++++++
 tools/objtool/check.c                         | 10 ++++++++-
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index f9883c431949..0336efecb9d9 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -28,6 +28,7 @@ enum insn_type {
 	INSN_STD,
 	INSN_CLD,
 	INSN_OTHER,
+	INSN_INVALID,
 };
 
 enum op_dest_type {
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 4d0ab2acca27..04358f41ef1d 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -78,7 +78,9 @@ static int is_arm64(struct elf *elf)
  *				 struct list_head *ops_list);
  */
 static arm_decode_class aarch64_insn_class_decode_table[NR_INSN_CLASS] = {
-	NULL,
+	[INSN_RESERVED]			= arm_decode_unknown,
+	[INSN_UNKNOWN]			= arm_decode_unknown,
+	[INSN_UNALLOC]			= arm_decode_unknown,
 };
 
 /*
@@ -125,3 +127,21 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 		WARN_FUNC("Unsupported instruction", sec, offset);
 	return res;
 }
+
+int arm_decode_unknown(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list)
+{
+	/*
+	 * There are a few reasons we might have non-valid opcodes in
+	 * code sections:
+	 * - For load literal, assembler can generate the data to be loaded in
+	 *   the code section
+	 * - Compiler/assembler can generate zeroes to pad function that do not
+	 *   end on 8-byte alignment
+	 * - Hand written assembly code might contain constants in the code
+	 *   section
+	 */
+	*type = INSN_INVALID;
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index c56b72ac4633..16066f8fca0d 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -5,6 +5,10 @@
 
 #include "../../../arch.h"
 
+#define INSN_RESERVED	0b0000
+#define INSN_UNKNOWN	0b0001
+#define INSN_UNALLOC	0b0011
+
 #define NR_INSN_CLASS	16
 #define INSN_CLASS(opcode)	(((opcode) >> 25) & (NR_INSN_CLASS - 1))
 
@@ -12,4 +16,7 @@ typedef int (*arm_decode_class)(u32 instr, enum insn_type *type,
 				unsigned long *immediate,
 				struct list_head *ops_list);
 
+/* arm64 instruction classes */
+int arm_decode_unknown(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 48aec56a7760..52a8e64e15ca 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1818,6 +1818,13 @@ static int validate_branch_alt_safe(struct objtool_file *file,
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
+		if (insn->type == INSN_INVALID) {
+			WARN("%s+0x%lx non-executable instruction, should never be reached",
+			     insn->sec->name,
+			     insn->offset);
+			return 1;
+		}
+
 		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
@@ -2137,7 +2144,8 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 {
 	int i;
 
-	if (insn->ignore || insn->type == INSN_NOP)
+	if (insn->ignore || insn->type == INSN_NOP ||
+	    insn->type == INSN_INVALID)
 		return true;
 
 	/*
-- 
2.21.0

