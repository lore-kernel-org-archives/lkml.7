Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7C1C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B5E2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F26qIbOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbgAIQHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731639AbgAIQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C242X53zcOHATp6nW8wanAXybHBsTs8xiHcl5AgRRKM=;
        b=F26qIbOgoaCLzpLyqcUv5jpGKybsugUVy+ORhWlMv9zQBld3u42hlWkhsemNSb3FixmBBY
        uIcThzNq/Kwsjcl9jtDoEsg6SoFcgtYMquDKLX+4V5pN8cHvGpQZHAN/cJ9bhetRzQ3LtG
        zZsI2Rd25uR703C4Phdhqz8gJvHkp7c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-qqf3tPyJPca0tCwRwZaIoQ-1; Thu, 09 Jan 2020 11:07:03 -0500
X-MC-Unique: qqf3tPyJPca0tCwRwZaIoQ-1
Received: by mail-wm1-f69.google.com with SMTP id q26so619283wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C242X53zcOHATp6nW8wanAXybHBsTs8xiHcl5AgRRKM=;
        b=IaJ2JeADnyDJzu+o0ZFCwWqBh7+B9Uw0zT2aDG9fmfWvtm8KB0tjTZqcyo69C099kq
         TV61TaCwag7J+JOGarOVIgeNFFpjmSbDg9j7E+AT4uvc2pSJv4DgDl/9zHByjP/hSHyw
         CfOcYVnWp6YWFYA0Vf99EeaSOkxT0urOLjwJZomMGf2Ex1XmZ0h5tMu+1XE4lwJlgWun
         NH/rD4bTOdiqeFXs4KFrUYc2SfgCXxQ62mICaYK4E9+TDO8fJpAK2UptH1ImHazquxyR
         OeT4Y8LEcDUbbYIUi7Rv2Wr7YkrMOlOhjCw5Zx5mZUkex3YuJAnoJo89L853ywdAjawJ
         Wolg==
X-Gm-Message-State: APjAAAX/GawBSRywwFP4p3vJLf3Levsn2Y5AaLOtiNzlnsrGedmX7npL
        URh7vOXFN7jDWySxK5PdmYe4w/DLSWV+I9mvGoqdcWn0ZUrhz5VZ86Z+gtmmPvWOJQpaT26AK03
        WHykIEvcbsC7ZVvQjJtkrFIqT
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr5945683wmk.68.1578586020598;
        Thu, 09 Jan 2020 08:07:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHOfR4JB2i4uBDVB7MQ9mxgnZen75IkCm90k8Leliq2qj5mXFDzoMI/euFvStxlxW9fbs8Jw==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr5945652wmk.68.1578586020371;
        Thu, 09 Jan 2020 08:07:00 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id q3sm9123252wrn.33.2020.01.09.08.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:06:59 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 31/57] objtool: arm64: Decode load/store with register offset
Date:   Thu,  9 Jan 2020 16:02:34 +0000
Message-Id: <20200109160300.26150-32-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store instruction using the value of a register as offset
for the target address.

Since objtool can't keep track of the possible values of this offset, it
is not possible to take this instructions into account for stack frame
validation. Luckily, the compiler does not tend to generate these
instructions for stack/frame pointer manipulation.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 34 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  3 ++
 2 files changed, 37 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 7064302416f4..00d5d627af08 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -830,6 +830,11 @@ static struct aarch64_insn_decoder ld_st_decoder[] = {
 		.value = 0b001100000000011,
 		.decode_func = arm_decode_ld_st_imm_pre,
 	},
+	{
+		.mask = 0b001101010000011,
+		.value = 0b001100010000010,
+		.decode_func = arm_decode_ld_st_regs_off,
+	},
 	{
 		.mask = 0b001101000000000,
 		.value = 0b001101000000000,
@@ -1200,3 +1205,32 @@ int arm_decode_ld_st_imm_unpriv(u32 instr, enum insn_type *type,
 	}
 	return 0;
 }
+
+int arm_decode_ld_st_regs_off(u32 instr, enum insn_type *type,
+			      unsigned long *immediate,
+			      struct list_head *ops_list)
+{
+	unsigned char size = 0, V = 0, opc = 0, option = 0;
+	unsigned char decode_field = 0;
+
+	size = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	opc = (instr >> 22) & ONES(2);
+	option = (instr >> 13) & ONES(3);
+
+#define LD_ROFF_UNALLOC_1	0b01110
+#define LD_ROFF_UNALLOC_2	0b10110
+#define LD_ROFF_UNALLOC_3	0b10011
+	decode_field = (size << 3) | (V << 2) | opc;
+	if (!EXTRACT_BIT(option, 1) ||
+	    (decode_field & LD_ROFF_UNALLOC_1) == LD_ROFF_UNALLOC_1 ||
+	    (decode_field & LD_ROFF_UNALLOC_2) == LD_ROFF_UNALLOC_2 ||
+	    (decode_field & 0b10111) == LD_ROFF_UNALLOC_3) {
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+	}
+#undef LD_ROFF_UNALLOC_1
+#undef LD_ROFF_UNALLOC_2
+#undef LD_ROFF_UNALLOC_3
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 1e031b12cf69..9043ca6f6708 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -106,6 +106,9 @@ int arm_decode_ld_st_imm_unpriv(u32 instr, enum insn_type *type,
 int arm_decode_ld_st_imm_pre(u32 instr, enum insn_type *type,
 			     unsigned long *immediate,
 			     struct list_head *ops_list);
+int arm_decode_ld_st_regs_off(u32 instr, enum insn_type *type,
+			      unsigned long *immediate,
+			      struct list_head *ops_list);
 int arm_decode_ld_st_regs_unsigned(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list);
-- 
2.21.0

