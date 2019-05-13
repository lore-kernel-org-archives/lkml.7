Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4516FC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D0621473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Nxf77d9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfEMPhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:37:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35319 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfEMPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:37:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id g5so6674127plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wRRDlrnvuHRLfyMRQOj/Q6jBHy3+2xu46qlQP+83E3Q=;
        b=Nxf77d9VAJIg0p/O3sFRuwWVZCEVabaV6YiJMr1MbvG7oaZbmCqmlTFzGO8l9CH55i
         DydBhMydR5+LP/ynF/NyEULTDLSILhhzuK5X5ev3UtjiWs68pv1O+8Zd7STdIfyocNqa
         gucAkpheJRkc+q4kYiiBBso55e58HG89v3m/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wRRDlrnvuHRLfyMRQOj/Q6jBHy3+2xu46qlQP+83E3Q=;
        b=nXcL2LYNJ1M1EUMlIzMB1Zb5K0XsS+mseh2K2tkPF0Jlz15ZQzSJiB2Q6s9CQPL8K0
         LQZDwxIXZLt3jU7cnBqrWr1cKf1hNDdltFNSd659JcKBja9Fx0+jffTzZUXSDxLasJZ5
         qSRHoCmqwdQWEGOzWel2CMTpWaORBBV00w+k92UI6H0ZUYgAeDYrZCkZjpoOmObEoQFD
         oKCvbFpLa9pWpc102owNZq36Jj2vREI2ZxhOlaY/IpksSkkBCOco7ZPF8/OD9kzAlzPc
         1L4MlLDPflBXqytkbTcAr9W/Sz8hmFJJpwfws4Ydf8ZMd+HmlwIugS0rXvnarIwg/iS+
         jFeA==
X-Gm-Message-State: APjAAAWMUUEkD7pyv6CeTLLumssnyrp+kr/T4HVbdjBLni1XzXYrFoXF
        6Wuj7HhywL9opSLRO1d4CKwWQw==
X-Google-Smtp-Source: APXvYqyEfOsJGByTquC1+xb7Jbk5F7LMEsnGHkoUmoOXvQVlgFOV/AD52SYM1R802GZtBjkYxnpL2A==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr13811570plt.84.1557761836581;
        Mon, 13 May 2019 08:37:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a17sm18387038pff.82.2019.05.13.08.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 08:37:15 -0700 (PDT)
Date:   Mon, 13 May 2019 11:37:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190513153714.GA40957@google.com>
References: <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509193625.GA12455@linux.ibm.com>
 <20190510120819.GR2589@hirez.programming.kicks-ass.net>
 <20190510230742.GY3923@linux.ibm.com>
 <20190511214520.GA3251@andrea>
 <20190512003915.GD3923@linux.ibm.com>
 <20190512010539.GA8167@andrea>
 <20190513122043.GJ3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513122043.GJ3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 05:20:43AM -0700, Paul E. McKenney wrote:
> On Sun, May 12, 2019 at 03:05:39AM +0200, Andrea Parri wrote:
> > > > > The fix is straightforward.  I just added "rcutorture.shuffle_interval=0"
> > > > > to the TRIVIAL.boot file, which stops rcutorture from shuffling its
> > > > > kthreads around.
> > > > 
> > > > I added the option to the file and I didn't reproduce the issue.
> > > 
> > > Thank you!  May I add your Tested-by?
> > 
> > Please feel free to do so.  But it may be worth to squash "the commits"
> > (and adjust the changelogs accordingly).  And you might want to remove
> > some of those debug checks/prints?
> 
> Revert/remove a number of the commits, but yes.  ;-)
> 
> And remove the extra loop, but leave the single WARN_ON() complaining
> about being on the wrong CPU.

The other "toy" implementation I noticed is based on reader/writer locking.

Would you see value in having that as an additional rcu torture type?

thanks,

 - Joel

