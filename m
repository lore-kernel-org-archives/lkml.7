Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A101C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33869218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfGCOsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfGCOsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:48:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68DB218B0;
        Wed,  3 Jul 2019 14:48:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1higYo-0005j2-1X; Wed, 03 Jul 2019 10:48:38 -0400
Message-Id: <20190703144837.933522724@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 10:47:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [for-linus][PATCH 5/5] ftrace/x86: Anotate text_mutex split between
 ftrace_arch_code_modify_post_process() and ftrace_arch_code_modify_prepare()
References: <20190703144741.181267753@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

ftrace_arch_code_modify_prepare() is acquiring text_mutex, while the
corresponding release is happening in ftrace_arch_code_modify_post_process().

This has already been documented in the code, but let's also make the fact
that this is intentional clear to the semantic analysis tools such as sparse.

Link: http://lkml.kernel.org/r/nycvar.YFH.7.76.1906292321170.27227@cbobk.fhfr.pm

Fixes: 39611265edc1a ("ftrace/x86: Add a comment to why we take text_mutex in ftrace_arch_code_modify_prepare()")
Fixes: d5b844a2cf507 ("ftrace/x86: Remove possible deadlock between register_kprobe() and ftrace_run_update_code()")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index d7e93b2783fd..76228525acd0 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -35,6 +35,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 int ftrace_arch_code_modify_prepare(void)
+    __acquires(&text_mutex)
 {
 	/*
 	 * Need to grab text_mutex to prevent a race from module loading
@@ -48,6 +49,7 @@ int ftrace_arch_code_modify_prepare(void)
 }
 
 int ftrace_arch_code_modify_post_process(void)
+    __releases(&text_mutex)
 {
 	set_all_modules_text_ro();
 	set_kernel_text_ro();
-- 
2.20.1


