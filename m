Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9588EC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FF220721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvkBghV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733038AbgAIQF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733014AbgAIQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yq+5KLGG8C3/es7UmF0OP8vHzerZYbNFdNiyqCT1ebc=;
        b=FvkBghV27MO7y+9Y57vRJ+Hl9e1plQkimJLsF6eZ/YpLVZSIoNbiDs3rMKEcHJxU/Cg/Wj
        HLjgoqYulXwc4qmm8O0gQvoS8cehTdQjR16wlGa+sQM/QwjkM7Lh3xOwb0zUDsPy4IszdU
        SXeQIecjSMNo7ezXZW9+XC42ZmYIZIc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-uHR4QKbXMEKK6bmr6Ft8EA-1; Thu, 09 Jan 2020 11:05:50 -0500
X-MC-Unique: uHR4QKbXMEKK6bmr6Ft8EA-1
Received: by mail-wm1-f69.google.com with SMTP id f25so1104299wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yq+5KLGG8C3/es7UmF0OP8vHzerZYbNFdNiyqCT1ebc=;
        b=fGPxIXY3+2H7Tfw4cXnsexkmfFQLSHeAE+omMnBl6dqYjdQwMN0FlA6LlBpttUe2f+
         0My4lTRiM0J+EstY1f4E1a4ensNMTVcyrgjgSkHCFjdZuQNOL5exBeHJQTs/Xsyj9j7r
         KzsPNGcaDm6OsK+OmOnykgELpsyRev7bDL4sB3FafoMes4+sx48SP/EsqjurHwolS6l5
         LYgGMhUzX0wfcN8VHVf3RXelteU2MMWF4KIkF+Wx/gdAU4y8JQucq7n2eCoQjCot8xwG
         dgFWZG3t501sNM+NayJ5lyU36rd4gYsNI7+0rtuC/C1IW49576HTs+vgfdWgN2MtAVsI
         jdTw==
X-Gm-Message-State: APjAAAVADnuTABDIVm0Bvh2XmQP5mZNuN3l8HpsjG/1ef13vZT60JFEb
        WB2UCTe6F49Ni0ONSDYMeFujyCFwmzJaMuITUhethUqu1+XB/ax8bmRq6RryHrt41ohs6Drnrxs
        DrYsXPQT8JkBssGhfNN/KX6wA
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr11575572wrt.229.1578585948475;
        Thu, 09 Jan 2020 08:05:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLZVgpVj1PcTS0z5J40QUs6nyfbe/27huXPUr91QfNm91o6qPV2F2jQlHKmgq8A7M+M38/7A==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr11575528wrt.229.1578585948045;
        Thu, 09 Jan 2020 08:05:48 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id a16sm8545544wrt.37.2020.01.09.08.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:47 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 24/57] objtool: arm64: Decode system instructions not affecting the flow
Date:   Thu,  9 Jan 2020 16:02:27 +0000
Message-Id: <20200109160300.26150-25-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode basic system instructions that do not cause jumps or stack
pointer modifications.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 95 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  | 23 +++++
 2 files changed, 118 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index a30c3294cc21..c38d73fb57e1 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -87,6 +87,7 @@ static arm_decode_class aarch64_insn_class_decode_table[NR_INSN_CLASS] = {
 	[INSN_UNKNOWN]			= arm_decode_unknown,
 	[INSN_UNALLOC]			= arm_decode_unknown,
 	[0b1000 ... INSN_DP_IMM]	= arm_decode_dp_imm,
+	[0b1010 ... INSN_SYS_BRANCH]	= arm_decode_br_sys,
 };
 
 /*
@@ -391,3 +392,97 @@ int arm_decode_extract(u32 instr, enum insn_type *type,
 
 	return arm_decode_unknown(instr, type, immediate, ops_list);
 }
+
+static struct aarch64_insn_decoder br_sys_decoder[] = {
+	{
+		.mask = 0b1111111111111111111111,
+		.value = 0b1100100000011001011111,
+		.decode_func = arm_decode_hints,
+	},
+	{
+		.mask = 0b1111111111111111100000,
+		.value = 0b1100100000011001100000,
+		.decode_func = arm_decode_barriers,
+	},
+	{
+		.mask = 0b1111111111000111100000,
+		.value = 0b1100100000000010000000,
+		.decode_func = arm_decode_pstate,
+	},
+	{
+		.mask = 0b1111111011000000000000,
+		.value = 0b1100100001000000000000,
+		.decode_func = arm_decode_system_insn,
+	},
+	{
+		.mask = 0b1111111010000000000000,
+		.value = 0b1100100010000000000000,
+		.decode_func = arm_decode_system_regs,
+	},
+};
+
+int arm_decode_br_sys(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list)
+{
+	u32 decode_field = 0, op1 = 0;
+	unsigned char op0 = 0, op2 = 0;
+	int i = 0;
+
+	op0 = (instr >> 29) & ONES(3);
+	op1 = (instr >> 12) & ONES(14);
+	op2 = instr & ONES(5);
+
+	decode_field = op0;
+	decode_field = (decode_field << 19) | (op1 << 5) | op2;
+
+	for (i = 0; i < ARRAY_SIZE(br_sys_decoder); i++) {
+		if ((decode_field & br_sys_decoder[i].mask) ==
+		    br_sys_decoder[i].value) {
+			return br_sys_decoder[i].decode_func(instr,
+							     type,
+							     immediate,
+							     ops_list);
+		}
+	}
+
+	return arm_decode_unknown(instr, type, immediate, ops_list);
+}
+
+int arm_decode_hints(u32 instr, enum insn_type *type,
+		     unsigned long *immediate, struct list_head *ops_list)
+{
+	*type = INSN_NOP;
+	return 0;
+}
+
+int arm_decode_barriers(u32 instr, enum insn_type *type,
+			unsigned long *immediate, struct list_head *ops_list)
+{
+	/* TODO:check unallocated */
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_pstate(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list)
+{
+	/* TODO:check unallocated */
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_system_insn(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	/* TODO:check unallocated */
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_system_regs(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	/* TODO:check unallocated */
+	*type = INSN_OTHER;
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 6f68e8887cdb..777a62f1a141 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -9,6 +9,7 @@
 #define INSN_UNKNOWN	0b0001
 #define INSN_UNALLOC	0b0011
 #define INSN_DP_IMM	0b1001	//0x100x
+#define INSN_SYS_BRANCH	0b1011	//0x101x
 
 #define NR_INSN_CLASS	16
 #define INSN_CLASS(opcode)	(((opcode) >> 25) & (NR_INSN_CLASS - 1))
@@ -25,9 +26,17 @@ typedef int (*arm_decode_class)(u32 instr, enum insn_type *type,
 				unsigned long *immediate,
 				struct list_head *ops_list);
 
+struct aarch64_insn_decoder {
+	u32 mask;
+	u32 value;
+	arm_decode_class decode_func;
+};
+
 /* arm64 instruction classes */
 int arm_decode_dp_imm(u32 instr, enum insn_type *type,
 		      unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_br_sys(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_unknown(u32 instr, enum insn_type *type,
 		       unsigned long *immediate, struct list_head *ops_list);
 
@@ -47,4 +56,18 @@ int arm_decode_bitfield(u32 instr, enum insn_type *type,
 			unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_extract(u32 instr, enum insn_type *type,
 		       unsigned long *immediate, struct list_head *ops_list);
+
+/* arm64 branch, exception generation, system insn subclasses */
+int arm_decode_hints(u32 instr, enum insn_type *type,
+		     unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_barriers(u32 instr, enum insn_type *type,
+			unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_pstate(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_system_insn(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_system_regs(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

