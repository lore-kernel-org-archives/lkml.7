Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78309C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A86217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfEHUZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfEHUYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2BBA21783;
        Wed,  8 May 2019 20:24:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7V-0007kC-QQ; Wed, 08 May 2019 16:24:53 -0400
Message-Id: <20190508202453.703532930@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [for-next][PATCH 12/13] tracing: Replace kzalloc with kcalloc
References: <20190508202427.252736423@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Replace kzalloc() function with its 2-factor argument form, kcalloc().

This patch replaces cases of:

	kzalloc(a * b, gfp)

with:
	kcalloc(a, b, gfp)

This code was detected with the help of Coccinelle.

Link: http://lkml.kernel.org/r/20190115043408.GA23456@embeddedor

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0d1d5353464..a347faced959 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -558,7 +558,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			 parg->count);
 	}
 
-	code = tmp = kzalloc(sizeof(*code) * FETCH_INSN_MAX, GFP_KERNEL);
+	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
 	if (!code)
 		return -ENOMEM;
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
@@ -637,7 +637,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	code->op = FETCH_OP_END;
 
 	/* Shrink down the code buffer */
-	parg->code = kzalloc(sizeof(*code) * (code - tmp + 1), GFP_KERNEL);
+	parg->code = kcalloc(code - tmp + 1, sizeof(*code), GFP_KERNEL);
 	if (!parg->code)
 		ret = -ENOMEM;
 	else
-- 
2.20.1


