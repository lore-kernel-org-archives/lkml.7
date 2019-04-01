Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8779BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCC521904
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfDAQnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728700AbfDAQnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:43:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F3B21902;
        Mon,  1 Apr 2019 16:43:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hB02C-0004uo-7Y; Mon, 01 Apr 2019 12:43:44 -0400
Message-Id: <20190401164344.121717482@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 12:43:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 10/15] tools/lib/traceevent: Remove call to exit() from
 tep_filter_add_filter_str()
References: <20190401164305.359125441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch removes call to exit() from tep_filter_add_filter_str(). A library
function should not force the application to exit. In the current implementation
tep_filter_add_filter_str() calls exit() when a special "test_filters" mode is
set, used only for debugging purposes. When this mode is set and a filter is
added - its string is printed to the console and exit() is called. This patch
changes the logic - when in "test_filters" mode, the filter string is still
printed, but the exit() is not called. It is up to the application to track when
"test_filters" mode is set and to call exit, if needed.

Link: http://lkml.kernel.org/r/20190326154328.28718-9-tstoyanov@vmware.com

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/parse-filter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 4ffd8b25a852..3320c0a0e343 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1346,9 +1346,6 @@ enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
 
 	free_events(events);
 
-	if (rtn >= 0 && pevent->test_filters)
-		exit(0);
-
 	return rtn;
 }
 
-- 
2.20.1


