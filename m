Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDB9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F9C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k/5zuk7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbfHZM5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:57:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbfHZM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5S/0Z+r468D5gRX7s/ck6KZRV7OfOo9+an+YYb8Q3Y8=; b=k/5zuk7ooZtnOSPO3/j1VFx0tX
        RFGgnlY7MMft9xHSctoSAyOORhOKHlUNg/LfEq1bcDhS6+s3kg7h+aTDaADOLM5+kerES30QsOhSU
        EH1appUbgOE7z04bS4Xecmgc2yu5TyUowna2qhTI2lMirDjqSb1TiUQaIBwyfuQg5zjWyEVHIOUxL
        Cquvc+ZHNXHhVbZZTe2E0Z+yCXT1hhQtPSddjsoj2+O2idKyX1fpquHQfLYen6uIqYKk7MKShw4/C
        zlXKRats5apxMDBbR/pmNrygMuTJRXjwyub5hlRUy8Gv4fsUr6Bx7f6RqSYK0vF3hXkJ4mVZ+KSUI
        srBZaw0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2EYa-0004Td-Jc; Mon, 26 Aug 2019 12:57:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EEF7307602;
        Mon, 26 Aug 2019 14:56:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 81E3320A71EF4; Mon, 26 Aug 2019 14:57:10 +0200 (CEST)
Message-Id: <20190826125519.798115791@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 26 Aug 2019 14:51:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] x86/alternatives: Move tp_vec
References: <20190826125138.710718863@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow other users to make use of the tp_vec; move it near
the text_poke_bp_batch() code, instead of keeping it in the jump_label
code.

Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |    4 ++++
 arch/x86/kernel/alternative.c        |    3 +++
 arch/x86/kernel/jump_label.c         |   25 ++++++++++++-------------
 3 files changed, 19 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -60,6 +60,10 @@ extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
 
+#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
+extern struct text_poke_loc tp_vec[TP_VEC_MAX];
+extern int tp_vec_nr;
+
 #ifndef CONFIG_UML_X86
 static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
 {
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1017,6 +1017,9 @@ int poke_int3_handler(struct pt_regs *re
 }
 NOKPROBE_SYMBOL(poke_int3_handler);
 
+struct text_poke_loc tp_vec[TP_VEC_MAX];
+int tp_vec_nr;
+
 /**
  * text_poke_bp_batch() -- update instructions on live kernel on SMP
  * @tp:			vector of instructions to patch
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -100,15 +100,12 @@ void arch_jump_label_transform(struct ju
 	mutex_unlock(&text_mutex);
 }
 
-#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
-static struct text_poke_loc tp_vec[TP_VEC_MAX];
-static int tp_vec_nr;
-
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
 	struct text_poke_loc *tp;
 	void *entry_code;
+	bool ret = true;
 
 	if (system_state == SYSTEM_BOOTING) {
 		/*
@@ -118,12 +115,15 @@ bool arch_jump_label_transform_queue(str
 		return true;
 	}
 
+	mutex_lock(&text_mutex);
 	/*
 	 * No more space in the vector, tell upper layer to apply
 	 * the queue before continuing.
 	 */
-	if (tp_vec_nr == TP_VEC_MAX)
-		return false;
+	if (tp_vec_nr == TP_VEC_MAX) {
+		ret = false;
+		goto unlock;
+	}
 
 	tp = &tp_vec[tp_vec_nr];
 
@@ -151,20 +151,19 @@ bool arch_jump_label_transform_queue(str
 	text_poke_loc_init(tp, entry_code, NULL, JUMP_LABEL_NOP_SIZE, NULL);
 
 	tp_vec_nr++;
+unlock:
+	mutex_unlock(&text_mutex);
 
-	return true;
+	return ret;
 }
 
 void arch_jump_label_transform_apply(void)
 {
-	if (!tp_vec_nr)
-		return;
-
 	mutex_lock(&text_mutex);
-	text_poke_bp_batch(tp_vec, tp_vec_nr);
-	mutex_unlock(&text_mutex);
-
+	if (tp_vec_nr)
+		text_poke_bp_batch(tp_vec, tp_vec_nr);
 	tp_vec_nr = 0;
+	mutex_unlock(&text_mutex);
 }
 
 static enum {


