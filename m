Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453B8C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FD7214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TmVJ99lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfHIUWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:22:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41397 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:22:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so46624684pff.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t13a+9s8YQTSbEdX18ZTbdYxdtI/KWow8fuJ4nIWRss=;
        b=TmVJ99lrsdcse7U2lq8bV9ghw6hxc/NdMJ3Tky/iNgoF9Tl0VRLtFC+shq6HeaMVp7
         5gc6czzPZvD0CKuaKju7qsMUngygv7XynDRja/TcUHeC304iUTOe2JP6ehL2yf0pIxQK
         LyC/718xgXK23XFSnTIF8SY8ywL4vnG7FAxVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t13a+9s8YQTSbEdX18ZTbdYxdtI/KWow8fuJ4nIWRss=;
        b=knw3S3rN3mGY0C2q9eFb1NUSzNPQWpljRhOT+9lYVLArEijDKkGcjIC+u15UNUn3xh
         fNyherAwbixWw2vVyg+HTwdLLmsbHCk+S0aEeFJUXzusm8J+9AIRgzM3y1nQmOnX8Oft
         aMkf0FNjCJ/T3d+qXM9sL3xn/11c6/x+zaXb3xzS0J6yy1TvazvXfPitZcMhQHR5fNkQ
         ORMSLg42zl7JNxLV6qcVT4iDQ5y6ezvcWJhMhtKfDoIsCHNfMBBlB5Fau2SmusT7n0uw
         OsAYkC85362APUJsooIakiZ1Z0EhcYXrfjLyxXfNkjixh+w8IE2ZzkvkDAKc3Y0BFN/5
         n3+w==
X-Gm-Message-State: APjAAAUKuIM25JRqfKG0DbMjWhgY9CH2H/A/54ExGyIBgJQdVgdB1W6m
        4sardaZLurwBxPx8uRofVmDFOwMpXaQ=
X-Google-Smtp-Source: APXvYqyiR2BaRAZbBzmzbLrCSe/F29fs7nNrrGHZzEkdw2psiPIrMsNUyyar2eCjKjowGUF6d8BWEA==
X-Received: by 2002:a63:e807:: with SMTP id s7mr18401303pgh.194.1565382148529;
        Fri, 09 Aug 2019 13:22:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e24sm9436544pgk.21.2019.08.09.13.22.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 13:22:27 -0700 (PDT)
Date:   Fri, 9 Aug 2019 16:22:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190809202226.GC255533@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
 <20190809163346.GF28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809163346.GF28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 09:33:46AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 09, 2019 at 11:39:24AM -0400, Joel Fernandes wrote:
> > On Fri, Aug 09, 2019 at 08:16:19AM -0700, Paul E. McKenney wrote:
> > > On Thu, Aug 08, 2019 at 07:30:14PM -0400, Joel Fernandes wrote:
> > [snip]
> > > > > But I could make it something like:
> > > > > 1. Letting ->head grow if ->head_free busy
> > > > > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > > > > 
> > > > > This would even improve performance, but will still risk going out of memory.
> > > > 
> > > > It seems I can indeed hit an out of memory condition once I changed it to
> > > > "letting list grow" (diff is below which applies on top of this patch) while
> > > > at the same time removing the schedule_timeout(2) and replacing it with
> > > > cond_resched() in the rcuperf test.  I think the reason is the rcuperf test
> > > > starves the worker threads that are executing in workqueue context after a
> > > > grace period and those are unable to get enough CPU time to kfree things fast
> > > > enough. But I am not fully sure about it and need to test/trace more to
> > > > figure out why this is happening.
> > > > 
> > > > If I add back the schedule_uninterruptibe_timeout(2) call, the out of memory
> > > > situation goes away.
> > > > 
> > > > Clearly we need to do more work on this patch.
> > > > 
> > > > In the regular kfree_rcu_no_batch() case, I don't hit this issue. I believe
> > > > that since the kfree is happening in softirq context in the _no_batch() case,
> > > > it fares better. The question then I guess is how do we run the rcu_work in a
> > > > higher priority context so it is not starved and runs often enough. I'll
> > > > trace more.
> > > > 
> > > > Perhaps I can also lower the priority of the rcuperf threads to give the
> > > > worker thread some more room to run and see if anything changes. But I am not
> > > > sure then if we're preparing the code for the real world with such
> > > > modifications.
> > > > 
> > > > Any thoughts?
> > > 
> > > Several!  With luck, perhaps some are useful.  ;-)
> > > 
> > > o	Increase the memory via kvm.sh "--memory 1G" or more.  The
> > > 	default is "--memory 500M".
> > 
> > Thanks, this definitely helped.

Also, I can go back to 500M if I just keep KFREE_DRAIN_JIFFIES at HZ/50. So I
am quite happy about that. I think I can declare that the "let list grow
indefinitely" design works quite well even with an insanely heavily loaded
case of every CPU in a 16CPU system with 500M memory, indefinitely doing
kfree_rcu()in a tight loop with appropriate cond_resched(). And I am like
thinking - wow how does this stuff even work at such insane scales :-D

> > > o	Leave a CPU free to run things like the RCU grace-period kthread.
> > > 	You might also need to bind that kthread to that CPU.
> > > 
> > > o	Alternatively, use the "rcutree.kthread_prio=" boot parameter to
> > > 	boost the RCU kthreads to real-time priority.  This won't do
> > > 	anything for ksoftirqd, though.
> > 
> > I will try these as well.
> > 

kthread_prio=50 definitely reduced the probability of OOM but it still
occurred.

> > > o	Along with the above boot parameter, use "rcutree.use_softirq=0"
> > > 	to cause RCU to use kthreads instead of softirq.  (You might well
> > > 	find issues in priority setting as well, but might as well find
> > > 	them now if so!)
> > 
> > Doesn't think one actually reduce the priority of the core RCU work? softirq
> > will always have higher priority than any there. So wouldn't that have the
> > effect of not reclaiming things fast enough? (Or, in my case not scheduling
> > the rcu_work which does the reclaim).
> 
> For low kfree_rcu() loads, yes, it increases overhead due to the need
> for context switches instead of softirq running at the tail end of an
> interrupt.  But for high kfree_rcu() loads, it gets you realtime priority
> (in conjunction with "rcutree.kthread_prio=", that is).

I meant for high kfree_rcu() loads, a softirq context executing RCU callback
is still better from the point of view of the callback running because the
softirq will run above all else (higher than the highest priority task) so
use_softirq=0 would be a down grade from that perspective if something higher
than rcutree.kthread_prio is running on the CPU. So unless kthread_prio is
set to the highest prio, then softirq running would work better. Did I miss
something?

> > > o	With any of the above, invoke rcu_momentary_dyntick_idle() along
> > > 	with cond_resched() in your kfree_rcu() loop.  This simulates
> > > 	a trip to userspace for nohz_full CPUs, so if this helps for
> > > 	non-nohz_full CPUs, adjustments to the kernel might be called for.

I did not try this yet. But I am thinking why would this help in nohz_idle
case? In nohz_idle we already have the tick active when CPU is idle. I guess
it is because there may be a long time that elapses before
rcu_data.rcu_need_heavy_qs == true ?

> > Ok, will try it.
> > 
> > Save these bullet points for future reference! ;-)  thanks,
> 
> I guess this is helping me to prepare for Plumbers.  ;-)

:-)

thanks, Paul!

 - Joel

