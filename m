Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1FCC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B3F2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaOTU52C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbgAIQHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60436 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733175AbgAIQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V80sKnfPgpuJ2PN6PlqMSnAckHTRWhZvUDB6P0wLWgc=;
        b=FaOTU52C15TiFR108zY1GEeUiAaWnmXt0qDEUp6GYzfWCTD4LzjukO4LYySLeUhOa2+bRy
        JxJA5ahj1i0ThjajltmMqAcFPYGL+i1D5rjRw6tl9PO6m8JNbJeVIRUl+sSjcpaqnaRAVm
        8BDGi9JDvN1moqiRdcWjY4w25IYE0/k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-kft19r4nOCKqCi6v_TGSSA-1; Thu, 09 Jan 2020 11:07:38 -0500
X-MC-Unique: kft19r4nOCKqCi6v_TGSSA-1
Received: by mail-wr1-f71.google.com with SMTP id d8so3036829wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V80sKnfPgpuJ2PN6PlqMSnAckHTRWhZvUDB6P0wLWgc=;
        b=IitlDNCD/LdCDJgmWOeEN5J+OVIBcqEc+rrrJUMVvDLKOlGYyZQhDnHiDnGY3RxiPo
         N+bcix1/c6SKSdDDn8hwXhD4eUlg5ItC0XVrPnJ/mfDoJT78IHQ8XOke9o1S5h18jf+9
         baOOLIt2UV1PraM7pZNUJWaGiMnOLuOu0MM6LejXNeP0GGWbsMOYM/hAm3aN4QyMCwFJ
         ndZ1YX49lKo4O0SSZ5ohwFluzGGfgTY57DJoxMnRxQQKFdxRwNXTfZudsuH6M/1MUDX0
         ARsQgNqLzHE3BSOx2fAtxcMUd35A283yU4zcMgthbjQbGjA3C8K6NiU2Xw81VNGbADEp
         9d8g==
X-Gm-Message-State: APjAAAU5bo+XeJDCM3qoymQRWOiE4EOEtCBOX1O2HSzfr7mKsCHHogc6
        KJ9t8SKDU1OHS3woy8pm3SGup21k29ClO7/7xIEdONz41gHqdm4zRTfVtxVynA8Qj0FIzAphnqS
        pjtmv9azx4lwmuUc9dXANAD0V
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr5972344wmd.112.1578586057204;
        Thu, 09 Jan 2020 08:07:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwc4TaEWjCmUkmfkOmwGRLIgB1O+Rz/bvnkIEzkSOYGeyv8HJLRBacELGQ/7+dBBu8TEZebjw==
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr5972312wmd.112.1578586057002;
        Thu, 09 Jan 2020 08:07:37 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id h2sm8591413wrv.66.2020.01.09.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:36 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 35/57] objtool: arm64: Decode atomic load/store
Date:   Thu,  9 Jan 2020 16:02:38 +0000
Message-Id: <20200109160300.26150-36-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode v8.1 atomic load/store instructions.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 86 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  2 +
 2 files changed, 88 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index e3f77d68b282..1897f62987fa 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -875,6 +875,11 @@ static struct aarch64_insn_decoder ld_st_decoder[] = {
 		.value = 0b001100000000011,
 		.decode_func = arm_decode_ld_st_imm_pre,
 	},
+	{
+		.mask = 0b001101010000011,
+		.value = 0b001100010000000,
+		.decode_func = arm_decode_atomic,
+	},
 	{
 		.mask = 0b001101010000011,
 		.value = 0b001100010000010,
@@ -1667,6 +1672,87 @@ int arm_decode_ld_st_imm_unpriv(u32 instr, enum insn_type *type,
 	return 0;
 }
 
+static struct aarch64_insn_decoder atom_unallocs_decoder[] = {
+	{
+		.mask = 0b1001111,
+		.value = 0b0001001,
+	},
+	{
+		.mask = 0b1001110,
+		.value = 0b0001010,
+	},
+	{
+		.mask = 0b1001111,
+		.value = 0b0001101,
+	},
+	{
+		.mask = 0b1001110,
+		.value = 0b0001110,
+	},
+	{
+		.mask = 0b1101111,
+		.value = 0b0001100,
+	},
+	{
+		.mask = 0b1111111,
+		.value = 0b0111100,
+	},
+	{
+		.mask = 0b1000000,
+		.value = 0b1000000,
+	},
+};
+
+int arm_decode_atomic(u32 instr, enum insn_type *type,
+		      unsigned long *immediate,
+		      struct list_head *ops_list)
+{
+	unsigned char V = 0, A = 0, R = 0, o3 = 0, opc = 0;
+	unsigned char rn = 0, rt = 0;
+	unsigned char decode_field = 0;
+	struct stack_op *op;
+	int i = 0;
+
+	V = EXTRACT_BIT(instr, 26);
+	A = EXTRACT_BIT(instr, 23);
+	R = EXTRACT_BIT(instr, 22);
+	o3 = EXTRACT_BIT(instr, 15);
+	opc = (instr >> 12) & ONES(3);
+
+	decode_field = (V << 6) | (A << 5) | (R << 4) | (o3 << 3) | opc;
+
+	for (i = 0; i < ARRAY_SIZE(atom_unallocs_decoder); i++) {
+		if ((decode_field & atom_unallocs_decoder[i].mask) ==
+		    atom_unallocs_decoder[i].value) {
+			return arm_decode_unknown(instr,
+						  type,
+						  immediate,
+						  ops_list);
+		}
+	}
+
+	rn = (instr >> 5) & ONES(5);
+	rt = instr & ONES(5);
+
+	if (!stack_related_reg(rn)) {
+		*type = INSN_OTHER;
+		return 0;
+	}
+	*type = INSN_STACK;
+
+	op = calloc(1, sizeof(*op));
+	list_add_tail(&op->list, ops_list);
+
+	op->src.reg = rn;
+	op->src.type = OP_DEST_REG_INDIRECT;
+	op->src.offset = 0;
+	op->dest.type = OP_DEST_REG;
+	op->dest.reg = rt;
+	op->dest.offset = 0;
+
+	return 0;
+}
+
 int arm_decode_ld_st_regs_off(u32 instr, enum insn_type *type,
 			      unsigned long *immediate,
 			      struct list_head *ops_list)
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 61152b4aa42a..89488c5df5e9 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -130,6 +130,8 @@ int arm_decode_ld_st_imm_unpriv(u32 instr, enum insn_type *type,
 int arm_decode_ld_st_imm_pre(u32 instr, enum insn_type *type,
 			     unsigned long *immediate,
 			     struct list_head *ops_list);
+int arm_decode_atomic(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_ld_st_regs_off(u32 instr, enum insn_type *type,
 			      unsigned long *immediate,
 			      struct list_head *ops_list);
-- 
2.21.0

