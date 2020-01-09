Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12390C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB3920661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eakVklX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgAIQHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26903 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733124AbgAIQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Io3pe+yXhkH0XtVt81FPsOl3c54xtZQ9M8pNFcB3Jec=;
        b=eakVklX4Yk90th1XKoqsSl+xz4aJSaNAUwuMNW6RZv4t5Hyd6YkcnwQVEdOVAWDI5U8h8B
        q6s0FqwWzqt814ScYAjoqtFYtvh1JPb4weAcbY3+d2JPu80D4wnfueMpCis8Gd08wfqyqh
        dpckURhAW7cuzLgOIDbiAIuxQBXQqoM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-qPNo7MnlMrmQeF8BtaDGBg-1; Thu, 09 Jan 2020 11:07:06 -0500
X-MC-Unique: qPNo7MnlMrmQeF8BtaDGBg-1
Received: by mail-wr1-f71.google.com with SMTP id z15so3077059wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Io3pe+yXhkH0XtVt81FPsOl3c54xtZQ9M8pNFcB3Jec=;
        b=Q+iM0KmppR0rFkxsUnRUJK+GtJs8O6EcVYv+Gu/n43Lnlshn1U9AAGHkf0hWPOqS5n
         EzdILijBgAGpCNKzltt03TYrdRvL57HMvl5T0MXMePBdOn8VFkvx0sHw8EBV7zumdLMH
         c9cQ+favrgD4wJuYd32MKfcyWL7w7AMFVJQXRpga76/0YodyQJfaZE+O6lex06++q5HV
         ObEZJ4BYIf3YS5xoRisvpiI+OSFQmbbzcdNN84QJhYvQ0klaYKrvLBF8nAcoofR23HNV
         qkoZ3S9MNME+EP9OS1dyt2X/1YFzFL44C2tgK3jJqxdVpPaGf5u3Fx5NhbIB7whgGbqy
         1koA==
X-Gm-Message-State: APjAAAUxp2N+a1fq9XAEa4Ihz00hOt0wrnIgR/JAQDuhecHJGWhfaSVi
        6S1zBWHKJGPSb3B/hWwfNrM9K1LGdHI+8pvlV2X34/iBl+eDzSv+XRhtIpj3DAtaILkZDbRrwbX
        A1F5PYnQ7pGaxbPVlGd27I7UI
X-Received: by 2002:a5d:5273:: with SMTP id l19mr12042234wrc.175.1578586024905;
        Thu, 09 Jan 2020 08:07:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhV2DNPneDJ3INZRmEMT5LfpnDkTy4hQ+cTQKOs/UrhpfRFlyh+43dh8pZyrUb2ibu33ow8w==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr12042205wrc.175.1578586024671;
        Thu, 09 Jan 2020 08:07:04 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id q3sm9123252wrn.33.2020.01.09.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:04 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 34/57] objtool: arm64: Decode load/store exclusive
Date:   Thu,  9 Jan 2020 16:02:37 +0000
Message-Id: <20200109160300.26150-35-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store exclusive instructions. From objtool's point
of view there aren't particular semantics to these operations.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 140 ++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |   3 +
 2 files changed, 143 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 7d480efe0bc2..e3f77d68b282 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -830,6 +830,11 @@ static struct aarch64_insn_decoder ld_st_decoder[] = {
 		.value = 0b000011100000000,
 		.decode_func = arm_decode_adv_simd_single_post,
 	},
