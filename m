Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB11ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E642054F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570635955;
	bh=6VNczijm7dR3WIsRcl2V0xeLyKxkwaweQslIMAwrUNg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Vee6J6mFROGZqlNrrVIrtB2/TKJQDlplhkVWzx5x9fLv546uDUSFJDz+n7u2XfcnY
	 N582KUBO1z61g/VkTuMhAp806yey8aMaUQYx0x69dC7V2+nXF/dpFaHUeXBJAOvlaF
	 Vt02mAJz+N7qBaf8aGhXp8vSfKuJC/iHoaRbT+eY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfJIPpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfJIPpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:45:54 -0400
Received: from paulmck-ThinkPad-P72 (mobile-166-177-250-63.mycingular.net [166.177.250.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7642053B;
        Wed,  9 Oct 2019 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570635953;
        bh=6VNczijm7dR3WIsRcl2V0xeLyKxkwaweQslIMAwrUNg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=v7CCczIwHTfOtyskNZ9whMMqCgEuT6J742xrfO3eWKtCAeGyj/PFDBQSHQArMVL7H
         gSHa1HZbPwxI9yp+yeHsi7W8Xem7m4u8shw59SwThvyQbxe3JGCYTZL+fNo6/E7KlU
         jgIXuqhP1hHxTObV1SjeKahIO69NH+UWtERbQ95g=
Date:   Wed, 9 Oct 2019 08:45:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Avoid to modify mask_ofl_ipi in
 sync_rcu_exp_select_node_cpus()
Message-ID: <20191009154548.GB2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191008050145.4041702-1-boqun.feng@gmail.com>
 <20191008163028.GA136151@google.com>
 <CANpmjNP0Vt4i7nWXPd2g4vaqkE3J2K1M_BiEMrtGqVcRE8khtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP0Vt4i7nWXPd2g4vaqkE3J2K1M_BiEMrtGqVcRE8khtw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 06:35:45PM +0200, Marco Elver wrote:
> On Tue, 8 Oct 2019 at 18:30, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Oct 08, 2019 at 01:01:40PM +0800, Boqun Feng wrote:
> > > "mask_ofl_ipi" is used for iterate CPUs which IPIs are needed to send
> > > to, however in the IPI sending loop, "mask_ofl_ipi" along with another
> > > variable "mask_ofl_test" might also get modified to record which CPU's
> > > quiesent state can be reported by sync_rcu_exp_select_node_cpus(). Two
> > > variables seems to be redundant for such a propose, so this patch clean
> > > things a little by solely using "mask_ofl_test" for recording and
> > > "mask_ofl_ipi" for iteration. This would improve the readibility of the
> > > IPI sending loop in sync_rcu_exp_select_node_cpus().
> > >
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> >
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > thanks,
> >
> >  - Joel
> 
> Acked-by: Marco Elver <elver@google.com>
> 
> If this is the official patch for the fix to the KCSAN reported
> data-race, it'd be great to include the tag:
> Reported-by: syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com
> so the bot knows this was fixed.

I applied your Acked-by to both patches, but please let me know if you
intended something else.  Either way, thank you both for finding this
and for your testing!

							Thanx, Paul

> Thanks!
> -- Marco
> 
> > >  kernel/rcu/tree_exp.h | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index 69c5aa64fcfd..212470018752 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -387,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > >               }
> > >               ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> > >               put_cpu();
> > > -             if (!ret) {
> > > -                     mask_ofl_ipi &= ~mask;
> > > +             /* The CPU responses the IPI, and will report QS itself */
> > > +             if (!ret)
> > >                       continue;
> > > -             }
> > > +
> > >               /* Failed, raced with CPU hotplug operation. */
> > >               raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >               if ((rnp->qsmaskinitnext & mask) &&
> > > @@ -401,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > >                       schedule_timeout_uninterruptible(1);
> > >                       goto retry_ipi;
> > >               }
> > > -             /* CPU really is offline, so we can ignore it. */
> > > -             if (!(rnp->expmask & mask))
> > > -                     mask_ofl_ipi &= ~mask;
> > > +             /* CPU really is offline, and we need its QS to pass GP. */
> > > +             if (rnp->expmask & mask)
> > > +                     mask_ofl_test |= mask;
> > >               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >       }
> > >       /* Report quiescent states for those that went offline. */
> > > -     mask_ofl_test |= mask_ofl_ipi;
> > >       if (mask_ofl_test)
> > >               rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
> > >  }
> > > --
> > > 2.23.0
> > >
