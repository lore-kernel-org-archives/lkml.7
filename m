Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE877CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 00:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D5F2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 00:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzKOj5ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfKAAUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 20:20:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35817 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfKAAUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 20:20:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id r22so892113qtt.2;
        Thu, 31 Oct 2019 17:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xi5TyLi/vvHgUujnBuE9/F+olYAjNu8EPkfesj0ZK4w=;
        b=rzKOj5icRaa7e7dd4H/ADt79zDKh5OVt8s58jN4YR0znr5Zgwq9peB+CLATCxwt7js
         G4m4VwXxC4BTyR9Wt6CdGF7GrfGLYW9OYODnujX+OhKMqrMG2vTjqCGCveAEsIEDj8ge
         rzclLH7VImO8mV/PGWh9U0j1qf6HoZvNg6ljxk6GRjwbLMHKvtsslP0/b2wDlCQFuuGi
         b89CnuhTKbjUNxKe6waMvFj+UtZr4B90te/Cib9GfSkFWGxxk5pn9rPffX92s32e5sfw
         6bZHHlD3MRa4IbdwIV/rWBeGtS6sYyuKAsdHzB0SiTtjCHUpsdUJ4YeUEKE9pHefMd0/
         vcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xi5TyLi/vvHgUujnBuE9/F+olYAjNu8EPkfesj0ZK4w=;
        b=LT3a5TKjxAbEIcqyo+hsSQPQAo6+cOm9A39H0BmxpKI+ndvi/x3e7M2fe8uszpsIOi
         ZPRU3TUYpQvPtq0xHzOS9U14Z/jpOjq1Da93ot7K2qedduxDKTsG1Kw4iv3r9fsrSs4T
         mJrhWUDZs8mstYo9foeA29clET3WzBZe8jTchUIPU2bTT2nSfLELADcM4KUHXuRNA9n3
         yx9lbnOvn9BRjwyiOrpAo3vspjZ470y+ryeIurIXMSPDBCs7AqLdzKKTci29nl7XFgJf
         FPobTvJmjtwZi9+2pha88vZCLYkBJ2hzfYP9o/Y35gpVIb+UUF1DfaSmlYYWfqnJTMP4
         l4NA==
X-Gm-Message-State: APjAAAXNAW+dqUr7a4rZNSBTrg0TLheuWdTkKv0Jc5qhkVpF5b4Uwlgy
        MauJzFJeq8uBPwN3Z0TFbK0=
X-Google-Smtp-Source: APXvYqxqxSJDeI2V3tx8kDrd5hNk4dcTmWeUwwm9LrVpi9BsPF+MhBP2TamP2awoaTi/IgOCAW+nlA==
X-Received: by 2002:ac8:30f4:: with SMTP id w49mr3279347qta.35.1572567599773;
        Thu, 31 Oct 2019 17:19:59 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b123sm1092985qkc.120.2019.10.31.17.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 17:19:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1177420CB3;
        Thu, 31 Oct 2019 20:19:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 31 Oct 2019 20:19:58 -0400
X-ME-Sender: <xms:LXq7XfO7Pkzn_njUnJn0J9wFg4GC6PAd_FRRVHrf7g2fMCEU1vbJ9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddtiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomh
    grihhnpehlfihnrdhnvghtnecukfhppeduieejrddvvddtrddvheehrddvkeenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:LXq7XSXx2jvDSf_aeIxnBY0bggmTmIm8QM-WkfCzx_Fh8herrWHYjQ>
    <xmx:LXq7XQdDwL8yVZjP9GTR2tqXW6dPqDHkMH6kgKeILga3RUmx-LKPJw>
    <xmx:LXq7XbgF5y41ZpezUo5pumJb5bq9CxkX8SZhPkrSJi8NxWEcEiqAjQ>
    <xmx:Lnq7XX-MtlGEDV0hnZqhmJaYDfQT6vsGZoew7T5CaR82C-mbZWOd4Q>
