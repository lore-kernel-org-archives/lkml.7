Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B9C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4E206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N89t4tjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbgAIQFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728584AbgAIQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AHYV2UMb6QFH2KrZdQF90S4dwnJAUXmqxV2bgFAoj4=;
        b=N89t4tjXjOxRl7daN2LnYJirp32GTCBLzQ7cgfoZ5OZkhiaq91acRleE7zp/yJiZpLOWg/
        mINEvVU5wy0SaAGWrMn0jE1VpiDxKcN6jV6oOAOG+tMT915NlSOJiQ0EOyIiXHiCXVJMum
        4iyLB6cxIhlp7Q35dqEQ4NZjqBJ9Fh8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-NkQLUOjOM22M4QRIHq31tA-1; Thu, 09 Jan 2020 11:05:47 -0500
X-MC-Unique: NkQLUOjOM22M4QRIHq31tA-1
Received: by mail-wm1-f72.google.com with SMTP id t4so1102144wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5AHYV2UMb6QFH2KrZdQF90S4dwnJAUXmqxV2bgFAoj4=;
        b=Qv/G3JBn2BWuSvcx35ciQs5WDGZrEkBlbUGUq2BDGm3emQu8sOhVNAEpL1J1EYIISJ
         1qXhjJvSNJTfM4xWrNjWnNojR5b+i1aOp+r1CDTAFXeBOObGep0W1jGDyXvqc8J6sqIm
         lYpItXdYFA21vI4Z4gNzXmavdKBWaJt4bydCQ/azLprw9tjnpUbUsiwyWo7cE9nGeFHX
         W4tjSmIrcyI7WoP9yIfKxz3PPd9MxUw3lHfuKuPd1mCpljdU2I+p1E+RNJtw2kiKszOR
         4piZcT2EBoMGnkP3whSjikE9HUQp8U9CqcANV9e8mRvZo/u4TezrRnKZvbgUc/nQVRqX
         8sCw==
X-Gm-Message-State: APjAAAWFyQ41OIRbyiJQTKG01Yjgp6w0hIQGEwnsQWFspSV1v+ZTc/ji
        65+uVK4jIobhJlf81HTDGL94Sgwvu8IcsCjgrr9dBYo7Bltk7Rx4GV3oxqtiEKf8YHvW39qfG60
        Z7Opa4cWArMMlakax4EREiJBl
X-Received: by 2002:adf:ee88:: with SMTP id b8mr12352667wro.249.1578585944493;
        Thu, 09 Jan 2020 08:05:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqziyrPjjwc6jFBPwhewcMunWuDhPtWfMzeeejSLNUTdBAiUMf1lRurJ4PQYCUI/+LBPOsBfYw==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr12352633wro.249.1578585944225;
        Thu, 09 Jan 2020 08:05:44 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id a16sm8545544wrt.37.2020.01.09.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:43 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 21/57] objtool: arm64: Decode simple data processing instructions
