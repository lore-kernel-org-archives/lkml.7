Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCFEC5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A3C2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562205096;
	bh=2bPf4DyyBA9BIUwdnRB+hbl7r5C3RRU3ruGOnwAWnZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SZ4agRTMbwRfgXp3/ncIkOqJPYYba1yd+8yGGqw66QmVoCoWkJvuulhNYVeo3hdlP
	 V9tfAqbL8sXZzjdQZV67XSMAfBJnn7oZmuHlVldI5EDnyg6Hid6A0s4BHnmzRCUZKu
	 kzGO927GbtigaIqQ4jpxmmPzit1Gr+C1SgLeJTxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGDBvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 21:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfGDBvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:51:31 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9BF2187F;
        Thu,  4 Jul 2019 01:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562205090;
        bh=2bPf4DyyBA9BIUwdnRB+hbl7r5C3RRU3ruGOnwAWnZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GnfQiR9BATfUd1LfUd8bDiw8x/IZJfwTNrLYHHD6ScLwDJz2mMVHK1w1uYAfYqbdn
         ZKcnkYKmql/Y0pFMyWeTqWrgML2IEs7nR9fUUJrZhxKgVHu2xG+flTn17D3AuoSyne
         /EmzU+sETx77MBNqGjuHhzw674lIZYZAt8RjJiKc=
Date:   Thu, 4 Jul 2019 10:51:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        shuah <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] ftrace/selftest: Test if set_event/ftrace_pid
 exists before writing
Message-Id: <20190704105126.355b476f13795cab16727fbc@kernel.org>
In-Reply-To: <20190703160009.31ef5cb7@gandalf.local.home>
References: <20190703194959.596805445@goodmis.org>
        <20190703195300.408302485@goodmis.org>
        <20190703160009.31ef5cb7@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 16:00:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 03 Jul 2019 15:50:01 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > While testing on a very old kernel (3.5), the tests failed because the write
> > to set_event_pid in the setup code, did not exist. The tests themselves
> > could pass, but the setup failed causing an error.
> > 
> > Other files test for existance before writing to them. Do the same for
> > set_event_pid and set_ftrace_pid.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  tools/testing/selftests/ftrace/test.d/functions | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > index 779ec11f61bd..a7b06291e32c 100644
> > --- a/tools/testing/selftests/ftrace/test.d/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > @@ -91,8 +91,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
> >      reset_events_filter
> >      reset_ftrace_filter
> >      disable_events
> > -    echo > set_event_pid	# event tracer is always on
> > -    echo > set_ftrace_pid
> > +    [ -f set_event_pid ] && echo > set_event_pid  # event tracer is always on
> 
> I probably should remove that comment, because I believe that was why
> it wasn't tested :-/

Hmm, OK. I think this comment means "the event tracer is always on if clearing
set_event_pid filter". Would this need to be removed?

Thank you,

> 
> -- Steve
> 
> 
> > +    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
> >      [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
> >      [ -f set_graph_function ] && echo | tee set_graph_*
> >      [ -f stack_trace_filter ] && echo > stack_trace_filter
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
