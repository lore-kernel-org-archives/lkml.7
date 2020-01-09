Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2275C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C9A206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGLgf/9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbgAIQG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:06:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49993 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733043AbgAIQGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgwSNSqS6px8jp3jNYPpBzj7QjkDMZcWf7jBSHIJiCU=;
        b=XGLgf/9PRTodldi7YSXcMwVK322j35KveqRzBYO8Zt7pcgWdOjKYxQFg35jNZCRh7Lbiz6
        D+as02xXzUpG9Eh0VQ5UD/wQbCLtCP/ouvT4YEnmw+drjoTgqTDQyZrd8xVEXqmXkzjQh5
        xXYId/o1krx2YEp0U82ykZ50HlsPlgQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-cZP0kYDwOpKgAfy4_wfXxw-1; Thu, 09 Jan 2020 11:06:23 -0500
X-MC-Unique: cZP0kYDwOpKgAfy4_wfXxw-1
Received: by mail-wr1-f70.google.com with SMTP id z14so3075614wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgwSNSqS6px8jp3jNYPpBzj7QjkDMZcWf7jBSHIJiCU=;
        b=cCR3RG5PfTeRFNT9cdjGLgV2ChOG4LOjS4mjrXlodsNQN6y/xgBXIDq6hzhYRE92gL
         HH7V6lVBlaknoGE36wdueMxxu4p+64qDfcb+k5fUjJLYn4VImN5c5lIgO+GZYoQOAmUm
         tPwAJCLqRTyuU4zE9n6T+wWQ7rEUKQEfi7wDUk8AOlRwB46bHMaRB00fmUDE0z+Vah9Q
         Fwn1Tk2/buddcb0yjdmQAiJxVfVwJAMydMUA3LJJUoncRatm6PTs0gtGY3xOBHkA3zGj
         4dnCP+206CWOwGV0zRbvu2DHXdL5djQR55vipQHwQnQm4g0n/scKTiXtYvr+XbBTJGT8
         xmlQ==
X-Gm-Message-State: APjAAAUqXcntNdB56wO6irz3mOqKmJeGMKwpBf5jEhx1fQBNhIgUpugU
        RFDWDeVCm5ZUE3jsuVAyWAjbUkFwTMIfrjZBLIlhwrtufTZXNC64aOcFzvZtZp/1VotF+qxAG8X
        rDE5XQMbqzZgU5plmDKRA/bqD
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr5555837wmj.37.1578585981649;
        Thu, 09 Jan 2020 08:06:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3pweoOYbsv4OP48X37FSBCDstfv+4OYIDJH8H8/t6Mr+whcukViSF0ZLbVNz5xhoyBsMETg==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr5555817wmj.37.1578585981473;
        Thu, 09 Jan 2020 08:06:21 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e18sm8643101wrr.95.2020.01.09.08.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:06:20 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 26/57] objtool: arm64: Decode brk instruction
Date:   Thu,  9 Jan 2020 16:02:29 +0000
Message-Id: <20200109160300.26150-27-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add decoding brk instructions. Associate known immediate values with
their kernel/compiler semantics.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index aa00de725686..1609750cc4b9 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -507,6 +507,7 @@ int arm_decode_except_gen(u32 instr, enum insn_type *type,
 #define INSN_SVC	0b00000001
 #define INSN_HVC	0b00000010
 #define INSN_SMC	0b00000011
+#define INSN_BRK	0b00100000
 
 	switch (decode_field) {
 	case INSN_SVC:
@@ -518,6 +519,38 @@ int arm_decode_except_gen(u32 instr, enum insn_type *type,
 		 */
 		*type = INSN_NOP;
 		return 0;
+	case INSN_BRK:
+		/* Based on arch/arm64/include/asm/brk-imm.h */
+		switch (imm16) {
+		case 0x004: /* KPROBES_BRK_IMM */
+		case 0x005: /* UPROBES_BRK_IMM */
+		case 0x400: /* KGDB_DYN_DBG_BRK_IMM */
+		case 0x401: /* KGDB_COMPILED_DBG_BRK_IMM */
+			*type = INSN_OTHER;
+			break;
+		case 0x800: /* BUG_BRK_IMM */
+			/*
+			 * brk #0x800 is generated by the BUG()/WARN() linux API
+			 * and is thus a particular case. Since those are not
+			 * necessarily compiled in, the surrounding code should
+			 * work properly without it. We thus consider it as a
+			 * nop.
+			 */
+			*type = INSN_NOP;
+			break;
+		case 0x3e8:
+			/*
+			 * Similar to the use of "ud2" on x86, GCC inserts
+			 * "brk #0x38e" instructions for certain divide-by-zero
+			 * cases.
+			 */
+			*type = INSN_BUG;
+			break;
+		default:
+			*type = INSN_CONTEXT_SWITCH;
+			break;
+		}
+		return 0;
 	default:
 		return arm_decode_unknown(instr, type, immediate, ops_list);
 	}
-- 
2.21.0

