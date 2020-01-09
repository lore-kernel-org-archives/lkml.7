Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761EF2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDuby3w9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbgAIQFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20513 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728333AbgAIQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dq52D+PjqCb5lmkvaEi43/GUeI+ylqf3UQ4Yjnbg3l0=;
        b=aDuby3w90Q2fOkqngKFaX7FVpdjzvuO+eWyamUDnTncew/kR2YxMijklAczJMk+MMAt9rl
        +9TsSBFRGd2rlYBmMHfV+jHCcQ2lr71eFyt3zicfW1CV4cwRmYmjuuLlKyg/Q899jMak0N
        ZnPlqrAj37rjzOv/UjIh5p3MyZ3KC2k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-Yr-NpsodNUChS1cziqIfRA-1; Thu, 09 Jan 2020 11:05:48 -0500
X-MC-Unique: Yr-NpsodNUChS1cziqIfRA-1
Received: by mail-wm1-f71.google.com with SMTP id t16so1099259wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dq52D+PjqCb5lmkvaEi43/GUeI+ylqf3UQ4Yjnbg3l0=;
        b=KQ1AjiH2iYwSuJe8pZouBn4iWdlACxANe3lONHjc7gwvBvKNAuHaF1FySThWj5KhSV
         9RFTSU7NKCAD9huyQjCXgzjsdCtym4//tfwoCxi0xdPdNXmBE4E3tliHkuA68+2Dus4g
         KnwAd3Be/rjHNW0qiR9bCq87VidUltBMsKoF+ooq+Xj6pwfZeDuI/skIFKDHr9OejI68
         TCmueOAdFA5qAxXgZ6FWnhsyQWjHZV2A8P0RAVNnsPt5OL1/T9FRHeG6mVmVGHaqj+J3
         Qx/shEC8TWz/2HSY1JYXW19ToVf8NocA7X0A57LOE+7lcyVGEK4tvkq+COehkKDbH6Zd
         w3NQ==
X-Gm-Message-State: APjAAAVA8/tNXdmelEp7yjMMUJ4QhXE70L+uQibzwPxBwfnLZEyo3O7L
        E8XLIPZy5p9x94whoGZkRxtiU7dbDftNkKxFEKAlmH/zp5o6cIveFGXmSDlJdfXjRbozzjysXE7
        A9WlFi/rHeBEfHOagO0JFc75n
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr11849278wrw.289.1578585947048;
        Thu, 09 Jan 2020 08:05:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwP9x68/cDeC19G8Csd5FQdYjLlYnXYaw7fp3/2NsvZJnBVV02K8nlocIVVAnRTR5wkU2nCEA==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr11849244wrw.289.1578585946797;
        Thu, 09 Jan 2020 08:05:46 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id a16sm8545544wrt.37.2020.01.09.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:46 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 23/57] objtool: arm64: Decode logical data processing instructions
Date:   Thu,  9 Jan 2020 16:02:26 +0000
Message-Id: <20200109160300.26150-24-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode instructions performing logical operations with immediate values.
Create a stack operation for and operation targeting the stack pointer.

Since OP_SRC_AND assumes the source and destination register are the same,
add a register assignment operation when the source operand of the logical
instruction is not the stack pointer.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 58 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  3 +
 2 files changed, 61 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index d240f29a2390..a30c3294cc21 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -160,6 +160,7 @@ static arm_decode_class aarch64_insn_dp_imm_decode_table[NR_DP_IMM_SUBCLASS] = {
 	[0 ... INSN_PCREL]	= arm_decode_pcrel,
 	[INSN_ADD_SUB]		= arm_decode_add_sub,
 	[INSN_ADD_TAG]		= arm_decode_add_sub_tags,
+	[INSN_LOGICAL]		= arm_decode_logical,
 	[INSN_MOVE_WIDE]	= arm_decode_move_wide,
 	[INSN_BITFIELD]		= arm_decode_bitfield,
 	[INSN_EXTRACT]		= arm_decode_extract,
@@ -273,6 +274,63 @@ int arm_decode_add_sub_tags(u32 instr, enum insn_type *type,
 	return 0;
 }
 
+int arm_decode_logical(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, opc = 0, N = 0;
+	unsigned char imms = 0, immr = 0, rn = 0, rd = 0;
+	struct stack_op *op;
+
+	rd = instr & ONES(5);
+	rn = (instr >> 5) & ONES(5);
+
+	imms = (instr >> 10) & ONES(6);
+	immr = (instr >> 16) & ONES(6);
+
+	N = EXTRACT_BIT(instr, 22);
+	opc = (instr >> 29) & ONES(2);
+	sf = EXTRACT_BIT(instr, 31);
+
+	if (N == 1 && sf == 0)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+	*immediate = (decode_bit_masks(N, imms, immr, true) >> 64);
+
+	if (opc & 1)
+		return 0;
+
+	if (rd != CFI_SP)
+		return 0;
+
+	*type = INSN_STACK;
+
+	if (rn != CFI_SP) {
+		op = calloc(1, sizeof(*op));
+		list_add_tail(&op->list, ops_list);
+
+		op->dest.type = OP_DEST_REG;
+		op->dest.offset = 0;
+		op->dest.reg = rd;
+		op->src.type = OP_SRC_REG;
+		op->src.offset = 0;
+		op->src.reg = rn;
+	}
+
+	op = calloc(1, sizeof(*op));
+	list_add_tail(&op->list, ops_list);
+
+	op->dest.type = OP_DEST_REG;
+	op->dest.offset = 0;
+	op->dest.reg = rd;
+
+	op->src.type = OP_SRC_AND;
+	op->src.offset = 0;
+	op->src.reg = rd;
+
+	return 0;
+}
+
 int arm_decode_move_wide(u32 instr, enum insn_type *type,
 			 unsigned long *immediate, struct list_head *ops_list)
 {
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 65e60b293a07..6f68e8887cdb 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -16,6 +16,7 @@
 #define INSN_PCREL	0b001	//0b00x
 #define INSN_ADD_SUB	0b010
 #define INSN_ADD_TAG	0b011
+#define INSN_LOGICAL	0b100
 #define INSN_MOVE_WIDE	0b101
 #define INSN_BITFIELD	0b110
 #define INSN_EXTRACT	0b111
@@ -38,6 +39,8 @@ int arm_decode_add_sub(u32 instr, enum insn_type *type,
 int arm_decode_add_sub_tags(u32 instr, enum insn_type *type,
 			    unsigned long *immediate,
 			    struct list_head *ops_list);
+int arm_decode_logical(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_move_wide(u32 instr, enum insn_type *type,
 			 unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_bitfield(u32 instr, enum insn_type *type,
-- 
2.21.0

