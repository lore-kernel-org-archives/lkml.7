Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E276C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34212214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="roZuExGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKKOr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfKKOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TjyDEh8C28K6PfcmZCallRBiJEgYFMbz6s05aN+pBGw=; b=roZuExGIiwpq8WdZnG9xwc8YtH
        LsCbWIuCyQIeeca+gG1pArL3fCPM/wm8AGM+J7ohpIxp/J4aDEa2xL5z+NpNqzLuZY2EbPoooZgTe
        ZnEjj1q8OU6pz6VAmO26EOMQi/rCaCbwuxBlCxJaCwih/wEYBLF05E0qwmry+KaWgCjGHbX6+iJte
        DeEH86k1c68OM9WLkCv4ENazAx90k3N7Ugvw4MJ6MPuI2Bz8kLcWlWxAUbuCYuS80KJiP5woSXPvN
        rHjl4eKIIGPN2qGPw8t4Wgq2Lyshn8Q6f6AC+7IgdCLsaxnBE20DZLLpFB1aVGhkHXTqoYqPyPkWs
        S75mEIXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAyB-0006a3-Kc; Mon, 11 Nov 2019 14:47:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14FA03070D5;
        Mon, 11 Nov 2019 15:45:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 948C129A37A8D; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111132457.989922744@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:13:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH -v5 09/17] x86/alternative: Remove text_poke_loc::len
References: <20191111131252.921588318@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the BUG_ON(len != insn.length) in text_poke_loc_init(), tp->len
must indeed be the same as text_opcode_size(tp->opcode). Use this to
remove this field from the structure.

Sadly, due to 8 byte alignment, this only increases the structure
padding.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -938,7 +938,6 @@ static void do_sync_core(void *info)
 
 struct text_poke_loc {
 	void *addr;
-	int len;
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
@@ -965,6 +964,7 @@ int notrace poke_int3_handler(struct pt_
 {
 	struct text_poke_loc *tp;
 	void *ip;
+	int len;
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
@@ -1004,7 +1004,8 @@ int notrace poke_int3_handler(struct pt_
 			return 0;
 	}
 
-	ip += tp->len;
+	len = text_opcode_size(tp->opcode);
+	ip += len;
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
@@ -1085,10 +1086,12 @@ static void text_poke_bp_batch(struct te
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		if (tp[i].len - sizeof(int3) > 0) {
+		int len = text_opcode_size(tp[i].opcode);
+
+		if (len - sizeof(int3) > 0) {
 			text_poke((char *)tp[i].addr + sizeof(int3),
 				  (const char *)tp[i].text + sizeof(int3),
-				  tp[i].len - sizeof(int3));
+				  len - sizeof(int3));
 			do_sync++;
 		}
 	}
@@ -1141,7 +1144,6 @@ void text_poke_loc_init(struct text_poke
 	BUG_ON(len != insn.length);
 
 	tp->addr = addr;
-	tp->len = len;
 	tp->opcode = insn.opcode.bytes[0];
 
 	switch (tp->opcode) {


