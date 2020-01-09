Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D93C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B184206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZxRbbSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgAIQGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:06:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59596 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733066AbgAIQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tp6JL9rGP8VcGeIdUkesp1xLP6ts4YGw1IAU9COITC4=;
        b=NZxRbbSYtUzOPsM+23SY+Ac2aDA7YRF1zEDO1UDM8sRp8SNlukaZWZrFzaDuSVpP8Ox7MW
        GJn8uEurxebCbnsmfhXOPGF/5hmyCasQRCq/sniWKBlclmaQSG6oN7joc/8r0jwX8nF+aX
        2tc6mWZJj6lollmXkzS/oMuYmRLsiJ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-kMBWGn5wPNuoHSHHg2aEFA-1; Thu, 09 Jan 2020 11:06:28 -0500
X-MC-Unique: kMBWGn5wPNuoHSHHg2aEFA-1
Received: by mail-wr1-f70.google.com with SMTP id j13so3036154wrr.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tp6JL9rGP8VcGeIdUkesp1xLP6ts4YGw1IAU9COITC4=;
        b=ng1rHi7pQKUAXPKVo6xwrGxEFXCbFqpoAs3SHiP+xqpuYJjGkGJocYaoLjoFvr52ND
         LSMNZuekQa73hirxEztBZ1GHALPSyMYSldwmd0jBqNtUtTpUN/nsUhgDdxFcwy6gRjjK
         nJUP+N3gUMI6xK7WJRQM7DbLUTKnP4wsUtNyd+wSvqWdDs0hpw6OlW9ahqLzPoNzTvh6
         ZLrzlaaJFEdLqC2HHKKOO+Z1Um/fC47vD55INQTrZ+VELyObfWFUcupr4igxH7jI8Bix
         QL2Dn8KyoP2iA19/siXOxpNd2l6FZYyx77gvPy5r8sZTGT6x9fPnXygmzOjiOv5+TMDk
         Qi8w==
X-Gm-Message-State: APjAAAVs2W/7ko2boR6+IE0JYTKyuFFEQm4SU1GMqpAQu4NsdQE1tqnq
        sgjLWurxfnfstwe9EE9bf1OsOH2QrCE3Ia+h2K0oCpxhd6nRSrvZ7phtfZn/7ffxHZ0WQFMX1Sb
        K6IPggH9SyqlqZ7f6VzsHF2M3
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr5990737wml.55.1578585986754;
        Thu, 09 Jan 2020 08:06:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEYx+b+ZCp2ZXGZSAYjmTHkSxr4PiMHPsV7FrExWj8/adU6yZ5L8AF6L4WgU01bYY7ltzeEg==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr5990707wml.55.1578585986501;
        Thu, 09 Jan 2020 08:06:26 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e18sm8643101wrr.95.2020.01.09.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:06:25 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 29/57] objtool: arm64: Decode branch to register instruction
Date:   Thu,  9 Jan 2020 16:02:32 +0000
Message-Id: <20200109160300.26150-30-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode instructions producing jumps in the execution flow, taking the
value of their operand register as the target address.

Return instructions are just branch to register instruction with
the link register (x31) as implicit operand.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 150 ++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |   3 +
 2 files changed, 153 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 7986ded8b622..bf9334451b40 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -444,6 +444,11 @@ static struct aarch64_insn_decoder br_sys_decoder[] = {
 		.value = 0b0011000000000000000000,
 		.decode_func = arm_decode_br_tst_imm,
 	},
