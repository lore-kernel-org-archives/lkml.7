Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C46C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF1221850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YMLUm+Os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfGEMYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:24:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38334 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGEMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:24:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id 9so4554067ple.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+92+mQnqCZ85omin5e6YlwLAH24rD0pIJUmhGE33hw=;
        b=YMLUm+Oskz620j3p0Ws9Tub7WR4bn2kIp+Yj5nnbwLmtfu9jCvdDJFNPmaJPD3PuSO
         QwWHb7Dz0k/IPJUe+7lloYfW2Nv8Xruz52EjVyZnb27KFZOsCemBK0F/xZT7qSw5FBLy
         efH3BnsIR/XBoyE9ZcOwt+kZGyJjM0KjKVTeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+92+mQnqCZ85omin5e6YlwLAH24rD0pIJUmhGE33hw=;
        b=A8IYpnnX8pe2wna2p+Vd84nyUJuQwl2o4MDp2YWkK4MHZRcnBIUJGlfneFicZ/70kZ
         e1P1RaMu0T5bak+6syYA037ac7YHMGpUIc5HdxE8XCpxtFwFFPG/2k9xVQx0pYf9dztG
         LwCZ4KeBIoZYC0O6widPPAd0S7Ix69Y1yIIoERFgDnR9w7d/DdL1EJDM71eogcYrAzNZ
         17p9iFtn6aQWdW1foOBdi5AzilaIuqCiOXlqRnyajZKjGcMU9Iil3WjJ84d57U9MY6UE
         lssz1srsshu2MW0JTU0aqn8nJBYS4UxiohIykXMkgcUK+3aEKC9OR1y9bp2JpTfa76la
         6YfQ==
X-Gm-Message-State: APjAAAVkEkjVpiQd7I7V+hR1uKiGi6V0Qg9fAYFHc/CGyHJwoeYgs1fN
        0fUVRVs9Pgdq12B5XOLt4Sko9LSixxg=
X-Google-Smtp-Source: APXvYqz9Zg2BFfwa8+N5Mja9B+tXvwy1K4XGIBLkOS/IhmO07//Bx7qCdd5bXEtvmGP3HnRsd+VGCQ==
X-Received: by 2002:a17:902:2889:: with SMTP id f9mr5078928plb.230.1562329492204;
        Fri, 05 Jul 2019 05:24:52 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v23sm8845074pff.185.2019.07.05.05.24.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 05:24:51 -0700 (PDT)
Date:   Fri, 5 Jul 2019 08:24:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH] rcuperf: Make rcuperf kernel test more robust for
 !expedited mode
Message-ID: <20190705122450.GA82532@google.com>
References: <20190704043431.208689-1-joel@joelfernandes.org>
 <20190704174044.GK26519@linux.ibm.com>
 <20190705035231.GA31088@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705035231.GA31088@X58A-UD3R>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 12:52:31PM +0900, Byungchul Park wrote:
> On Thu, Jul 04, 2019 at 10:40:44AM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 04, 2019 at 12:34:30AM -0400, Joel Fernandes (Google) wrote:
> > > It is possible that the rcuperf kernel test runs concurrently with init
> > > starting up.  During this time, the system is running all grace periods
> > > as expedited.  However, rcuperf can also be run for normal GP tests.
> > > Right now, it depends on a holdoff time before starting the test to
> > > ensure grace periods start later. This works fine with the default
> > > holdoff time however it is not robust in situations where init takes
> > > greater than the holdoff time to finish running. Or, as in my case:
> > > 
> > > I modified the rcuperf test locally to also run a thread that did
> > > preempt disable/enable in a loop. This had the effect of slowing down
> > > init. The end result was that the "batches:" counter in rcuperf was 0
> > > causing a division by 0 error in the results. This counter was 0 because
> > > only expedited GPs seem to happen, not normal ones which led to the
> > > rcu_state.gp_seq counter remaining constant across grace periods which
> > > unexpectedly happen to be expedited. The system was running expedited
> > > RCU all the time because rcu_unexpedited_gp() would not have run yet
> > > from init.  In other words, the test would concurrently with init
> > > booting in expedited GP mode.
> > > 
> > > To fix this properly, let us check if system_state if SYSTEM_RUNNING
> > > is set before starting the test. The system_state approximately aligns
> 
> Just minor typo..
> 
> To fix this properly, let us check if system_state if SYSTEM_RUNNING
> is set before starting the test. ...
> 
> Should be
> 
> To fix this properly, let us check if system_state is set to
> SYSTEM_RUNNING before starting the test. ...

That's a fair point. I wonder if Paul already fixed it up in his tree,
however I am happy to resend if he hasn't. Paul, how would you like to handle
this commit log nit?

it is just 'if ..' to 'is SYSTEM_RUNNING'
