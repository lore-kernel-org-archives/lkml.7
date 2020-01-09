Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB6AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD9621744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEq3Ww9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbgAIQHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26501 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728567AbgAIQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=674vedoaHlOK+sohBzVeKsD1bt4H4p7wzQDNyJHcuUU=;
        b=iEq3Ww9EAhSLRGT8UdPLYM3Gu+mPpQy8W5sEgRuLSlVM4AeKXldoR6fUS8Hai+JQgYwrPg
        2QBBX+t04HNILn9qc/EdxqBG274tnAH4QymgfGqCbe7IFuWqYKdd50Y/Ezh8dWnXd8ovju
        186JilA3Uc5LFS120Fs8PIzIDGh7ql4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-wrW-gCq-N1K_H6MS82nJtw-1; Thu, 09 Jan 2020 11:07:05 -0500
X-MC-Unique: wrW-gCq-N1K_H6MS82nJtw-1
Received: by mail-wr1-f69.google.com with SMTP id o6so3039907wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=674vedoaHlOK+sohBzVeKsD1bt4H4p7wzQDNyJHcuUU=;
        b=ZPxv3qG6NP8e0DU6BT6Jygo61Vcqj62KugrojlnQHRmi11xVe/XJ5PEe6QoeQgeusW
         CtsV9Ie5Bik8catuXJ5+i8Yr7y7Af5SjMkBgHL+q0qH9iiKtNNCreA4NjaewxIsk7u6A
         gZHfHyLtY8hWJQGacjAe5u02NRZPJ1Wy+hSBnZU8LlG47tck2NnbROZpe4EsoVgrbnVM
         VapjfFtDg8NpzlyVBFNe9+0zuo7coV22L+bD4jw6+lbg6kx4e+ARQtet0bU3ws+YrJTp
         S+uGP1fewr6wPIBVFix+1tD5w5XPX4P+yoTiNNOOggjjjiVGBA2opchMxJY4gxCtW2UC
         JbAw==
X-Gm-Message-State: APjAAAUtURxYvzzKnNULfi8ClSvhnBBcr0PTBWj5hWGTCl+IWcj3nkRu
        DYU5AXu7Xd1k1UgeP8rAv34ACJxmW14f5IkrQ6FptM1osqFz6AXS1z6zlJpe8iWwT9tkQGCe8iB
        rwITh77GaA5pZDsSNhqp10Zc7
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr5750927wmi.104.1578586023795;
        Thu, 09 Jan 2020 08:07:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYyTRISBUXfTdMjMVF0DyWCzXa8gRzRagckK39rZstNu1/RnqpteCWutzTgpkE45cGgf1BEw==
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr5750895wmi.104.1578586023548;
        Thu, 09 Jan 2020 08:07:03 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id q3sm9123252wrn.33.2020.01.09.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:03 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 33/57] objtool: arm64: Decode FP/SIMD load/store instructions
