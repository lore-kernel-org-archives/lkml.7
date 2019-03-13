Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B71217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504593;
	bh=76/UYan8R6HIL1YeUwZatxpInqsroSF2eYLFXRCdGBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GkXUhlwsIa1ybaNhYV0v+Dr0rabi6gLYw6my30EUtmSAk3T2l4GW576lbD/tXXd/1
	 W80N/s3Q7K0X42D92p9ustJpp7r8z01di/dvIIWiO15H0r2y/gaBxHidTWoJut48T4
	 9ttqIlBUmjKF5fz6VzKSI6UZ6dtF6rYXdzA6pi9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfCMTQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbfCMTQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:16:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4981217F5;
        Wed, 13 Mar 2019 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504588;
        bh=76/UYan8R6HIL1YeUwZatxpInqsroSF2eYLFXRCdGBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJy99ejcE1V8cOiFqJek3CsLiu7at6/HEoeGWdEl1oxzUtp275IbO4x1Dad8go3Wi
         mzMZlPHOM1Jz/Oi2QMFniYRRp0dRd9ExLHqsTmwZQIJN68AMGyXAS8ymhezzdJaRVq
         UFhsXMgTUNDBh6B2YAAk8ZDxa7GkA2TZdmlGblyk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 26/33] ARCv2: support manual regfile save on interrupts
Date:   Wed, 13 Mar 2019 15:14:59 -0400
Message-Id: <20190313191506.159677-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

[ Upstream commit e494239a007e601448110ac304fe055951f9de3b ]

There's a hardware bug which affects the HSDK platform, triggered by
micro-ops for auto-saving regfile on taken interrupt. The workaround is
to inhibit autosave.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/Kconfig                   |  8 +++++
 arch/arc/include/asm/entry-arcv2.h | 54 ++++++++++++++++++++++++++++++
 arch/arc/kernel/entry-arcv2.S      |  4 ++-
 arch/arc/kernel/intc-arcv2.c       |  2 ++
 arch/arc/plat-hsdk/Kconfig         |  1 +
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 9d06c9478a0d..82050893d0b3 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -417,6 +417,14 @@ config ARC_HAS_ACCL_REGS
 	  (also referred to as r58:r59). These can also be used by gcc as GPR so
 	  kernel needs to save/restore per process
 
+config ARC_IRQ_NO_AUTOSAVE
+	bool "Disable hardware autosave regfile on interrupts"
+	default n
+	help
+	  On HS cores, taken interrupt auto saves the regfile on stack.
+	  This is programmable and can be optionally disabled in which case
+	  software INTERRUPT_PROLOGUE/EPILGUE do the needed work
+
 endif	# ISA_ARCV2
 
 endmenu   # "ARC CPU Configuration"
diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 257a68f3c2fe..9f581553dcc3 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -17,6 +17,33 @@
 	;
 	; Now manually save: r12, sp, fp, gp, r25
 
+#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
+.ifnc \called_from, exception
+	st.as	r9, [sp, -10]	; save r9 in it's final stack slot
+	sub	sp, sp, 12	; skip JLI, LDI, EI
+
+	PUSH	lp_count
+	PUSHAX	lp_start
+	PUSHAX	lp_end
+	PUSH	blink
+
+	PUSH	r11
+	PUSH	r10
+
+	sub	sp, sp, 4	; skip r9
+
+	PUSH	r8
+	PUSH	r7
+	PUSH	r6
+	PUSH	r5
+	PUSH	r4
+	PUSH	r3
+	PUSH	r2
+	PUSH	r1
+	PUSH	r0
+.endif
+#endif
+
 #ifdef CONFIG_ARC_HAS_ACCL_REGS
 	PUSH	r59
 	PUSH	r58
@@ -86,6 +113,33 @@
 	POP	r59
 #endif
 
+#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
+.ifnc \called_from, exception
+	POP	r0
+	POP	r1
+	POP	r2
+	POP	r3
+	POP	r4
+	POP	r5
+	POP	r6
+	POP	r7
+	POP	r8
+	POP	r9
+	POP	r10
+	POP	r11
+
+	POP	blink
+	POPAX	lp_end
+	POPAX	lp_start
+
+	POP	r9
+	mov	lp_count, r9
+
+	add	sp, sp, 12	; skip JLI, LDI, EI
+	ld.as	r9, [sp, -10]	; reload r9 which got clobbered
+.endif
+#endif
+
 .endm
 
 /*------------------------------------------------------------------------*/
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index cc558a25b8fa..562089d62d9d 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -209,7 +209,9 @@ restore_regs:
 ;####### Return from Intr #######
 
 debug_marker_l1:
-	bbit1.nt r0, STATUS_DE_BIT, .Lintr_ret_to_delay_slot
+	; bbit1.nt r0, STATUS_DE_BIT, .Lintr_ret_to_delay_slot
+	btst	r0, STATUS_DE_BIT		; Z flag set if bit clear
+	bnz	.Lintr_ret_to_delay_slot	; branch if STATUS_DE_BIT set
 
 .Lisr_ret_fast_path:
 	; Handle special case #1: (Entry via Exception, Return via IRQ)
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index 067ea362fb3e..cf18b3e5a934 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -49,11 +49,13 @@ void arc_init_IRQ(void)
 
 	*(unsigned int *)&ictrl = 0;
 
+#ifndef CONFIG_ARC_IRQ_NO_AUTOSAVE
 	ictrl.save_nr_gpr_pairs = 6;	/* r0 to r11 (r12 saved manually) */
 	ictrl.save_blink = 1;
 	ictrl.save_lp_regs = 1;		/* LP_COUNT, LP_START, LP_END */
 	ictrl.save_u_to_u = 0;		/* user ctxt saved on kernel stack */
 	ictrl.save_idx_regs = 1;	/* JLI, LDI, EI */
+#endif
 
 	WRITE_AUX(AUX_IRQ_CTRL, ictrl);
 
diff --git a/arch/arc/plat-hsdk/Kconfig b/arch/arc/plat-hsdk/Kconfig
index fcc9a9e27e9c..8fb1600b29b7 100644
--- a/arch/arc/plat-hsdk/Kconfig
+++ b/arch/arc/plat-hsdk/Kconfig
@@ -9,5 +9,6 @@ menuconfig ARC_SOC_HSDK
 	bool "ARC HS Development Kit SOC"
 	depends on ISA_ARCV2
 	select ARC_HAS_ACCL_REGS
+	select ARC_IRQ_NO_AUTOSAVE
 	select CLK_HSDK
 	select RESET_HSDK
-- 
2.19.1

