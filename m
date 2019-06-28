Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50730C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D804208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPWl/bbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF1Ngb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:36:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfF1NgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9VFSmflzVfL3h4M0s7noQx6gwkm4hG7pGZRkMRfLWbM=; b=JPWl/bblnW5cuPRxlspzM1rMuX
        nNMSWENzk6AlZebLCBkpObaj0DJt5+6d4qayunBc2TEu8ZXcWewCWM2y9Ip9o/Bq6E8GhZ93xlSgr
        v8LLDmqcddMe7SgqN07yB7+W0LZmiv70Ks9hHnsnHFYQyN2e6zcT6RHd8x/r6CUBBbM5kx2+xJSwC
        jt3fSPW/0BMf8vDgb1lJh1Dq/jzd3084Y/TPcfC/j3dOjasW9vQsm97ZUirptpp9Ip/Tcxo7j+wyG
        ZqN/uMC5IMIU6Ap+cLdo7vQUWUBCIv77I4+RsPx24Znp+wFC4gcxOj/u13ooXVfdfeBGI87/8JpNI
        X8oigppw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr2r-0006t3-3Q; Fri, 28 Jun 2019 13:36:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8853F20AB8991; Fri, 28 Jun 2019 15:36:03 +0200 (CEST)
Message-Id: <20190628103224.659817235@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 12:21:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC][PATCH 4/8] jump_label, x86: Remove init NOP optimization
References: <20190628102113.360432762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking if the emitted (default) NOP is the ideal NOP, and
conditionally rewrite the NOP, just rewrite the NOP.

This shouldn't be a problem because init / module_load uses
text_poke_early() which is cheap and this saves us from having to go
figure out which NOP to compare against when we go variable size.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/jump_label.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -177,21 +177,10 @@ __init_or_module void arch_jump_label_tr
 				      enum jump_label_type type)
 {
 	/*
-	 * This function is called at boot up and when modules are
-	 * first loaded. Check if the default nop, the one that is
-	 * inserted at compile time, is the ideal nop. If it is, then
-	 * we do not need to update the nop, and we can leave it as is.
-	 * If it is not, then we need to update the nop to the ideal nop.
+	 * Rewrite the NOP on init / module-load to ensure we got the ideal
+	 * nop.  Don't bother with trying to figure out what size and what nop
+	 * it should be for now, simply do an unconditional rewrite.
 	 */
-	if (jlstate == JL_STATE_START) {
-		const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-		const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-
-		if (memcmp(ideal_nop, default_nop, 5) != 0)
-			jlstate = JL_STATE_UPDATE;
-		else
-			jlstate = JL_STATE_NO_UPDATE;
-	}
-	if (jlstate == JL_STATE_UPDATE)
+	if (jlstate == JL_STATE_UPDATE || jlstate == JL_STATE_START)
 		__jump_label_transform(entry, type, 1);
 }


