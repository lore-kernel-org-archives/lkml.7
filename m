Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F4CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87CF222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l+bGO+Wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504769AbfJRHvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34270 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504755AbfJRHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TjyDEh8C28K6PfcmZCallRBiJEgYFMbz6s05aN+pBGw=; b=l+bGO+WvcWaMabDARaMfkLB+9j
        EEkLKqy+0BxNpKzHIHmNnQm5iKSwuftyoGDYqzC2J4Wx+lnHVetOScE19nIdB59hUtmEWWhhKNT6P
        e4ecWn8zQd4vUldhcvGS2vhCy7uhdEPcj/zptxQ+sG5PfyhjQtpTuRbG1D8TzE5morS32iGcbLrJv
        OC/iFiSPZ7eE98zX49ae4AJzq2BOLKxg2EPiqNz30PLgu6r0yDsrN37f57hCfE9FuROZJGU9xpY7l
        xV3FRTnE8AheF8w9GuzdvD1QT1Yf5cEQkQF7wuQ3yW8FtvowE4KoGEFSmceqTKI4iSPE15Betwz2R
        BAwPgmbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2b-0007mi-2i; Fri, 18 Oct 2019 07:51:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A756306BB8;
        Fri, 18 Oct 2019 09:50:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5095C2B178113; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.457534206@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 09/16] x86/alternative: Remove text_poke_loc::len
References: <20191018073525.768931536@infradead.org>
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