Date:   Thu,  9 Jan 2020 16:02:36 +0000
Message-Id: <20200109160300.26150-34-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store instruction acting on floating point and SIMD
registers.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 301 ++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  12 +
 2 files changed, 313 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 2aaac4e3786c..7d480efe0bc2 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -810,6 +810,26 @@ int arm_decode_br_uncond_reg(u32 instr, enum insn_type *type,
 #undef INSN_DRPS_MASK
 
 static struct aarch64_insn_decoder ld_st_decoder[] = {
+	{
+		.mask = 0b101111111111100,
+		.value = 0b000010000000000,
+		.decode_func = arm_decode_adv_simd_mult,
+	},
+	{
+		.mask = 0b101111110000000,
+		.value = 0b000010100000000,
+		.decode_func = arm_decode_adv_simd_mult_post,
+	},
+	{
+		.mask = 0b101111101111100,
+		.value = 0b000011000000000,
+		.decode_func = arm_decode_adv_simd_single,
+	},
+	{
+		.mask = 0b101111100000000,
+		.value = 0b000011100000000,
+		.decode_func = arm_decode_adv_simd_single_post,
+	},
 	{
 		.mask = 0b001101100000000,
 		.value = 0b001000000000000,
@@ -889,6 +909,287 @@ int arm_decode_ld_st(u32 instr, enum insn_type *type,
 	return arm_decode_unknown(instr, type, immediate, ops_list);
 }
 
+static int adv_simd_mult_fields[] = {
+	0b00000,
+	0b00010,
+	0b00100,
+	0b00110,
+	0b00111,
+	0b01000,
+	0b01010,
+	0b10000,
+	0b10010,
+	0b10100,
+	0b10110,
+	0b10111,
+	0b11000,
+	0b11010,
+};
+
+int arm_decode_adv_simd_mult(u32 instr, enum insn_type *type,
+			     unsigned long *immediate,
+			     struct list_head *ops_list)
+{
+	unsigned char L = 0, opcode = 0, rn = 0;
+	unsigned char decode_field = 0;
+	int i = 0;
+
+	L = EXTRACT_BIT(instr, 22);
+	opcode = (instr >> 12) & ONES(4);
+
+	decode_field = (L << 4) | opcode;
+	rn = (instr >> 5) & ONES(5);
+	*type = INSN_OTHER;
+
+	for (i = 0; i < ARRAY_SIZE(adv_simd_mult_fields); i++) {
+		if ((decode_field & 0b11111) == adv_simd_mult_fields[i]) {
+			if (!stack_related_reg(rn))
+				return 0;
+		}
+	}
+
+	return arm_decode_unknown(instr, type, immediate, ops_list);
+}
+
+int arm_decode_adv_simd_mult_post(u32 instr, enum insn_type *type,
+				  unsigned long *immediate,
+				  struct list_head *ops_list)
+{
+	/* same opcode as for the no offset variant */
+	int ret = 0;
+
+	ret = arm_decode_adv_simd_mult(instr, type, immediate, ops_list);
+
+	/* TODO: Create stack_op for post increment with immediate */
+	return ret;
+}
+
+static struct aarch64_insn_decoder simd_single_decoder[] = {
+	{
+		.mask = 0b11111000,
+		.value = 0b00000000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111000,
+		.value = 0b00001000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b00010000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b00011000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b00100000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b00100001,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b00101000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b00101001,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111000,
+		.value = 0b01000000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111000,
+		.value = 0b01001000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b01010000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b01011000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b01100000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b01100001,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b01101000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b01101001,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111000,
+		.value = 0b10000000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111000,
+		.value = 0b10001000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b10010000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b10011000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b10100000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b10100001,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b10101000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b10101001,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111100,
+		.value = 0b10110000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111100,
+		.value = 0b10111000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11000000,
+		.value = 0b11111000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111000,
+		.value = 0b11001000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b11010000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b11011000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b11100000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b11100001,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b11101000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b11101001,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111100,
+		.value = 0b11110000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b11111100,
+		.value = 0b11111000,
+		.decode_func = NULL,
+	},
+};
+
+int arm_decode_adv_simd_single(u32 instr, enum insn_type *type,
+			       unsigned long *immediate,
+			       struct list_head *ops_list)
+{
+	unsigned char L = 0, R = 0, S = 0, opcode = 0, size = 0;
+	unsigned char rn = 0, dfield = 0;
+	int i = 0;
+
+	L = EXTRACT_BIT(instr, 22);
+	R = EXTRACT_BIT(instr, 21);
+	S = EXTRACT_BIT(instr, 12);
+	opcode = (instr >> 13) & ONES(3);
+	size = (instr >> 10) & ONES(2);
+
+	dfield = (L << 7) | (R << 6) | (opcode << 3) | (S << 2) | size;
+
+	*type = INSN_OTHER;
+	rn = (instr << 5) & ONES(5);
+
+	for (i = 0; i < ARRAY_SIZE(simd_single_decoder); i++) {
+		if ((dfield & simd_single_decoder[i].mask) ==
+		    simd_single_decoder[i].value) {
+			if (!stack_related_reg(rn))
+				return 0;
+		}
+	}
+
+	return arm_decode_unknown(instr, type, immediate, ops_list);
+}
+
+int arm_decode_adv_simd_single_post(u32 instr, enum insn_type *type,
+				    unsigned long *immediate,
+				    struct list_head *ops_list)
+{
+	/* same opcode as for the no offset variant */
+	int ret = 0;
+
+	ret = arm_decode_adv_simd_single(instr, type, immediate, ops_list);
+
+	/* TODO: Create stack_op for post increment with immediate */
+	return ret;
+}
+
 int arm_decode_ld_st_regs_unsc_imm(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list)
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index caeb40942b18..7fd333f88612 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -94,6 +94,18 @@ int arm_decode_br_uncond_reg(u32 instr, enum insn_type *type,
 			     struct list_head *ops_list);
 
 /* arm64 load/store instructions */
+int arm_decode_adv_simd_mult(u32 instr, enum insn_type *type,
+			     unsigned long *immediate,
+			     struct list_head *ops_list);
+int arm_decode_adv_simd_mult_post(u32 instr, enum insn_type *type,
+				  unsigned long *immediate,
+				  struct list_head *ops_list);
+int arm_decode_adv_simd_single(u32 instr, enum insn_type *type,
+			       unsigned long *immediate,
+			       struct list_head *ops_list);
+int arm_decode_adv_simd_single_post(u32 instr, enum insn_type *type,
+				    unsigned long *immediate,
+				    struct list_head *ops_list);
 int arm_decode_ld_st_noalloc_pair_off(u32 instr, enum insn_type *type,
 				      unsigned long *immediate,
 				      struct list_head *ops_list);
-- 
2.21.0

