Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024EAC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C580A2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EdkjMnpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfEQTcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:32:31 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:34288 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727714AbfEQTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:32:29 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C93D4C00F9;
        Fri, 17 May 2019 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558121554; bh=xj+F4rfsxPPtbg7rvu15yyPc1Q9tuWTngEt3T6FetdM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=EdkjMnpoDQjbzQh9Nt1lWDwpjgJn7PF8Q0X8Qm7hR9yByETbeVGrEbpzO2hJSLQLN
         OrVITMgb/R71E4gqztetiyedpqIKRru2BdS7NdvXckcALDmkpuiPMb1FrYwwGxiclO
         rFbpyYZQJ26NamI5LHoeqig/J3izFeXYKJ26xrk7XU3bYSOAN0sjd8uUV/EWLnWgKG
         xyvcjk7ft/AhGMiUEQq3afsoHPRSXJl49OFp7CwHd95fpXQGrZ2uU49aaFtj5y5UD2
         iWNNtUXeGHW/1XnZ/smxcyvYfXSHmjwsQoERQ8/eQRjzXmXSdxhcyOV/mKkIiL/QbQ
         1eki3IkRM3SLg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AE188A009C;
        Fri, 17 May 2019 19:32:27 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 May 2019 12:32:26 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:37 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:25 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 2/5] ARCv2: entry: push out the Z flag unclobber from common EXCEPTION_PROLOGUE
Date:   Fri, 17 May 2019 12:32:05 -0700
Message-ID: <1558121528-30184-3-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
References: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon a taken interrupt/exception from User mode, HS hardware auto sets Z flag.
This helps shave a few instructions from EXCEPTION_PROLOGUE by eliding
re-reading ERSTATUS and some bit fiddling.

However TLB Miss Exception handler can clobber the CPU flags and still end
up in EXCEPTION_PROLOGUE in the slow path handling TLB handling case:

   EV_TLBMissD
     do_slow_path_pf
       EV_TLBProtV (aliased to call_do_page_fault)
          EXCEPTION_PROLOGUE

As a result, EXCEPTION_PROLOGUE need to "unclobber" the Z flag which this
patch changes. It is now pushed out to TLB Miss Exception handler.
The reasons beings:

 - The flag restoration is only needed for slowpath TLB Miss Exception
   handling, but currently being in EXCEPTION_PROLOGUE penalizes all
   exceptions such as ProtV and syscall Trap, where Z flag is already
   as expected.

 - Pushing unclobber out to where it was clobbered is much cleaner and
   also serves to document the fact.

 - Makes EXCEPTION_PROLGUE similar to INTERRUPT_PROLOGUE so easier to
   refactor the common parts which is what this series aims to do

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-arcv2.h |  8 --------
 arch/arc/mm/tlbex.S                | 11 +++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 1c3520d1fa42..3209a6762960 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -225,14 +225,6 @@
 
 	; -- for interrupts, regs above are auto-saved by h/w in that order --
 	; Now do what ISR prologue does (manually save r12, sp, fp, gp, r25)
-	;
-	; Set Z flag if this was from U mode (expected by INTERRUPT_PROLOGUE)
-	; Although H/w exception micro-ops do set Z flag for U mode (just like
-	; for interrupts), it could get clobbered in case we soft land here from
-	; a TLB Miss exception handler (tlbex.S)
-
-	and	r10, r10, STATUS_U_MASK
-	xor.f	0, r10, STATUS_U_MASK
 
 	INTERRUPT_PROLOGUE  exception
 
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 0e1e47a67c73..e50cac799a51 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -396,6 +396,17 @@ EV_TLBMissD_fast_ret:	; additional label for VDK OS-kit instrumentation
 ;-------- Common routine to call Linux Page Fault Handler -----------
 do_slow_path_pf:
 
+#ifdef CONFIG_ISA_ARCV2
+	; Set Z flag if exception in U mode. Hardware micro-ops do this on any
+	; taken interrupt/exception, and thus is already the case at the entry
+	; above, but ensuing code would have already clobbered.
+	; EXCEPTION_PROLOGUE called in slow path, relies on correct Z flag set
+
+	lr	r2, [erstatus]
+	and	r2, r2, STATUS_U_MASK
+	bxor.f	0, r2, STATUS_U_BIT
+#endif
+
 	; Restore the 4-scratch regs saved by fast path miss handler
 	TLBMISS_RESTORE_REGS
 
-- 
2.7.4

