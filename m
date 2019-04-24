Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42843C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17048218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfDXLAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDXLAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:00:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2BB031688E3;
        Wed, 24 Apr 2019 11:00:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id CAA31600C1;
        Wed, 24 Apr 2019 11:00:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Apr 2019 13:00:33 +0200 (CEST)
Date:   Wed, 24 Apr 2019 13:00:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/percpu-rwsem: Add DEFINE_PERCPU_RWSEM(), use it
 to initialize cgroup_threadgroup_rwsem
Message-ID: <20190424110031.GA16167@redhat.com>
References: <20190423163241.GA15866@redhat.com>
 <20190424103155.GA9642@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424103155.GA9642@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 24 Apr 2019 11:00:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Ingo Molnar wrote:
>
> > -#define DEFINE_STATIC_PERCPU_RWSEM(name)				\
> > +#define __DEFINE_PERCPU_RWSEM(name, is_static)				\
> >  static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
> > -static struct percpu_rw_semaphore name = {				\
> > +is_static struct percpu_rw_semaphore name = {				\
> >  	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
> >  	.read_count = &__percpu_rwsem_rc_##name,			\
> >  	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
> >  	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
> >  }
> > +#define DEFINE_PERCPU_RWSEM(name)		\
> > +	__DEFINE_PERCPU_RWSEM(name, /* not static */)
> > +#define DEFINE_STATIC_PERCPU_RWSEM(name)	\
> > +	__DEFINE_PERCPU_RWSEM(name, static)
>
> Which tree is this against? It doesn't apply to tip:master nor latest

OOPS, sorry Ingo!

I forgot that the change above depends on another cleanup I sent to Paul,

	[PATCH] rcu/sync: kill rcu_sync_type/gp_type
	https://lore.kernel.org/lkml/20190423120724.GA6132@redhat.com/

which does

	-       .rss = __RCU_SYNC_INITIALIZER(name.rss, RCU_SCHED_SYNC),        \
	+       .rss = __RCU_SYNC_INITIALIZER(name.rss),                        \

so lets forget it for now, or may be Paul can take this patch too.

Sorry,

Oleg.

