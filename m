Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4134C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBA325375
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190200;
	bh=N70H1+R5SeViVNqndvuL3AyU8G493F/y+Q0HGRBG2lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHgMK0Nx+vf6nf1sn9hgjAfuL0t7hexO7ZUJ3Mwa+uily5EwW13vn63+7oIJuEZ/f
	 oO6Dq7VytfcSbvyBrfUPv92ISoCLLpYJOV9qsXBuoUc4o2x61zt9J6sL0r1dNcQLYw
	 RkTRJlgSqaR93ORq1cHGUDkW46F0AGQxiQLZTx3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfE3EXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbfE3DPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:02 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3172F24569;
        Thu, 30 May 2019 03:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186102;
        bh=N70H1+R5SeViVNqndvuL3AyU8G493F/y+Q0HGRBG2lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXnl4vYcKm2WG5S/RVNYf+BrneYDwLWDVYAZ2s3RpKHNUpb1lnmunXFTVmsduMBD6
         BK4BJnr/qN0XKZazyWUtVa532cnOz7NXgCsVfoadibNOaQJbEHTrcQ9AoWRBPTa8Ke
         bAREKh8hJNd9wY7OnSiMX13Bxs3orbSwRs3eRwAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 240/346] x86/uaccess, ftrace: Fix ftrace_likely_update() vs. SMAP
Date:   Wed, 29 May 2019 20:05:13 -0700
Message-Id: <20190530030553.190825923@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4a6c91fbdef846ec7250b82f2eeeb87ac5f18cf9 ]

For CONFIG_TRACE_BRANCH_PROFILING=y the likely/unlikely things get
overloaded and generate callouts to this code, and thus also when
AC=1.

Make it safe.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_branch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index 4ad967453b6fb..3ea65cdff30d5 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -205,6 +205,8 @@ void trace_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			  int expect, int is_constant)
 {
+	unsigned long flags = user_access_save();
+
 	/* A constant is always correct */
 	if (is_constant) {
 		f->constant++;
@@ -223,6 +225,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 		f->data.correct++;
 	else
 		f->data.incorrect++;
+
+	user_access_restore(flags);
 }
 EXPORT_SYMBOL(ftrace_likely_update);
 
-- 
2.20.1



