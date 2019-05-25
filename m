Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A355C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C5F2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEYDLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 23:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfEYDLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:11:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA5A2133D;
        Sat, 25 May 2019 03:11:08 +0000 (UTC)
Date:   Fri, 24 May 2019 23:11:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [GIT PULL] tracing: Small fixes to histogram code and header
 cleanup
Message-ID: <20190524231106.5812936b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

Tom Zanussi sent me some small fixes and cleanups to the histogram
code and I forgot to incorporate them.

I also added a small clean up patch that was sent to me a while ago
and I just noticed it.


Please pull the latest trace-v5.2-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.2-rc1

Tag SHA1: bceb0fd66744c3aa0cd8f3bba3e4b45ca38b3aaa
Head SHA1: 4eebe38a37f9397ffecd4bd3afbdf36838a97969


Jagadeesh Pagadala (1):
      kernel/trace/trace.h: Remove duplicate header of trace_seq.h

Tom Zanussi (3):
      tracing: Prevent hist_field_var_ref() from accessing NULL tracing_map_elts
      tracing: Check keys for variable references in expressions too
      tracing: Add a check_val() check before updating cond_snapshot() track_val

----
 kernel/trace/trace.h             |  1 -
 kernel/trace/trace_events_hist.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1974ce818ddb..82c70b63d375 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -15,7 +15,6 @@
 #include <linux/trace_seq.h>
 #include <linux/trace_events.h>
 #include <linux/compiler.h>
-#include <linux/trace_seq.h>
 #include <linux/glob.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7fca3457c705..ca6b0dff60c5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -59,7 +59,7 @@
 	C(NO_CLOSING_PAREN,	"No closing paren found"),		\
 	C(SUBSYS_NOT_FOUND,	"Missing subsystem"),			\
 	C(INVALID_SUBSYS_EVENT,	"Invalid subsystem or event name"),	\
-	C(INVALID_REF_KEY,	"Using variable references as keys not supported"), \
+	C(INVALID_REF_KEY,	"Using variable references in keys not supported"), \
 	C(VAR_NOT_FOUND,	"Couldn't find variable"),		\
 	C(FIELD_NOT_FOUND,	"Couldn't find field"),
 
@@ -1854,6 +1854,9 @@ static u64 hist_field_var_ref(struct hist_field *hist_field,
 	struct hist_elt_data *elt_data;
 	u64 var_val = 0;
 
+	if (WARN_ON_ONCE(!elt))
+		return var_val;
+
 	elt_data = elt->private_data;
 	var_val = elt_data->var_ref_vals[hist_field->var_ref_idx];
 
@@ -3582,14 +3585,20 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	struct track_data *track_data = tr->cond_snapshot->cond_data;
 	struct hist_elt_data *elt_data, *track_elt_data;
 	struct snapshot_context *context = cond_data;
+	struct action_data *action;
 	u64 track_val;
 
 	if (!track_data)
 		return false;
 
+	action = track_data->action_data;
+
 	track_val = get_track_val(track_data->hist_data, context->elt,
 				  track_data->action_data);
 
+	if (!action->track_data.check_val(track_data->track_val, track_val))
+		return false;
+
 	track_data->track_val = track_val;
 	memcpy(track_data->key, context->key, track_data->key_len);
 
@@ -4503,7 +4512,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			goto out;
 		}
 
-		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (field_has_hist_vars(hist_field, 0))	{
 			hist_err(tr, HIST_ERR_INVALID_REF_KEY, errpos(field_str));
 			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;

