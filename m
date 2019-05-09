Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D17BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768E521479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jLsM8KPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEIV4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:56:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfEIV4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:56:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so5030112wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1kRTEOBvuu7n82aYhDwahjyAPNcCVrckm7MY2AP1/s=;
        b=jLsM8KPI+cRrg57aRoQ9bO1btOiu3+Tcqz623v5dBjFmrs5LA0iWrOGdGbxIRdJsJM
         IqcZSJCBscLeNwAyE7D4Ls0hFQ39IBC/FdyCRH4zm4ZRb/yoC4sl5suUWJTiH33B/dSE
         XvWc4X4apMEpPK+Mk3RSK2W3J4RAQsT2/HGX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1kRTEOBvuu7n82aYhDwahjyAPNcCVrckm7MY2AP1/s=;
        b=JFLdh54PUb75qGVsL7j7jVSx0fmK9YA3t3+G3+EhKvmHkEg+Hs1uV7vh9YKSUiMOt2
         rZdKsCSXOfMCxB/qFCv2oSF7dD+p+4Cfy4YfKUmSaDxLiKcYsBp3j8fOmFHEzA2XSi+Q
         E2bVHHEv4inok3AyO35NdjSZOpmIBXUlendzDVF0mLuBYQZONiqywQFpZSua7YM6h9sj
         PqsCYjAnSK1IyA7GIehX7nowfZcstv9kr58NGfsPyO61VW6qhhs0iXMJgVV7fxbcvbLm
         FUHeZ/sMGJCYjU9N0rj2kiQOVPuzn511j3La89okWeOQMUTHj1b0D+VBIpGvNK9To26G
         VP5A==
X-Gm-Message-State: APjAAAWeReuNm7EcA9UD/+ugv8VjeIrgvQwDEmZXbXQu+SmmCJEAj2pl
        mxam+ytMMPRuIo5Bvi4eUN+yeA==
X-Google-Smtp-Source: APXvYqyYj1qm46kU8XQ5CSOLeLl2qqmS6F2GQ8G8NWz9Fhnpnqf3ZptmmUmmPHHM8sOOSpiSMjsgCQ==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr4565305wmh.68.1557439003887;
        Thu, 09 May 2019 14:56:43 -0700 (PDT)
Received: from andrea ([91.252.228.170])
        by smtp.gmail.com with ESMTPSA id n4sm7124800wmb.22.2019.05.09.14.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:56:42 -0700 (PDT)
Date:   Thu, 9 May 2019 23:56:35 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190509215505.GB5820@andrea>
References: <20190427180246.GA15502@linux.ibm.com>
 <20190430100318.GP2623@hirez.programming.kicks-ass.net>
 <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509214025.GA5385@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509214025.GA5385@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 11:40:25PM +0200, Andrea Parri wrote:
> On Thu, May 09, 2019 at 10:36:54AM -0700, Paul E. McKenney wrote:
> > On Tue, May 07, 2019 at 03:16:13PM -0700, Paul E. McKenney wrote:
> > > On Wed, May 01, 2019 at 01:27:13PM -0700, Paul E. McKenney wrote:
> > > > On Wed, May 01, 2019 at 03:16:55PM -0400, Steven Rostedt wrote:
> > > > > On Wed, 1 May 2019 12:12:13 -0700
> > > > > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > > > > 
> > > > > 
> > > > > > OK, what I did was to apply the patch at the end of this email to -rcu
> > > > > > branch dev, then run rcutorture as follows:
> > > > > > 
> > > > > > nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop"
> > > > > > 
> > > > > > This resulted in the console output that I placed here:
> > > > > > 
> > > > > > http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > > > > > 
> > > > > > But I don't see calls to sched_setaffinity() or migration_cpu_stop().
> > > > > > Steve, is something else needed on the kernel command line in addition to
> > > > > > the following?
> > > > > > 
> > > > > > ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop
> > > > > 
> > > > > Do you have function graph enabled in the config?
> > > > > 
> > > > > [    2.098303] ftrace bootup tracer 'function_graph' not registered.
> > > > 
> > > > I guess I don't!  Thank you, will fix.
> > > > 
> > > > Let's see...
> > > > 
> > > > My .config has CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y.  It looks like I
> > > > need CONFIG_FUNCTION_GRAPH_TRACER=y, which I don't have.  And it looks
> > > > like that needs CONFIG_FUNCTION_TRACER=y, which I also don't have.
> > > > But I do have CONFIG_HAVE_FUNCTION_TRACER=y.  So I should add this
> > > > to my rcutorture command line:
> > > > 
> > > > --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y".
> > > > 
> > > > I fired this up.  Here is hoping!  ;-)
> > > > 
> > > > And it does have sched_setaffinity(), woo-hoo!!!  I overwrote the old file:
> > > > 
> > > > 	http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > > 
> > > And I reran after adding a trace_printk(), which shows up as follows:
> > > 
> > > [  211.409565]  6)               |  /* On unexpected CPU 6, expected 4!!! */
> > > 
> > > I placed the console log here:
> > > 
> > > 	http://www2.rdrop.com/~paulmck/submission/console.tpk.log.gz
> > > 
> > > Just in case the earlier log proves useful.
> > > 
> > > And it is acting as if the destination CPU proved to be offline.  Except
> > > that this rcutorture scenario doesn't offline anything, and I don't see
> > > any CPU-hotplug removal messages.  So I added another trace_printk() to
> > > print out cpu_online_mask.  This gets me the following:
> > > 
> > > [   31.565605]  0)               |  /* On unexpected CPU 0, expected 1!!! */
> > > [   31.565605]  0)               |  /* Online CPUs: 0-7 */
> > > 
> > > So we didn't make it to CPU 1 despite its being online.  I placed the
> > > console log here:
> > > 
> > > 	http://www2.rdrop.com/~paulmck/submission/console.tpkol.log.gz
> > > 
> > > Thoughts?
> 
> And I can finally see/reproduce it!!
> 
> Frankly, no idea how this is happening (I have been staring at these
> traces/functions for hours/days now...  ;-/ )
> 
> Adding some "sched" folks in Cc: hopefully, they can shed some light
> about this.

+Thomas, +Sebastian

Thread starts here:

http://lkml.kernel.org/r/20190427180246.GA15502@linux.ibm.com

  Andrea


> 
> And yes, my only suggestion/approach would be to keep bisecting this
> code with printk*..., 'fun' ;-/
> 
>   Andrea
