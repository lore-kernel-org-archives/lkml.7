Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E5C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D472146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JtUgc6MI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfELBJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:09:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46222 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfELBJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:09:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so10831363wrr.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b8AW4BGaZt47ssLrB6qXfhhNxNJaIAABugP8Bf2LUJc=;
        b=JtUgc6MIGk7Y5MmFv4m3d4ISHMCOvUp6g70RA6sbJklbPEVGXVcftsBCT7hb5H1h0k
         /tp84iZt9wpGTu4789QOwr/LuvvL5efzMDvkcNfztOA+KYtq22DXr4TJOuCD71vDgcfy
         PAmm6OmFKtJSdn20Sq0KP1N7R6yfVj4Vk6Oss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b8AW4BGaZt47ssLrB6qXfhhNxNJaIAABugP8Bf2LUJc=;
        b=JRinHy0t2EXBS0lYfowjZ77joS5O/1halO2pWOxNagN9WzEjfHvksMVLH0wpncJLml
         46Km1znkFP0WB8nEA29NdLv4v8b4eTOXKh7/8hdUEAsUx+4Nzmic+v+F7KfhRIGaFgIK
         Nz04ad2tm8XDmUHTs+nGE318J+wqaDN3gNsGOVSzQQGJRBzR6r8xX2ml8Xl7l9fNGPeD
         H/ibJVDzc2WosuPjrB5uQIBvFyMu8OSwGlxbs5yPTvHZotVYOQRpEvtmI+0MeYiO9L8S
         WgRQZR8MnfOBo9LZuAihgTPXxV+JSdaKyovDZptNZ6xxGexVefyuGVrCLCTnoI6ySU9U
         L6YA==
X-Gm-Message-State: APjAAAVYnyU4emFlbm0nEFl4ZLRM98FKlaGL0pW+0sA3CElp9ow8jO+2
        ozr0SaRUrN/6gPp5PH3ltmfsrQ==
X-Google-Smtp-Source: APXvYqyhFbsf1FNgNI+/rAhBZzMgj02SE5lckYXHhdIt2dVUQv5+Ig7Tv7vgFOweYh2jEJHIGNHKzg==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr7970362wrs.280.1557623389777;
        Sat, 11 May 2019 18:09:49 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id t18sm19424094wrg.19.2019.05.11.18.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:09:49 -0700 (PDT)
Date:   Sun, 12 May 2019 03:09:41 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/rcu: Correct field_count field naming in examples
Message-ID: <20190512010941.GA8611@andrea>
References: <20190505020328.165839-1-joel@joelfernandes.org>
 <20190507000453.GB3923@linux.ibm.com>
 <20190508162635.GD187505@google.com>
 <20190508181638.GY3923@linux.ibm.com>
 <20190511221126.GA3984@andrea>
 <20190512004131.GE3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512004131.GE3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 05:41:31PM -0700, Paul E. McKenney wrote:
> On Sun, May 12, 2019 at 12:11:26AM +0200, Andrea Parri wrote:
> > Hi Paul, Joel,
> > 
> > > > > On the other hand, would you have ideas for more modern replacement
> > > > > examples?
> > > > 
> > > > There are 3 cases I can see in listRCU.txt:
> > > >   (1) action taken outside of read_lock (can tolerate stale data), no in-place update.
> > > >                 this is the best possible usage of RCU.
> > > >   (2) action taken outside of read_lock, in-place updates
> > > >                 this is good as long as not too many in-place updates.
> > > >                 involves copying creating new list node and replacing the
> > > >                 node being updated with it.
> > > >   (3) cannot tolerate stale data: here a deleted or obsolete flag can be used
> > > >                                   protected by a per-entry lock. reader
> > > > 				  aborts if object is stale.
> > > > 
> > > > Any replacement example must make satisfy (3) too?
> > > 
> > > It would be OK to have a separate example for (3).  It would of course
> > > be nicer to have one example for all three, but not all -that- important.
> > > 
> > > > The only example for (3) that I know of is sysvipc sempahores which you also
> > > > mentioned in the paper. Looking through this code, it hasn't changed
> > > > conceptually and it could be a fit for an example (ipc_valid_object() checks
> > > > for whether the object is stale).
> > > 
> > > That is indeed the classic canonical example.  ;-)
> > > 
> > > > The other example could be dentry look up which uses seqlocks for the
> > > > RCU-walk case? But that could be too complex. This is also something I first
> > > > learnt from the paper and then the excellent path-lookup.rst document in
> > > > kernel sources.
> > > 
> > > This is a great example, but it would need serious simplification for
> > > use in the Documentation/RCU directory.  Note that dcache uses it to
> > > gain very limited and targeted consistency -- only a few types of updates
> > > acquire the write-side of that seqlock.
> > > 
> > > Might be quite worthwhile to have a simplified example, though!
> > > Perhaps a trivial hash table where write-side sequence lock is acquired
> > > only when moving an element from one chain to another?
> > 
> > Sorry to take you down here..., but what do you mean by "the paper"?  ;-/
> 
> One or both of these two:
> 
> http://www2.rdrop.com/~paulmck/techreports/survey.2012.09.17a.pdf
> http://www2.rdrop.com/~paulmck/techreports/RCUUsage.2013.02.24a.pdf

Oh, these are familiar.  ;-) Thank you!

  Andrea
