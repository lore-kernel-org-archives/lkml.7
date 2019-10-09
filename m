Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47381C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E6D2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av/zTGly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfJICU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:20:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:47085 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJICUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:20:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so1149155qtq.13;
        Tue, 08 Oct 2019 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rkCUTbc9dLnUiP2HpaJfOwDfYhW+bYmDcz+kx3qWJr0=;
        b=av/zTGly0LOWOW7gPSoZ3FTKD5NqpfqIu526b4ngzBckbnHL5h8NJzFF/j5DR8nOau
         9Shj6ZXLXHf5ChLj7uQ1dl8ShI3m3dyYCuv9l54/Ur+qAwNqc2LL1QtdCLXlNe+sTgAr
         6A6yJaHYccdcoceYZ7L9LyWI+XCWOu2xhvTVNcfQMMLiQS0QyK82fy4Kf6XeByAps1Y4
         20sYi9iencwLVZjDM0LOHmkSckAXAzzpfxdtJr1D+b/cPuPz0g6yIX6i+fAhakLH+eYV
         5zsRDkK3B5DyIF1Ejm17/ZcfhX2xi7aDiqU4DcpEnMLztVvUZpOPY8HgSyizplr58jEV
         m03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rkCUTbc9dLnUiP2HpaJfOwDfYhW+bYmDcz+kx3qWJr0=;
        b=uf5xhWDbk9gyukGPEFDJ2sxVbMVaJhySKFuQ4TRSj8AC8Df4fNoWCh0zwgo7qhL9OS
         D/yvWz/0A8dC6iwe7t4HUooYcc+PchqGiGygN0DzWitCqHgaphNQIG8mw8Wu2RFiYOOf
         hJrw3neDlFUXLQUN7hugu+dd5Om64qYsmRM1kmbbhsp3OmN/ursqH0sWrIWWcdurJ9cR
         dTFiGTIHgS3PWCGy2ZtbUI5lCs94KvQs+APxWFZm6RNMuU4LI3diNHqKyHG2pMAVAkmu
         1yS6uJMDfbNCy7tacA2AWKutBdhkRQStrkxW1ljrVlrY2EHDehCvaINxTTNJm/zyzB6O
         6OAg==
X-Gm-Message-State: APjAAAWCePMBMrVNqXBGv27BN7hTGfiRXjZnOdrROGI0BOnXtjgCZLAW
        FGNQsEVeKRNBz7Z96ooVeeM=
X-Google-Smtp-Source: APXvYqz+cucmSFVlA6bF8rqI2V90lCgKHBCuBK1KHBbhlPA8LeFoBkiD0yHYsdyEPW68KWwaHz6ijw==
X-Received: by 2002:ac8:334e:: with SMTP id u14mr1265251qta.120.1570587624355;
        Tue, 08 Oct 2019 19:20:24 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d55sm569130qta.41.2019.10.08.19.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 19:20:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9BB5521AF2;
        Tue,  8 Oct 2019 22:20:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 08 Oct 2019 22:20:22 -0400
X-ME-Sender: <xms:5UOdXYQW23I0tS327ar5CThMCv00koPKsgqYtczR9Hm40ItvNKn2aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphepudeijedrvddvtddrvdehhedrtdenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:5UOdXaAjWJiRbx_UVNK6HGbt6P6_AiNXhn9nmjI5x8wBmNv0D8446Q>
    <xmx:5UOdXQ3Ys2atz4-66LtR8IDSeTPL7jE4qOp1o0NpOC2wr4OVqJ1JXg>
    <xmx:5UOdXQW1qc-yT44_ZKJcRyVz-qgfVfz2IupsFW-_a5RGI1jRLPp0IA>
    <xmx:5kOdXfYOkvVVo59FfhKzwhjL3SsfgE56pJI3dzi018FYttwVT5OwVw>
Received: from localhost (unknown [167.220.255.0])
        by mail.messagingengine.com (Postfix) with ESMTPA id C440980060;
        Tue,  8 Oct 2019 22:20:20 -0400 (EDT)
Date:   Wed, 9 Oct 2019 10:20:17 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Avoid to modify mask_ofl_ipi in
 sync_rcu_exp_select_node_cpus()
