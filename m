Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB29C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF9A227BF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgABTpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgABTpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:45:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868E32253D;
        Thu,  2 Jan 2020 19:45:16 +0000 (UTC)
Date:   Thu, 2 Jan 2020 14:45:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <huawei.libin@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/debug: Reset watchdog on all CPUs while
 processing sysrq-t
Message-ID: <20200102144514.646df101@gandalf.local.home>
In-Reply-To: <20191226085224.48942-1-liwei391@huawei.com>
References: <20191226085224.48942-1-liwei391@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019 16:52:24 +0800
Wei Li <liwei391@huawei.com> wrote:

> Lengthy output of sysrq-t may take a lot of time on slow serial console
> with lots of processes and CPUs.
> 
> So we need to reset NMI-watchdog to avoid spurious lockup messages, and
> we also reset softlockup watchdogs on all other CPUs since another CPU
> might be blocked waiting for us to process an IPI or stop_machine.

Have you had this triggered?

> 
> Add to sysrq_sched_debug_show() as what we did in show_state_filter().
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  kernel/sched/debug.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index f7e4579e746c..879d3ccf3806 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -751,9 +751,16 @@ void sysrq_sched_debug_show(void)
>  	int cpu;
>  
>  	sched_debug_header(NULL);
> -	for_each_online_cpu(cpu)
> +	for_each_online_cpu(cpu) {
> +		/*
> +		 * Need to reset softlockup watchdogs on all CPUs, because
> +		 * another CPU might be blocked waiting for us to process
> +		 * an IPI or stop_machine.
> +		 */
> +		touch_nmi_watchdog();
> +		touch_all_softlockup_watchdogs();

This doesn't seem to hurt to add, thus.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  		print_cpu(NULL, cpu);
> -
> +	}
>  }
>  
>  /*

