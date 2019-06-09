Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFECEC468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DD6206E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eWNdQH0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfFIVZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 17:25:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40330 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfFIVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 17:25:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so775704pfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CZFUTqogdoT9h52wNWXCdK3qKHElU8kAeC/PqrX8CSU=;
        b=eWNdQH0FRGKWNdUUTKwvNWa1xs5abEBDHUhhFwZudS2hOlkrHFwd32LnksW/fmqJ2q
         JPJhN4YzgptkqTRrYgcu4I0g925rb2cBUUgZu2xLQhE3AYjaXRev1BEMDBq1Giad0obC
         zhXZLDc2n63XsLaO9qmrXsK1+PYYCapla3Yrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZFUTqogdoT9h52wNWXCdK3qKHElU8kAeC/PqrX8CSU=;
        b=I0fGMO5QAZ1QvYoHJQ5oBL3ziPad4cvkskuFBe4CS7zgFIqA/qaq9JMfv+qi4n2/ZT
         UpeFqTQu0ngdKpsx8K746B9hP6kPbQSGA2fm3GYznfAdaVkhyTmHfovoHjXnPdQZVEpr
         zyGN7kDLVtXu3aWM8a6S3SDT1buI+3xLO7ZYGeZrrMkiksyOKWaHgVZbPgzYOeqhIVc1
         cH7xEaDz+hOYddIKTwN7FWuizZPH7nJe3RxNNRQO6gD5yKqbtQiifnWIjpqzgNWSUdbE
         CzUOs421M6FDMP3bMZ6rxqTIMM21uBpSkXVUwaWn1OJnDOxGIFn/jFau/8zxrDh45Z7Y
         0aFw==
X-Gm-Message-State: APjAAAW9Xf6QjEeFjE9lgOVKJDOn3npGb/CevGHqfE26Psb+YTk/PFnN
        2zTnFP1pYyYPR2Yf2JOGyAMsLQ==
X-Google-Smtp-Source: APXvYqxD7pAyV4mkv2ht5HtKjXQfP74V9gowrefzShjJHP0ma4F0WQfba/f1efuUZzZlpsbYFchv3A==
X-Received: by 2002:a17:90a:20e7:: with SMTP id f94mr17378962pjg.68.1560115540913;
        Sun, 09 Jun 2019 14:25:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 24sm7990056pgn.32.2019.06.09.14.25.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 14:25:40 -0700 (PDT)
Date:   Sun, 9 Jun 2019 17:25:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Eric Dumazet <edumazet@google.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about cacheline bounching with percpu-rwsem and rcu-sync
Message-ID: <20190609210216.GD84498@google.com>
References: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
 <20190531135051.GL28207@linux.ibm.com>
 <CAEXW_YReo2juN8A3CF+CKv8PcN_cH23gYWkLfkOJQqignyx85g@mail.gmail.com>
 <CAEXW_YT93U4OAVUggkR7E3KV2m7pdVwG-r+x6zjtrGzortvc4w@mail.gmail.com>
 <20190609122226.GU28207@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609122226.GU28207@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 05:22:26AM -0700, Paul E. McKenney wrote:
> On Sat, Jun 08, 2019 at 08:24:36PM -0400, Joel Fernandes wrote:
> > On Fri, May 31, 2019 at 10:43 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > [snip]
> > > >
> > > > Either way, it would be good for you to just try it.  Create a kernel
> > > > module or similar than hammers on percpu_down_read() and percpu_up_read(),
> > > > and empirically check the scalability on a largish system.  Then compare
> > > > this to down_read() and up_read()
> > >
> > > Will do! thanks.
> > 
> > I created a test for this and the results are quite amazing just
> > stressed read lock/unlock for rwsem vs percpu-rwsem.
> > The test is conducted on a dual socket Intel x86_64 machine with 14
> > cores each socket.
> > 
> > Test runs 10,000,000 loops of rwsem vs percpu-rwsem:
> > https://github.com/joelagnel/linux-kernel/commit/8fe968116bd887592301179a53b7b3200db84424
> 
> Interesting location, but looks functional.  ;-)
> 
> > Graphs/Results here:
> > https://docs.google.com/spreadsheets/d/1cbVLNK8tzTZNTr-EDGDC0T0cnFCdFK3wg2Foj5-Ll9s/edit?usp=sharing
> > 
> > The completion time of the test goes up somewhat exponentially with
> > the number of threads, for the rwsem case, where as for percpu-rwsem
> > it is the same. I could add this data to some of the documentation as
> > well.
> 
> Actually, the completion time looks to be pretty close to linear in the
> number of CPUs.  Which is still really bad, don't get me wrong.

Sure, yes on second thought it is more linear than exponential :)

> Thank you for doing this, and it might be good to have some documentation
> on this.  In perfbook, I use counters to make this point, and perhaps
> I need to emphasize more that it also applies to other algorithms,
> including locking.  Me, I learned this lesson from a logic analyzer
> back in the very early 1990s.  This was back in the days before on-CPU
> caches when a logic analyzer could actually tell you something about
> the detailed execution.  ;-)
> 
> The key point is that you can often closely approximate the performance
> of synchronization algorithms by counting the number of cache misses and
> the number of CPUs competing for each cache line.

Cool, thanks for that insight. It has been some years since I used a logic
analyzer for some bus protocol debugging, but those are fun!

> If you want to get the microbenchmark test code itself upstream,
> one approach might be to have a kernel/locking/lockperf.c similar to
> kernel/rcu/rcuperf.c.
> Thoughts?

That sounds great to me, there's no other locking performance tests in the
kernel. There's locking api selftests at boot (DEBUG_LOCKING_API_SELFTESTS)
which just tests whether lockdep catches locking issues, and there's
locktorture, but I believe none of these test for lock performance.

I think a lockperf.c could also test other things about locking mechanisms,
such as how they perform if the owner of the lock is currently running vs
sleeping, while another thread is trying to acquire etc. What do you think? I
can add this to my list to do. Right now I'm working on the list-RCU lockdep
checking I started to work on [1] and want to post another series soon.

Thanks a lot,

- Joel

[1] https://lkml.org/lkml/2019/6/1/495
    https://lore.kernel.org/patchwork/patch/1082846/
> 
> 							Thanx, Paul
> 
