Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B99C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E592089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfEPKiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:38:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40918 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbfEPKiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:38:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE6DF1B4B;
        Thu, 16 May 2019 03:38:16 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 322813F703;
        Thu, 16 May 2019 03:38:15 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 09/16] arm64: assembler: Add macro to annotate asm function having non standard stack-frame.
Date:   Thu, 16 May 2019 11:36:48 +0100
Message-Id: <20190516103655.5509-10-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516103655.5509-1-raphael.gault@arm.com>
References: <20190516103655.5509-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions don't have standard stack-frames but are intended
this way. In order for objtool to ignore those particular cases
we add a macro that enables us to annotate the cases we chose
to mark as particular.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/include/asm/assembler.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index c5308d01e228..8948474a9bcb 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -760,4 +760,17 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 .Lyield_out_\@ :
 	.endm
 
+	/*
+	 * This macro is the arm64 assembler equivalent of the
+	 * macro STACK_FRAME_NON_STANDARD define at
+	 * ~/include/linux/frame.h
+	 */
+	.macro	asm_stack_frame_non_standard	func
+#ifdef	CONFIG_STACK_VALIDATION
+	.pushsection ".discard.func_stack_frame_non_standard"
+	.8byte	\func
+	.popsection
+#endif
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
-- 
2.17.1

