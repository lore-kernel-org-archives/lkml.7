Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE06CC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D7B20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557237351;
	bh=4YXwuQ8n+Mqq/6UmCl8odTutlhbgLjaGJtxDalHRu+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2kzFKZGxFhX4o3RFV/YS1s0huLw+b+86RjA851CkVxYdSqM4ZVRpe4CnLDx0KcvQs
	 Dw3CddH3PwaEwGLLiHDUCv3qivnutchPlVD4DXeo8Yl5RSaP7XmJVBUx7AMBp7WH2x
	 HHguQ9DaA8HqkfiBpZh22Wz73Y2okeJQZZ7IGSdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfEGNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfEGNzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:55:47 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A7B20825;
        Tue,  7 May 2019 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557237346;
        bh=4YXwuQ8n+Mqq/6UmCl8odTutlhbgLjaGJtxDalHRu+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnafkpE4qlw7jKn8s8/zR35xVN0A8YHgDu53f0ErqhVo9cl+t0GSODeCMIPeFNUD+
         ASTPNHetdXRiS3KHVFxdOso5hIJuCfm85Hqe3d18XHoJ0vJ48Bbfb/0FPAgl79K28z
         PvfKleyRjtnL77GBp0t4FUNToyEpOP+3jxLvFgtQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] tracing: uprobes: Re-enable $comm support for uprobe events
Date:   Tue,  7 May 2019 22:55:41 +0900
Message-Id: <155723734162.9149.4042756162201097965.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155723732200.9149.10482668315693777743.stgit@devnote2>
References: <155723732200.9149.10482668315693777743.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Andreas Ziegler <andreas.ziegler@fau.de>
Acked-by: Andreas Ziegler <andreas.ziegler@fau.de>
---
  Changes in v3
   - Always add +1 to strlen() result.
   - Use -ECOMM as a token to specify current->comm.
---
 kernel/trace/trace_probe.h  |    1 +
 kernel/trace/trace_uprobe.c |   13 +++++++++++--
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

