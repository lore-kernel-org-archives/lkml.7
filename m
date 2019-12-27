Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562ABC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACE1206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HZ2Qtek6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfL0SED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:04:03 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:40746 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727337AbfL0SD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:03:59 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2A53C09A7;
        Fri, 27 Dec 2019 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1577469838; bh=FA6LUY6CHkOmJ9QzyFH4ZmwtZXrc9eBJr1JMrs9R+1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZ2Qtek6HXlinyXMlGK64VmnZsxa+H5F/Nkxp0ScwPvSMthuo1z/8s64wHiM8c7u6
         3c0pO2gyGlZbHW5yfbpBEDyoD+36aQz01u71xQAmJoY5XboOqxmfQ9v4348YgUF0rm
         y+7AFgL6vFiF+vJaTDDE1lQXhLrlE6VHrBtJgUMDSaYRSRcDvTGg0HZjBcIf0v+H+2
         TlW0fc+G1k83jztbi4z5ali9MA8yK9JhgORt/kFYC/CxKCyTdLVJZx2WWj+EIDxN3Z
         sSnmxfdhQ8WEnn7+zY2nZeybPXgSIjMEB4Yc07WTVPfc35NMYM2ThGJtqubWOyRiJU
         ByopaDgHEkjhQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.65])
        by mailhost.synopsys.com (Postfix) with ESMTP id DEE08A0063;
        Fri, 27 Dec 2019 18:03:55 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/5] ARC: pt_regs: remove hardcoded registers offset
Date:   Fri, 27 Dec 2019 21:03:43 +0300
Message-Id: <20191227180347.3579-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hardcoded registers offset numbers by calculated via
offsetof.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/entry-arcv2.h | 8 ++++----
 arch/arc/kernel/asm-offsets.c      | 9 +++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 41b16f21beec..0b8b63d0bec1 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -162,7 +162,7 @@
 #endif
 
 #ifdef CONFIG_ARC_HAS_ACCL_REGS
-	ST2	r58, r59, PT_sp + 12
+	ST2	r58, r59, PT_r58
 #endif
 
 .endm
@@ -172,8 +172,8 @@
 
 	LD2	gp, fp, PT_r26		; gp (r26), fp (r27)
 
-	ld	r12, [sp, PT_sp + 4]
-	ld	r30, [sp, PT_sp + 8]
+	ld	r12, [sp, PT_r12]
+	ld	r30, [sp, PT_r30]
 
 	; Restore SP (into AUX_USER_SP) only if returning to U mode
 	;  - for K mode, it will be implicitly restored as stack is unwound
@@ -190,7 +190,7 @@
 #endif
 
 #ifdef CONFIG_ARC_HAS_ACCL_REGS
-	LD2	r58, r59, PT_sp + 12
+	LD2	r58, r59, PT_r58
 #endif
 .endm
 
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index 631ebb5d3458..c783bcd35eb8 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -67,5 +67,14 @@ int main(void)
 	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
 	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
 
+#ifdef CONFIG_ISA_ARCV2
+	OFFSET(PT_r12, pt_regs, r12);
+	OFFSET(PT_r30, pt_regs, r30);
+#endif
+#ifdef CONFIG_ARC_HAS_ACCL_REGS
+	OFFSET(PT_r58, pt_regs, r58);
+	OFFSET(PT_r59, pt_regs, r59);
+#endif
+
 	return 0;
 }
-- 
2.21.0

