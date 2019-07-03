Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DE8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3881218BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGCOsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCOsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:48:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7157F21882;
        Wed,  3 Jul 2019 14:48:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1higYn-0005hY-Iw; Wed, 03 Jul 2019 10:48:37 -0400
Message-Id: <20190703144837.476653870@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 10:47:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [for-linus][PATCH 2/5] ftrace/x86: Add a comment to why we take text_mutex in
 ftrace_arch_code_modify_prepare()
References: <20190703144741.181267753@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Taking the text_mutex in ftrace_arch_code_modify_prepare() is to fix a
race against module loading and live kernel patching that might try to
change the text permissions while ftrace has it as read/write. This
really needs to be documented in the code. Add a comment that does such.

Link: http://lkml.kernel.org/r/20190627211819.5a591f52@gandalf.local.home

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 33786044d5ac..d7e93b2783fd 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -36,6 +36,11 @@
 
 int ftrace_arch_code_modify_prepare(void)
 {
+	/*
+	 * Need to grab text_mutex to prevent a race from module loading
+	 * and live kernel patching from changing the text permissions while
+	 * ftrace has it set to "read/write".
+	 */
 	mutex_lock(&text_mutex);
 	set_kernel_text_rw();
 	set_all_modules_text_rw();
-- 
2.20.1


