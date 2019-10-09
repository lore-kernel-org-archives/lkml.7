Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9092ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B08720B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Rsd8aSnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfJIOZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:25:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35082 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbfJIOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:25:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so1146180plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZfOkB528FPvVmEaRKHaiWpNxM3xg1dR37magrnuxY2g=;
        b=Rsd8aSnRA1bBCEecP7/HgMrIQ6l/y/cRNKiSAk3lzeVj6Oj7cIC0ZoxVnClKqn2aZM
         utU35f2ZiUhYheloCIeFLlNrMCtOQJPoKH6IZV0P/4BpboOfPFC0qqSAdV8EF1PeJvvM
         r6o/arsiVlMJVYgtu9Yt/cC6jGyEZddTD6HJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfOkB528FPvVmEaRKHaiWpNxM3xg1dR37magrnuxY2g=;
        b=aUjQQZVP1gw21O1Uk8yr3xzTmIyX/8XbsPQb09fiK9uMfg7JdFNY2XTc0mopFz7k6T
         5VnlDW+aZW8/PX36v6m224Y0tf/Hs01tUGnsmZnsr5pAMdxzCIpeWeMzxDojCWHNpm4O
         xFuUirh4iF7Frb3I4LpG6oHtviQqp+MON1BzAtF2k90X0l3orcX1i78J3OEGOkq581rd
         kjg9rR27w7J20I+nHsfPRG0avBqdn3ExrAk8KkafO5ynWoX5gj5Big4kcr6dLuQJKm4x
         QVhXzrYfmv8b/LM5A6StNcD+O9zx2+yrQILeS6419dBGKne/Nsr96h3MgR9e1l+2OH43
         hVrA==
X-Gm-Message-State: APjAAAULxjKgyhAJxxz7Vga4oM6Ahp4LgQKn86NUs4yrZr6uBH7h5q6o
        RM+PtnUAwORScObYuVElKOo2vg==
X-Google-Smtp-Source: APXvYqwyKMc7Shz9xHarkvwuwc/8wg6cVkasAbMF7VeiZGSHYy+mYzqSy76oHBIQlpMUbYBM9cwGvA==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr3479799pls.210.1570631109717;
        Wed, 09 Oct 2019 07:25:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o11sm2300417pgp.13.2019.10.09.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:25:09 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:25:08 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Avoid to modify mask_ofl_ipi in
 sync_rcu_exp_select_node_cpus()
Message-ID: <20191009142508.GE143258@google.com>
References: <20191008050145.4041702-1-boqun.feng@gmail.com>
 <20191008163028.GA136151@google.com>
 <CANpmjNP0Vt4i7nWXPd2g4vaqkE3J2K1M_BiEMrtGqVcRE8khtw@mail.gmail.com>
 <20191008170121.GA143258@google.com>
 <20191009022017.GA664@boqun-laptop.fareast.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009022017.GA664@boqun-laptop.fareast.corp.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:20:17AM +0800, Boqun Feng wrote:
[snip] 
> > Boqun, are you going to be posting another patch which just uses mask_ofl_ipi
> > in the for_each(..) loop? (without using _snap) as Paul suggested?
> > 
> 
> IIUC, Paul already has this fix along with other ->expmask queued in his
> dev branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=4e4fefe0630dcf7415d62e6d9171c8f209444376
> 
> , and with the proper "Reported-by" tag to give syzbot credit.

Yes, I see it now. So Marco you should be good ;)

thanks!

 - Joel

> 
> Regards,
> Boqun
> 
> > Paul mentioned other places where rnp->expmask is locklessly accessed so I
> > think that may be fixed separately (such as the stall-warning code). Paul,
> > were you planning on fixing all such accesses together (other than this code)
> > or should I look into it more? I guess for the stall case, KCSAN would have
> > to trigger stalls to see those issues.
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > > 
> > > Thanks!
> > > -- Marco
> > > 
> > > > >  kernel/rcu/tree_exp.h | 13 ++++++-------
> > > > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > > index 69c5aa64fcfd..212470018752 100644
> > > > > --- a/kernel/rcu/tree_exp.h
> > > > > +++ b/kernel/rcu/tree_exp.h
> > > > > @@ -387,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > > >               }
> > > > >               ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> > > > >               put_cpu();
> > > > > -             if (!ret) {
> > > > > -                     mask_ofl_ipi &= ~mask;
> > > > > +             /* The CPU responses the IPI, and will report QS itself */
> > > > > +             if (!ret)
> > > > >                       continue;
> > > > > -             }
> > > > > +
> > > > >               /* Failed, raced with CPU hotplug operation. */
> > > > >               raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > >               if ((rnp->qsmaskinitnext & mask) &&
> > > > > @@ -401,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > > >                       schedule_timeout_uninterruptible(1);
> > > > >                       goto retry_ipi;
> > > > >               }
> > > > > -             /* CPU really is offline, so we can ignore it. */
> > > > > -             if (!(rnp->expmask & mask))
> > > > > -                     mask_ofl_ipi &= ~mask;
> > > > > +             /* CPU really is offline, and we need its QS to pass GP. */
> > > > > +             if (rnp->expmask & mask)
> > > > > +                     mask_ofl_test |= mask;
> > > > >               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > > >       }
> > > > >       /* Report quiescent states for those that went offline. */
> > > > > -     mask_ofl_test |= mask_ofl_ipi;
> > > > >       if (mask_ofl_test)
> > > > >               rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
> > > > >  }
> > > > > --
> > > > > 2.23.0
> > > > >
