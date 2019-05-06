Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0E82053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfEFOqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbfEFOqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:46:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9798C2053B;
        Mon,  6 May 2019 14:46:19 +0000 (UTC)
Date:   Mon, 6 May 2019 10:46:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190506104618.2fa49e13@gandalf.local.home>
In-Reply-To: <20190506144200.z4s63nm7untol2tr@e107158-lin.cambridge.arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
        <20190505115732.9844-5-qais.yousef@arm.com>
        <20190506090859.GK2606@hirez.programming.kicks-ass.net>
        <20190506095239.08577b3e@gandalf.local.home>
        <20190506144200.z4s63nm7untol2tr@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 15:42:00 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> I can control that for the wrappers I'm introducing. But the actual tracepoint
> get the 'trace_' part prepended automatically by the macros.
> 
> ie DECLARE_TRACE(pelt_rq, ...) will automatically generate a function called
> trace_pelt_se(...)
> 
> Or am I missing something?

No trace comes from the trace points.

So basically, we are going back to having tracepoints without
associated trace events. Which basically is just saying "we want trace
events here, but don't want an API". Of course, we can create a module
that can attach to them and create the trace events as well.

I'm not a big fan of this, but I'll let Peter decide.

-- Steve
