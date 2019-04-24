Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384BAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F7C2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556103783;
	bh=vzji0tYdmFzgN7DZo3AjdEnnBPguooQnJZ0UUKEX+WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IXS/pR3zSf/ug3Q4eXgNCIRdi4uqTa8znwC/olSY8loO/Qciov/xQzoATm2qT/sCJ
	 Km+m7+vbro/yWciPsjnxenCAzerfpw23a+hsZuNDlbCFjTirphstGV0CtHy6/6xmTH
	 iNQ5EHVvUorvg0/tKv/VjDhRcnnnv2N+9U5px8kY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfDXLDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:03:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35801 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDXLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:03:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so4443691wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=klI+XsSAX/064sfGOIxlVG4huWRZilsGAlAnnCgzUSU=;
        b=sw8DhlekCxXBoI3OF2wg4kVDk7pAevEgJmVqLgOvR0f+AYY+yLqcCYVxBHTH1eKbRp
         Z5chnfXVIyAOlL5Teux61UHFWsq3T6KFWLPOOKOXPezfaNRblBt/owJwPIdkuEksgt9Q
         VvF+nonU3anVFU+GSaAw7Cn4iClfenFCNSGCH7g11+7foTyNnIoo3OF/H+8xcfl/CjgF
         lkAaRKySLG6FyfjDFL9U/c4URxF6OIR+yuJ06M1gzbH+DsSWrmyff8IfNdjeYgaDuO61
         EZSMTGGNbo45RiNLSQshxQc4W0v86rmGN8MFSP9JoqLB9CF+XeIv4b01FRCZqyrBZ39e
         EGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=klI+XsSAX/064sfGOIxlVG4huWRZilsGAlAnnCgzUSU=;
        b=WS3s+zqA+Jk4ID6PFVaqkPWhYNwW0wtvx6l1fhdUM7uRzjn+2i5S4Cwd6ItziH/s+A
         8uS3oZc3oT3bhu7kqfk4hiyBEpF4jvn2TKEcJu2l7ZgyLaNNMSO0QrxavqNDiFxjt+HH
         6pbq5+8Wp7DZ8mHqetWnLlKQ3wtbEMYerFK7Zhjg/Ir9TeQ64X9ngnJSKpgjB2JcfTaH
         GUBByl4ft8loshhW+UNC99Bblx7PVpFuim/OosLgDJeBEwOiyGM7VZ11CodLybQ/7UcT
         g0rqWksf2zlXq5MAu5H0lmEPLp8gk+oYailex7es44hGBeTQKQrQlWMYiXeCZ3n0j9Q3
         7D3g==
X-Gm-Message-State: APjAAAUZDXu4m96i7+d1aXE5kcAEcaOqyac/YkUlvyqEoaDqUh0SQQ8y
        9yIo3yx7xZll2MPIRKS/FYE=
X-Google-Smtp-Source: APXvYqy2aj/Br0xs9xZFCLM8R6vnvY5Y+u1o01Myao1hu61JfDstslVUoLHCkF4n52SzAkak40luuw==
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr6513402wml.74.1556103779359;
        Wed, 24 Apr 2019 04:02:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e16sm23645453wrs.0.2019.04.24.04.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 04:02:58 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:02:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/percpu-rwsem: Add DEFINE_PERCPU_RWSEM(), use it
 to initialize cgroup_threadgroup_rwsem
Message-ID: <20190424110256.GA86120@gmail.com>
References: <20190423163241.GA15866@redhat.com>
 <20190424103155.GA9642@gmail.com>
 <20190424110031.GA16167@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424110031.GA16167@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> On 04/24, Ingo Molnar wrote:
> >
> > > -#define DEFINE_STATIC_PERCPU_RWSEM(name)				\
> > > +#define __DEFINE_PERCPU_RWSEM(name, is_static)				\
> > >  static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
> > > -static struct percpu_rw_semaphore name = {				\
> > > +is_static struct percpu_rw_semaphore name = {				\
> > >  	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
> > >  	.read_count = &__percpu_rwsem_rc_##name,			\
> > >  	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
> > >  	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
> > >  }
> > > +#define DEFINE_PERCPU_RWSEM(name)		\
> > > +	__DEFINE_PERCPU_RWSEM(name, /* not static */)
> > > +#define DEFINE_STATIC_PERCPU_RWSEM(name)	\
> > > +	__DEFINE_PERCPU_RWSEM(name, static)
> >
> > Which tree is this against? It doesn't apply to tip:master nor latest
> 
> OOPS, sorry Ingo!
> 
> I forgot that the change above depends on another cleanup I sent to Paul,
> 
> 	[PATCH] rcu/sync: kill rcu_sync_type/gp_type
> 	https://lore.kernel.org/lkml/20190423120724.GA6132@redhat.com/
> 
> which does
> 
> 	-       .rss = __RCU_SYNC_INITIALIZER(name.rss, RCU_SCHED_SYNC),        \
> 	+       .rss = __RCU_SYNC_INITIALIZER(name.rss),                        \
> 
> so lets forget it for now, or may be Paul can take this patch too.

No problem, and both rwsem patches you sent seem fine to me:

Reviewed-by: Ingo Molnar <mingo@kernel.org>
 
Thanks,

	Ingo
