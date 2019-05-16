Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC2C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6F42087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfEPKii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:38:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfEPKi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:38:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A3381BB0;
        Thu, 16 May 2019 03:38:29 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 834C03F703;
        Thu, 16 May 2019 03:38:27 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 16/16] arm64: kernel: Annotate non-standard stack frame functions
Date:   Thu, 16 May 2019 11:36:55 +0100
Message-Id: <20190516103655.5509-17-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516103655.5509-1-raphael.gault@arm.com>
References: <20190516103655.5509-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate assembler functions which are callable but do not
setup a correct stack frame.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/kernel/hyp-stub.S | 2 ++
 arch/arm64/kvm/hyp-init.S    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 17f325ba831e..ded5a50d95bf 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -53,6 +53,7 @@ ENTRY(__hyp_stub_vectors)
 	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
 	ventry	el1_error_invalid		// Error 32-bit EL1
 ENDPROC(__hyp_stub_vectors)
+asm_stack_frame_non_standard __hyp_stub_vectors
 
 	.align 11
 
@@ -80,6 +81,7 @@ el1_sync:
 9:	mov	x0, xzr
 	eret
 ENDPROC(el1_sync)
+asm_stack_frame_non_standard el1_sync
 
 .macro invalid_vector	label
 \label:
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 4576b86a5579..2ef2e2c51824 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -129,6 +129,7 @@ CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
 	/* Hello, World! */
 	eret
 ENDPROC(__kvm_hyp_init)
+asm_stack_frame_non_standard __kvm_hyp_init
 
 ENTRY(__kvm_handle_stub_hvc)
 	cmp	x0, #HVC_SOFT_RESTART
@@ -170,6 +171,7 @@ reset:
 	eret
 
 ENDPROC(__kvm_handle_stub_hvc)
+asm_stack_frame_non_standard __kvm_handle_stub_hvc
 
 	.ltorg
 
-- 
2.17.1

