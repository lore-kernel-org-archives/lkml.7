Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D55421726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfEHUZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbfEHUYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4E4217F4;
        Wed,  8 May 2019 20:24:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7U-0007gJ-FV; Wed, 08 May 2019 16:24:52 -0400
Message-Id: <20190508202452.369559913@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 04/13] tracing: uprobes: Re-enable $comm support for uprobe events
References: <20190508202427.252736423@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since commit 533059281ee5 ("tracing: probeevent: Introduce new
argument fetching code") dropped the $comm support from uprobe
events, this re-enables it.

For $comm support, uses strlcpy() instead of strncpy_from_user()
to copy current task's comm. Because it is in the kernel space,
strncpy_from_user() always fails to copy the comm.
This also uses strlen() instead of strnlen_user() to measure the
length of the comm.

Note that this uses -ECOMM as a token value to fetch the comm
string. If the user-space pointer points -ECOMM, it will be
translated to task->comm.

Link: http://lkml.kernel.org/r/155723734162.9149.4042756162201097965.stgit@devnote2

Fixes: 533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
Reported-by: Andreas Ziegler <andreas.ziegler@fau.de>
Acked-by: Andreas Ziegler <andreas.ziegler@fau.de>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.h  |  1 +
 kernel/trace/trace_uprobe.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index b7737666c1a8..f9a8c632188b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -124,6 +124,7 @@ struct fetch_insn {
 
 /* fetch + deref*N + store + mod + end <= 16, this allows N=12, enough */
 #define FETCH_INSN_MAX	16
+#define FETCH_TOKEN_COMM	(-ECOMM)
 
 /* Fetch type information table */
 struct fetch_type {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index cd8750a72768..eb7e06b54741 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	if (unlikely(!maxlen))
 		return -ENOMEM;
 
-	ret = strncpy_from_user(dst, src, maxlen);
+	if (addr == FETCH_TOKEN_COMM)
+		ret = strlcpy(dst, current->comm, maxlen);
+	else
+		ret = strncpy_from_user(dst, src, maxlen);
 	if (ret >= 0) {
 		if (ret == maxlen)
 			dst[ret - 1] = '\0';
@@ -180,7 +183,10 @@ fetch_store_strlen(unsigned long addr)
 	int len;
 	void __user *vaddr = (void __force __user *) addr;
 
-	len = strnlen_user(vaddr, MAX_STRING_SIZE);
+	if (addr == FETCH_TOKEN_COMM)
+		len = strlen(current->comm) + 1;
+	else
+		len = strnlen_user(vaddr, MAX_STRING_SIZE);
 
 	return (len > MAX_STRING_SIZE) ? 0 : len;
 }
@@ -220,6 +226,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	case FETCH_OP_IMM:
 		val = code->immediate;
 		break;
+	case FETCH_OP_COMM:
+		val = FETCH_TOKEN_COMM;
+		break;
 	case FETCH_OP_FOFFS:
 		val = translate_user_vaddr(code->immediate);
 		break;
-- 
2.20.1


