Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F37C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8817F218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573143114;
	bh=awD6N2CESXn5U2N9EcHchdVWtzDo0QVla+3w4q1cSxU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=JKCMpC/0ZS+ogX4azcbuqIwF/YdtoCfaabTrUt7ibOyEaA/S0FLAbt6Eh+gfZHLv6
	 RNZX7EQh01Lb3uNbn0GMeb3QyEAs9E4n9hFLc3WRKp4Yac+2gC0IgTHcsLFSv7L1DH
	 SF0MWfk/nInuhr3wrw2RHRs/kxkKqU6rDX28pBZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbfKGQLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbfKGQLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:11:53 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.209.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5372A214D8;
        Thu,  7 Nov 2019 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573143111;
        bh=awD6N2CESXn5U2N9EcHchdVWtzDo0QVla+3w4q1cSxU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K6K2EKyYtO0ktuL4X41HYrE6FTRUp5t9OTlR9DJ0bc/kk2Wg4gBTVzZ/qiaWhLMQT
         I9yXq90aNWOkPC26C+xIjJ0syeM+3m0V0SMhSwCXnMtzCdntdiFAO2qcFpgrwq7ULa
         VMKbqn7mw6FIAQ4sfGcrJQTI1caR7e1hrYmRUgfE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4E47535227FC; Thu,  7 Nov 2019 08:11:49 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:11:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to
 timer->state
Message-ID: <20191107161149.GQ20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191106174804.74723-1-edumazet@google.com>
 <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
 <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
 <20191107085255.GK20975@paulmck-ThinkPad-P72>
 <CANn89i+8Hq5j234zFRY05QxZU1n=Vr6S-kZCcvn3Z80xYaindg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+8Hq5j234zFRY05QxZU1n=Vr6S-kZCcvn3Z80xYaindg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 07:48:50AM -0800, Eric Dumazet wrote:
> On Thu, Nov 7, 2019 at 12:53 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Nov 06, 2019 at 02:59:36PM -0800, Eric Dumazet wrote:
> > > On Wed, Nov 6, 2019 at 2:53 PM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > On Wed, Nov 6, 2019 at 2:24 PM tip-bot2 for Eric Dumazet
> > > > <tip-bot2@linutronix.de> wrote:
> > > > >
> > > > > The following commit has been merged into the timers/core branch of tip:
> > > > >
> > > > > Commit-ID:     56144737e67329c9aaed15f942d46a6302e2e3d8
> > > > > Gitweb:        https://git.kernel.org/tip/56144737e67329c9aaed15f942d46a6302e2e3d8
> > > > > Author:        Eric Dumazet <edumazet@google.com>
> > > > > AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> > > > > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > > > > CommitterDate: Wed, 06 Nov 2019 23:18:31 +01:00
> > > > >
> > > > > hrtimer: Annotate lockless access to timer->state
> > > > >
> > > >
> > > > I guess we also need to fix timer_pending(), since timer->entry.pprev
> > > > could change while we read it.
> > >
> > > It is interesting seeing hlist_add_head() has a WRITE_ONCE(h->first, n);,
> > > but no WRITE_ONCE() for the pprev change.
> > >
> > > The WRITE_ONCE() was added in commit 1c97be677f72b3c338312aecd36d8fff20322f32
> > > ("list: Use WRITE_ONCE() when adding to lists and hlists")
> >
> > The theory is that while the ->next pointer is concurrently accessed by
> > RCU readers, the ->pprev pointer is accessed only by updaters, who need
> > to supply sufficient synchronization.
> >
> > But what is this theory missing in practice?
> 
> Here is some context : I am helping triaging about 400 KCSAN data-race
> splats in syzbot moderation queue.
> 
> Take a look at the timer related one in [1]
> 
> If we want to avoid potential load/store-tearing, minimall patch would be :
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 85c92555e31f85f019354e54d6efb8e79c2aee17..9139803b851cc37bb759c8d7c12ee7e36c61f009
> 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -761,7 +761,7 @@ static inline void __hlist_del(struct hlist_node *n)
> 
>         WRITE_ONCE(*pprev, next);
>         if (next)
> -               next->pprev = pprev;
> +               WRITE_ONCE(next->pprev, pprev);
>  }
> 
>  static inline void hlist_del(struct hlist_node *n)
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index 1e6650ed066d5d28251b0bd385fc37ef94c96532..c7c8dd89f2797389ca96473e60c7297fd38d8259
> 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct
> timer_list *timer) { }
>   */
>  static inline int timer_pending(const struct timer_list * timer)
>  {
> -       return timer->entry.pprev != NULL;
> +       return READ_ONCE(timer->entry.pprev) != NULL;
>  }
> 
>  extern void add_timer_on(struct timer_list *timer, int cpu);
> 
> But really many other WRITE_ONCE() would be needed in include/linux/list.h
> 
> [1]
> 
> BUG: KCSAN: data-race in del_timer / detach_if_pending
> 
> write to 0xffff88808697d870 of 8 bytes by task 10 on cpu 0:
>  __hlist_del include/linux/list.h:764 [inline]
>  detach_timer kernel/time/timer.c:815 [inline]
>  detach_if_pending+0xcd/0x2d0 kernel/time/timer.c:832
>  try_to_del_timer_sync+0x60/0xb0 kernel/time/timer.c:1226
>  del_timer_sync+0x6b/0xa0 kernel/time/timer.c:1365
>  schedule_timeout+0x2d2/0x6e0 kernel/time/timer.c:1896
>  rcu_gp_fqs_loop+0x37c/0x580 kernel/rcu/tree.c:1639
>  rcu_gp_kthread+0x143/0x230 kernel/rcu/tree.c:1799
>  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> 
> read to 0xffff88808697d870 of 8 bytes by task 12060 on cpu 1:
>  del_timer+0x3b/0xb0 kernel/time/timer.c:1198
>  sk_stop_timer+0x25/0x60 net/core/sock.c:2845
>  inet_csk_clear_xmit_timers+0x69/0xa0 net/ipv4/inet_connection_sock.c:523
>  tcp_clear_xmit_timers include/net/tcp.h:606 [inline]
>  tcp_v4_destroy_sock+0xa3/0x3f0 net/ipv4/tcp_ipv4.c:2096
>  inet_csk_destroy_sock+0xf4/0x250 net/ipv4/inet_connection_sock.c:836
>  tcp_close+0x6f3/0x970 net/ipv4/tcp.c:2497
>  inet_release+0x86/0x100 net/ipv4/af_inet.c:427
>  __sock_release+0x85/0x160 net/socket.c:590
>  sock_close+0x24/0x30 net/socket.c:1268
>  __fput+0x1e1/0x520 fs/file_table.c:280
>  ____fput+0x1f/0x30 fs/file_table.c:313
>  task_work_run+0xf6/0x130 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_usermode_loop+0x2b4/0x2c0 arch/x86/entry/common.c:163
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 12060 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> ==================================================================

OK, so this is due to timer_pending() lockless access to ->entry.pprev
to determine whether or not the timer is on the list.  New one on me!

Given that use case, I don't have an objection to your patch to list.h.

Except...

Would it make sense to add a READ_ONCE() to hlist_unhashed()
and to then make timer_pending() invoke hlist_unhashed()?  That
would better confine the needed uses of READ_ONCE().

							Thanx, Paul
