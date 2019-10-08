Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B2C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636B5206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xNuhAuTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfJHRBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:01:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35612 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJHRBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:01:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id c3so7239025plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZp8JchvcdlzTvPRe10OMjXECzkCkCJFVu0ZHeOLniw=;
        b=xNuhAuTlqdl5j1fwt9UJkPakMi2ENRRhCumwZwhgTgkNiH5ylj6vQ7y8xEVqRkR2mU
         GjT+EpDYJIldteTU1vgUrLGBhWpq+n8uMLdGsIIAfafTbIFWFp2n/NvfOrLtJOXtCapB
         UbCGJINHJ3dCbPZ9XSEsuTzdasxQvh+PaAX74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZp8JchvcdlzTvPRe10OMjXECzkCkCJFVu0ZHeOLniw=;
        b=ajVJNLB3weRDvnarHEwkcdNLs6q52XKKMXxkKpCp8+Nj4d5j6wKgFKeDTjjAQSQy/P
         DY9o0KqemO6VkafuWhGd8zU4Pcn40OE8REpqYOehb+P0LdiXIxbNFQZqyS+Mwoo3M94L
         ow4xQjO5EMHBVtnTSM3taABqUQMXA7gSe4VDKUUzuhDzWCyNH5BnUuq5lqcvED2LgZv8
         uNuE/V1mlwnqKoSxeFe7ataUiBm8UG3PKzHt8t7h1K3PJXxqzDEF+bETI5i9uSxX439g
         yCXdMJrexm6Ol/CvQ2uww9TxzJLMjFOwIMg+sHtoxwJYRp1oaM/VfveuDy9oKMyjMYfm
         Je8A==
X-Gm-Message-State: APjAAAVqZcS5h/J6Rlmizor4woY6AhdA1ydSRN3sje3m1G7bPbSyDtx/
        oSvU2gmM524JP6mX39Su0Ey7dg==
X-Google-Smtp-Source: APXvYqzoa24eCDGzskBwnBJhJbLFJX9UR15QVg4KFbUcqw5jE0XCrtF+ME55lMZeJWp8xku3lijeSQ==
X-Received: by 2002:a17:902:a611:: with SMTP id u17mr4774307plq.4.1570554082947;
        Tue, 08 Oct 2019 10:01:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m123sm19044062pfb.133.2019.10.08.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 10:01:22 -0700 (PDT)
Date:   Tue, 8 Oct 2019 13:01:21 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Marco Elver <elver@google.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Avoid to modify mask_ofl_ipi in
 sync_rcu_exp_select_node_cpus()
Message-ID: <20191008170121.GA143258@google.com>
References: <20191008050145.4041702-1-boqun.feng@gmail.com>
 <20191008163028.GA136151@google.com>
 <CANpmjNP0Vt4i7nWXPd2g4vaqkE3J2K1M_BiEMrtGqVcRE8khtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP0Vt4i7nWXPd2g4vaqkE3J2K1M_BiEMrtGqVcRE8khtw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

It is just an optimization that got triggerred due to debugging of the
reported issue but does (should) not fix the issue.

Boqun, are you going to be posting another patch which just uses mask_ofl_ipi
in the for_each(..) loop? (without using _snap) as Paul suggested?

Paul mentioned other places where rnp->expmask is locklessly accessed so I
think that may be fixed separately (such as the stall-warning code). Paul,
were you planning on fixing all such accesses together (other than this code)
or should I look into it more? I guess for the stall case, KCSAN would have
to trigger stalls to see those issues.

thanks,

 - Joel

> 
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
