Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAAFC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD0520661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLUKQiEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgAIQHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59815 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733192AbgAIQHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSzXbc/iliStE7cNjDlAGjV3g1ZUU8qfPQMgIaRdVVc=;
        b=CLUKQiEMIgY34TU5rC0dMV08SOrM2/aH9whkrRCMdT4kzaHYiSlbBKFx+XarjOflOlmQuF
        cjZFoYloKTyoNKlVKZVCrGfXjQnbYaYburaqNDd1sKxsPvTNnkocPKB88ybIjKLh62qU7P
        KUnDDh+Qd3KY+Oj5zBNxLP5d7mvFzK4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-ECrCcWmKMFqEP7mQlZVHCQ-1; Thu, 09 Jan 2020 11:07:43 -0500
X-MC-Unique: ECrCcWmKMFqEP7mQlZVHCQ-1
Received: by mail-wr1-f71.google.com with SMTP id k18so3064379wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSzXbc/iliStE7cNjDlAGjV3g1ZUU8qfPQMgIaRdVVc=;
        b=CiiTG93gv1y0uGArMw5DNI+jvMSB5l/6hNpJa700pqp7uHzY6tfZSlC8QpJG/KgPcX
         yEmWpD+VHjrHcpX9Ftg1p9pc1Z8buoRo1D+2b5Cy7PzqG2ep1mRU6LExzdWrGLdZPaXz
         bgP8CEzt1NGVlWVPKny/hvKtS/pv3fBUrDU7CiHwqA90/tSLMMZXRCqbtftf+NHue983
         46Em/R7+c09V43bw4fcGTPXO0BBMISzPYPjQ+XUOjuCYRg8wYu/av2mz7Ww4NB1Wt7eF
         kyZSxvaPpR1TWXakiHetZ7uEoyy/x8/Elfx9AB8RTqvPQjAlZKxsBGHwrLC4/42dWTB3
         DQaA==
X-Gm-Message-State: APjAAAV0NSAkVL39tcErQpMJKtFwA4+0+hGbJPRCkr+EVHJ6tBgfc16W
        HUZLvNt7rfmlvn6qW8Y+zKbV+bm57jI3NBPaA+/LH1eTug3L/c+WoqeB0qr0P9+W3HXhTRJoucq
        70AmPz6hL62xcq9UjdpV0+Xu4
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6009341wmk.15.1578586061491;
        Thu, 09 Jan 2020 08:07:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXR+O6Irjgn/GaJkOXCpnf30KgGD1FiNm0sUHMqw1/wbVxO2aGMcymgxoFGZ08UHSYH/a03w==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6009322wmk.15.1578586061280;
        Thu, 09 Jan 2020 08:07:41 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id h2sm8591413wrv.66.2020.01.09.08.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:40 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 38/57] objtool: arm64: Decode load/store with memory tag
Date:   Thu,  9 Jan 2020 16:02:41 +0000
Message-Id: <20200109160300.26150-39-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store instructions provided by the v8.5 memorty tagging
architecture extension.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 87 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  3 +
 2 files changed, 90 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index becc563345dd..bc4c62401012 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -830,6 +830,11 @@ static struct aarch64_insn_decoder ld_st_decoder[] = {
 		.value = 0b000011100000000,
 		.decode_func = arm_decode_adv_simd_single_post,
 	},
+	{
+		.mask = 0b111111010000000,
+		.value = 0b110101010000000,
+		.decode_func = arm_decode_ld_st_mem_tags,
+	},
 	{
 		.mask = 0b001111000000000,
 		.value = 0b000000000000000,
@@ -2100,3 +2105,85 @@ int arm_decode_ldapr_stlr_unsc_imm(u32 instr, enum insn_type *type,
 
 	return 0;
 }
+
+int arm_decode_ld_st_mem_tags(u32 instr, enum insn_type *type,
+			      unsigned long *immediate,
+			      struct list_head *ops_list)
+{
+	u32 imm9 = 0;
+	unsigned char opc = 0, op2 = 0, rn = 0, rt = 0, decode_field = 0;
+	struct stack_op *op;
+
+	imm9 = (instr >> 12) & ONES(9);
+	opc = (instr >> 22) & ONES(2);
+	op2 = (instr >> 10) & ONES(2);
+	rn = (instr >> 5) & ONES(5);
+	rt = instr & ONES(6);
+
+	decode_field = (opc << 2) | op2;
+
+	if (decode_field == 0x0 ||
+	    (decode_field == 0x8 && imm9 != 0) ||
+	    (decode_field == 0xC && imm9 != 0)) {
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
+	/*
+	 * Offset should normally be shifted to the
+	 * left of LOG2_TAG_GRANULE
+	 */
+	switch (decode_field) {
+	case 1:
+	case 5:
+	case 9:
+	case 13:
+		/* post index */
+	case 3:
+	case 7:
+	case 8:
+	case 11:
+	case 15:
+		/* pre index */
+		op->dest.reg = rn;
+		op->dest.type = OP_DEST_PUSH;
+		op->dest.offset = SIGN_EXTEND(imm9, 9);
+		op->src.reg = rt;
+		op->src.type = OP_SRC_REG;
+		op->src.offset = 0;
+		return 0;
+	case 2:
+	case 6:
+	case 10:
+	case 14:
+		/* store */
+		op->dest.reg = rn;
+		op->dest.type = OP_DEST_REG_INDIRECT;
+		op->dest.offset = SIGN_EXTEND(imm9, 9);
+		op->src.reg = rt;
+		op->src.type = OP_SRC_REG;
+		op->src.offset = 0;
+		return 0;
+	case 4:
+	case 12:
+		/* load */
+		op->src.reg = rn;
+		op->src.type = OP_SRC_REG_INDIRECT;
+		op->src.offset = SIGN_EXTEND(imm9, 9);
+		op->dest.reg = rt;
+		op->dest.type = OP_DEST_REG;
+		op->dest.offset = 0;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 1721d9c487d0..e6a62691b487 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -106,6 +106,9 @@ int arm_decode_adv_simd_single(u32 instr, enum insn_type *type,
 int arm_decode_adv_simd_single_post(u32 instr, enum insn_type *type,
 				    unsigned long *immediate,
 				    struct list_head *ops_list);
+int arm_decode_ld_st_mem_tags(u32 instr, enum insn_type *type,
+			      unsigned long *immediate,
+			      struct list_head *ops_list);
 int arm_decode_ldapr_stlr_unsc_imm(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list);
-- 
2.21.0

