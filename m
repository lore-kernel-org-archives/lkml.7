Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F6C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C3206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLWUNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 15:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfLWUND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 15:13:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5C2206D3;
        Mon, 23 Dec 2019 20:13:02 +0000 (UTC)
Date:   Mon, 23 Dec 2019 15:13:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq
 enable/disable events
Message-ID: <20191223151301.20be63f7@gandalf.local.home>
In-Reply-To: <20191221234741.GA116648@google.com>
References: <20191127154428.191095-1-antonio.borneo@st.com>
        <20191204092115.30ef75c9@gandalf.local.home>
        <20191221234741.GA116648@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2019 18:47:41 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, Dec 04, 2019 at 09:21:15AM -0500, Steven Rostedt wrote:
> > 
> > Joel,
> > 
> > Any comments on this patch?  
> 
> Steve, it looks like this issue happens with trace-cmd not knowing what
> _stext is. If I do cat trace_pipe , then I don't see the issue as _stext is
> looked up correctly but the reporter of the bug is using trace-cmd. Is there
> a way to solve this within trace-cmd? Not knowing much about trace-cmd
> internals, I will have to defer to you on this though..
> 
> Other than this, I need to make the offset to _stext as s32 instead of u32
> type so that the problem of the symbol location being before _stext does not
> cause overflow.
> 
> Lastly, I am not super convinced that we need to store the full pointer just
> to handle a case where the offset of the symbol might be more than +-2G from
> _stext. Once we see such issue, then we can handle it. But right now the size
> of the trace buffer is utilized better by just storing the offset IMHO.
>

Does this fix it for you?

-- Steve

diff --git a/lib/traceevent/event-parse.c b/lib/traceevent/event-parse.c
index 4fd3907e..dc705dd2 100644
--- a/lib/traceevent/event-parse.c
+++ b/lib/traceevent/event-parse.c
@@ -3595,6 +3595,45 @@ tep_find_event_by_name(struct tep_handle *tep,
 	return event;
 }
 
+static unsigned long long test_for_symbol(struct tep_handle *tep,
+					  struct tep_print_arg *arg)
+{
+	unsigned long long val = 0;
+	struct func_list *item = tep->funclist;
+	char *func;
+	int i;
+
+	if (isdigit(arg->atom.atom[0]))
+		return 0;
+
+	for (i = 0; i < (int)tep->func_count; i++) {
+		unsigned long long addr;
+		const char *name;
+
+		if (tep->func_map) {
+			addr = tep->func_map[i].addr;
+			name = tep->func_map[i].func;
+		} else if (item) {
+			addr = item->addr;
+			name = item->func;
+			item = item->next;
+		} else
+			break;
+
+		if (strcmp(arg->atom.atom, name) == 0) {
+			val = addr;
+			break;
+		}
+	}
+
+	func = realloc(arg->atom.atom, 32);
+	if (func) {
+		snprintf(func, 32, "%lld", val);
+		arg->atom.atom = func;
+	}
+	return val;
+}
+
 static unsigned long long
 eval_num_arg(void *data, int size, struct tep_event *event, struct tep_print_arg *arg)
 {
@@ -3611,7 +3650,10 @@ eval_num_arg(void *data, int size, struct tep_event *event, struct tep_print_arg
 		/* ?? */
 		return 0;
 	case TEP_PRINT_ATOM:
-		return strtoull(arg->atom.atom, NULL, 0);
+		val = strtoull(arg->atom.atom, NULL, 0);
+		if (!val)
+			val = test_for_symbol(tep, arg);
+		return val;
 	case TEP_PRINT_FIELD:
 		if (!arg->field.field) {
 			arg->field.field = tep_find_any_field(event, arg->field.name);
