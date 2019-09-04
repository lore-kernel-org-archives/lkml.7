Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E517EC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E2B20820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfIDLhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfIDLhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:37:42 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4BD222CF7;
        Wed,  4 Sep 2019 11:37:40 +0000 (UTC)
Date:   Wed, 4 Sep 2019 07:37:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viktor Rosendahl <viktor.rosendahl@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190904073734.0a70236c@oasis.local.home>
In-Reply-To: <20190904082046.GB2349@hirez.programming.kicks-ass.net>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
        <20190903132602.3440-2-viktor.rosendahl@gmail.com>
        <20190904082046.GB2349@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 10:20:46 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Sep 03, 2019 at 03:25:59PM +0200, Viktor Rosendahl wrote:
> 
> > It seems like it would be possible to simply replace the calls to
> > latency_fsnotify_enable/disable() with calls to
> > start/stop_critical_timings(). However, the main problem is that it
> > would not work for the wakup tracer. The wakeup tracer needs a
> > facility that postpones the notifications, not one that prevents the
> > measurements because all its measurements takes place in the middle
> > of __schedule(). On the other hand, in some places, like in idle and
> > the console we need start stop functions that prevents the
> > measurements from being make.  
> 
> Like Joel already mentioned; you can use irq_work here.

And I was thinking the exact same thing here too ;-)

-- Steve
