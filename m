Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E787C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EEA2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CShM5qhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbgAIQHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48927 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733185AbgAIQHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MXSkudn70UtEbMzCHfdquKWnGc9F4q7hjxMMx1IdM8=;
        b=CShM5qhWDv4fjOvzDZXcm36Owsv2bC89vqMJYVrCBAHMqF/nArpV0Qa0SCCCa8yn63ztpI
        PUtB4PmwVnoaG82aBap9LjSzk723Th+Hj79/RUVUgnmLB6ooLeo8hG9PR04k5PtLoT8Gto
        r/fYab2F2cUhZJ8nxX4yIr4cI132LYg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-SE8psibPO9O46Lmu0mPugA-1; Thu, 09 Jan 2020 11:07:41 -0500
X-MC-Unique: SE8psibPO9O46Lmu0mPugA-1
Received: by mail-wm1-f70.google.com with SMTP id q26so619992wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MXSkudn70UtEbMzCHfdquKWnGc9F4q7hjxMMx1IdM8=;
        b=USqt5jnTmx9Hvcvjv68h2iVYHLiVuRUa9vF/CgpLFleG7ix6lL2fqQpeWyjpCxfru/
         nIO3RH37JmjK947/x/15PvDl25ah8cnkIrsMVdhbMjTNoklXK2qgYKo+g4eO4YkBL8ax
         IRJdg33t6Tx0l+5t4dhpdqUoglBomPiKCDkjYwXle6SBqSSvoIsmZceMf0c0mm9dvJIX
         vH0AKf6oPzFZG1tbj3zESsMJsbPV/ulEpA+GJ0IUfAYQNPPMWmOziCOJLO20o84PYbxv
         GMFZi+i1LPs+PRxEhvA9GO/cB1Yrr7/HuaAMKyMSGg3i0169T32kk4IiePqpjBiyMqVi
         oq4A==
X-Gm-Message-State: APjAAAUlWTOz2ae9MrbpBFrYLPPm+rxv4+My6QKIgJvyQ5/HjcL44sj4
        V0D/DjND3iJ5NoQd7rtyM65o9s3o/bWNkNtvKioPmPG6d+PjNKYM3K1VqqyW2UGf6qyLcVyOVsH
        7z2Y0vUq8oLEOP6XULD3xp6ro
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr5326759wmc.145.1578586059940;
        Thu, 09 Jan 2020 08:07:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwO98wUDEIRDRIYLKdIbYyjOEf2GJMH63VpDj9P6FrGkNnf7bEr0cdtCq9CGHTRBKqwcrGGfw==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr5326736wmc.145.1578586059741;
        Thu, 09 Jan 2020 08:07:39 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id h2sm8591413wrv.66.2020.01.09.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:39 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 37/57] objtool: arm64: Decode load acquire/store release
Date:   Thu,  9 Jan 2020 16:02:40 +0000
Message-Id: <20200109160300.26150-38-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store instructions provided by the v8.4 RCPC architecture
extension.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 68 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  3 +
 2 files changed, 71 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 0bbbacd74e48..becc563345dd 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -835,6 +835,11 @@ static struct aarch64_insn_decoder ld_st_decoder[] = {
 		.value = 0b000000000000000,
 		.decode_func = arm_decode_ld_st_exclusive,
 	},
+	{
+		.mask = 0b001111010000011,
+		.value = 0b000101000000000,
+		.decode_func = arm_decode_ldapr_stlr_unsc_imm,
+	},
 	{
 		.mask = 0b001101100000000,
 		.value = 0b001000000000000,
@@ -2032,3 +2037,66 @@ int arm_decode_ld_st_regs_pac(u32 instr, enum insn_type *type,
 
 	return 0;
 }
+
+int arm_decode_ldapr_stlr_unsc_imm(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list)
+{
+	u32 imm9 = 0;
+	unsigned char size = 0, opc = 0, rn = 0, rt = 0, decode_field = 0;
+	struct stack_op *op;
+
+	imm9 = (instr >> 12) & ONES(9);
+	size = (instr >> 30) & ONES(2);
+	opc = (instr >> 22) & ONES(2);
+	rn = (instr >> 5) & ONES(5);
+	rt = instr & ONES(5);
+
+	decode_field = (size << 2) | opc;
+	if (decode_field == 0xB ||
+	    decode_field == 0xE ||
+	    decode_field == 0xF) {
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+	}
+
+	if (!stack_related_reg(rn)) {
+		*type = INSN_OTHER;
+		return 0;
+	}
+	*type = INSN_STACK;
+	*immediate = imm9;
+
+	op = calloc(1, sizeof(*op));
+	list_add_tail(&op->list, ops_list);
+
+	switch (decode_field) {
+	case 1:
+	case 2:
+	case 3:
+	case 5:
+	case 6:
+	case 7:
+	case 9:
+	case 10:
+	case 13:
+		/* load */
+		op->src.type = OP_SRC_REG_INDIRECT;
+		op->src.reg = rn;
+		op->src.offset = SIGN_EXTEND(imm9, 9);
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = rt;
+		op->dest.offset = 0;
+		break;
+	default:
+		/* store */
+		op->dest.type = OP_SRC_REG_INDIRECT;
+		op->dest.reg = rn;
+		op->dest.offset = SIGN_EXTEND(imm9, 9);
+		op->src.type = OP_SRC_REG;
+		op->src.reg = rt;
+		op->src.offset = 0;
+		break;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index d819d2e795a3..1721d9c487d0 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -106,6 +106,9 @@ int arm_decode_adv_simd_single(u32 instr, enum insn_type *type,
 int arm_decode_adv_simd_single_post(u32 instr, enum insn_type *type,
 				    unsigned long *immediate,
 				    struct list_head *ops_list);
+int arm_decode_ldapr_stlr_unsc_imm(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list);
 int arm_decode_ld_st_noalloc_pair_off(u32 instr, enum insn_type *type,
 				      unsigned long *immediate,
 				      struct list_head *ops_list);
-- 
2.21.0