+	{
+		.mask = 0b001111000000000,
+		.value = 0b000000000000000,
+		.decode_func = arm_decode_ld_st_exclusive,
+	},
 	{
 		.mask = 0b001101100000000,
 		.value = 0b001000000000000,
@@ -1190,6 +1195,141 @@ int arm_decode_adv_simd_single_post(u32 instr, enum insn_type *type,
 	return ret;
 }
 
+#define ST_EXCL_UNALLOC_1 0b001010
+#define ST_EXCL_UNALLOC_2 0b000010
+
+#define LDXRB		0b000100
+#define LDAXRB		0b000101
+#define LDLARB		0b001100
+#define LDARB		0b001101
+#define LDXRH		0b010100
+#define LDAXRH		0b010101
+#define LDLARH		0b011100
+#define LDARH		0b011101
+#define LDXR		0b100100
+#define LDAXR		0b100101
+#define LDXP		0b100110
+#define LDAXP		0b100111
+#define LDLAR		0b101100
+#define LDAR		0b101101
+#define LDXR_64		0b110100
+#define LDAXR_64	0b110101
+#define LDXP_64		0b110110
+#define LDAXP_64	0b110111
+#define LDLAR_64	0b111100
+#define LDAR_64		0b111101
+
+#define LD_EXCL_NUMBER	20
+
+static int ld_excl_masks[] = {
+	LDXRB,
+	LDAXRB,
+	LDLARB,
+	LDARB,
+	LDXRH,
+	LDAXRH,
+	LDLARH,
+	LDARH,
+	LDXR,
+	LDAXR,
+	LDXP,
+	LDAXP,
+	LDLAR,
+	LDAR,
+	LDXR_64,
+	LDAXR_64,
+	LDXP_64,
+	LDAXP_64,
+	LDLAR_64,
+	LDAR_64,
+};
+
+int arm_decode_ld_st_exclusive(u32 instr, enum insn_type *type,
+			       unsigned long *immediate,
+			       struct list_head *ops_list)
+{
+	unsigned char size = 0, o2 = 0, L = 0, o1 = 0, o0 = 0;
+	unsigned char rt = 0, rt2 = 0, rn = 0;
+	unsigned char decode_field = 0;
+	struct stack_op *op;
+	int i = 0;
+
+	size = (instr >> 30) & ONES(2);
+	o2 = EXTRACT_BIT(instr, 23);
+	L = EXTRACT_BIT(instr, 22);
+	o1 = EXTRACT_BIT(instr, 21);
+	o0 = EXTRACT_BIT(instr, 15);
+
+	rt2 = (instr >> 10) & ONES(5);
+	rn = (instr >> 5) & ONES(5);
+	rt = instr & ONES(5);
+
+	decode_field = (size << 4) | (o2 << 3) | (L << 2) | (o1 << 1) | o0;
+
+	if ((decode_field & ST_EXCL_UNALLOC_1) == ST_EXCL_UNALLOC_1 ||
+	    (decode_field & 0b101010) == ST_EXCL_UNALLOC_2) {
+		if (rt2 != 31)
+			return arm_decode_unknown(instr, type, immediate,
+						  ops_list);
+	}
+
+	if (!stack_related_reg(rn)) {
+		*type = INSN_OTHER;
+		return 0;
+	}
+
+	*type = INSN_STACK;
+	op = calloc(1, sizeof(*op));
+	list_add_tail(&op->list, ops_list);
+
+	for (i = 0; i < LD_EXCL_NUMBER; i++) {
+		if ((decode_field & 0b111111) == ld_excl_masks[i]) {
+			op->src.type = OP_SRC_REG_INDIRECT;
+			op->src.reg = rn;
+			op->src.offset = 0;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = rt;
+			op->dest.offset = 0;
+			return 0;
+		}
+	}
+
+	op->dest.type = OP_DEST_REG_INDIRECT;
+	op->dest.reg = rn;
+	op->dest.offset = 0;
+	op->src.type = OP_SRC_REG;
+	op->src.reg = rt;
+	op->src.offset = 0;
+
+	return 0;
+}
+
+#undef ST_EXCL_UNALLOC_1
+#undef ST_EXCL_UNALLOC_2
+
+#undef LD_EXCL_NUMBER
+
+#undef LDXRB
+#undef LDAXRB
+#undef LDLARB
+#undef LDARB
+#undef LDXRH
+#undef LDAXRH
+#undef LDLARH
+#undef LDARH
+#undef LDXR
+#undef LDAXR
+#undef LDXP
+#undef LDAXP
+#undef LDLAR
+#undef LDAR
+#undef LDXR_64
+#undef LDAXR_64
+#undef LDXP_64
+#undef LDAXP_64
+#undef LDLAR_64
+#undef LDAR_64
+
 int arm_decode_ld_st_regs_unsc_imm(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list)
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 7fd333f88612..61152b4aa42a 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -136,4 +136,7 @@ int arm_decode_ld_st_regs_off(u32 instr, enum insn_type *type,
 int arm_decode_ld_st_regs_unsigned(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list);
+int arm_decode_ld_st_exclusive(u32 instr, enum insn_type *type,
+			       unsigned long *immediate,
+			       struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

