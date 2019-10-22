Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC03CCA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A6120882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571710391;
	bh=S/2WtQMt9L/0ZoLF2YR0k3YeJsSzQfW7/ml8EXtJZvQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=03eTPCbhEfxL0B/ZuxIM6W0RHguVScRtkcXlflbHM9Skkj/iG19XBj/XwSjJyhzqQ
	 rHgZPNzkuZzkat2s79qLu6P8TiMztABeaXa+4pgJIS+rUs6GJ0T37sNbBPn6E0nMIp
	 65Sq9KevQrmpq8iFyMLDVhUYLGF7C63WlR+TJIzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfJVCNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfJVCNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:13:10 -0400
Received: from paulmck-ThinkPad-P72 (cpe-67-241-73-101.twcny.res.rr.com [67.241.73.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 873D12086D;
        Tue, 22 Oct 2019 02:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571710389;
        bh=S/2WtQMt9L/0ZoLF2YR0k3YeJsSzQfW7/ml8EXtJZvQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W2+pqJsXZVCDf8qWvoR27cJI/6f5uG2gCB5k8Ghad9Zr7D2VIHYSdll/wRwZqRLFd
         UbKo85vILq3YxvjNwmzn0pBvbtBvPflDFTDPKcElEKh/h2kH4hnuXnZjumRLMbQxpl
         OH6GT+HydvwSq7LrueUKv9geSOaxXaQGAo4OLsG4=
Date:   Mon, 21 Oct 2019 19:13:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Micah Morton <mortonm@chromium.org>,
        Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
Message-ID: <20191022021306.GB2479@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
 <20190923233038.GE7828@paulmck-ThinkPad-P72>
 <20191021065811.GA17098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021065811.GA17098@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 08:58:11AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -383,20 +383,22 @@ do {									      \
> >  } while (0)
> >  
> >  /**
> > - * rcu_swap_protected() - swap an RCU and a regular pointer
> > - * @rcu_ptr: RCU pointer
> > + * rcu_replace() - replace an RCU pointer, returning its old value
> > + * @rcu_ptr: RCU pointer, whose old value is returned
> >   * @ptr: regular pointer
> > - * @c: the conditions under which the dereference will take place
> > + * @c: the lockdep conditions under which the dereference will take place
> >   *
> > - * Perform swap(@rcu_ptr, @ptr) where @rcu_ptr is an RCU-annotated pointer and
> > - * @c is the argument that is passed to the rcu_dereference_protected() call
> > - * used to read that pointer.
> > + * Perform a replacement, where @rcu_ptr is an RCU-annotated
> > + * pointer and @c is the lockdep argument that is passed to the
> > + * rcu_dereference_protected() call used to read that pointer.  The old
> > + * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
> >   */
> > -#define rcu_swap_protected(rcu_ptr, ptr, c) do {			\
> > +#define rcu_replace(rcu_ptr, ptr, c)					\
> > +({									\
> >  	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
> >  	rcu_assign_pointer((rcu_ptr), (ptr));				\
> > -	(ptr) = __tmp;							\
> > -} while (0)
> > +	__tmp;								\
> > +})
> 
> One small suggestion, would it make sense to name it "rcu_replace_pointer()"?
> 
> This would make it fit into the pointer handling family of RCU functions: 
> rcu_assign_pointer(), rcu_access_pointer(), RCU_INIT_POINTER() et al?

Easy enough to make the change.  I will do that tomorrow and test over
the following night.

> rcu_swap() would also look a bit weird if used in MM code. ;-)

How much RCU swap should we configure on this system?  About same amount
as reader-writer swap!  ;-)

							Thanx, Paul
