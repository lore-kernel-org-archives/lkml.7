Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E5C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D44920896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EfWdCdro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDGTcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:32:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37435 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfDGTcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:32:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so13090490qtn.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RB2LVx/Uz7Ey5cRgK6zYNqgibWflhIIDMH+h59VGSCA=;
        b=EfWdCdroSm9OQf18nLicmc2J4RAaNEgoPae2iX4U0lEoyD8EdfTwtdPlN+SAC0Jx/M
         NDdSl9JClVu6sZzmPCdNvvO1GI9Lav5OygeW4MlH3ltQPG9ilDujSBs6tE5ozV7Du3dk
         BoAzhTzsBwq3Ya+jRMsgi/KX62zCMiPZ7xM9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RB2LVx/Uz7Ey5cRgK6zYNqgibWflhIIDMH+h59VGSCA=;
        b=cYDx9yXP+Xe+VQWMJ3DP9DNUXOaMMxr8vVmz7bHBN46Z7r2nFB+UjzFPMrBItukEBo
         tFB89Wn9Jlm/V79Ga7wa4gH3QPV6jd06hR56AkuPz+Go8ZD2FrhsgVw2zgZdoy5MQSxZ
         Jaip0ZE76fWYp5vJL4aqx25XOCg95Msc/NSDfnzNZHnQn6J1XnLVS6JlOQgdnIKHTbG1
         kcUITzRKOm+DlSixpVkU/4Fc5J0W+q0kpwy3bK7i+WUtM1TXCtvIFlFR5WF2CPoq61b5
         gx+9DUiSkjwlx8ywaoT4n4xkgljifYHOxJTindIEU+j7PWmGH1MPZ77QOTxpqSb4uFBS
         NRAg==
X-Gm-Message-State: APjAAAXdOIw4Ekx2cxUQ5stTp6eyQGdXu6Pm98RZWqXO3zyl/3BbH8gm
        CJ5q1JAWrPedMuawqKNaNMh6/w==
X-Google-Smtp-Source: APXvYqzd7fmyjxiWkduxZOXjPLEzu2JWLxO+KIZSS99QW/2lwvjF+t6L5kp0TpfkXyh/E30lz/9MGQ==
X-Received: by 2002:ac8:8b9:: with SMTP id v54mr22054715qth.64.1554665524463;
        Sun, 07 Apr 2019 12:32:04 -0700 (PDT)
Received: from localhost ([2600:1003:b457:899d:6e8:4c99:e38f:32bb])
        by smtp.gmail.com with ESMTPSA id q51sm18955843qte.29.2019.04.07.12.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 12:32:03 -0700 (PDT)
Date:   Sun, 7 Apr 2019 19:32:02 +0000
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
Message-ID: <20190407193202.GA30934@localhost>
References: <20190402142816.GA13084@linux.ibm.com>
 <20190403133243.GE4102@linux.ibm.com>
 <1028306587.504.1554301662374.JavaMail.zimbra@efficios.com>
 <20190403162039.GA14111@linux.ibm.com>
 <20190405232835.GA24702@linux.ibm.com>
 <20190406230613.GA187766@google.com>
 <20190407133941.GC14111@linux.ibm.com>
 <20190407135937.GA30053@linux.ibm.com>
 <134026717.535.1554665176677.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134026717.535.1554665176677.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 03:26:16PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 7, 2019, at 9:59 AM, paulmck paulmck@linux.ibm.com wrote:
> 
> > On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
> >> On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> > 
> > [ . . . ]
> > 
> >> > > diff --git a/include/asm-generic/vmlinux.lds.h
> >> > > b/include/asm-generic/vmlinux.lds.h
> >> > > index f8f6f04c4453..c2d919a1566e 100644
> >> > > --- a/include/asm-generic/vmlinux.lds.h
> >> > > +++ b/include/asm-generic/vmlinux.lds.h
> >> > > @@ -338,6 +338,10 @@
> >> > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> >> > >  		__stop___tracepoints_ptrs = .;				\
> >> > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> >> > > +		. = ALIGN(8);						\
> >> > > +		__start___srcu_struct = .;				\
> >> > > +		*(___srcu_struct_ptrs)					\
> >> > > +		__end___srcu_struct = .;				\
> >> > >  	}								\
> >> > 
> >> > This vmlinux linker modification is not needed. I tested without it and srcu
> >> > torture works fine with rcutorture built as a module. Putting further prints
> >> > in kernel/module.c verified that the kernel is able to find the srcu structs
> >> > just fine. You could squash the below patch into this one or apply it on top
> >> > of the dev branch.
> >> 
> >> Good point, given that otherwise FORTRAN named common blocks would not
> >> work.
> >> 
> >> But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
> >> macro that it can be mapped read-only?  Or am I suffering from excessive
> >> optimism?
> > 
> > And to answer the other question, in the case where I am suffering from
> > excessive optimism, it should be a separate commit.  Please see below
> > for the updated original commit thus far.
> > 
> > And may I have your Tested-by?
> 
> Just to confirm: does the cleanup performed in the modules going
> notifier end up acting as a barrier first before freeing the memory ?
> If not, is it explicitly stated that a barrier must be issued before
> module unload ?
> 

You mean rcu_barrier? It is mentioned in the documentation that this is the
responsibility of the module writer to prevent delays for all modules.

thanks.


> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