Received: from localhost (unknown [167.220.255.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4FF1780066;
        Thu, 31 Oct 2019 20:19:56 -0400 (EDT)
Date:   Fri, 1 Nov 2019 08:19:48 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 02/11] rcu: fix bug when rcu_exp_handler() in nested
 interrupt
Message-ID: <20191101001948.GA182@boqun-laptop.fareast.corp.microsoft.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-3-laijs@linux.alibaba.com>
 <20191031134731.GP20975@paulmck-ThinkPad-P72>
 <20191031143119.GA15954@paulmck-ThinkPad-P72>
 <6b621228-4cab-6e2c-9912-cddc56ad6775@linux.alibaba.com>
 <20191031185258.GX20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191031185258.GX20975@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:52:58AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 31, 2019 at 11:14:23PM +0800, Lai Jiangshan wrote:
> > 
> > 
> > On 2019/10/31 10:31 下午, Paul E. McKenney wrote:
> > > On Thu, Oct 31, 2019 at 06:47:31AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Oct 31, 2019 at 10:07:57AM +0000, Lai Jiangshan wrote:
> > > > > These is a possible bug (although which I can't triger yet)
> > > > > since 2015 8203d6d0ee78
> > > > > (rcu: Use single-stage IPI algorithm for RCU expedited grace period)
> > > > > 
> > > > >   rcu_read_unlock()
> > > > >    ->rcu_read_lock_nesting = -RCU_NEST_BIAS;
> > > > >    interrupt(); // before or after rcu_read_unlock_special()
> > > > >     rcu_read_lock()
> > > > >      fetch some rcu protected pointers
> > > > >      // exp GP starts in other cpu.
> > > > >      some works
> > > > >      NESTED interrupt for rcu_exp_handler();
> > > 
> > > Also, which platforms support nested interrupts?  Last I knew, this was
> > > prohibited.
> > > 
> > > > >        report exp qs! BUG!
> > > > 
> > > > Why would a quiescent state for the expedited grace period be reported
> > > > here?  This CPU is still in an RCU read-side critical section, isn't it?
> > > 
> > > And I now see what you were getting at here.  Yes, the current code
> > > assumes that interrupt-disabled regions, like hardware interrupt
> > > handlers, cannot be interrupted.  But if interrupt-disabled regions such
> > > as hardware interrupt handlers can be interrupted (as opposed to being
> > > NMIed), wouldn't that break a whole lot of stuff all over the place in
> > > the kernel?  So that sounds like an arch bug to me.
> > 
> > I don't know when I started always assuming hardware interrupt
> > handler can be nested by (other) interrupt. I can't find any
> > documents say Linux don't allow nested interrupt handler.
> > Google search suggests the opposite.

FWIW, there is a LWN article talking about we disallow interrupt nesting
in *most* cases:

	https://lwn.net/Articles/380931/

, that's unless a interrupt handler explicitly calls
local_irq_enable_in_hardirq(), it remains irq disabled, which means no
nesting interrupt allowed.

Regards,
Boqun

> 
> The results I am seeing look to be talking about threaded interrupt
> handlers, which indeed can be interrupted by hardware interrupts.  As can
> softirq handlers.  But these are not examples of a hardware interrupt
> handler being interrupted by another hardware interrupt.  For that to
> work reasonably, something like a system priority level is required,
> as in the old DYNIX/ptx kernel, or, going even farther back, DEC's RT-11.
> 
> > grep -rIni nested Documentation/memory-barriers.txt Documentation/x86/
> > It still have some words about nested interrupt handler.
> 
> Some hardware does not differentiate between interrupts and exceptions,
> for example, an illegal-instruction trap within an interrupt handler
> might look in some ways like a nested interrupt.
> 
> > The whole patchset doesn't depend on this patch, and actually
> > it is reverted later in the patchset. Dropping this patch
> > can be an option for next round.
> 
> Sounds like a plan!
> 
> 							Thanx, Paul
> 
[...]
