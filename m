Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCAB208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BwCdbk6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfFGU3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:29:12 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:57926 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729118AbfFGU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:29:12 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5765EC586D;
        Fri,  7 Jun 2019 20:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559939351; bh=pmARe3tUmEYzB2LSbTOuxEpkN/rlxKuVeduSK360CXI=;
        h=From:To:CC:Subject:Date:From;
        b=BwCdbk6D26cikG3UaPk8Y28H7pWA9Y2I7Fpyu4KolvHBTY73B4C3AudwPErEAhY2j
         YLQwUNa9GJEps0WiFnzcRAIMpdWUW+qa0VUKfL/tqGKTBFb3D1YeJGYGrkBJ9ZldQV
         QMC2guYyyO7hEuHPsDpgj7r2lSkAktZTqLlgk9zsnS90em2WmVIo6m3hAoNP8ISZNO
         2OAhibvkD685RUtlmaY238xDRqnnEDqpUqRR+BpTJRcapZESt+h/OO4R9shJFBUlXo
         8MhQ9izZKKzX54r/9t8MnDHqqAK03ysmKT7ee+/hbj+qJteJkLIPMuBeEZivwW73Ys
         RgM+jMllJvf/A==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4E184A0093;
        Fri,  7 Jun 2019 20:29:11 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Jun 2019 13:29:10 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 8 Jun 2019 01:59:08 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.35) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 8 Jun 2019 01:59:20 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] ARCv2: entry: simplify return to Delay Slot via interrupt
Date:   Fri, 7 Jun 2019 13:28:58 -0700
Message-ID: <1559939338-27673-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.35]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4255b07f2c9c43540 ("ARCv2: STAR 9000793984: Handle return
from intr to Delay Slot") involved a complex 2 staged trampoline.

Apparently this can be greatly simplified by returning from pure
kernel mode (vs interrupt) so drop to pute kernel mdoe and execute the
normal exception return path.

Note that after commit 4de0e52867d83105767 ("ARCv2: STAR 9000814690:
Really Re-enable interrupts to avoid deadlocks") the pur einterrupt
return path is rarely exercised for normal interrupts so this return to
delay slot via interrupt becomes extreemely hard to hit (and test),
so my local test setup had that revert to validate this fix.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry-arcv2.S | 55 +++++++------------------------------------
 1 file changed, 8 insertions(+), 47 deletions(-)

diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index 6cbf0ee8a20a..5dc2bb525765 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -82,7 +82,7 @@ ENTRY(handle_interrupt)
 	#
 	# Note this disable is only for consistent book-keeping as further interrupts
 	# will be disabled anyways even w/o this. Hardware tracks active interrupts
-	# seperately in AUX_IRQ_ACTIVE.active and will not take new interrupts
+	# seperately in AUX_IRQ_ACT.active and will not take new interrupts
 	# unless this one returns (or higher prio becomes pending in 2-prio scheme)
 
 	IRQ_DISABLE
@@ -203,7 +203,7 @@ restore_regs:
 	ld	r0, [sp, PT_status32]	; U/K mode at time of entry
 	lr	r10, [AUX_IRQ_ACT]
 
-	bmsk	r11, r10, 15	; AUX_IRQ_ACT.ACTIVE
+	bmsk	r11, r10, 15		; extract AUX_IRQ_ACT.active
 	breq	r11, 0, .Lexcept_ret	; No intr active, ret from Exception
 
 ;####### Return from Intr #######
@@ -247,8 +247,8 @@ debug_marker_syscall:
 ;
 ; IRQ RTIE won't reliably restore DE bit and/or BTA, needs workaround
 ;
-; Solution is return from Intr w/o any delay slot quirks into a kernel trampoline
-; and from pure kernel mode return to delay slot which handles DS bit/BTA correctly
+; Solution is to drop out of interrupt context into pure kernel mode
+; and return from pure kernel mode which does right things for delay slot
 
 .Lintr_ret_to_delay_slot:
 debug_marker_ds:
@@ -257,48 +257,9 @@ debug_marker_ds:
 	add	r2, r2, 1
 	st	r2, [@intr_to_DE_cnt]
 
-	ld	r2, [sp, PT_ret]
-	ld	r3, [sp, PT_status32]
-
-	; STAT32 for Int return created from scratch
-	; (No delay dlot, disable Further intr in trampoline)
-
-	bic  	r0, r3, STATUS_U_MASK|STATUS_DE_MASK|STATUS_IE_MASK|STATUS_L_MASK
-	st	r0, [sp, PT_status32]
-
-	mov	r1, .Lintr_ret_to_delay_slot_2
-	st	r1, [sp, PT_ret]
-
-	; Orig exception PC/STAT32 safekept @orig_r0 and @event stack slots
-	st	r2, [sp, 0]
-	st	r3, [sp, 4]
-
-	b	.Lisr_ret_fast_path
-
-.Lintr_ret_to_delay_slot_2:
-	; Trampoline to restore orig exception PC/STAT32/BTA/AUX_USER_SP
-	sub	sp, sp, SZ_PT_REGS
-	st	r9, [sp, -4]
-
-	ld	r9, [sp, 0]
-	sr	r9, [eret]
-
-	ld	r9, [sp, 4]
-	sr	r9, [erstatus]
-
-	; restore AUX_USER_SP if returning to U mode
-	bbit0	r9, STATUS_U_BIT, 1f
-	ld	r9, [sp, PT_sp]
-	sr	r9, [AUX_USER_SP]
-
-1:
-	ld	r9, [sp, 8]
-	sr	r9, [erbta]
-
-	ld	r9, [sp, -4]
-	add	sp, sp, SZ_PT_REGS
-
-	; return from pure kernel mode to delay slot
-	rtie
+	; drop out of interrupt context (clear AUX_IRQ_ACT.active)
+	bmskn	r11, r10, 15
+	sr	r11, [AUX_IRQ_ACT]
+	b	.Lexcept_ret
 
 END(ret_from_exception)
-- 
2.7.4