+	{
+		.mask = 0b1111000000000000000000,
+		.value = 0b1101000000000000000000,
+		.decode_func = arm_decode_br_uncond_reg,
+	},
 };
 
 int arm_decode_br_sys(u32 instr, enum insn_type *type,
@@ -654,3 +659,148 @@ int arm_decode_br_tst_imm(u32 instr, enum insn_type *type,
 	*type = INSN_JUMP_CONDITIONAL;
 	return 0;
 }
+
+static struct aarch64_insn_decoder ret_decoder[] = {
+	/*
+	 * RET, RETAA, RETAB
+	 */
+	{
+		.mask = 0b1111111111111110000011111,
+		.value = 0b0010111110000000000000000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111111111111111,
+		.value = 0b0010111110000101111111111,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111111111111111,
+		.value = 0b0010111110000111111111111,
+		.decode_func = NULL,
+	},
+};
+
+static struct aarch64_insn_decoder br_decoder[] = {
+	/*
+	 * BR, BRAA, BRAAZ, BRAB, BRABZ
+	 */
+	{
+		.mask = 0b1111111111111110000011111,
+		.value = 0b0000111110000000000000000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111110000011111,
+		.value = 0b0000111110000100000011111,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111110000011111,
+		.value = 0b0000111110000110000011111,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111110000000000,
+		.value = 0b1000111110000100000000000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111110000000000,
+		.value = 0b1000111110000110000000000,
+		.decode_func = NULL,
+	},
+};
+
+#define INSN_DRPS_FIELD		0b0101111110000001111100000
+#define INSN_DRPS_MASK		0b1111111111111111111111111
+
+static struct aarch64_insn_decoder ct_sw_decoder[] = {
+	/*
+	 * ERET, ERETAA, ERETAB
+	 */
+	{
+		.mask = INSN_DRPS_MASK,
+		.value = 0b0100111110000001111100000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = INSN_DRPS_MASK,
+		.value = 0b0100111110000101111111111,
+		.decode_func = NULL,
+	},
+	{
+		.mask = INSN_DRPS_MASK,
+		.value = 0b0100111110000111111111111,
+		.decode_func = NULL,
+	},
+};
+
+static struct aarch64_insn_decoder call_decoder[] = {
+	/*
+	 * BLR, BLRAA, BLRAAZ, BLRAB, BLRABZ
+	 */
+	{
+		.mask = 0b1111111111111110000011111,
+		.value =  0b0001111110000000000000000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111110000011111,
+		.value = 0b0001111110000100000011111,
+		.decode_func = NULL,
+	},
+	{
+		0b1111111111111110000011111,
+		0b0001111110000110000011111,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111110000000000,
+		.value = 0b1001111110000100000000000,
+		.decode_func = NULL,
+	},
+	{
+		.mask = 0b1111111111111110000000000,
+		.value = 0b1001111110000110000000000,
+		.decode_func = NULL,
+	},
+};
+
+int arm_decode_br_uncond_reg(u32 instr, enum insn_type *type,
+			     unsigned long *immediate,
+			     struct list_head *ops_list)
+{
+	u32 decode_field = 0;
+	int i = 0;
+
+	decode_field = instr & ONES(25);
+	*type = 0;
+	for (i = 0; i < ARRAY_SIZE(br_decoder); i++) {
+		if ((decode_field & br_decoder[i].mask) == br_decoder[i].value)
+			*type = INSN_JUMP_DYNAMIC;
+	}
+	for (i = 0; i < ARRAY_SIZE(call_decoder); i++) {
+		if ((decode_field & call_decoder[i].value) ==
+		    call_decoder[i].value)
+			*type = INSN_CALL_DYNAMIC;
+	}
+	for (i = 0; i < ARRAY_SIZE(ret_decoder); i++) {
+		if ((decode_field & ret_decoder[i].mask) ==
+		    ret_decoder[i].value)
+			*type = INSN_RETURN;
+	}
+	for (i = 0; i < ARRAY_SIZE(ct_sw_decoder); i++) {
+		if ((decode_field & ct_sw_decoder[i].mask) ==
+		    ct_sw_decoder[i].value)
+			*type = INSN_CONTEXT_SWITCH;
+	}
+	if ((decode_field & INSN_DRPS_MASK) == INSN_DRPS_FIELD)
+		*type = INSN_OTHER;
+	if (*type == 0)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+	return 0;
+}
+
+#undef INSN_DRPS_FIELD
+#undef INSN_DRPS_MASK
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index ceb80a58c548..6e600f408bea 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -83,4 +83,7 @@ int arm_decode_br_tst_imm(u32 instr, enum insn_type *type,
 int arm_decode_br_cond_imm(u32 instr, enum insn_type *type,
 			   unsigned long *immediate,
 			   struct list_head *ops_list);
+int arm_decode_br_uncond_reg(u32 instr, enum insn_type *type,
+			     unsigned long *immediate,
+			     struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

