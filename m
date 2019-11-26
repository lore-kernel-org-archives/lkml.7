Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA5CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A11206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="F+CezjWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfKZMg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:36:26 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:25835 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbfKZMgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:36:17 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Mk0Z3Hlmz9v0G8;
        Tue, 26 Nov 2019 13:36:14 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=F+CezjWa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5NS0X-0jvC8c; Tue, 26 Nov 2019 13:36:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Mk0Z2F25z9v0G3;
        Tue, 26 Nov 2019 13:36:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574771774; bh=SuQxAQ4l/1mHGi45aVKRS3CT3WsuP/jKyi3kssGze6g=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=F+CezjWaWcLVWwfzSbZHbxkNkW2eY/uQkx1c6+/ORauptQeeDq/bsmg1Xi1F4jEQ+
         YskD5wLgPMujZJMHQFfDf0v1sbPXZw9UF0LDlh/NdqEE4uJpVhhkawjz2Jm/TqJBEd
         V+UuRUJpq1oREQ/aC85ATds8+wi8jrcWF55Ee2tw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D43B8B7FC;
        Tue, 26 Nov 2019 13:36:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4rld6BwlFtzU; Tue, 26 Nov 2019 13:36:15 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6526D8B771;
        Tue, 26 Nov 2019 13:36:15 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EA2866B76A; Tue, 26 Nov 2019 12:36:14 +0000 (UTC)
Message-Id: <c893bfdf0ff385427f8013a2faa2643f6a7df6c7.1574771541.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1574771539.git.christophe.leroy@c-s.fr>
References: <cover.1574771539.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 11/16] powerpc/8xx: move DataStoreTLBMiss perf handler
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Tue, 26 Nov 2019 12:36:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move DataStoreTLBMiss perf handler in order to cope
with future growing exception prolog.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5aa63693f790..1e718e47fe3c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -166,18 +166,6 @@ SystemCall:
  */
 	EXCEPTION(0x1000, SoftEmu, program_check_exception, EXC_XFER_STD)
 
-/* Called from DataStoreTLBMiss when perf TLB misses events are activated */
-#ifdef CONFIG_PERF_EVENTS
-	patch_site	0f, patch__dtlbmiss_perf
-0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	addi	r10, r10, 1
-	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	mfspr	r10, SPRN_DAR
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	mfspr	r11, SPRN_M_TW
-	rfi
-#endif
-
 	. = 0x1100
 /*
  * For the MPC8xx, this is a software tablewalk to load the instruction
@@ -486,6 +474,18 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	/* 0x300 is DataAccess exception, needed by bad_page_fault() */
 	EXC_XFER_LITE(0x300, handle_page_fault)
 
+/* Called from DataStoreTLBMiss when perf TLB misses events are activated */
+#ifdef CONFIG_PERF_EVENTS
+	patch_site	0f, patch__dtlbmiss_perf
+0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	mfspr	r10, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_M_TW
+	rfi
+#endif
+
 /* On the MPC8xx, these next four traps are used for development
  * support of breakpoints and such.  Someday I will get around to
  * using them.
-- 
2.13.3

