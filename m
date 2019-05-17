Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD7AC04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375EA2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WFw4Y3wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfEQTcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:32:39 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:37102 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727478AbfEQTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:32:37 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EFBCAC00EC;
        Fri, 17 May 2019 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558121546; bh=fAUxrkJtkHNBYPCF1Tt5XpGFd5OGsTKlAxmk7SradgE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WFw4Y3wt/jOdKlXfhkdDzdK1igXiJeh/rreyGpTFJ7xrpDjpU9pctp5cJD1xVE/oV
         m7MrlqYIGknu4/SsWx5E3vsPEOcOxsg5HHIJRP42Vnd1tGqNTLoq7SN2xNThRIEsBO
         Jz60ZB+KFnDSBqcus/ywMfCJixaEi3znzl1hWQlWBvOZAlKIcwmAEG5U/INxzeLzmg
         fZd0TOjVB3pkw/HsBmiBSCZuRp4VEnIg/9/6fwR2E97AElR3GtufqkVHoV8zzBcmmu
         FlhLBPLTP57XIZ15ZrUfQLiL7z4aQgXsFQkdpC3NBE424nEHJFO8+6JWRLwsat4m8v
         7ypKxY+QK7DTg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9CDECA005D;
        Fri, 17 May 2019 19:32:35 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 May 2019 12:32:35 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:43 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:31 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 5/5] ARC: entry: EV_Trap expects r10 (vs. r9) to have exception cause
Date:   Fri, 17 May 2019 12:32:08 -0700
Message-ID: <1558121528-30184-6-git-send-email-vgupta@synopsys.com>
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

avoids 1 MOV instruction in light of double load/store code

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-arcv2.h   | 3 +--
 arch/arc/include/asm/entry-compact.h | 4 ++--
 arch/arc/kernel/entry.S              | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 0733752ce7fe..f5ae394ebe06 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -95,9 +95,8 @@
 	lr	r10, [ecr]
 	lr	r11, [erbta]
 	ST2	r10, r11, PT_event
-	mov	r9, r10
 
-	; OUTPUT: r9 has ECR
+	; OUTPUT: r10 has ECR expected by EV_Trap
 .endm
 
 /*------------------------------------------------------------------------
diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 29f3988c9424..98aff149b344 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -198,8 +198,8 @@
 	PUSHAX  CTOP_AUX_EFLAGS
 #endif
 
-	lr	r9, [ecr]
-	st      r9, [sp, PT_event]    /* EV_Trap expects r9 to have ECR */
+	lr	r10, [ecr]
+	st      r10, [sp, PT_event]    /* EV_Trap expects r10 to have ECR */
 .endm
 
 /*--------------------------------------------------------------
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 85d9ea4a0acc..730b83ccfbc1 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -235,8 +235,8 @@ ENTRY(EV_Trap)
 	EXCEPTION_PROLOGUE
 
 	;============ TRAP 1   :breakpoints
-	; Check ECR for trap with arg (PROLOGUE ensures r9 has ECR)
-	bmsk.f 0, r9, 7
+	; Check ECR for trap with arg (PROLOGUE ensures r10 has ECR)
+	bmsk.f 0, r10, 7
 	bnz    trap_with_param
 
 	;============ TRAP  (no param): syscall top level
-- 
2.7.4

