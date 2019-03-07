Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC94C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1B2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AkQBaTly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfCGLyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:54:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfCGLwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OXrTqMuylXpQnqjfLjKiLaVE2XD1S2ZTsJmOXFxtGlg=; b=AkQBaTlybYokB3cj49A+mn6/Qv
        RLvWtmT1kqGrwDVQuHS79H1WiBQRx4TM5iXpHitLvNHWq5SqB4afpnFoaTwvcA6YkLZCouTiDHvX+
        aE1ekWOTjCPaaOs0EhuYlsahtnaxEjjXH7DI9isVMR72YOLpWipwPIsfg1lTUkBrmvCCJOzbh6GfJ
        A6CvcWO4E1f8+3tA0lyFOYIk/H4D3Z2V6WhPJvMjlA/xaOODUzl54LvKe/2eB7RIor8yOFOmbTPFY
        I6YrNmia8FwmRq0aZelhNBDbiTksc24oCkk74IR9Rg2RO/HqUxlJO0mijOJ/7DlwoMATD66gWwNYd
        vy76/EcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZm-0001Wi-Vy; Thu, 07 Mar 2019 11:52:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B714420297BDE; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115200.062030811@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 11/20] x86/uaccess,ftrace: Fix ftrace_likely_update() vs SMAP
References: <20190307114511.870090179@infradead.org>
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
 


