Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84927C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6222821882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfGDCBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfGDCBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:01:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5875021882;
        Thu,  4 Jul 2019 02:01:07 +0000 (UTC)
Date:   Wed, 3 Jul 2019 22:01:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] ftrace/selftest: Test if set_event/ftrace_pid
 exists before writing
Message-ID: <20190703220105.5a5db301@gandalf.local.home>
In-Reply-To: <20190704105126.355b476f13795cab16727fbc@kernel.org>
References: <20190703194959.596805445@goodmis.org>
        <20190703195300.408302485@goodmis.org>
        <20190703160009.31ef5cb7@gandalf.local.home>
        <20190704105126.355b476f13795cab16727fbc@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 10:51:26 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > > index 779ec11f61bd..a7b06291e32c 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/functions
> > > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > > @@ -91,8 +91,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
> > >      reset_events_filter
> > >      reset_ftrace_filter
> > >      disable_events
> > > -    echo > set_event_pid	# event tracer is always on
> > > -    echo > set_ftrace_pid
> > > +    [ -f set_event_pid ] && echo > set_event_pid  # event tracer is always on  
> > 
> > I probably should remove that comment, because I believe that was why
> > it wasn't tested :-/  
> 
> Hmm, OK. I think this comment means "the event tracer is always on if clearing
> set_event_pid filter". Would this need to be removed?

When this was added in commit 131f840d5b7 ("selftests: ftrace:
Initialize ftrace before each test"), we had this:

+    echo > set_event_pid       # event tracer is always on
+    [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
+    [ -f set_graph_function ] && echo | tee set_graph_*
+    [ -f stack_trace_filter ] && echo > stack_trace_filter
+    [ -f kprobe_events ] && echo > kprobe_events
+    [ -f uprobe_events ] && echo > uprobe_events

Where set_event_pid is the only file not tested for existence. I
figured that comment was the reason for not testing it. If that was the
case, then adding a test, I would think we should remove the comment.

Do you agree?

-- Steve


> 
> Thank you,
> 
> > 
> > -- Steve
> > 
> >   
> > > +    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
> > >      [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
> > >      [ -f set_graph_function ] && echo | tee set_graph_*
> > >      [ -f stack_trace_filter ] && echo > stack_trace_filter  
> >   
> 
> 

