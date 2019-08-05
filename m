Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7464C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A45F20657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011644;
	bh=tF5l4vY/ZytGIGsA1ZiECEOzN6+zhjA3RpfxlO/nO/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pcLAnYkkfjXaqEM9ZZrMneV2QqDdd5hVJYyXtm8Az+U3dc608ZYp5Q3YiedKl3rgk
	 sWkrVOp5EmaCn/4sN8DLwzG7S7YcDfLHjIHMecYdMWWN5UOUoJGwOBepswxLn/ilQv
	 m5oaOIaUCItnvph4BkSSGZIQOUyRSGopX7hK9yeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfHENY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbfHENYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:24:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E99D2075B;
        Mon,  5 Aug 2019 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011494;
        bh=tF5l4vY/ZytGIGsA1ZiECEOzN6+zhjA3RpfxlO/nO/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqPYfOjbeW2C0shRLwAz/eh6Pxgw+s4OwsEA6HOp0LQzsSaf1brHczWuwngtG0ziy
         ssFMCsrnPRV9RqKxvTh/yD0PCq3KhsIAW3OmICFDeiVeyHozKkAkTND/z+RSDI4THt
         pRvQIkLgQqVBib/jx+BFvDCO+c+SjZHHB9laUS2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.2 082/131] fgraph: Remove redundant ftrace_graph_notrace_addr() test
Date:   Mon,  5 Aug 2019 15:02:49 +0200
Message-Id: <20190805124957.435614683@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

commit 6c77221df96177da0520847ce91e33f539fb8b2d upstream.

We already have tested it before. The second one should be removed.
With this change, the performance should have little improvement.

Link: http://lkml.kernel.org/r/20190730140850.7927-1-changbin.du@gmail.com

Cc: stable@vger.kernel.org
Fixes: 9cd2992f2d6c ("fgraph: Have set_graph_notrace only affect function_graph tracer")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_functions_graph.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -137,6 +137,13 @@ int trace_graph_entry(struct ftrace_grap
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
 		return 0;
 
+	/*
+	 * Do not trace a function if it's filtered by set_graph_notrace.
+	 * Make the index of ret stack negative to indicate that it should
+	 * ignore further functions.  But it needs its own ret stack entry
+	 * to recover the original index in order to continue tracing after
+	 * returning from the function.
+	 */
 	if (ftrace_graph_notrace_addr(trace->func)) {
 		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
 		/*
@@ -156,16 +163,6 @@ int trace_graph_entry(struct ftrace_grap
 		return 0;
 
 	/*
-	 * Do not trace a function if it's filtered by set_graph_notrace.
-	 * Make the index of ret stack negative to indicate that it should
-	 * ignore further functions.  But it needs its own ret stack entry
-	 * to recover the original index in order to continue tracing after
-	 * returning from the function.
-	 */
-	if (ftrace_graph_notrace_addr(trace->func))
-		return 1;
-
-	/*
 	 * Stop here if tracing_threshold is set. We only write function return
 	 * events to the ring buffer.
 	 */


