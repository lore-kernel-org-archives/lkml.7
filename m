Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E7ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6C921835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406703AbfJQSip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727766AbfJQSio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:38:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB06C2089C;
        Thu, 17 Oct 2019 18:38:43 +0000 (UTC)
Date:   Thu, 17 Oct 2019 14:38:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] libtraceevent: perf script -g python segfaults
Message-ID: <20191017143841.317b26b5@gandalf.local.home>
In-Reply-To: <20191017154205.GC8974@kernel.org>
References: <20191017154205.GC8974@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 12:42:05 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> I'll try and continue later, but if you guys can take a look...

Does this fix it for you?

-- Steve

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index ad74be1f0e42..227629796e32 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -193,30 +193,32 @@ int parse_event_file(struct tep_handle *pevent,
 struct tep_event *trace_find_next_event(struct tep_handle *pevent,
 					struct tep_event *event)
 {
+	static struct tep_event **all_events;
 	static int idx;
 	int events_count;
-	struct tep_event *all_events;
 
-	all_events = tep_get_first_event(pevent);
 	events_count = tep_get_events_count(pevent);
 	if (!pevent || !all_events || events_count < 1)
 		return NULL;
 
 	if (!event) {
 		idx = 0;
-		return all_events;
+		all_events = tep_list_events(pevent, TEP_EVENT_SORT_ID);
+		if (all_events)
+			return all_events[0];
+		return NULL;
 	}
 
-	if (idx < events_count && event == (all_events + idx)) {
+	if (idx < events_count && event == all_events[idx]) {
 		idx++;
 		if (idx == events_count)
 			return NULL;
-		return (all_events + idx);
+		return all_events[idx];
 	}
 
 	for (idx = 1; idx < events_count; idx++) {
-		if (event == (all_events + (idx - 1)))
-			return (all_events + idx);
+		if (event == all_events[idx - 1])
+			return all_events[idx];
 	}
 	return NULL;
 }
