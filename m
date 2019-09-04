Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D5BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D712339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfIDKQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:16:24 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF72E21881;
        Wed,  4 Sep 2019 10:16:20 +0000 (UTC)
Date:   Wed, 4 Sep 2019 06:16:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alessio Balsini <balsini@android.com>, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, kernel-team@android.com
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190904061616.25ce79e1@oasis.local.home>
In-Reply-To: <20190902091623.GQ2349@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
        <20190726161357.397880775@infradead.org>
        <20190802172104.GA134279@google.com>
        <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
        <20190822122949.GA245353@google.com>
        <20190822165125.GW2369@hirez.programming.kicks-ass.net>
        <20190831144117.GA133727@google.com>
        <20190902091623.GQ2349@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2019 11:16:23 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> in sched_dl_period_handler(). And do:
> 
> +	preempt_disable();
> 	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> 	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
> +	preempt_enable();

Hmm, I'm curious. Doesn't the preempt_disable/enable() also add
compiler barriers which would remove the need for the READ_ONCE()s here?

-- Steve
