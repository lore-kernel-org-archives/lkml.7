Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A5C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DD220830
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfJDPlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:41:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbfJDPlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:41:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 267433086E24;
        Fri,  4 Oct 2019 15:41:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id DF5E95DAAE;
        Fri,  4 Oct 2019 15:41:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  4 Oct 2019 17:41:13 +0200 (CEST)
Date:   Fri, 4 Oct 2019 17:41:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        peterz@infradead.org, paulmck@kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Remove GP_REPLAY state from rcu_sync
Message-ID: <20191004154102.GA20945@redhat.com>
References: <20191004145741.118292-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145741.118292-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 04 Oct 2019 15:41:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04, Joel Fernandes (Google) wrote:
>
> But this is not always true if you consider the following events:

I'm afraid I missed your point, but...

> ---------------------->
> GP num         111111     22222222222222222222222222222222233333333
> GP state  i    e     p    x                 r              rx     i
> CPU0 :         rse	  rsx
> CPU1 :                         rse     rsx
> CPU2 :                                         rse     rsx
>
> Here, we had 3 grace periods that elapsed, 1 for the rcu_sync_enter(),
> and 2 for the rcu_sync_exit(s).

But this is fine?

We only need to ensure that we have a full GP pass between the "last"
rcu_sync_exit() and GP_XXX -> GP_IDLE transition.

> However, we had 3 rcu_sync_exit()s, not 2. In other words, the
> rcu_sync_exit() got batched.
>
> So my point here is, rcu_sync_exit() does not really always cause a new
> GP to happen

See above, it should not.

> Then what is the point of the GP_REPLAY state at all if it does not
> always wait for a new GP?

Again, I don't understand... GP_REPLAY ensures that we will have a full GP
before rcu_sync_func() sets GP_IDLE, note that it does another "recursive"
call_rcu() if it sees GP_REPLAY.

> Taking a step back, why did we intend to have
> to wait for a new GP if another rcu_sync_exit() comes while one is still
> in progress?

To ensure that if another CPU sees rcu_sync_is_idle() (GP_IDLE) after you
do rcu_sync_exit(), then it must also see all memory changes you did before
rcu_sync_exit().

Oleg.

