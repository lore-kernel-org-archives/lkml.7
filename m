Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C721C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 21:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B273207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 21:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKYVgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfKYVgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 16:36:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0534D20706;
        Mon, 25 Nov 2019 21:36:51 +0000 (UTC)
Date:   Mon, 25 Nov 2019 16:36:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191125163650.6a624fee@gandalf.local.home>
In-Reply-To: <20191009104611.15363-1-qais.yousef@arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the very late response...

On Wed,  9 Oct 2019 11:46:11 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> ATM the uclamp value are only used for frequency selection; but on
> heterogeneous systems this is not enough and we need to ensure that the
> capacity of the CPU is >= uclamp_min. Which is what implemented here.

Is it possible that the capacity can be fixed, where the process can
just have a cpu mask of CPUs that has the capacity for it?

Not that this will affect this patch now, but just something for the
future.

> 
> 	capacity_orig_of(cpu) >= rt_task.uclamp_min
> 
> Note that by default uclamp.min is 1024, which means that RT tasks will
> always be biased towards the big CPUs, which make for a better more
> predictable behavior for the default case.
> 
> Must stress that the bias acts as a hint rather than a definite
> placement strategy. For example, if all big cores are busy executing
> other RT tasks we can't guarantee that a new RT task will be placed
> there.
> 
> On non-heterogeneous systems the original behavior of RT should be
> retained. Similarly if uclamp is not selected in the config.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
