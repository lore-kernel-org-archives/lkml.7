Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41191C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084BA20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfCZPaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfCZPaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:30:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7934220811;
        Tue, 26 Mar 2019 15:30:00 +0000 (UTC)
Date:   Tue, 26 Mar 2019 11:29:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH v2 3/3] rcu: validate arguments for rcu tracepoints
Message-ID: <20190326112958.2668a4a1@gandalf.local.home>
In-Reply-To: <20190326151815.GI4102@linux.ibm.com>
References: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
        <1553602391-11926-4-git-send-email-laoar.shao@gmail.com>
        <20190326151815.GI4102@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 08:18:15 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> On Tue, Mar 26, 2019 at 08:13:11PM +0800, Yafang Shao wrote:
> > When CONFIG_RCU_TRACE is not set, all these tracepoints are defined as
> > do-nothing macro.
> > We'd better make those inline functions that take proper arguments.
> > 
> > As RCU_TRACE() is defined as do-nothing marco as well when
> > CONFIG_RCU_TRACE is not set, so we can clean it up.  
> 
> How about this for the commit log?
> 
> 	Unless the CONFIG_RCU_TRACE kconfig option is set, almost all
> 	of RCU's tracepoints are defined as empty macros.  It would
> 	be better if these tracepoints could instead be empty inline
> 	functions with proper arguments and type checking.  It would
> 	also be good to get rid of the RCU_TRACE() macro, which
> 	compiles its argument in CONFIG_RCU_TRACE=y kernels and
> 	omits them otherwise.
> 
> 	This commit therefore creates a TRACE_EVENT_RCU macro that
> 	is defined as TRACE_EVENT in CONFIG_RCU_TRACE=y kernels and
> 	as the new TRACE_EVENT_NOP otherwise, which allows the
> 	empty macros and the RCU_TRACE() macro to be eliminated.
> 
> With that:
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

Yafang,

If you are OK with the above changes, I'll take this patch with the
updated change log.

-- Steve
