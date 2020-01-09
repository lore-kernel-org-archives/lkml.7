Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470B5C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD0F20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhDXS2oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbgAIQHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49716 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733186AbgAIQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gehBuZsWTyS5GusQuL5RiDnS9qnv2i+e7pvi+x7gJHA=;
        b=fhDXS2oRYYURVgdLlmbss/BwRfKDNUlAndPhM68J14fzpstbwZOzJq7ITvY3WnkGgVwGij
        qXzq6f3X4+T/Uy5B7MDyfYjHZEJamXRqlw6JuFpgS7jmuwyAW+Lea5yOd6aryWW8EuujgP
        EGVckZd9xhGRioBTtX9tLeSNtRCYOc4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-ete4zU1DMBiGio49jimQsg-1; Thu, 09 Jan 2020 11:07:39 -0500
X-MC-Unique: ete4zU1DMBiGio49jimQsg-1
Received: by mail-wr1-f70.google.com with SMTP id t3so3023156wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gehBuZsWTyS5GusQuL5RiDnS9qnv2i+e7pvi+x7gJHA=;
        b=H+O9XUEVAqrAk3Pg3PbCZzh+XdDgL/+jPDbko4FuM093oR/HmhqxbLhmAkgtL74+16
         WhzV5M5cfTZn4fuoElNtXzHu8OwjMghlHYnHmYJdNhoP7H3adXQZGfXPIrQgezQ4ol8F
         4k4QK/jHewfdZfhPbQNAE+TAH+qCiSEvgm+WwPWH87o7U3AG+7zrIl3Hla+Og9svPmaO
         c9AvZgnzmAbrxKgi8CwwdusEq4d5cculprBZhth84nuOY31BNN/QovOQUxxQjAloWFP/
         JCSnpZoTqSDBc2met1K4AEHQaa4Jo8kzLiJ1q7fshQigX/PXxeLp2pUWgrHFD2VHayrW
         NBeA==
X-Gm-Message-State: APjAAAWI+lih9EzS3PBYoODECwpW7h7Mnudx5PqyHHU2enAUtvQXYlQV
        YAffl4S/E6wd72Uz6pVlPU/izGKj6VMBcX2fEFJZ2awPtBqeStW7YkSDpRPjjDBUdEMBceIVw6w
        xMiOxW7ag2+jHcDqgJpLPxLNn
X-Received: by 2002:a1c:f001:: with SMTP id a1mr5483530wmb.76.1578586058540;
        Thu, 09 Jan 2020 08:07:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjD64xWcH+OF87TPinIqmOaTnoguN09GymLeZun31rI/KZftrppzQP03Apb2IWiqX3F1kkTA==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr5483512wmb.76.1578586058385;
        Thu, 09 Jan 2020 08:07:38 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id h2sm8591413wrv.66.2020.01.09.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:37 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 36/57] objtool: arm64: Decode pointer auth load instructions
Date:   Thu,  9 Jan 2020 16:02:39 +0000
Message-Id: <20200109160300.26150-37-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store instruction provided by the v8.3 pointer
authentication architecture extension.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 51 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  3 ++
 2 files changed, 54 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 1897f62987fa..0bbbacd74e48 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -885,6 +885,11 @@ static struct aarch64_insn_decoder ld_st_decoder[] = {
 		.value = 0b001100010000010,
 		.decode_func = arm_decode_ld_st_regs_off,
 	},
+	{
+		.mask = 0b001101010000001,
+		.value = 0b001100010000001,
+		.decode_func = arm_decode_ld_st_regs_pac,
+	},
 	{
 		.mask = 0b001101000000000,
 		.value = 0b001101000000000,
@@ -1981,3 +1986,49 @@ int arm_decode_ld_st_regs_pair_pre(u32 instr, enum insn_type *type,
 
 	return 0;
 }
+
+int arm_decode_ld_st_regs_pac(u32 instr, enum insn_type *type,
+			      unsigned long *immediate,
+			      struct list_head *ops_list)
+{
+	unsigned char size = 0, V = 0, W = 0, S = 0;
+	unsigned char rn = 0, rt = 0;
+	struct stack_op *op;
+	u32 imm9 = 0, s10 = 0;
+
+	size = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	W = EXTRACT_BIT(instr, 11);
+
+	if (size != 3 || V == 1)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	rn = (instr >> 5) & ONES(5);
+
+	if (!stack_related_reg(rn)) {
+		*type = INSN_OTHER;
+		return 0;
+	}
+
+	S = EXTRACT_BIT(instr, 22);
+	s10 = (S << 9) | imm9;
+
+	*type = INSN_STACK;
+
+	op = calloc(1, sizeof(*op));
+	list_add_tail(&op->list, ops_list);
+
+	op->dest.reg = rt;
+	op->dest.type = OP_DEST_REG;
+	op->dest.offset = 0;
+	op->src.offset = (SIGN_EXTEND(s10, 9) << 3);
+	if (W) { /* pre-indexed/writeback */
+		op->src.type = OP_SRC_POP;
+		op->src.reg = rn;
+	} else {
+		op->src.type = OP_SRC_REG_INDIRECT;
+		op->src.reg = rn;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 89488c5df5e9..d819d2e795a3 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -135,6 +135,9 @@ int arm_decode_atomic(u32 instr, enum insn_type *type,
 int arm_decode_ld_st_regs_off(u32 instr, enum insn_type *type,
 			      unsigned long *immediate,
 			      struct list_head *ops_list);
+int arm_decode_ld_st_regs_pac(u32 instr, enum insn_type *type,
+			      unsigned long *immediate,
+			      struct list_head *ops_list);
 int arm_decode_ld_st_regs_unsigned(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list);
-- 
2.21.0

