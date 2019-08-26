Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7369FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4209C2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfHZQTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:19:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:53657 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731762AbfHZQTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:19:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 09:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="355476615"
Received: from mgross-mobl.amr.corp.intel.com (HELO localhost) ([10.7.198.58])
  by orsmga005.jf.intel.com with ESMTP; 26 Aug 2019 09:19:31 -0700
Date:   Mon, 26 Aug 2019 09:19:31 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 01/16] stop_machine: Fix stop_cpus_in_progress
 ordering
Message-ID: <20190826161929.GB2680@u1904>
Reply-To: mgross@linux.intel.com
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:36:37PM +0000, Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Make sure the entire for loop has stop_cpus_in_progress set.
It is not clear how this commit comment matches the change.  Please explain
how adding 2 barrier's makes sure stop_cpus_in_progress is set for the entier
for loop.

--mark

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/stop_machine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index 067cb83f37ea..583119e0c51c 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -375,6 +375,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
>  	 */
>  	preempt_disable();
>  	stop_cpus_in_progress = true;
> +	barrier();
>  	for_each_cpu(cpu, cpumask) {
>  		work = &per_cpu(cpu_stopper.stop_work, cpu);
>  		work->fn = fn;
> @@ -383,6 +384,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
>  		if (cpu_stop_queue_work(cpu, work))
>  			queued = true;
>  	}
> +	barrier();
>  	stop_cpus_in_progress = false;
>  	preempt_enable();
>  
> -- 
> 2.17.1
> 
