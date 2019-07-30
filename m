Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21756C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4D5206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfG3NRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbfG3NRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:17:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB52F3086272;
        Tue, 30 Jul 2019 13:17:06 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAB7F600F8;
        Tue, 30 Jul 2019 13:16:55 +0000 (UTC)
Date:   Tue, 30 Jul 2019 09:16:54 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aaron Lu <aaron.lwe@gmail.com>, keescook@chromium.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        torvalds@linux-foundation.org,
        Tim Chen <tim.c.chen@linux.intel.com>, fweisbec@gmail.com,
        subhra.mazumdar@oracle.com,
        Julien Desfossez <jdesfossez@digitalocean.com>, pjt@google.com,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>, kerrnel@google.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC][PATCH 02/13] stop_machine: Fix stop_cpus_in_progress
 ordering
Message-ID: <20190730131653.GA14277@pauld.bos.csb>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.455421817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726161357.455421817@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 30 Jul 2019 13:17:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 04:54:11PM +0200 Peter Zijlstra wrote:
> Make sure the entire for loop has stop_cpus_in_progress set.
> 
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Aaron Lu <aaron.lwe@gmail.com>
> Cc: keescook@chromium.org
> Cc: mingo@kernel.org
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: torvalds@linux-foundation.org
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: fweisbec@gmail.com
> Cc: subhra.mazumdar@oracle.com
> Cc: tglx@linutronix.de
> Cc: Julien Desfossez <jdesfossez@digitalocean.com>
> Cc: pjt@google.com
> Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
> Cc: Aubrey Li <aubrey.intel@gmail.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: kerrnel@google.com
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com
> ---
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
> 

This looks good.

Reviewed-by: Phil Auld <pauld@redhat.com>


-- 
