Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A0ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD33206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfJGOJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbfJGOJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB8F82112;
        Mon,  7 Oct 2019 14:09:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3EEEE1001B11;
        Mon,  7 Oct 2019 14:09:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  7 Oct 2019 16:09:50 +0200 (CEST)
Date:   Mon, 7 Oct 2019 16:09:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        peterz@infradead.org, paulmck@kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Remove GP_REPLAY state from rcu_sync
Message-ID: <20191007140942.GA12213@redhat.com>
References: <20191004145741.118292-1-joel@joelfernandes.org>
 <20191004154102.GA20945@redhat.com>
 <20191004163732.GA253167@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004163732.GA253167@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 07 Oct 2019 14:09:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04, Joel Fernandes wrote:
>
> On Fri, Oct 04, 2019 at 05:41:03PM +0200, Oleg Nesterov wrote:
> > On 10/04, Joel Fernandes (Google) wrote:
> > >
> > > Taking a step back, why did we intend to have
> > > to wait for a new GP if another rcu_sync_exit() comes while one is still
> > > in progress?
> >
> > To ensure that if another CPU sees rcu_sync_is_idle() (GP_IDLE) after you
> > do rcu_sync_exit(), then it must also see all memory changes you did before
> > rcu_sync_exit().
>
> Would this not be better implemented using memory barriers, than starting new
> grace periods just for memory ordering? A memory barrier is lighter than
> having to go through a grace period. So something like: if the state is
> already GP_EXIT, then rcu_sync_exit() issues a memory barrier instead of
> replaying. But if state is GP_PASSED, then wait for a grace period.

But these 2 cases do not differ. If we can use mb() if GP_EXIT, then we can
do the same if state == GP_PASSED and just move the state to GP_IDLE, and
remove both GP_PASSED/GP_REPLAY states.

However, in this case the readers will need the barrier too, and rcu_sync_enter()
will _always_ need to block (wait for GP).

rcu_sync.c is "equivalent" to the following implementation:


            struct rcu_sync_struct {
                    atomic_t writers;
            };

            bool rcu_sync_is_idle(rss)
            {
                    return atomic_read(rss->writers) == 0;
            }

            void rcu_sync_enter(rss)
            {
                    atomic_inc(rss->writers);
                    synchronize_rcu();
            }

            void rcu_sync_exit(rss)
            {
                    synchronize_rcu();
                    atomic_dec(rss->writers);
            }

except

	- rcu_sync_exit() never blocks

	- synchronize_rcu/call_rci is called only if it is really needed.
	  In particular, if 2 writers come in a row the 2nd one will not
	  block in _enter().

Oleg.

