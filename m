Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F581C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738D62073F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574638500;
	bh=Oav+uiJmqfptFvJh4FrT6FVO+QKTlGZ9QC8LeJrp4n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OGPOBu/rn298SFrM77GpSvjdT+3TmDRkRkx8TVs3bbeSu8CX34aVKe7+tgwUAgdgr
	 lKBxbdBRI1eBOg/Jtr3hH9qtRjxwhFYPr6OvYiH4oGhhFPaUxHaRBdrryEggLMqkau
	 9nVG4fOMMh364FGUplplDZxlz0mOdaYMyQQKncjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKXXe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfKXXe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:34:59 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17AF620718;
        Sun, 24 Nov 2019 23:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574638498;
        bh=Oav+uiJmqfptFvJh4FrT6FVO+QKTlGZ9QC8LeJrp4n0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D6J3NJ0yuaGgGyz8MiYwoWiLG2iS7I5z3c/+5b9SUdCgEocm4sqbY5+XORrTyvhEf
         USr6dUP9URZoS6uCVZjggi2PwPeDDNFC0leZnQwbgJYgqI8vIN1FHXknNAwaNZAYSk
         tSjNyQQ9GfPOvLbKCYRxY24UKhhSM0r9YnKhG4mE=
Date:   Mon, 25 Nov 2019 08:34:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 1/3] selftests/ftrace: Fix to check the existence
 of set_ftrace_filter
Message-Id: <20191125083454.a6ae668d953608befddfbedd@kernel.org>
In-Reply-To: <20191124163426.649ce5a1@oasis.local.home>
References: <157457133001.25666.5309062776021151107.stgit@devnote2>
        <157457133923.25666.16444621591775429575.stgit@devnote2>
        <20191124163426.649ce5a1@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 16:35:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 24 Nov 2019 13:55:39 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > If we run ftracetest on the kernel with CONFIG_FUNCTION_TRACER=n,
> > there is no set_ftrace_filter and all test cases are failed,
> 
> Note, that we can have CONFIG_FUNCTION_TRACER=y and there be no
> set_ftrace_filter. That is determined by CONFIG_DYNAMIC_FTRACE. I guess
> we should probably still check for that for this test, but I just
> wanted to state that set_ftrace_filter is not dependent on
> FUNCTION_TRACER but instead DYNAMIC_FTRACE.

Ah, good catch! I always set DYNAMIC_FTRACE=y if FUNCTION_TRACER=y.
OK, I'll update the description.

Thank you,

> 
> 
> > because reset_ftrace_filter returns an error.
> > Let's check whether set_ftrace_filter exists and remove redundant
> > set_ftrace_filter from initialize_ftrace().
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/testing/selftests/ftrace/test.d/functions |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > index 86986c4bba54..19d288cdf336 100644
> > --- a/tools/testing/selftests/ftrace/test.d/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > @@ -46,6 +46,9 @@ reset_events_filter() { # reset all current setting filters
> >  }
> >  
> >  reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
> > +    if [ ! -f set_ftrace_filter ]; then
> > +      return 0
> > +    fi
> >      echo > set_ftrace_filter
> >      grep -v '^#' set_ftrace_filter | while read t; do
> >  	tr=`echo $t | cut -d: -f2`
> > @@ -93,7 +96,6 @@ initialize_ftrace() { # Reset ftrace to initial-state
> >      disable_events
> >      [ -f set_event_pid ] && echo > set_event_pid
> >      [ -f set_ftrace_pid ] && echo > set_ftrace_pid
> > -    [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
> 
> This also resets set_ftrace_notrace, which reset_ftrace_filter does not.
> 
> -- Steve
> 
> 
> >      [ -f set_graph_function ] && echo | tee set_graph_*
> >      [ -f stack_trace_filter ] && echo > stack_trace_filter
> >      [ -f kprobe_events ] && echo > kprobe_events
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
