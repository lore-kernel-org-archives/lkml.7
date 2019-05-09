Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63957C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9530A2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="haoasArP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfEIVkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:40:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:40:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id d12so4988584wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h2jBjXGG/LxKqbPIKLSy4NYaQVWD1OWeaqfqz7Vo+Wc=;
        b=haoasArPwJX4hpLK6K2z3rPbR1ZDtlVnCJh5QYCnPHJpC4AOrTqf91WWmCVM+a6yj6
         Z8OcUWh2XGlyEWXroLS6es5J65Y/Rwq7Xe8ssfJEB1drFTbohhuYAYuzQ9FZpuWB5E5j
         vc4yjbebzPhL4oSwm/av9LaHRs9b2UphZiWT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h2jBjXGG/LxKqbPIKLSy4NYaQVWD1OWeaqfqz7Vo+Wc=;
        b=C0vCz99v/OfRXMS9/qkdpxdASNStKB5GOBVYP9ppW4Np6VBSMtnxsN1SwyaS2V/xia
         Hlbp6buZGe1eJUNaHdJPCmEnyWIHw9WgXYZ5vdqW82qD+e0v/nw/df9sw3HxbA27ZJHG
         DyOGkvG22TASnXi5WG0OFGI2mZ9sZru1x1le+OKmEvlC0SQ3BIlWFdu7Y2Nga7MK6cXE
         hn2zW8xFy0AwqsCOHhMJbVbnGza5+lt2j+2CLVN8LxaflFo6WcH1yIn1kZqnB7I2YYMn
         JZ640CCNKaIGWIqH7XrdHALaEvBAM3YZfUXvECwR2ZoaaqjlgNg0+8bpm9cPzd6Qi7nc
         ynyw==
X-Gm-Message-State: APjAAAUIPAX0qXN7ebJkJSIxQzOPlWjILOmJY0aiJ4LmvZ5p1PG8RMRX
        k22eAPwfiH1DbWFY4Yt0FLI2xQ==
X-Google-Smtp-Source: APXvYqwSgo4ndFtz8p1G31juXiK2md0vDdvLmcwXkGfgUJcIW+ytPKeNOcUJkJqF9EWSMqBJkQKGxw==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr4966011wrn.156.1557438034292;
        Thu, 09 May 2019 14:40:34 -0700 (PDT)
Received: from andrea ([91.252.228.170])
        by smtp.gmail.com with ESMTPSA id z5sm9543607wre.70.2019.05.09.14.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:40:33 -0700 (PDT)
Date:   Thu, 9 May 2019 23:40:25 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190509214025.GA5385@andrea>
References: <20190427180246.GA15502@linux.ibm.com>
 <20190430100318.GP2623@hirez.programming.kicks-ass.net>
 <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509173654.GA23530@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 10:36:54AM -0700, Paul E. McKenney wrote:
> On Tue, May 07, 2019 at 03:16:13PM -0700, Paul E. McKenney wrote:
> > On Wed, May 01, 2019 at 01:27:13PM -0700, Paul E. McKenney wrote:
> > > On Wed, May 01, 2019 at 03:16:55PM -0400, Steven Rostedt wrote:
> > > > On Wed, 1 May 2019 12:12:13 -0700
> > > > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > > > 
> > > > 
> > > > > OK, what I did was to apply the patch at the end of this email to -rcu
> > > > > branch dev, then run rcutorture as follows:
> > > > > 
> > > > > nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop"
> > > > > 
> > > > > This resulted in the console output that I placed here:
> > > > > 
> > > > > http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > > > > 
> > > > > But I don't see calls to sched_setaffinity() or migration_cpu_stop().
> > > > > Steve, is something else needed on the kernel command line in addition to
> > > > > the following?
> > > > > 
> > > > > ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop
> > > > 
> > > > Do you have function graph enabled in the config?
> > > > 
> > > > [    2.098303] ftrace bootup tracer 'function_graph' not registered.
> > > 
> > > I guess I don't!  Thank you, will fix.
> > > 
> > > Let's see...
> > > 
> > > My .config has CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y.  It looks like I
> > > need CONFIG_FUNCTION_GRAPH_TRACER=y, which I don't have.  And it looks
> > > like that needs CONFIG_FUNCTION_TRACER=y, which I also don't have.
> > > But I do have CONFIG_HAVE_FUNCTION_TRACER=y.  So I should add this
> > > to my rcutorture command line:
> > > 
> > > --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y".
> > > 
> > > I fired this up.  Here is hoping!  ;-)
> > > 
> > > And it does have sched_setaffinity(), woo-hoo!!!  I overwrote the old file:
> > > 
> > > 	http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > 
> > And I reran after adding a trace_printk(), which shows up as follows:
> > 
> > [  211.409565]  6)               |  /* On unexpected CPU 6, expected 4!!! */
> > 
> > I placed the console log here:
> > 
> > 	http://www2.rdrop.com/~paulmck/submission/console.tpk.log.gz
> > 
> > Just in case the earlier log proves useful.
> > 
> > And it is acting as if the destination CPU proved to be offline.  Except
> > that this rcutorture scenario doesn't offline anything, and I don't see
> > any CPU-hotplug removal messages.  So I added another trace_printk() to
> > print out cpu_online_mask.  This gets me the following:
> > 
> > [   31.565605]  0)               |  /* On unexpected CPU 0, expected 1!!! */
> > [   31.565605]  0)               |  /* Online CPUs: 0-7 */
> > 
> > So we didn't make it to CPU 1 despite its being online.  I placed the
> > console log here:
> > 
> > 	http://www2.rdrop.com/~paulmck/submission/console.tpkol.log.gz
> > 
> > Thoughts?

And I can finally see/reproduce it!!

Frankly, no idea how this is happening (I have been staring at these
traces/functions for hours/days now...  ;-/ )

Adding some "sched" folks in Cc: hopefully, they can shed some light
about this.

And yes, my only suggestion/approach would be to keep bisecting this
code with printk*..., 'fun' ;-/

  Andrea
