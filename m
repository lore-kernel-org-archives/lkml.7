Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C3FC04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C120675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfD3L14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:27:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfD3L1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 892A83002619;
        Tue, 30 Apr 2019 11:27:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 577D775274;
        Tue, 30 Apr 2019 11:27:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Apr 2019 13:27:52 +0200 (CEST)
Date:   Tue, 30 Apr 2019 13:27:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rcu/sync: simplify the state machine
Message-ID: <20190430112749.GA23020@redhat.com>
References: <20190425164054.GA21309@redhat.com>
 <20190425165055.GC21412@redhat.com>
 <20190427210230.GE3923@linux.ibm.com>
 <20190428222652.GA30908@linux.ibm.com>
 <20190429160603.GC17715@redhat.com>
 <20190429204041.GU3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429204041.GU3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Apr 2019 11:27:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29, Paul E. McKenney wrote:
>
> On Mon, Apr 29, 2019 at 06:06:04PM +0200, Oleg Nesterov wrote:
> >
> > Well, at least WRITE_ONCE()'s look certainly unneeded to me, gp_state
> > is protected by rss_lock.
> >
> > WARN_ON_ONCE(gp_state) can read gp_state lockless, but even in this case
> > I do not understand what READ_ONCE() tries to prevent...
> >
> > Nevermind, this won't hurt and as I already said I don't understand the
> > _ONCE() magic anyway ;)
>
> If I understand correctly, rcu_sync_is_idle() can be inline and returns
> ->gp_state.

Ah, sorry! I didn't mean rcu_sync_is_idle(). To be honeest, I didn't even
notice this change, but it looks obviously fine to me, with or without this
patch.

And yes,

> Without the READ_ONCE(), the compiler might fuse reads from
> consecutive calls to rcu_sync_is_idle() or (under register pressure)
> re-read from it, getting inconsistent results.  For example, this:
>
> 	tmp = rcu_sync_is_idle(rsp);
> 	do_something(tmp);
> 	do_something_else(tmp);
>
> Might become this:
>
> 	do_something(rcu_sync_is_idle(rsp));
> 	do_something_else(rcu_sync_is_idle(rsp));


this is very clear. Even for me ;)

Thanks,

Oleg.

