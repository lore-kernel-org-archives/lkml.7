Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A01C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED2E2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfEPKiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:38:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfEPKiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:38:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E671A25;
        Thu, 16 May 2019 03:38:09 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F3EF3F703;
        Thu, 16 May 2019 03:38:08 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 05/16] objtool: arm64: Handle hypercalls as nops
Date:   Thu, 16 May 2019 11:36:44 +0100
Message-Id: <20190516103655.5509-6-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516103655.5509-1-raphael.gault@arm.com>
References: <20190516103655.5509-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We consider that the hypervisor/secure-monitor is behaving
correctly. This enables us to handle hvc/smc/svc context switching
instructions as nop since we consider that the context is restored
correctly. This enables us to get rid of the "unsupported instruction
in callable function" warning which is not really useful.

Note that those instruction/warnings are caused by hypervisor-related
calls.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch/arm64/decode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 721152342dd3..6c77ad1a08ec 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -577,8 +577,11 @@ int arm_decode_except_gen(u32 instr, unsigned char *type,
 	case INSN_SVC:
 	case INSN_HVC:
 	case INSN_SMC:
-		*immediate = imm16;
-		*type = INSN_CONTEXT_SWITCH;
+		/*
+		 * We consider that the context will be restored correctly
+		 * with an unchanged sp and the same general registers
+		 */
+		*type = INSN_NOP;
 		return 0;
 	case INSN_BRK:
 		if (imm16 == 0x800)
-- 
2.17.1