Date:   Thu,  9 Jan 2020 16:02:24 +0000
Message-Id: <20200109160300.26150-22-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode data processing instructions that do not constitute stack
operations.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 104 ++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  18 +++
 2 files changed, 122 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 04358f41ef1d..6c8db9335fc9 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -81,6 +81,7 @@ static arm_decode_class aarch64_insn_class_decode_table[NR_INSN_CLASS] = {
 	[INSN_RESERVED]			= arm_decode_unknown,
 	[INSN_UNKNOWN]			= arm_decode_unknown,
 	[INSN_UNALLOC]			= arm_decode_unknown,
+	[0b1000 ... INSN_DP_IMM]	= arm_decode_dp_imm,
 };
 
 /*
@@ -145,3 +146,106 @@ int arm_decode_unknown(u32 instr, enum insn_type *type,
 
 	return 0;
 }
+
+#define NR_DP_IMM_SUBCLASS	8
+#define INSN_DP_IMM_SUBCLASS(opcode)			\
+	(((opcode) >> 23) & (NR_DP_IMM_SUBCLASS - 1))
+
+static arm_decode_class aarch64_insn_dp_imm_decode_table[NR_DP_IMM_SUBCLASS] = {
+	[0 ... INSN_PCREL]	= arm_decode_pcrel,
+	[INSN_MOVE_WIDE]	= arm_decode_move_wide,
+	[INSN_BITFIELD]		= arm_decode_bitfield,
+	[INSN_EXTRACT]		= arm_decode_extract,
+};
+
+int arm_decode_dp_imm(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list)
+{
+	arm_decode_class decode_fun;
+
+	decode_fun = aarch64_insn_dp_imm_decode_table[INSN_DP_IMM_SUBCLASS(instr)];
+	if (!decode_fun)
+		return -1;
+	return decode_fun(instr, type, immediate, ops_list);
+}
+
+int arm_decode_pcrel(u32 instr, enum insn_type *type,
+		     unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char page = 0;
+	u32 immhi = 0, immlo = 0;
+
+	page = EXTRACT_BIT(instr, 31);
+	immhi = (instr >> 5) & ONES(19);
+	immlo = (instr >> 29) & ONES(2);
+
+	*immediate = SIGN_EXTEND((immhi << 2) | immlo, 21);
+
+	if (page)
+		*immediate = SIGN_EXTEND(*immediate << 12, 33);
+
+	*type = INSN_OTHER;
+
+	return 0;
+}
+
+int arm_decode_move_wide(u32 instr, enum insn_type *type,
+			 unsigned long *immediate, struct list_head *ops_list)
+{
+	u32 imm16 = 0;
+	unsigned char hw = 0, opc = 0, sf = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	opc = (instr >> 29) & ONES(2);
+	hw = (instr >> 21) & ONES(2);
+	imm16 = (instr >> 5) & ONES(16);
+
+	if ((sf == 0 && (hw & 0x2)) || opc == 0x1)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+	*immediate = imm16;
+
+	return 0;
+}
+
+int arm_decode_bitfield(u32 instr, enum insn_type *type,
+			unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, opc = 0, N = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	opc = (instr >> 29) & ONES(2);
+	N = EXTRACT_BIT(instr, 22);
+
+	if (opc == 0x3 || sf != N)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+
+	return 0;
+}
+
+int arm_decode_extract(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, op21 = 0, N = 0, o0 = 0;
+	unsigned char imms = 0;
+	unsigned char decode_field = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	op21 = (instr >> 29) & ONES(2);
+	N = EXTRACT_BIT(instr, 22);
+	o0 = EXTRACT_BIT(instr, 21);
+	imms = (instr >> 10) & ONES(6);
+
+	decode_field = (sf << 4) | (op21 << 2) | (N << 1) | o0;
+	*type = INSN_OTHER;
+	*immediate = imms;
+
+	if ((decode_field == 0 && !EXTRACT_BIT(imms, 5)) ||
+	    decode_field == 0b10010)
+		return 0;
+
+	return arm_decode_unknown(instr, type, immediate, ops_list);
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 16066f8fca0d..06235d81300c 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -8,15 +8,33 @@
 #define INSN_RESERVED	0b0000
 #define INSN_UNKNOWN	0b0001
 #define INSN_UNALLOC	0b0011
+#define INSN_DP_IMM	0b1001	//0x100x
 
 #define NR_INSN_CLASS	16
 #define INSN_CLASS(opcode)	(((opcode) >> 25) & (NR_INSN_CLASS - 1))
 
+#define INSN_PCREL	0b001	//0b00x
+#define INSN_MOVE_WIDE	0b101
+#define INSN_BITFIELD	0b110
+#define INSN_EXTRACT	0b111
+
 typedef int (*arm_decode_class)(u32 instr, enum insn_type *type,
 				unsigned long *immediate,
 				struct list_head *ops_list);
 
 /* arm64 instruction classes */
+int arm_decode_dp_imm(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_unknown(u32 instr, enum insn_type *type,
 		       unsigned long *immediate, struct list_head *ops_list);
+
+/* arm64 data processing -- immediate subclasses */
+int arm_decode_pcrel(u32 instr, enum insn_type *type,
+		     unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_move_wide(u32 instr, enum insn_type *type,
+			 unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_bitfield(u32 instr, enum insn_type *type,
+			unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_extract(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

