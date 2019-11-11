Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E44C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1E0214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MhtjAktE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKKOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfKKOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4svTgr24B3DFbicDirGPWmJ5CQkIQvaSubBKnXTLtnY=; b=MhtjAktEDsF6spFEpXZMI8txgn
        0x2rI54GtKHzBZGVa+3rWTHXiIkZB/i2WDwMtRzZZ3PcG9mMil9JRtKuOVO1pdxzFcrCAUaBJd/V5
        geESq1a0IR9D7SX2SrV/vb359RZ7BnzCxxeDwk5uJhCRxYxeBxIY2mgPfXIoPPX+HRUcLFF2grUQR
        Ecs37vwT4W3Sq+x9vd2wBCIhKx0faEVYc/6nUi9CXR5xEsJ4jLKxIoYdsD5Qx0qgN7D6Ig2nvbm7h
        PCJnxD4YexiNnCYhSHqkHGHI4iONZ3FaeGKi+KMy2m3Hu2WXlfcarBZXigdSPqZoRHGi3VPpLjTbN
        7iC0TuzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAy9-0006Zh-SM; Mon, 11 Nov 2019 14:47:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E075B306E66;
        Mon, 11 Nov 2019 15:45:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 995C529A37A8E; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111132458.047052889@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:13:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH -v5 10/17] x86/alternative: Shrink text_poke_loc
References: <20191111131252.921588318@infradead.org>
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


