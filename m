Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B545021726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfEHUZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbfEHUYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED6D217F9;
        Wed,  8 May 2019 20:24:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7U-0007gn-Ks; Wed, 08 May 2019 16:24:52 -0400
Message-Id: <20190508202452.530936142@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/13] tracing: probeevent: Do not accumulate on ret variable
References: <20190508202427.252736423@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Do not accumulate strlen result on "ret" local variable, because
it is accumulated on "total" local variable for array case.

Link: http://lkml.kernel.org/r/155723735237.9149.3192150444705457531.stgit@devnote2

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe_tmpl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 4737bb8c07a3..c30c61f12ddd 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -88,7 +88,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
 		if (code->op == FETCH_OP_ST_STRING) {
-			ret += fetch_store_strlen(val + code->offset);
+			ret = fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
 		} else
-- 
2.20.1


