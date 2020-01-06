Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29ADC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B0C2081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578347014;
	bh=D40R+s508mEXSVXOQ1t6RztEzDp+C0eZ3m/aCRf0AkY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=B825fQSPCKB4kIJ8JbXk+wGsi7foeOo4n+q58F6thoUnqMl/Nvaq6Wx5t8wvkK0pb
	 WmxTeaPwYaODWxCW5y4A4MbrKtOiXpMRcqq+H+0ghX88UpLd3STadvMfCtdgPADaYf
	 iZEtJr2Gmj7EBNHNqGKUcr0iW0gxrE/3ARjZkrss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgAFVne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgAFVnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:43:33 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248DF2080A;
        Mon,  6 Jan 2020 21:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578347013;
        bh=D40R+s508mEXSVXOQ1t6RztEzDp+C0eZ3m/aCRf0AkY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IcvQRK/YIp0u1+vc/JHsBaMzpzpqbusydrWc3+6UFHH64Gy5/4gvucn3jrpRW3sQ+
         sHBG7GyeBc5dwDuLuLdpxL2Bvvf6Kr/eiSqqNdmnStMjS4vEYxijHEgfS6Tw23OIGR
         /T9k5wP+TXI3SbQ4mIrHIx0ciiAUG4/IjqHVXALs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BAA4E352274D; Mon,  6 Jan 2020 13:43:32 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:43:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <20200106214332.GU13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191212160622.021517d3@canb.auug.org.au>
 <CAOesGMiabP7nAPYKrmP=j_8bSj-UfUSFoiD0W+kqzaBp-6J2hQ@mail.gmail.com>
 <20200106181006.GL13449@paulmck-ThinkPad-P72>
 <CAOesGMjTbrtVTU6ootOrOifKLqY_D0bstgqBKGriE9pVkNcPOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjTbrtVTU6ootOrOifKLqY_D0bstgqBKGriE9pVkNcPOQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 01:08:37PM -0800, Olof Johansson wrote:
> On Mon, Jan 6, 2020 at 10:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Jan 06, 2020 at 09:51:47AM -0800, Olof Johansson wrote:
> > > Hi,
> > >
> > > On Wed, Dec 11, 2019 at 9:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > After merging the rcu (I think) tree, today's linux-next build (x86_64
> > > > allnoconfig) produced this warning:
> > > >
> > > > kernel/time/timer.c: In function 'schedule_timeout':
> > > > kernel/time/timer.c:969:20: warning: 'timer.expires' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > > >   969 |   long diff = timer->expires - expires;
> > > >       |               ~~~~~^~~~~~~~~
> > > >
> > > > Introduced by (bisected to) commit
> > > >
> > > >   c4127fce1d02 ("timer: Use hlist_unhashed_lockless() in timer_pending()")
> > > >
> > > > x86_64-linux-gnu-gcc (Debian 9.2.1-21) 9.2.1 20191130
> > >
> > > This is still there as of last night's -next. Any update on getting a
> > > fix queued together with the offending patch?
> >
> > Hello, Olof,
> >
> > Thank you, I had indeed lost track of this one.  :-/
> >
> > Does Eric's patch fix things for you?
> >
> > https://lore.kernel.org/lkml/CANn89i+xomdo4HFqewrfNf_Z4Q5ayXuW6A4SjSkE46JXP9KuFw@mail.gmail.com/
> 
> It does, but it's not a proper patch (whitespace damage, no S-o-b, etc).

Understood, and thank you for checking!

Eric, would you be willing to turn this into a something that can be
sent upstream?

							Thanx, Paul
