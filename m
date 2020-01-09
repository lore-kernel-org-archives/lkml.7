Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CF92072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWCp8xMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733068AbgAIQG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:06:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22497 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733014AbgAIQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNhyss2u9SsGVYYccTk/iU0pIIQIcXT3bxVXb0UyHWg=;
        b=aWCp8xMwoieRqaU4z5pBRTRRzn9cUrLonjyfcfL2bvoVdaIa03w9WGdxYpQ7C/3etJQ1Lq
        uUeyoCVr9yI5O2QRO1J4cO29lMHPCvalMFeJblmQJ/U6RqPn68JaNNIsokcTtMv0VbU8gz
        EVOCsjehjq+LVeg33c45QMDiK7IGwSw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-Zkvv4ARhOWa_LUJwuphmvg-1; Thu, 09 Jan 2020 11:06:24 -0500
X-MC-Unique: Zkvv4ARhOWa_LUJwuphmvg-1
Received: by mail-wr1-f72.google.com with SMTP id i9so3060416wru.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNhyss2u9SsGVYYccTk/iU0pIIQIcXT3bxVXb0UyHWg=;
        b=LgAiV505tGseIeVTpO075awXlJs2Y76atDJcee5z4+Pfz2T7JA+f1s89y96WF8v+7/
         hBYtNu5y7qs5TuUH2+5aOmg8MelZ4bbsl+0Bzc5ddwbbDYjnkRHuzewV1R9xzVUm99j4
         VMJpMROZrlTiQeI6JytIPkHJ5WwVVzNB8F1iaImRfP9LWxM6XO3FJpod6sbh5UJL6pl2
         OwkcXELUnyoMnjrsOd009qiNalS49FqU0kchDr3eAbGtykX/0O2MfIa41oT+oVfNE29D
         xJptUlxmGJV6WT2JTMyPPsooiE9Oz7CkX1fbmGbzBJVXGxm4kHb1mtsB21igbTEyNCfY
         FQCg==
X-Gm-Message-State: APjAAAXRMPDEO93K40WqnjoApOZuBCCeD2EJz5R6p2QPTSc5HJsVrq/i
        spPfdigIxSi6F0uI/t0JTUqEAbqBK2xZ1ToJdTVwPBIb8xJjC/CiBpPDl/0BU1byPfW9ZGrSafa
        nKMqou0aURpr9LUS8aRFOi1u8
X-Received: by 2002:adf:f10a:: with SMTP id r10mr11698851wro.202.1578585983151;
        Thu, 09 Jan 2020 08:06:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfuKPzYnuaQfyIgBEkCdvvo1v0X3eOw5Mldms4E6Ry3uTgyBQ8xNyJC89tB0eee772rraRfA==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr11698826wro.202.1578585982936;
        Thu, 09 Jan 2020 08:06:22 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e18sm8643101wrr.95.2020.01.09.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:06:22 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 27/57] objtool: arm64: Decode instruction triggering context switch
Date:   Thu,  9 Jan 2020 16:02:30 +0000
Message-Id: <20200109160300.26150-28-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode instructions that volutarily trigger an exception to change
the context of execution.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 1609750cc4b9..5eba83c5d5bc 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -508,6 +508,10 @@ int arm_decode_except_gen(u32 instr, enum insn_type *type,
 #define INSN_HVC	0b00000010
 #define INSN_SMC	0b00000011
 #define INSN_BRK	0b00100000
+#define INSN_HLT	0b01000000
+#define INSN_DCPS1	0b10100001
+#define INSN_DCPS2	0b10100010
+#define INSN_DCPS3	0b10100011
 
 	switch (decode_field) {
 	case INSN_SVC:
@@ -551,6 +555,13 @@ int arm_decode_except_gen(u32 instr, enum insn_type *type,
 			break;
 		}
 		return 0;
+	case INSN_HLT:
+	case INSN_DCPS1:
+	case INSN_DCPS2:
+	case INSN_DCPS3:
+		*immediate = imm16;
+		*type = INSN_CONTEXT_SWITCH;
+		return 0;
 	default:
 		return arm_decode_unknown(instr, type, immediate, ops_list);
 	}
-- 
2.21.0

