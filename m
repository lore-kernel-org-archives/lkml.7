Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDCA2082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390769AbfIEPpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390059AbfIEPnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54972178F;
        Thu,  5 Sep 2019 15:43:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvA-0007V5-CN; Thu, 05 Sep 2019 11:43:40 -0400
Message-Id: <20190905154340.270842127@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 06/25] tracing/dynevent: Delete all matched events
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

When user gives an event name to delete, delete all
matched events instead of the first one.

This means if there are several events which have same
name but different group (subsystem) name, those are
removed if user passed only the event name, e.g.

  # cat kprobe_events
  p:group1/testevent _do_fork
  p:group2/testevent fork_idle
  # echo -:testevent >> kprobe_events
  # cat kprobe_events
  #

Link: http://lkml.kernel.org/r/156095684958.28024.16597826267117453638.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_dynevent.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index fa100ed3b4de..1cc55c50c491 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -61,10 +61,12 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 	for_each_dyn_event_safe(pos, n) {
 		if (type && type != pos->ops)
 			continue;
-		if (pos->ops->match(system, event, pos)) {
-			ret = pos->ops->free(pos);
+		if (!pos->ops->match(system, event, pos))
+			continue;
+
+		ret = pos->ops->free(pos);
+		if (ret)
 			break;
-		}
 	}
 	mutex_unlock(&event_mutex);
 
-- 
2.20.1


