Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCFFCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0314421897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GkMlMmdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504848AbfJRHwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:52:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504813AbfJRHvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8DVkfpEw5rYdUnaM+NBpjQJ6vzHDL9N060qKRsLkW1I=; b=GkMlMmdv6hw3QrA4FBLYlg1IRR
        Qb6LevrsX9rxAZoiUrtEIeipYjUzatMsxh9USIX9iYy39L0QB4GRJQ6G0naKWil1Kpixx0Sp+bnAt
        ctwstNh+btwG6Rs3QJWvmCbN8ALd9suq9R1bjGBSZs+ugxh8alwBKCtC3qJ+UQtOlePURzBK7HmNN
        L2L9sDGXMJy4WsAoQKqVcSQiF9Yotl0tKPcGKfBAFcCglTD4j1OtkerGg5oPi5JdePiLVoetO9vgH
        28Qnk8g2s9m0PbyNaDrrGB6vZsueuM4fIq9Np3xR8OEAX06PKt/DAamfwQyvqM5if0DXDUHNOarD2
        HBq1zhhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2d-0001Pz-V0; Fri, 18 Oct 2019 07:51:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57D16306D75;
        Fri, 18 Oct 2019 09:50:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 61EEC2B178119; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.687479693@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, rabin@rab.in,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, james.morse@arm.com
Subject: [PATCH v4 13/16] arm/ftrace: Use __patch_text_real()
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of flipping text protection, use the patch_text infrastructure
that uses a fixmap alias where required.

This removes the last user of set_all_modules_text_*().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: ard.biesheuvel@linaro.org
Cc: rabin@rab.in
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: james.morse@arm.com
---
 arch/arm/kernel/ftrace.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -22,6 +22,7 @@
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 #include <asm/set_memory.h>
+#include <asm/patch.h>
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define	NOP		0xf85deb04	/* pop.w {lr} */
@@ -31,13 +32,15 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+static int patch_text_remap = 0;
+
 static int __ftrace_modify_code(void *data)
 {
 	int *command = data;
 
-	set_kernel_text_rw();
+	patch_text_remap++;
 	ftrace_modify_all_code(*command);
-	set_kernel_text_ro();
+	patch_text_remap--;
 
 	return 0;
 }
@@ -59,13 +62,13 @@ static unsigned long adjust_address(stru
 
 int ftrace_arch_code_modify_prepare(void)
 {
-	set_all_modules_text_rw();
+	patch_text_remap++;
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
 {
-	set_all_modules_text_ro();
+	patch_text_remap--;
 	/* Make sure any TLB misses during machine stop are cleared. */
 	flush_tlb_all();
 	return 0;
@@ -97,10 +100,7 @@ static int ftrace_modify_code(unsigned l
 			return -EINVAL;
 	}
 
-	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
-		return -EPERM;
-
-	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
+	__patch_text_real((void *)pc, new, patch_text_remap);
 
 	return 0;
 }


