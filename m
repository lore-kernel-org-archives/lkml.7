Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9027AC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635FB22DA9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfHaKy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbfHaKyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:54:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497ED23405;
        Sat, 31 Aug 2019 10:54:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i411G-0001KW-Ff; Sat, 31 Aug 2019 06:54:10 -0400
Message-Id: <20190831105410.361305179@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 31 Aug 2019 06:53:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Jin <joe.jin@oracle.com>, Denis Efremov <efremov@linux.com>
Subject: [for-linus][PATCH 4/7] tracing: Make exported ftrace_set_clr_event non-static
References: <20190831105329.122820332@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

The function ftrace_set_clr_event is declared static and marked
EXPORT_SYMBOL_GPL(), which is at best an odd combination. Because the
function was decided to be a part of API, this commit removes the static
attribute and adds the declaration to the header.

Link: http://lkml.kernel.org/r/20190704172110.27041-1-efremov@linux.com

Fixes: f45d1225adb04 ("tracing: Kernel access to Ftrace instances")
Reviewed-by: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 1 +
 kernel/trace/trace_events.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5150436783e8..30a8cdcfd4a4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -548,6 +548,7 @@ extern int trace_event_get_offsets(struct trace_event_call *call);
 
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
 
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 
 /*
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c7506bc81b75..648930823b57 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -787,7 +787,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match;
 	int ret;
-- 
2.20.1


