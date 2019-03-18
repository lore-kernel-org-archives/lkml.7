Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D391C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D17920880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cbkVUiF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfCRPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:53:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58718 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfCRPw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OXrTqMuylXpQnqjfLjKiLaVE2XD1S2ZTsJmOXFxtGlg=; b=cbkVUiF74uBUPTkYHN4WnV6w+w
        BkJ5sgN8qncBnLTubG/LF7aRuyI1X5z4z6CibzEOLqF7uvLcJxWV7MhoyHb0F/R9p7CxIE7iK0ebA
        VDqr5VsXvKY7Z2BWMq0zmbm9e5KzvdvKgDushMsvuOibUDG2G9A1kl8g8S6h/hesRm25zYYTIYDG1
        QAm1lBUi9B9MHuTxHCaE/ou4qFt4a5GAjOCEwmpec1vxGKjAqCbV62vl8zx+TmLTGs+dp7nb0f/bT
        OI0v6KvG4GLnZOWTPbAYwJFHYe1ihk52QfzGgsbI51Ob/BG/JgEC/ytZycB8i2KwBN+smrwYoz5Uy
        WuxWQblQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ9-0005V7-4N; Mon, 18 Mar 2019 15:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CB62E25E45D7B; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155141.280380020@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 15/25] x86/uaccess,ftrace: Fix ftrace_likely_update() vs SMAP
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CONFIG_TRACE_BRANCH_PROFILING the likely/unlikely things get
overloaded and generate callouts to this code, and thus also when
AC=1.

Make it safe.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/trace_branch.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -205,6 +205,8 @@ void trace_likely_condition(struct ftrac
 void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			  int expect, int is_constant)
 {
+	unsigned long flags = user_access_save();
+
 	/* A constant is always correct */
 	if (is_constant) {
 		f->constant++;
@@ -223,6 +225,8 @@ void ftrace_likely_update(struct ftrace_
 		f->data.correct++;
 	else
 		f->data.incorrect++;
+
+	user_access_restore(flags);
 }
 EXPORT_SYMBOL(ftrace_likely_update);
 


