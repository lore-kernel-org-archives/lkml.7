Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51517C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2263A20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbdDQZVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbgAIQIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:08:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21935 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731574AbgAIQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctt7fi/3NhIYPlxgrIxpO4KG6ezkTHoGLojp3YwAvJc=;
        b=HbdDQZVfhHR81h5rFMvuXqr8ewwlyaYRUsD09OHckDXF8gmr+vU2Xl97dLBOIxQml6cVBR
        vgyfJP3mFLeHl3XU+ARhdqQOpNLpQ62mixYeuNWQUbzMufHRIyzRJBU7TexAYSqADfTy7D
        5ONsPhOyyAjNSEW4TZr8YU83qoVEt5c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-AtJuAxOpONmDCTGP044ajw-1; Thu, 09 Jan 2020 11:08:19 -0500
X-MC-Unique: AtJuAxOpONmDCTGP044ajw-1
Received: by mail-wm1-f71.google.com with SMTP id c4so1095699wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctt7fi/3NhIYPlxgrIxpO4KG6ezkTHoGLojp3YwAvJc=;
        b=YKTYbzvQUf4Ss1P2e9Dd6vTtVBS87Oqv0yfrRcQwtI3AWsCspHn/GlKDvmgy6LeU2z
         AtOu0skMA62Fz2g0TE3ewKUGqHBh6RTr8kxL5EL2xLkdeV7gtDKkbcxkQsFiV/w9opQ4
         nrKJz0IZ1OnyHZn8No/BCZxgA3wCutqXGrm7DbZpdnowznejVAR3nYqNxYQ3kAn7Xfti
         RztUGIDnS5ZVXMxTlrC7gOrwxPNSH0yv6ivCgY6xb7iz/bV1ELHj9ZsarlcrwMHZRdoO
         3YM/uX4/hCrG0fiGtc6EkUoOPIn6p3mQMibyPgYti6d1MY53oCZiATvwJo4HzhKBTtOW
         xAfQ==
X-Gm-Message-State: APjAAAXIVeGlJNDEjhuAINo8Q3OxYHA5Yo8oY0++oxXfyhs+CDFlMjcW
        EXPQ2gQbgFLzHgzHrv7dgdrtab15UQ0D1aP9T2n0OJLlQFcdrR9j+G0whXdzPE9MZyWbyTtRqnH
        siILpZlVjwaRxr3YxFizmLonE
X-Received: by 2002:a05:600c:2488:: with SMTP id 8mr5704794wms.152.1578586097769;
        Thu, 09 Jan 2020 08:08:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjzv/MBj0UUOLxwAZL7QjHdlmjkQxcm6p51hFdYJfwpTI9BGX+m6/4LY2WFg1fDeMR4LNnNQ==
X-Received: by 2002:a05:600c:2488:: with SMTP id 8mr5704783wms.152.1578586097594;
        Thu, 09 Jan 2020 08:08:17 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m10sm8562605wrx.19.2020.01.09.08.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:16 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 41/57] objtool: arm64: Decode FP/SIMD data processing instructions
Date:   Thu,  9 Jan 2020 16:02:44 +0000
Message-Id: <20200109160300.26150-42-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FP/SIMD data processing instructions cannot modify the stack or frame
pointer.

Simply acknowledge the corresponding opcodes are valid.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c              | 9 +++++++++
 tools/objtool/arch/arm64/include/insn_decode.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index bb1ba3b0997f..d35c2b58d309 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -130,11 +130,13 @@ static arm_decode_class aarch64_insn_class_decode_table[NR_INSN_CLASS] = {
 	[INSN_LD_ST_4]			= arm_decode_ld_st,
 	[INSN_DP_REG_5]			= arm_decode_dp_reg,
 	[INSN_LD_ST_6]			= arm_decode_ld_st,
+	[INSN_DP_SIMD_7]		= arm_decode_dp_simd,
 	[0b1000 ... INSN_DP_IMM]	= arm_decode_dp_imm,
 	[0b1010 ... INSN_SYS_BRANCH]	= arm_decode_br_sys,
 	[INSN_LD_ST_C]			= arm_decode_ld_st,
 	[INSN_DP_REG_D]			= arm_decode_dp_reg,
 	[INSN_LD_ST_E]			= arm_decode_ld_st,
+	[INSN_DP_SIMD_F]		= arm_decode_dp_simd,
 };
 
 /*
@@ -2746,3 +2748,10 @@ int arm_decode_dp_reg_3src(u32 instr, enum insn_type *type,
 	*type = INSN_OTHER;
 	return 0;
 }
+
+int arm_decode_dp_simd(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list)
+{
+	*type = INSN_OTHER;
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 8fb2f2b7564f..2bff4d7da007 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -16,6 +16,8 @@
 #define INSN_LD_ST_E	0b1110	//0bx1x0
 #define INSN_DP_REG_5	0b0101	//0bx101
 #define INSN_DP_REG_D	0b1101	//0bx101
+#define INSN_DP_SIMD_7	0b0111	//0bx111
+#define INSN_DP_SIMD_F	0b1111	//0bx111
 
 #define NR_INSN_CLASS	16
 #define INSN_CLASS(opcode)	(((opcode) >> 25) & (NR_INSN_CLASS - 1))
@@ -47,6 +49,8 @@ int arm_decode_br_sys(u32 instr, enum insn_type *type,
 		      unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_ld_st(u32 instr, enum insn_type *type,
 		     unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_dp_simd(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_unknown(u32 instr, enum insn_type *type,
 		       unsigned long *immediate, struct list_head *ops_list);
 
-- 
2.21.0

