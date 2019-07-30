Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6879DC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1E92089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfG3NWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfG3NWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:22:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CBE20644;
        Tue, 30 Jul 2019 13:22:45 +0000 (UTC)
Date:   Tue, 30 Jul 2019 09:22:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aaron Lu <aaron.lwe@gmail.com>, keescook@chromium.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Phil Auld <pauld@redhat.com>, torvalds@linux-foundation.org,
        Tim Chen <tim.c.chen@linux.intel.com>, fweisbec@gmail.com,
        subhra.mazumdar@oracle.com,
        Julien Desfossez <jdesfossez@digitalocean.com>, pjt@google.com,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>, kerrnel@google.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC][PATCH 02/13] stop_machine: Fix stop_cpus_in_progress
 ordering
Message-ID: <20190730092240.42383953@gandalf.local.home>
In-Reply-To: <20190726161357.455421817@infradead.org>
References: <20190726145409.947503076@infradead.org>
        <20190726161357.455421817@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 16:54:11 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Make sure the entire for loop has stop_cpus_in_progress set.


>  kernel/stop_machine.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -383,6 +383,7 @@ static bool queue_stop_cpus_work(const s
>  	 */
>  	preempt_disable();
>  	stop_cpus_in_progress = true;
> +	barrier();

Like smp_mb() shouldn't barrier() have a comment to what is being
ordered and why?

-- Steve

>  	for_each_cpu(cpu, cpumask) {
>  		work = &per_cpu(cpu_stopper.stop_work, cpu);
>  		work->fn = fn;
> @@ -391,6 +392,7 @@ static bool queue_stop_cpus_work(const s
>  		if (cpu_stop_queue_work(cpu, work))
>  			queued = true;
>  	}
> +	barrier();
>  	stop_cpus_in_progress = false;
>  	preempt_enable();
>  
> 

