Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0F0C5B577
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB0F215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GGlD3qyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfF2Tf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:35:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53821 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfF2Tf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:35:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so12120223wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AIYJrR0ei1hDjegV3RZZBi3QRy+2KeuZEznoUGiMh5w=;
        b=GGlD3qyhDyigzmPVMEjWx6LBtcJAKaZDpWtSYeNxDmKp69E5MQaXdShTxnhILQNHYD
         CNv7tVwMJ5hHfo0yy6o9UpdmbwLPveA/r++x+Ty/TWHgj/tuKNpsf47zOE3nw76FuHjX
         WRMzhXZA1QAgIxUqi88l3H+J5FyNXqkgC8Sa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIYJrR0ei1hDjegV3RZZBi3QRy+2KeuZEznoUGiMh5w=;
        b=V4ZhpFomE0V3jTFbMh6jGb2tS5Vm0WMBvPiCp8PnNYOirzRNuV5IyGI+eIS+/Gw5ZG
         cDhTooFJLxfYYFoldFl7Q0Xc3TfFYajkHT4tORZicrQAL2U3+S4sGQTshH5NYhkOPsAF
         4xGgG6JCZDXizPhXruo44JQgpvXyYbiMvSWEBTMmlRYMR0MKzxPljd5ydLxfhqDXwZxD
         /8QrG+2WT1xLPlotTZT6CVDxq99UnReGGmULPgx+nL83rkvmf86aMU74pAVscZCjLgfg
         MKGmy5aaYh29B771Enf8Y39bovuOfHRqgjykmngiacBx7BLcJuIuVoklAQYA/DOS734D
         1HvQ==
X-Gm-Message-State: APjAAAWzgyA3+miphOzvfO4OjAgHnTruGn4EDuh8FMhQQ0V7aINSf7h2
        Fq+Wb5KLQcgybeRAYzC9vNSU0Q==
X-Google-Smtp-Source: APXvYqyeAXmHLqMjzugYMFmDD7hFr7AZZlLbU/HdY74sXBX7SmBIn5g9iVg/An/CXH82LeEmN+sVeQ==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr10503971wma.123.1561836954411;
        Sat, 29 Jun 2019 12:35:54 -0700 (PDT)
Received: from andrea ([93.90.167.233])
        by smtp.gmail.com with ESMTPSA id x17sm4049219wrq.64.2019.06.29.12.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 12:35:53 -0700 (PDT)
Date:   Sat, 29 Jun 2019 21:35:48 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190629193548.GA8308@andrea>
References: <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628073138.GB13650@X58A-UD3R>
 <20190628104045.GA8394@X58A-UD3R>
 <20190628114411.5d9ab351@gandalf.local.home>
 <20190629151236.GA7862@andrea>
 <20190629165533.GA3112@linux.ibm.com>
 <20190629180910.GA3399@andrea>
 <20190629191515.GM26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629191515.GM26519@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 12:15:15PM -0700, Paul E. McKenney wrote:
> On Sat, Jun 29, 2019 at 08:09:10PM +0200, Andrea Parri wrote:
> > On Sat, Jun 29, 2019 at 09:55:33AM -0700, Paul E. McKenney wrote:
> > > On Sat, Jun 29, 2019 at 05:12:36PM +0200, Andrea Parri wrote:
> > > > Hi Steve,
> > > > 
> > > > > As Paul stated, interrupts are synchronization points. Archs can only
> > > > > play games with ordering when dealing with entities outside the CPU
> > > > > (devices and other CPUs). But if you have assembly that has two stores,
> > > > > and an interrupt comes in, the arch must guarantee that the stores are
> > > > > done in that order as the interrupt sees it.
> > > > 
> > > > Hopefully I'm not derailing the conversation too much with my questions
> > > > ... but I was wondering if we had any documentation (or inline comments)
> > > > elaborating on this "interrupts are synchronization points"?
> > > 
> > > I don't know of any, but I would suggest instead looking at something
> > > like the Hennessey and Patterson computer-architecture textbook.
> > > 
> > > Please keep in mind that the rather detailed documentation on RCU is a
> > > bit of an outlier due to the fact that there are not so many textbooks
> > > that cover RCU.  If we tried to replicate all of the relevant textbooks
> > > in the Documentation directory, it would be quite a large mess.  ;-)
> > 
> > You know some developers considered it worth to develop formal specs in
> > order to better understand concepts such as "synchronization" and "IRQs
> > (processing)"! ...  ;-)  I still think that adding a few paragraphs (if
> > only in informal prose) to explain that "interrupts are synchronization
> > points" wouln't hurt.  And you're right, I guess we may well start from
> > a reference to H&P...
> > 
> > Remark: we do have code which (while acknowledging that "interrupts are
> > synchronization points") doesn't quite seem to "believe it", c.f., e.g.,
> > kernel/sched/membarrier.c:ipi_mb().  So, I guess the follow-up question
> > would be "Would we better be (more) paranoid? ..."
> 
> As Steve said that I said, they are synchronization points from the
> viewpoint of code within the interrupted CPU.  Unless the architecture
> code does as smp_mb() on interrupt entry and exit (which perhaps some
> do, for all I know, maybe all of them do by now), memory accesses could
> still be reordered across the interrupt from the perspective of other
> CPUs and devices on the system.

Yes, I got it.  See:

  https://lkml.kernel.org/r/20190629182132.GA5666@andrea

Still...

  Andrea