Message-ID: <20191009022017.GA664@boqun-laptop.fareast.corp.microsoft.com>
References: <20191008050145.4041702-1-boqun.feng@gmail.com>
 <20191008163028.GA136151@google.com>
 <CANpmjNP0Vt4i7nWXPd2g4vaqkE3J2K1M_BiEMrtGqVcRE8khtw@mail.gmail.com>
 <20191008170121.GA143258@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008170121.GA143258@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 01:01:21PM -0400, Joel Fernandes wrote:
> On Tue, Oct 08, 2019 at 06:35:45PM +0200, Marco Elver wrote:
> > On Tue, 8 Oct 2019 at 18:30, Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Tue, Oct 08, 2019 at 01:01:40PM +0800, Boqun Feng wrote:
> > > > "mask_ofl_ipi" is used for iterate CPUs which IPIs are needed to send
> > > > to, however in the IPI sending loop, "mask_ofl_ipi" along with another
> > > > variable "mask_ofl_test" might also get modified to record which CPU's
> > > > quiesent state can be reported by sync_rcu_exp_select_node_cpus(). Two
> > > > variables seems to be redundant for such a propose, so this patch clean
> > > > things a little by solely using "mask_ofl_test" for recording and
> > > > "mask_ofl_ipi" for iteration. This would improve the readibility of the
> > > > IPI sending loop in sync_rcu_exp_select_node_cpus().
> > > >
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > >
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > thanks,
> > >
> > >  - Joel
> > 
> > Acked-by: Marco Elver <elver@google.com>
> > 

Thank you both!

> > If this is the official patch for the fix to the KCSAN reported
> > data-race, it'd be great to include the tag:
> > Reported-by: syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com
> > so the bot knows this was fixed.
> 
> It is just an optimization that got triggerred due to debugging of the
> reported issue but does (should) not fix the issue.
> 

Right.

> Boqun, are you going to be posting another patch which just uses mask_ofl_ipi
> in the for_each(..) loop? (without using _snap) as Paul suggested?
> 

IIUC, Paul already has this fix along with other ->expmask queued in his
dev branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=4e4fefe0630dcf7415d62e6d9171c8f209444376

, and with the proper "Reported-by" tag to give syzbot credit.

Regards,
Boqun

> Paul mentioned other places where rnp->expmask is locklessly accessed so I
> think that may be fixed separately (such as the stall-warning code). Paul,
> were you planning on fixing all such accesses together (other than this code)
> or should I look into it more? I guess for the stall case, KCSAN would have
> to trigger stalls to see those issues.
> 
> thanks,
> 
>  - Joel
> 
> > 
> > Thanks!
> > -- Marco
> > 
> > > >  kernel/rcu/tree_exp.h | 13 ++++++-------
> > > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index 69c5aa64fcfd..212470018752 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -387,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > >               }
> > > >               ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> > > >               put_cpu();
> > > > -             if (!ret) {
> > > > -                     mask_ofl_ipi &= ~mask;
> > > > +             /* The CPU responses the IPI, and will report QS itself */
> > > > +             if (!ret)
> > > >                       continue;
> > > > -             }
> > > > +
> > > >               /* Failed, raced with CPU hotplug operation. */
> > > >               raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > >               if ((rnp->qsmaskinitnext & mask) &&
> > > > @@ -401,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > >                       schedule_timeout_uninterruptible(1);
> > > >                       goto retry_ipi;
> > > >               }
> > > > -             /* CPU really is offline, so we can ignore it. */
> > > > -             if (!(rnp->expmask & mask))
> > > > -                     mask_ofl_ipi &= ~mask;
> > > > +             /* CPU really is offline, and we need its QS to pass GP. */
> > > > +             if (rnp->expmask & mask)
> > > > +                     mask_ofl_test |= mask;
> > > >               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > >       }
> > > >       /* Report quiescent states for those that went offline. */
> > > > -     mask_ofl_test |= mask_ofl_ipi;
> > > >       if (mask_ofl_test)
> > > >               rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
> > > >  }
> > > > --
> > > > 2.23.0
> > > >
