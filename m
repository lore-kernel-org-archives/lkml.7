Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554EFC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234622087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p3Y+ILcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDGVHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:07:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42564 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDGVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:07:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so13176106qtc.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2vNfUNP3i+O55viCb8wmk1mIJ8Q3I7LsPR2jHYkKESo=;
        b=p3Y+ILcXCSIom06UiCBs75Tv83mtP+PfgZZbWZTGAxM2cexlsoFrw43alqEWi1fPme
         K5j5tm4A2KjC1QqnkW0WCwZtSqXsobb6MG9Lmp+G4NmzDwaZw7tNF64kJrMf0gcbA+a3
         UR+3kHre/VxxR8+9nSxvc7hiUN9nWda4rnGzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2vNfUNP3i+O55viCb8wmk1mIJ8Q3I7LsPR2jHYkKESo=;
        b=sYbxOX1lcIsVZZVGjl6mP/JAuXiqueGsBzaBHVw+xp98gt9WUoBdiTicsO3KP1XV+D
         K0J/qVtHG6G3aY1g5wUtMjMJxDiAVSawhOJxGc7QA/4WxtMhiiBdMwbpddd0XTn9jnPq
         4xHrF0VaREAqaXMtVktmRDRLI9xu6mI1S18Ar3ygOJEGwh9hzkvT+8wUCzPcib6Ubnbj
         O3jMrutWu4j6XfIsNkdCV3rbsIj7LaBLkdLpeMdy7jS9SpvFhbEXoNLubHDwQeHJlDF6
         iNSIHQPMLB1DkvlpxEUOj37ASW1+OMrjrLZZzhbC5TGNzhSFJotWgBaLN9R8G4NXhdZu
         S/mQ==
X-Gm-Message-State: APjAAAVHmnVLPmARgp1PQ6ByFo8Za91nqcZ+OdOj2P7l4b/ZHblFMrlo
        JYCYDUZqSzMmU7o5GJxST4n/1w==
X-Google-Smtp-Source: APXvYqzZf1qj3N0PtGU5dfxFiIepADbEWP5vJXbkBxUgr9vxLtabNVNjrkGbRAiE5scGg4WYXIWOOA==
X-Received: by 2002:ac8:30f9:: with SMTP id w54mr21488807qta.336.1554671240424;
        Sun, 07 Apr 2019 14:07:20 -0700 (PDT)
Received: from localhost ([2600:1003:b457:899d:6e8:4c99:e38f:32bb])
        by smtp.gmail.com with ESMTPSA id h2sm13052343qkl.3.2019.04.07.14.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 14:07:19 -0700 (PDT)
Date:   Sun, 7 Apr 2019 21:07:18 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@linux.ibm.com>, rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Message-ID: <20190407210718.GA6656@localhost>
References: <20190402142816.GA13084@linux.ibm.com>
 <20190403162039.GA14111@linux.ibm.com>
 <20190405232835.GA24702@linux.ibm.com>
 <20190406230613.GA187766@google.com>
 <20190407133941.GC14111@linux.ibm.com>
 <20190407135937.GA30053@linux.ibm.com>
 <134026717.535.1554665176677.JavaMail.zimbra@efficios.com>
 <20190407193202.GA30934@localhost>
 <1632568795.549.1554669696728.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632568795.549.1554669696728.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 04:41:36PM -0400, Mathieu Desnoyers wrote:
> 
> ----- On Apr 7, 2019, at 3:32 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> 
> > On Sun, Apr 07, 2019 at 03:26:16PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Apr 7, 2019, at 9:59 AM, paulmck paulmck@linux.ibm.com wrote:
> >> 
> >> > On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
> >> >> On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> >> > 
> >> > [ . . . ]
> >> > 
> >> >> > > diff --git a/include/asm-generic/vmlinux.lds.h
> >> >> > > b/include/asm-generic/vmlinux.lds.h
> >> >> > > index f8f6f04c4453..c2d919a1566e 100644
> >> >> > > --- a/include/asm-generic/vmlinux.lds.h
> >> >> > > +++ b/include/asm-generic/vmlinux.lds.h
> >> >> > > @@ -338,6 +338,10 @@
> >> >> > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> >> >> > >  		__stop___tracepoints_ptrs = .;				\
> >> >> > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> >> >> > > +		. = ALIGN(8);						\
> >> >> > > +		__start___srcu_struct = .;				\
> >> >> > > +		*(___srcu_struct_ptrs)					\
> >> >> > > +		__end___srcu_struct = .;				\
> >> >> > >  	}								\
> >> >> > 
> >> >> > This vmlinux linker modification is not needed. I tested without it and srcu
> >> >> > torture works fine with rcutorture built as a module. Putting further prints
> >> >> > in kernel/module.c verified that the kernel is able to find the srcu structs
> >> >> > just fine. You could squash the below patch into this one or apply it on top
> >> >> > of the dev branch.
> >> >> 
> >> >> Good point, given that otherwise FORTRAN named common blocks would not
> >> >> work.
> >> >> 
> >> >> But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
> >> >> macro that it can be mapped read-only?  Or am I suffering from excessive
> >> >> optimism?
> >> > 
> >> > And to answer the other question, in the case where I am suffering from
> >> > excessive optimism, it should be a separate commit.  Please see below
> >> > for the updated original commit thus far.
> >> > 
> >> > And may I have your Tested-by?
> >> 
> >> Just to confirm: does the cleanup performed in the modules going
> >> notifier end up acting as a barrier first before freeing the memory ?
> >> If not, is it explicitly stated that a barrier must be issued before
> >> module unload ?
> >> 
> > 
> > You mean rcu_barrier? It is mentioned in the documentation that this is the
> > responsibility of the module writer to prevent delays for all modules.
> 
> It's a srcu barrier yes. Considering it would be a barrier specific to the
> srcu domain within that module, I don't see how it would cause delays for
> "all" modules if we implicitly issue the barrier on module unload. What
> am I missing ?

Yes you are right. I thought of this after I just sent my email. I think it
makes sense for srcu case to do and could avoid a class of bugs.

thanks!

> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
