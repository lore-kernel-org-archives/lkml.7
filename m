Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9520659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfJUQpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbfJUQpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:45:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB4820659;
        Mon, 21 Oct 2019 16:45:10 +0000 (UTC)
Date:   Mon, 21 Oct 2019 12:45:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Prateek Sood <prsood@codeaurora.org>
Subject: [GIT PULL] tracing: A couple of minor fixes
Message-ID: <20191021124508.203ccdb3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Two minor fixes:

 - A race in perf trace initialization (missing mutexes)

 - Minor fix to represent gfp_t in synthetic events as properly signed


Please pull the latest trace-v5.4-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.4-rc3

Tag SHA1: 46467c95be6062b0c66aae0efbab5746bee09f1e
Head SHA1: 668993e5696ddc5db01940d66818c7c038895893


Prateek Sood (1):
      tracing: Fix race in perf_trace_buf initialization

Zhengjun Xing (1):
      tracing: Fix "gfp_t" format for synthetic events

----
 kernel/trace/trace_event_perf.c  | 4 ++++
 kernel/trace/trace_events_hist.c | 2 ++
 2 files changed, 6 insertions(+)
---------------------------
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 0892e38ed6fb..a9dfa04ffa44 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -272,9 +272,11 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
 		goto out;
 	}
 
+	mutex_lock(&event_mutex);
 	ret = perf_trace_event_init(tp_event, p_event);
 	if (ret)
 		destroy_local_trace_kprobe(tp_event);
+	mutex_unlock(&event_mutex);
 out:
 	kfree(func);
 	return ret;
@@ -282,8 +284,10 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
 
 void perf_kprobe_destroy(struct perf_event *p_event)
 {
+	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
+	mutex_unlock(&event_mutex);
 
 	destroy_local_trace_kprobe(p_event->tp_event);
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 57648c5aa679..7482a1466ebf 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -679,6 +679,8 @@ static bool synth_field_signed(char *type)
 {
 	if (str_has_prefix(type, "u"))
 		return false;
+	if (strcmp(type, "gfp_t") == 0)
+		return false;
 
 	return true;
 }
