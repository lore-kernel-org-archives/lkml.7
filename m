Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8FBC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4392085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TkB92hAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfCRPw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:52:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfCRPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NlyhOqhTVrpUrt4zBj8Q7r+TPq1L3DgnUugws9Cn/PA=; b=TkB92hAletfOQZNkNzvpEzfazv
        P4mBonFuK+Zg3k+XjLrLjqAUsrtAK1UZ+ykbz2tucQ+odUcdrFLzyPk0BLKaFjMFF6ipIX3Ta8HD0
        YHK2et4rD4cQLrFRZdJhlme+765rAWlUhm3dOeeLl46cTMcnswVVojkSs9e/pedeHApQvfMg2cXdy
        C6KVCKKXBsznu00x6pKl2hvbFkCt862grm41IM32JYpjEPdBtfof09gFKN/eGewtwkzOuBVqAvgBj
        CYVv/j68wVJoyhlvK/A7eT0gQaLLwXY6D/l8D46jkQupOFHOLMxhc4iIjLKCoKZvpNXyaLH6BJhou
        GHok3IGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ7-0006iR-C3; Mon, 18 Mar 2019 15:52:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8A37C25E45D6C; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155140.156753404@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 03/25] x86/ia32: Fix ia32_restore_sigcontext AC leak
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool spotted that we call native_load_gs_index() with AC set.
Re-arrange the code to avoid that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 321fe5f5d0e9..4d5fcd47ab75 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -61,9 +61,8 @@
 } while (0)
 
 #define RELOAD_SEG(seg)		{		\
-	unsigned int pre = GET_SEG(seg);	\
+	unsigned int pre = (seg) | 3;		\
 	unsigned int cur = get_user_seg(seg);	\
-	pre |= 3;				\
 	if (pre != cur)				\
 		set_user_seg(seg, pre);		\
 }
@@ -72,6 +71,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 				   struct sigcontext_32 __user *sc)
 {
 	unsigned int tmpflags, err = 0;
+	u16 gs, fs, es, ds;
 	void __user *buf;
 	u32 tmp;
 
@@ -79,16 +79,10 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	current->restart_block.fn = do_no_restart_syscall;
 
 	get_user_try {
-		/*
-		 * Reload fs and gs if they have changed in the signal
-		 * handler.  This does not handle long fs/gs base changes in
-		 * the handler, but does not clobber them at least in the
-		 * normal case.
-		 */
-		RELOAD_SEG(gs);
-		RELOAD_SEG(fs);
-		RELOAD_SEG(ds);
-		RELOAD_SEG(es);
+		gs = GET_SEG(gs);
+		fs = GET_SEG(fs);
+		ds = GET_SEG(ds);
+		es = GET_SEG(es);
 
 		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
 		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
@@ -106,6 +100,17 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 		buf = compat_ptr(tmp);
 	} get_user_catch(err);
 
+	/*
+	 * Reload fs and gs if they have changed in the signal
+	 * handler.  This does not handle long fs/gs base changes in
+	 * the handler, but does not clobber them at least in the
+	 * normal case.
+	 */
+	RELOAD_SEG(gs);
+	RELOAD_SEG(fs);
+	RELOAD_SEG(ds);
+	RELOAD_SEG(es);
+
 	err |= fpu__restore_sig(buf, 1);
 
 	force_iret();


