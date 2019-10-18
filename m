Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BDC222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FTfMehUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504724AbfJRHv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391192AbfJRHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4svTgr24B3DFbicDirGPWmJ5CQkIQvaSubBKnXTLtnY=; b=FTfMehUSzUJ0WYGWokzcPFTils
        j7xgBU3sjOT8s3IpsAeuzdN3eOGPbvrovYJut0cHKWH9uw00J9rRFBEfBKr3O8ZQL+F/AN3AbMsav
        7vUpbO2igZzn3qzuCKLaf4KgWK3Bj+62B1L+1rLmiuZzmInpmv5fqCY4Pc6WQBQIE+c+zHDf5cP4l
        OJ4GZWnzi6QQmvZnxVdr0ux3NyL4EJ2vD41ssJ28hLGNfZWUmcjJ4N6SR7geCPBCqfqXCZyUd5uoK
        WsiPxaY4xX8aPdOFlsSlKgbMDod8iDKvzFnBjHR0N4EcGvYuULDE+B/j7rBHZhYlJpCF18v2ZDBoC
        qFMZWjEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2c-0001NN-5J; Fri, 18 Oct 2019 07:51:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 131D8306BB9;
        Fri, 18 Oct 2019 09:50:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 53FC92B178115; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.514629541@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 10/16] x86/alternative: Shrink text_poke_loc
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Employ the fact that all text must be within a s32 displacement of one
another to shrink the text_poke_loc::addr field. Make it relative to
_stext.

This then shrinks struct text_poke_loc to 16 bytes, and consequently
increases TP_VEC_MAX from 170 to 256.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -937,7 +937,7 @@ static void do_sync_core(void *info)
 }
 
 struct text_poke_loc {
-	void *addr;
+	s32 rel_addr; /* addr := _stext + rel_addr */
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
@@ -948,13 +948,18 @@ static struct bp_patching_desc {
 	int nr_entries;
 } bp_patching;
 
+static inline void *text_poke_addr(struct text_poke_loc *tp)
+{
+	return _stext + tp->rel_addr;
+}
+
 static int notrace patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
-	if (key < tp->addr)
+	if (key < text_poke_addr(tp))
 		return -1;
-	if (key > tp->addr)
+	if (key > text_poke_addr(tp))
 		return 1;
 	return 0;
 }
@@ -1000,7 +1005,7 @@ int notrace poke_int3_handler(struct pt_
 			return 0;
 	} else {
 		tp = bp_patching.vec;
-		if (tp->addr != ip)
+		if (text_poke_addr(tp) != ip)
 			return 0;
 	}
 
@@ -1078,7 +1083,7 @@ static void text_poke_bp_batch(struct te
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < nr_entries; i++)
-		text_poke(tp[i].addr, &int3, sizeof(int3));
+		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
@@ -1089,7 +1094,7 @@ static void text_poke_bp_batch(struct te
 		int len = text_opcode_size(tp[i].opcode);
 
 		if (len - sizeof(int3) > 0) {
-			text_poke((char *)tp[i].addr + sizeof(int3),
+			text_poke(text_poke_addr(&tp[i]) + sizeof(int3),
 				  (const char *)tp[i].text + sizeof(int3),
 				  len - sizeof(int3));
 			do_sync++;
@@ -1113,7 +1118,7 @@ static void text_poke_bp_batch(struct te
 		if (tp[i].text[0] == INT3_INSN_OPCODE)
 			continue;
 
-		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
+		text_poke(text_poke_addr(&tp[i]), tp[i].text, sizeof(int3));
 		do_sync++;
 	}
 
@@ -1143,7 +1148,7 @@ void text_poke_loc_init(struct text_poke
 	BUG_ON(!insn_complete(&insn));
 	BUG_ON(len != insn.length);
 
-	tp->addr = addr;
+	tp->rel_addr = addr - (void *)_stext;
 	tp->opcode = insn.opcode.bytes[0];
 
 	switch (tp->opcode) {
@@ -1192,7 +1197,7 @@ static bool tp_order_fail(void *addr)
 		return true;
 
 	tp = &tp_vec[tp_vec_nr - 1];
-	if ((unsigned long)tp->addr > (unsigned long)addr)
+	if ((unsigned long)text_poke_addr(tp) > (unsigned long)addr)
 		return true;
 
 	return false;


