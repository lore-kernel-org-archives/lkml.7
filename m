Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2CEC2D0CA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83D12467B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576441226;
	bh=MdmJ64HRkk9tT9NmFhePTWKkIqcvoa642z83P8Vcuko=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=0fuoXHkkjm7+CrCpllEV63h6g7NEYGWi3+rjjifeBL8xXiJ8vrIYs9GiF/o741oB5
	 UKyGttwmGvLttz9KrP/qyj7OdF6epjiX6dx0CcEwhHmbj0gzTCnGNvWjRkpQgmGEzb
	 WCZFazfYJh7Lz9C5ncqYRJ2XyEvBjjGvPzVWXY3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfLOUUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfLOUUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:20:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2955920700;
        Sun, 15 Dec 2019 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576441224;
        bh=MdmJ64HRkk9tT9NmFhePTWKkIqcvoa642z83P8Vcuko=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d9cjONB1gZogQ7rCuOiMfiY9u6KF7ktCTrf++iYsV18pOmg27cV+2p5ZabjVKkonH
         zx3/I0HS5WQD7bWJIsZQk7GK2vtjvilEhkenCNnMz7mvDj1QkdmDo+Tr5FIQsCzBLL
         eTXdz4kywjvQv9XR5LsAJ2/1/pxmgtRyDj1nqAjA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 00690352274B; Sun, 15 Dec 2019 12:20:23 -0800 (PST)
Date:   Sun, 15 Dec 2019 12:20:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dexuan-Linux Cui <dexuan.linux@gmail.com>
Cc:     Qian Cai <cai@lca.pw>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lili Deng <Lili.Deng@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Baihua Lu <Baihua.Lu@microsoft.com>
Subject: Re: "rcu: React to callback overload by aggressively seeking
 quiescent states" hangs on boot
Message-ID: <20191215202023.GM2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191213224646.GH2889@paulmck-ThinkPad-P72>
 <CAA6354A-C747-4BE0-8EDC-C06E3C1D7D08@lca.pw>
 <20191214064048.GI2889@paulmck-ThinkPad-P72>
 <CAA42JLbBFkpYHXRVvyveYO76DnbkE3gyRW-=qmBGZcJTAiB6Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA42JLbBFkpYHXRVvyveYO76DnbkE3gyRW-=qmBGZcJTAiB6Uw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 11:18:43AM -0800, Dexuan-Linux Cui wrote:
> On Fri, Dec 13, 2019 at 10:41 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Dec 13, 2019 at 06:11:16PM -0500, Qian Cai wrote:
> > >
> > >
> > > > On Dec 13, 2019, at 5:46 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > I am running this on a number of x86 systems, but will try it on a
> > >
> > > The config to reproduce includes several debugging options that might
> > > required to recreate.
> >
> > If you run without those debugging options, do you still see the hangs?
> > If not, please let me know which debugging are involved.
> >
> > > > wider variety.  If I cannot reproduce it, would you be willing to
> > > > run diagnostics?
> > >
> > > Yes.
> >
> > Very good!  Let me see what I can put together.  (No luck reproducing
> > at my end thus far.)
> >
> > > > Just to double-check...  Are you running rcutorture built into the kernel?
> > > > (My guess is "no", but figured that I should ask.)
> > >
> > > No as you can see from the config I linked in the original email.
> >
> > Fair point, and please accept my apologies for the pointless question.
> >
> >                                                         Thanx, Paul
> 
> Hi,
> We're seeing the same hang issue with a recent Linux next-20191213
> kernel.  If we revert the same commit 82150cb53dcb ("rcu: React to
> callback overload by aggressively seeking quiescent states”), the
> issue will go away.
> 
> Note: we're running the x86-64 Linux VM Hyper-V, and the the torture
> test is not used:
> 
> $ grep  -i torture  .config
> CONFIG_LOCK_TORTURE_TEST=m
> CONFIG_TORTURE_TEST=m
> # CONFIG_RCU_TORTURE_TEST is not set
> 
> (FYI: the kernel config and the serial console log are attached).
> 
> When the issue happens, I force a kernel panic by NMI several times
> and I can see the rcu_gp_kthread hangs at some places, but it looks
> all the places are in the below loop:
> 
> (The first panic log is in the attachment)
> (gdb) l *(rcu_gp_kthread+0x703)
> 0xffffffff811128c3 is in rcu_gp_kthread (kernel/rcu/tree.c:1763).
> 1758                    if (rnp == rdp->mynode)
> 1759                            needgp = __note_gp_changes(rnp, rdp) || needgp;
> 1760                    /* smp_mb() provided by prior unlock-lock pair. */
> 1761                    needgp = rcu_future_gp_cleanup(rnp) || needgp;
> 1762                    // Reset overload indication for CPUs no
> longer overloaded
> 1763                    for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
> 1764                            rdp = per_cpu_ptr(&rcu_data, cpu);
> 1765                            check_cb_ovld_locked(rdp, rnp);
> 1766                    }
> 1767                    sq = rcu_nocb_gp_get(rnp);

This is consistent with what I saw in Qian Cai's report, FYI.  So I
am very interested in learning whether the first patch in my reply [1]
helps you.

							Thanx, Paul

[1]  https://lore.kernel.org/lkml/20191215201646.GK2889@paulmck-ThinkPad-P72/
