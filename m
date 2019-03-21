Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6F9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FFB218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sh7bfqSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfCUR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:59:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rjIIWiz5Bo0fTLzrBx6G7rvlX1W0eGKhdzQc9t/F+ig=; b=sh7bfqSHO9C4sGVQwjURM3Dui
        gv/MpejRbMNM9QQ7vXi/nVmazvsmQ6IfT2CK8t3WQW1LJjdrBVpbVybw1lZadQ6tCZCRtztTBwFA5
        WDuLHn0n9d0FBcv5jC09XrserOQ9PO8LWlyjdZXIScoiAGhfwmmZzS2+/Qr89FiT61k72vpn4n1zh
        QNQp5wMGGajVGriTur6XEpT4PBGKgNjBGnkK/pnJbElg+FacMUOQT/fXnpdRemBMieKcL9r9L1GR3
        BYnPfU4uJyasDehFEv5gY2iRYgftFq9q7n52H0AAFG897+X24sxSl8j/dpBquywoaI61bSfG5yWgr
        tULCb9pxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h71xq-0001Rk-Gf; Thu, 21 Mar 2019 17:58:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1DF2203CBE1E; Thu, 21 Mar 2019 18:58:47 +0100 (CET)
Date:   Thu, 21 Mar 2019 18:58:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/4] RCU fixes for rcu_assign_pointer() usage
Message-ID: <20190321175847.GP6058@hirez.programming.kicks-ass.net>
References: <20190321003426.160260-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321003426.160260-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:34:22PM -0400, Joel Fernandes (Google) wrote:
> This is just a resend with scheduler patches split from the driver fixes and
> Paul's Reviewed-by(s) added.
> 
> These patches fix various sparse errors ccaused as a result of the recent check
> to add rcu_check_sparse() to rcu_assign_pointer().  The errors are due to
> missing annotations. The annotations added in the series can also help avoid
> future incorrect usages and bugs so it is a good idea to do in any case.
> 
> RFC v1 -> Patch v2:
> Made changes based on Peter Zijlstra review.
> 
> Joel Fernandes (Google) (4):
> sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu
> sched_domain: Annotate RCU pointers properly
> rcuwait: Annotate task_struct with __rcu
> sched: Annotate perf_domain pointer with __rcu
> 
> include/linux/rcuwait.h        |  2 +-
> include/linux/sched/topology.h |  4 ++--
> kernel/sched/cpufreq.c         |  2 +-
> kernel/sched/sched.h           | 18 +++++++++---------
> kernel/sched/topology.c        | 10 +++++-----
> 5 files changed, 18 insertions(+), 18 deletions(-)

Thanks Joel
