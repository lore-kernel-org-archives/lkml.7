Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B99ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C861121655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YsMF0lp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfJGLX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:23:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfJGLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R+qnu2hRoP/bdCAOYjqTItUQ3vLpj/a9EFhgoM1DLXA=; b=YsMF0lp3jZSSgsYafmaApw9Kvy
        PN0GKPTsbDEghZWxh8YUYUE1FxBRRDWdE5tZm97u3OhPP+8hqtMbLoQjEK0T4CwFOhBjhXeWdhIFK
        ym4HSgu2jffK1yHJvg/GViJTLQWx5AbAq28uo1dM7gxngTEXLexVlrDVT14uHXBy+qHKEUTudpkcI
        OX1KxPupmSIrRzBfyelyL4YqWRGZpO2VggilLjOII/sgKspTj8WvuAZG4Fsp7QM9lU402nQVOiiUt
        QDc/zZdOL+pREdSenq9/oeHWORC8AdYOQPk2kQQaReO1oM0s0rHbluU1Ewrlxtt6LqwyyWmpi2pgj
        P+g1Qfug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6x-0002BK-NH; Mon, 07 Oct 2019 11:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BC29307383;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F259120244F8E; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007090011.94810887.8@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 3/9] jump_label, x86: Remove init NOP optimization
References: <20191007084443.79370128.1@infradead.org>
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
@@ -137,21 +137,10 @@ __init_or_module void arch_jump_label_tr
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
 		jump_label_transform(entry, type, 1);
 }


