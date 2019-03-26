Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BEBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263DA2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfCZCRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730691AbfCZCRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:17:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4811220823;
        Tue, 26 Mar 2019 02:17:49 +0000 (UTC)
Date:   Mon, 25 Mar 2019 22:17:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        shaoyafang@didiglobal.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tracing: introduce TRACE_EVENT_NONE and use it
Message-ID: <20190325221745.1009cbdf@oasis.local.home>
In-Reply-To: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
References: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 09:40:04 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> In this patchset, I introduce a new macro TRACE_EVENT_NONE(), which will
> define a tracepoint as a do-nothing inline function.
> 	#define TRACE_EVENT_NONE(name, proto)			\
> 		static inline void trace_##name(proto)		\
> 		{ }						\
> 		static inline bool trace_##name##_enabled(void)	\
> 		{						\
> 			return false;				\
> 		}
> 

BTW, I prefer a name of TRACE_EVENT_DISABLED()

Which shows that it is disabled, or TRACE_EVENT_UNDEF(), or
TRACE_EVENT_NOP(). Something that states it is turned off. When I first
saw NONE() I thought it was another attempt to introduce zero parameter
trace events.


> Let's take some example for why this macro is needed.
> 
> - sched
> The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
> be not exposed to user if CONFIG_SCHEDSTATS is not set.
> We can place #ifdef in the kernel/sched/fair.c to fix it, but we
> don't want to sprinkle #ifdef.

But you still sprinkle #ifdef in the header, but the part I don't like
is the need to duplicate the prototypes and the like.


> So with TRACE_EVENT_NONE(), we can fix it in
> include/trace/events/sched.h.
> 
> - rcu
> When CONFIG_RCU_TRACE is not set, some rcu tracepoints are define as
> do-nothing macro without validating arguments, that is not proper.
> We should validate the arguments.
> 
> Yafang Shao (3):
>   tracing: introduce TRACE_EVENT_NONE()
>   sched/fair: do not expose some tracepoints to user if
>     CONFIG_SCHEDSTATS is not set
>   rcu: validate arguments for rcu tracepoints
> 

See my reply in the next patch.

-- Steve
