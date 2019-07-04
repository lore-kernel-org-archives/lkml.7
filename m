Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C94C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D68218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562219798;
	bh=ev00zY18elXA5ijjKl+ZTkplSz07vBXTc3V/9aX7YTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OAkgp5ktVYWdxauQD/KK/lRdPc88fPnRAXpZpF7MwPejgPVA4h6wZ0Qajh1Xafeyc
	 UU2Vh0LEJQ7LLPSSA8jJ+L9B58nniTDtsmfhuzH2OnNjWpEplCQGQ34dUrpYIiaTaf
	 OzatvuDHs3a9P1kIJI40JeIyGJT5KcAO0CG7QSgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGDF4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDF4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:56:36 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3561D21882;
        Thu,  4 Jul 2019 05:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562219795;
        bh=ev00zY18elXA5ijjKl+ZTkplSz07vBXTc3V/9aX7YTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o7bd8laRAY2IHaVCAXtydSA7UYY9V5mOGs3Q70qpbPxifJwPGp8pRVbr4JbfQD1at
         7lJhN0R0SL3582a/6WsjK6Mj643bVchmFVMK4mPLOdsuRqnrQ29/HP7OWZBXYcvh/p
         BCsyUY5IgzvSX1GXvWNR8NsYW5PGe4mEQ13fdAbg=
Date:   Thu, 4 Jul 2019 14:56:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] ftrace/selftest: Test if set_event/ftrace_pid
 exists before writing
Message-Id: <20190704145631.58e78ce0add30b3987ea8845@kernel.org>
In-Reply-To: <20190703220105.5a5db301@gandalf.local.home>
References: <20190703194959.596805445@goodmis.org>
        <20190703195300.408302485@goodmis.org>
        <20190703160009.31ef5cb7@gandalf.local.home>
        <20190704105126.355b476f13795cab16727fbc@kernel.org>
        <20190703220105.5a5db301@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 22:01:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 4 Jul 2019 10:51:26 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > > > index 779ec11f61bd..a7b06291e32c 100644
> > > > --- a/tools/testing/selftests/ftrace/test.d/functions
> > > > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > > > @@ -91,8 +91,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
> > > >      reset_events_filter
> > > >      reset_ftrace_filter
> > > >      disable_events
> > > > -    echo > set_event_pid	# event tracer is always on
> > > > -    echo > set_ftrace_pid
> > > > +    [ -f set_event_pid ] && echo > set_event_pid  # event tracer is always on  
> > > 
> > > I probably should remove that comment, because I believe that was why
> > > it wasn't tested :-/  
> > 
> > Hmm, OK. I think this comment means "the event tracer is always on if clearing
> > set_event_pid filter". Would this need to be removed?
> 
> When this was added in commit 131f840d5b7 ("selftests: ftrace:
> Initialize ftrace before each test"), we had this:
> 
> +    echo > set_event_pid       # event tracer is always on
> +    [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
> +    [ -f set_graph_function ] && echo | tee set_graph_*
> +    [ -f stack_trace_filter ] && echo > stack_trace_filter
> +    [ -f kprobe_events ] && echo > kprobe_events
> +    [ -f uprobe_events ] && echo > uprobe_events
> 
> Where set_event_pid is the only file not tested for existence. I
> figured that comment was the reason for not testing it. If that was the
> case, then adding a test, I would think we should remove the comment.

Ah, I see.

> 
> Do you agree?

Yes, I agree with removing it.

Thank you!

> 
> -- Steve
> 
> 
> > 
> > Thank you,
> > 
> > > 
> > > -- Steve
> > > 
> > >   
> > > > +    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
> > > >      [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
> > > >      [ -f set_graph_function ] && echo | tee set_graph_*
> > > >      [ -f stack_trace_filter ] && echo > stack_trace_filter  
> > >   
> > 
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
