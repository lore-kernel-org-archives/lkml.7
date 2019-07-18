Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E70EC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A56620873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfGRX1U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 19:27:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:24676 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfGRX1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:27:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 16:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,279,1559545200"; 
   d="scan'208";a="251970992"
Received: from schen9-mobl.jf.intel.com ([10.24.10.117])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2019 16:27:19 -0700
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad> <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <5f869512-3336-d9f0-6fff-e1150673a924@linux.intel.com>
Date:   Thu, 18 Jul 2019 16:27:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190718100714.GA469@aaronlu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/19 3:07 AM, Aaron Lu wrote:
> On Wed, Jun 19, 2019 at 02:33:02PM -0400, Julien Desfossez wrote:

> 
> With the below patch on top of v3 that makes use of util_avg to decide
> which task win, I can do all 8 steps and the final scores of the 2
> workloads are: 1796191 and 2199586. The score number are not close,
> suggesting some unfairness, but I can finish the test now...

Aaron,

Do you still see high variance in terms of workload throughput that
was a problem with the previous version?

>
>  
>  }
> +
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +	struct sched_entity *sea = &a->se;
> +	struct sched_entity *seb = &b->se;
> +	bool samecore = task_cpu(a) == task_cpu(b);


Probably "samecpu" instead of "samecore" will be more accurate.
I think task_cpu(a) and task_cpu(b)
can be different, but still belong to the same cpu core.

> +	struct task_struct *p;
> +	s64 delta;
> +
> +	if (samecore) {
> +		/* vruntime is per cfs_rq */
> +		while (!is_same_group(sea, seb)) {
> +			int sea_depth = sea->depth;
> +			int seb_depth = seb->depth;
> +
> +			if (sea_depth >= seb_depth)

Should this be strictly ">" instead of ">=" ?

> +				sea = parent_entity(sea);
> +			if (sea_depth <= seb_depth)

Should use "<" ?

> +				seb = parent_entity(seb);
> +		}
> +
> +		delta = (s64)(sea->vruntime - seb->vruntime);
> +	}
> +

Thanks.

Tim

