Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E58C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4372166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d0VFIDow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfH2TAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:00:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38711 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfH2TAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:00:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so2699685pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YFO4ToJTqzSQELe3odwwkEfeFs84ACj71p8BdwBVqGc=;
        b=d0VFIDowYpvAl/u3SmvC0to24Kdmxtpz2/UnnHd8VZyq1Od8buoXAZgDmyshy3xKpv
         E4JQSe8CmUGbPMBhy30yzfA9+zY3kE2Oveu4m/7CuPoW/IOsvPx2E/fQ8csrW2zCDVFZ
         YCaTL8mvBoul3+p5hEYzMhXdMc/Th4xD/Oc+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YFO4ToJTqzSQELe3odwwkEfeFs84ACj71p8BdwBVqGc=;
        b=r9VHQOIxyW7QqTD2vtzf0iQdhppXO/8alBoZyxmB2AkUGVJqSxLr6Z5b8a7tGmxU6A
         f+H8FgzPsWFnkhzgDKD+/zuEvjrr6MhQNOlu9DwpCFtok6B5ZTMZyNVMEVuXDIvOdvO6
         /qwZ1TZMGi08M/EveDUYv3KcQrykCYd46jd5Xy0xthcJq9zUqXsmOAAnAhh/kF7c5ZRQ
         1sbS5zoT0glYIqTb/NFF/vNPpuJtN2y9qoaDlttwUzKBRmY9G+Q+Q1hM03nSzO0N+S13
         NC2vqNWfJL4z6Nra5DrgsiU7Dj8JhWNjVXTRebzaJ1xehNOz/VI0FnCrqqvF/uq3rJQ+
         i9UQ==
X-Gm-Message-State: APjAAAV3iK4q24q7BRsF3/hqKloP8BwCe4SXubSBvGPxIyUJpN5x+/ff
        nLLaxNdLHsQOnwQkp0IqFj5cu4d8CPw=
X-Google-Smtp-Source: APXvYqw8LkU0kSGTofdVPMh2aqBnJCfeAMn73MuHa4izANAy35sEF6IaMEn0o0lntDwre+4hF5klZA==
X-Received: by 2002:a17:90a:d345:: with SMTP id i5mr11528135pjx.16.1567105248246;
        Thu, 29 Aug 2019 12:00:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 5sm2846842pgh.93.2019.08.29.12.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:00:47 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:00:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Android Kernel Team <kernel-team@android.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
Message-ID: <20190829190046.GB115245@google.com>
References: <20190828214241.GD75931@google.com>
 <20190828220108.GC26530@linux.ibm.com>
 <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com>
 <20190829144355.GE63638@google.com>
 <20190829160946.GP4125@linux.ibm.com>
 <CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com>
 <20190829165407.GT4125@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829165407.GT4125@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Aug 29, 2019 at 09:54:07AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 29, 2019 at 09:21:46AM -0700, Andy Lutomirski wrote:
> > On Thu, Aug 29, 2019 at 9:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Aug 29, 2019 at 10:43:55AM -0400, Joel Fernandes wrote:
> > >
> > > [ . . . ]
> > >
> > > > Paul, do we also nuke rcu_eqs_special_set()?  Currently I don't see anyone
> > > > using it. And also remove the bottom most bit of dynticks?
> > > >
> > > > Also what happens if a TLB flush broadcast is needed? Do we IPI nohz or idle
> > > > CPUs are the moment?
> > > >
> > > > All of this was introduced in:
> > > > b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
> > >
> > > Adding Andy Lutomirski on CC.
> > >
> > > Andy, is this going to be used in the near term, or should we just get
> > > rid of it?
> > 
> > Let's get rid of it.  I'm not actually convinced it *can* be used as designed.
> > 
> > For those who forgot the history or weren't cc'd on all of it: I had
> > this clever idea about how we could reduce TLB flushes.  I implemented
> > some of it (but not the part that would have used this RCU feature),
> > and it exploded in nasty and subtle ways.  This caused me to learn
> > that speculative TLB fills were a problem that I had entirely failed
> > to account for.  Then PTI happened and thoroughly muddied the water.
> 
> Yeah, PTI was quite annoying.  Still is, from what I can see.  :-/
> 
> > So I think we should just drop this :(
> 
> OK, thank you!  I will put a tag into -rcu marking its removal in case
> it should prove useful whenever for whatever.
> 
> Joel, would you like to remove this, or would you rather that I did?
> It is in code you are working with right now, so if I do it, I need to
> wait until yours is finalized.  Which wouldn't be a problem.

I can remove it in my series, made a note to do so.

thanks,

 - Joel

