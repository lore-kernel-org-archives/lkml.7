Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9675C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AF9206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrvRjhRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbgAIQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:06:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28387 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733014AbgAIQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=59aS99No1krrXfIWCRAYZAAd//TqWaD8qP5fyW3sdMg=;
        b=DrvRjhRZO8Yb6Ovbh/Cd/uxQUIDh0qD0CPas9QUz5le9PLufHxUfQ5RLiXjoPftBwLJ8AI
        KiP62q0WYE1dVmaDPUlLWBs1MsME0TDF3AkVE1/RT5mrucOA0KTuT9Ux43YeKMdS2DM1iZ
        apTIo/P9h4wm9l4RQ/uUc0+JtVByd8s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-xxA-vimtN7CDAcai9lmMSg-1; Thu, 09 Jan 2020 11:06:21 -0500
X-MC-Unique: xxA-vimtN7CDAcai9lmMSg-1
Received: by mail-wm1-f71.google.com with SMTP id w205so1097150wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59aS99No1krrXfIWCRAYZAAd//TqWaD8qP5fyW3sdMg=;
        b=kCKRJ2gYkjXQ3GOM+pOBTYZtzocvkw7xKsDJ/5Fl1leYp7W5i2ICT0dwt4F4VUJhkM
         RzOwCXfaF8kMge92SB2KBoepwktOjtylY0XdUHKjAGYrAQOaj25YONmlM5gIEbKq0mAR
         enHzRvdPpDFAGLz6E92u6WA609+h1unTLENViIQwls0J1Xg5lNq3wvjnCTrKCwHhnbpt
         /48u/aepVRj+N4mL33KzLALQX9MXOu5scuF2+MWj1k5Z4Vby6rPtL+cl+LrsToDDkWsC
         HdOBmVFOuAkot75xgZyD4sSkexZ8jtcTHtoRF2muyuV4YBdBETapFx/YzRSVEOLjPau4
         Mc4g==
X-Gm-Message-State: APjAAAUG9GefIGMYKOgZOt3YrgRWiwofsLcQlstT8P3mhaQPJ8jT3Pgq
        8ve8vBdsW73MPX/xBTHcqD9Yv6JE2YUKo2ipb4qEsPSrg6H3YxgWsfVeunqppdzTL7JpIIPLq9g
        hNf9xx+tDmKqBi5ggWozQB6Db
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr5663398wmh.94.1578585980285;
        Thu, 09 Jan 2020 08:06:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjRFkbMIepr4wXf1QqLfVFyAf3vdn/APW9YXTZqFn1HcPM1Jr3zmviIV97H+YUovcevsWwVA==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr5663373wmh.94.1578585980101;
        Thu, 09 Jan 2020 08:06:20 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e18sm8643101wrr.95.2020.01.09.08.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:06:19 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 25/57] objtool: arm64: Decode calls to higher EL
Date:   Thu,  9 Jan 2020 16:02:28 +0000
Message-Id: <20200109160300.26150-26-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode instructions that volontarily trigger exceptions to a higher
exception level.

It is assumed that the higher exception level should service the request
in a sane maner, returning to the caller exception level without
altering its context too much (e.g. not modifying the PC, the stack
pointer or the frame pointer).

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 45 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  2 +
 2 files changed, 47 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index c38d73fb57e1..aa00de725686 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -419,6 +419,11 @@ static struct aarch64_insn_decoder br_sys_decoder[] = {
 		.value = 0b1100100010000000000000,
 		.decode_func = arm_decode_system_regs,
 	},
+	{
+		.mask = 0b1111100000000000000000,
+		.value = 0b1100000000000000000000,
+		.decode_func = arm_decode_except_gen,
+	},
 };
 
 int arm_decode_br_sys(u32 instr, enum insn_type *type,
@@ -486,3 +491,43 @@ int arm_decode_system_regs(u32 instr, enum insn_type *type,
 	*type = INSN_OTHER;
 	return 0;
 }
+
+int arm_decode_except_gen(u32 instr, enum insn_type *type,
+			  unsigned long *immediate, struct list_head *ops_list)
+{
+	u32 imm16 = 0;
+	unsigned char opc = 0, op2 = 0, LL = 0, decode_field = 0;
+
+	imm16 = (instr >> 5) & ONES(16);
+	opc = (instr >> 21) & ONES(3);
+	op2 = (instr >> 2) & ONES(3);
+	LL = instr & ONES(2);
+	decode_field = (opc << 5) | (op2 << 2) | LL;
+
+#define INSN_SVC	0b00000001
+#define INSN_HVC	0b00000010
+#define INSN_SMC	0b00000011
+
+	switch (decode_field) {
+	case INSN_SVC:
+	case INSN_HVC:
+	case INSN_SMC:
+		/*
+		 * We consider that the context will be restored correctly
+		 * with an unchanged sp and the same general registers
+		 */
+		*type = INSN_NOP;
+		return 0;
+	default:
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+	}
+
+#undef INSN_SVC
+#undef INSN_HVC
+#undef INSN_SMC
+#undef INSN_BRK
+#undef INSN_HLT
+#undef INSN_DCPS1
+#undef INSN_DCPS2
+#undef INSN_DCPS3
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 777a62f1a141..a55dcbfcfed2 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -70,4 +70,6 @@ int arm_decode_system_insn(u32 instr, enum insn_type *type,
 int arm_decode_system_regs(u32 instr, enum insn_type *type,
 			   unsigned long *immediate,
 			   struct list_head *ops_list);
+int arm_decode_except_gen(u32 instr, enum insn_type *type,
+			  unsigned long *immediate, struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

