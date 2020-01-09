Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5696C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA020721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4j0nOJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbgAIQGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:06:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51258 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733066AbgAIQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J63NkwzczmrLcPGsOIe2c0tfTD5HWt1z/wmViklA3es=;
        b=K4j0nOJIo3qp8fRuAl+OLewuNHP3XYDJj7Nd29Il3NsOfmcFB49f+D1nwAQ2OSB6N+HIum
        CQwywqzzQY9Sbhdk6+lsquXT4HiNbjvmYo4AxXAw2JM00HGC2uW3W2RF3vpYNYHnfPb+Qc
        xbkHkd37KjLYiQcftHAfIp2t7LLfA+Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-quW1xYavOACKSCfkE3GPOg-1; Thu, 09 Jan 2020 11:06:28 -0500
X-MC-Unique: quW1xYavOACKSCfkE3GPOg-1
Received: by mail-wr1-f69.google.com with SMTP id c17so3036571wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J63NkwzczmrLcPGsOIe2c0tfTD5HWt1z/wmViklA3es=;
        b=o3m4etEPzvbAwCUWIy7q740SON7FKdUuaIEdrVjXdQ1V5HNuOonRFbza9dadXKQv2U
         2KAOwZbDzqy8YSbgNpZRSimIph4AhVbj6sH/CTd1EEhtLIHjNbwtruAb/82Ztsr8dWNi
         WJUr2nqqFwePin6w0k1/RAbWwTcdPmMeV4Ua+3dcUpp7st9JB0+6c1FKVvU28JmajNve
         CSyv7vYg8jNgeAfpDp4gnFUtfrPJPFYu3wk+7sbuG+Tdm+hrAHZkhg1fQ5F56NsmuakQ
         GSHtB6PzMQItcK+3m15PTMam5ytc+VVP0lnbggZwggWkPXA9oZ+8L9nXPVPUzw7Vr8i3
         L1Aw==
X-Gm-Message-State: APjAAAVZ8gYqw1aL/cWh/AwKDpaoIWD6/TreK1DP1D7aV0KN0DzI+rOH
        rzLHgxuoMouER53c+WrOO4NOc65skreTKk9IfQK5sx2VkYg481QSkdH3+VTQrTvqGoYlTlkvqXY
        ySWPMSjAaIeqv4tC+ukVlx/Lt
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr11380320wrv.144.1578585985409;
        Thu, 09 Jan 2020 08:06:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxG3LuVTogmg7FJSWlNc329KhrNkP0B6SiHOu3F08s0s+2V12EeNGQmM0ARlcnccvAJXUA4Ew==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr11380293wrv.144.1578585985185;
        Thu, 09 Jan 2020 08:06:25 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e18sm8643101wrr.95.2020.01.09.08.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:06:24 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 28/57] objtool: arm64: Decode branch instructions with PC relative immediates
Date:   Thu,  9 Jan 2020 16:02:31 +0000
Message-Id: <20200109160300.26150-29-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode instructions that cause a jump in the execution flow, adding
an immediate value to the current instruction counter.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 79 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  | 11 +++
 2 files changed, 90 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 5eba83c5d5bc..7986ded8b622 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -424,6 +424,26 @@ static struct aarch64_insn_decoder br_sys_decoder[] = {
 		.value = 0b1100000000000000000000,
 		.decode_func = arm_decode_except_gen,
 	},
+	{
+		.mask = 0b1111000000000000000000,
+		.value = 0b0100000000000000000000,
+		.decode_func = arm_decode_br_cond_imm,
+	},
+	{
+		.mask = 0b0110000000000000000000,
+		.value = 0b0000000000000000000000,
+		.decode_func = arm_decode_br_uncond_imm,
+	},
+	{
+		.mask = 0b0111000000000000000000,
+		.value = 0b0010000000000000000000,
+		.decode_func = arm_decode_br_comp_imm,
+	},
+	{
+		.mask = 0b0111000000000000000000,
+		.value = 0b0011000000000000000000,
+		.decode_func = arm_decode_br_tst_imm,
+	},
 };
 
 int arm_decode_br_sys(u32 instr, enum insn_type *type,
@@ -575,3 +595,62 @@ int arm_decode_except_gen(u32 instr, enum insn_type *type,
 #undef INSN_DCPS2
 #undef INSN_DCPS3
 }
+
+int arm_decode_br_cond_imm(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char o0 = 0, o1 = 0;
+	u32 imm19;
+
+	o0 = EXTRACT_BIT(instr, 4);
+	o1 = EXTRACT_BIT(instr, 24);
+	imm19 = (instr >> 5) & ONES(19);
+
+	*immediate = SIGN_EXTEND(imm19 << 2, 19);
+
+	if ((o1 << 1) | o0)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_JUMP_CONDITIONAL;
+
+	return 0;
+}
+
+int arm_decode_br_uncond_imm(u32 instr, enum insn_type *type,
+			     unsigned long *immediate,
+			     struct list_head *ops_list)
+{
+	unsigned char decode_field = 0;
+	u32 imm26 = 0;
+
+	decode_field = EXTRACT_BIT(instr, 31);
+	imm26 = instr & ONES(26);
+
+	*immediate = SIGN_EXTEND(imm26 << 2, 28);
+	if (decode_field == 0)
+		*type = INSN_JUMP_UNCONDITIONAL;
+	else
+		*type = INSN_CALL;
+
+	return 0;
+}
+
+int arm_decode_br_comp_imm(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	u32 imm19 = (instr >> 5) & ONES(19);
+
+	*immediate = SIGN_EXTEND(imm19 << 2, 21);
+	*type = INSN_JUMP_CONDITIONAL;
+	return 0;
+}
+
+int arm_decode_br_tst_imm(u32 instr, enum insn_type *type,
+			  unsigned long *immediate, struct list_head *ops_list)
+{
+	u32 imm14 = (instr >> 5) & ONES(14);
+
+	*immediate = SIGN_EXTEND(imm14 << 2, 16);
+	*type = INSN_JUMP_CONDITIONAL;
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index a55dcbfcfed2..ceb80a58c548 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -72,4 +72,15 @@ int arm_decode_system_regs(u32 instr, enum insn_type *type,
 			   struct list_head *ops_list);
 int arm_decode_except_gen(u32 instr, enum insn_type *type,
 			  unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_br_uncond_imm(u32 instr, enum insn_type *type,
+			     unsigned long *immediate,
+			     struct list_head *ops_list);
+int arm_decode_br_comp_imm(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_br_tst_imm(u32 instr, enum insn_type *type,
+			  unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_br_cond_imm(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

