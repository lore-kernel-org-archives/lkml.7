Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BBAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74076214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfLLOhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:37:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbfLLOhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:37:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9096A206A5;
        Thu, 12 Dec 2019 14:37:23 +0000 (UTC)
Date:   Thu, 12 Dec 2019 09:37:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/debug: fix trival print task format
Message-ID: <20191212093721.1d9a2f7f@gandalf.local.home>
In-Reply-To: <20191212122244.132751-1-xiexiuqi@huawei.com>
References: <20191212122244.132751-1-xiexiuqi@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 20:22:44 +0800
Xie XiuQi <xiexiuqi@huawei.com> wrote:

> Ensure levave a whitespace between state and task name.

"levave"?

> 
> w/o patch:
> runnable tasks:
>  S           task   PID         tree-key  switches  prio     wait
> -----------------------------------------------------------------
>  I    kworker/0:2   656     87693.884557      8255   120
>  Sirq/10-ACPI:Ged   829         0.000000         3    49
>  Sirq/11-ACPI:Ged   830         0.000000         3    49
>  Sirq/50-arm-smmu   945         0.000000         3    49
> 
> with patch:
> runnable tasks:
>  S            task   PID         tree-key  switches  prio     wait
> ------------------------------------------------------------------
>  I     kworker/0:2   656     87693.884557      8255   120
>  S irq/10-ACPI:Ged   829         0.000000         3    49
>  S irq/11-ACPI:Ged   830         0.000000         3    49
>  S irq/50-arm-smmu   945         0.000000         3    49
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> ---
>  kernel/sched/debug.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index f7e4579e746c..a1b5a4c1213e 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -434,9 +434,9 @@ static void
>  print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
>  {
>  	if (rq->curr == p)
> -		SEQ_printf(m, ">R");
> +		SEQ_printf(m, ">R ");
>  	else
> -		SEQ_printf(m, " %c", task_state_to_char(p));
> +		SEQ_printf(m, " %c ", task_state_to_char(p));
>  
>  	SEQ_printf(m, "%15s %5d %9Ld.%06ld %9Ld %5d ",

Wouldn't it be simpler to just add one space to the above?

	SEQ_printf(m, " %15s %5d %9Ld.%06ld %9Ld %5d ",

?

-- Steve

>  		p->comm, task_pid_nr(p),
> @@ -465,10 +465,10 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
>  
>  	SEQ_printf(m, "\n");
>  	SEQ_printf(m, "runnable tasks:\n");
> -	SEQ_printf(m, " S           task   PID         tree-key  switches  prio"
> +	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
>  		   "     wait-time             sum-exec        sum-sleep\n");
>  	SEQ_printf(m, "-------------------------------------------------------"
> -		   "----------------------------------------------------\n");
> +		   "------------------------------------------------------\n");
>  
>  	rcu_read_lock();
>  	for_each_process_thread(g, p) {

