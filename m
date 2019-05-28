Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098CAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75B32173B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wUceDG+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfE1Rqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:46:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46855 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1Rqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:46:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id bb3so1020573plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wY82HrCXC9QDXU5bRNjvssd+tA05bUg151lPfy3cTs8=;
        b=wUceDG+2+NcHsQ1DywnJSqBjcRsvqC3nkJYqAlkaiuODqiUjprIgQeRiOoLxGvt9gm
         +xEsuLIBihqGYcomYAVvZCxIDVeBRVL47nluCaFUAOqKBeml7mFY/I6/nPr5yWVyGtoH
         40r4/w1cjJBJm7XNsAKqJRUxRpASvWZbxNKJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wY82HrCXC9QDXU5bRNjvssd+tA05bUg151lPfy3cTs8=;
        b=q0RbcNe7yb4k9v+hfLEhgY4/RgDlWU4BqVSi/Hj0nYqAVjcd8ZhAAwGKOe2KpU0/K4
         ix9VNiJTZur3PEFQRIRuTfgLHlX8I++DWIH6KAig0FuAFzyH9fieQ2q0geVCVTwrQ8vY
         nV7GFlZjNkECsP+iYdvZeaba6dp1wObL4/GFIbR6nqLdTwvs6hW2VUHrqVYA4HmKCFv8
         rx/tTGlqtH9Ge6xrwVoflvwsyQdXUhHyiP4vQqZ6KtWCekJAKac2IGamvryQAcljuSbV
         1rh6+QCg+1nLgnPx+jBGLusIQQGjWcYlZ+myYCj3rCs51lnivgt+8PTqAWYAnpckitFV
         s9UQ==
X-Gm-Message-State: APjAAAWkNsKbGruaxUtbmd9FBsqbT4kBK825tHTcQJ87OBMsOXPyrooq
        K9OPXzytiuRObMVGZlo3JCO8dQ==
X-Google-Smtp-Source: APXvYqwdyPYojRIA2z8GMRGnytDASupR49P5Sjr1ylm3GCVoGDqEFamKZTZh4ZTGHSDtlYhu12Cfsw==
X-Received: by 2002:a17:902:148:: with SMTP id 66mr75747265plb.143.1559065598901;
        Tue, 28 May 2019 10:46:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x28sm16584048pfo.78.2019.05.28.10.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:46:36 -0700 (PDT)
Date:   Tue, 28 May 2019 13:46:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH 01/16 v3] function_graph: Convert ret_stack to a series
 of longs
Message-ID: <20190528174635.GB252809@google.com>
References: <20190525031633.811342628@goodmis.org>
 <20190525031745.235716308@goodmis.org>
 <20190528095043.GA252809@google.com>
 <20190528085826.796157de@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528085826.796157de@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:58:26AM -0400, Steven Rostedt wrote:
> On Tue, 28 May 2019 05:50:43 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Fri, May 24, 2019 at 11:16:34PM -0400, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > In order to make it possible to have multiple callbacks registered with the
> > > function_graph tracer, the retstack needs to be converted from an array of
> > > ftrace_ret_stack structures to an array of longs. This will allow to store
> > > the list of callbacks on the stack for the return side of the functions.
> > > 
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > >  include/linux/sched.h |   2 +-
> > >  kernel/trace/fgraph.c | 124 ++++++++++++++++++++++++------------------
> > >  2 files changed, 71 insertions(+), 55 deletions(-)
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 11837410690f..1850d8a3c3f0 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1113,7 +1113,7 @@ struct task_struct {
> > >  	int				curr_ret_depth;
> > >  
> > >  	/* Stack of return addresses for return function tracing: */
> > > -	struct ftrace_ret_stack		*ret_stack;
> > > +	unsigned long			*ret_stack;  
> > 
> > Can it be converted to an array of unsigned int so the shadown stack space
> > can be better used? This way stack overflow chance is lesser if there are too
> > many registered fgraph users and the function call depth is too deep.
> > AFAICS from patch 5/13, you need only 32-bits for the ftrace_ret_stack
> > offset, type and array index, so the upper 32-bit would not be used.
> > 
> 
> We can look to improve that later on. This is complex enough and I kept
> some features (like 4 byte minimum) out of this series to keep the
> complexity down. I believe there are some archs that require 64bit
> aligned access for 64 bit words and pointers. And the retstack
> structure still has longs on it. If we need to adapt to making sure we
> are aligned, I rather keep that complexity out for now.
> 
> That said, I just did a git grep HAVE_64BIT_ALIGNED_ACCESS and only
> found the kconfig where it is defined and the ring buffer code that
> deals with it. We recently removed a bunch of archs, and it could very
> well be that this requirement no longer exists.
> 
> Regardless, I've been testing this code quite heavily, and changing the
> stack from moving up to moving down already put me behind. I'd like to
> pull this code into linux-next soon. Converting to ints can be done for
> the release after we get this in.

Ok sure, I agree the conversion to ints can be done at a later time. thanks!

 - Joel

