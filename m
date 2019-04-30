Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9071C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FA021734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfD3Pq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:46:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:60243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfD3Pq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:46:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 08:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="147129241"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 30 Apr 2019 08:46:56 -0700
Received: from [10.254.90.156] (kliang2-mobl.ccr.corp.intel.com [10.254.90.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DD23A580372;
        Tue, 30 Apr 2019 08:46:55 -0700 (PDT)
Subject: Re: [PATCH 3/4] perf cgroup: Add cgroup ID as a key of RB tree
To:     Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, tj@kernel.org,
        ak@linux.intel.com
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
 <CAP-5=fUKeyj=yFCBdeKgtTP=e8DYL_5zLi=gF9OeiOFquuD7YQ@mail.gmail.com>
 <20190430090847.GM2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5bd40a66-bb20-44c7-9c0e-35bfa1d271f6@linux.intel.com>
Date:   Tue, 30 Apr 2019 11:46:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430090847.GM2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2019 5:08 AM, Peter Zijlstra wrote:
> On Mon, Apr 29, 2019 at 04:02:33PM -0700, Ian Rogers wrote:
>> This is very interesting. How does the code handle cgroup hierarchies?
>> For example, if we have:
>>
>> cgroup0 is the cgroup root
>> cgroup1 whose parent is cgroup0
>> cgroup2 whose parent is cgroup1
>>
>> we have task0 running in cgroup0, task1 in cgroup1, task2 in cgroup2
>> and then a perf command line like:
>> perf stat -e cycles,cycles,cycles -G cgroup0,cgroup1,cgroup2 --no-merge sleep 10
>>
>> we expected 3 cycles counts:
>>   - for cgroup0 including task2, task1 and task0
>>   - for cgroup1 including task2 and task1
>>   - for cgroup2 just including task2
>>
>> It looks as though:
>> +       if (next && (next->cpu == event->cpu) && (next->cgrp_id ==
>> event->cgrp_id))
>>
>> will mean that events will only consider cgroups that directly match
>> the cgroup of the event. Ie we'd get 3 cycles counts of:
>>   - for cgroup0 just task0
>>   - for cgroup1 just task1
>>   - for cgroup2 just task2
> Yeah, I think you're right; the proposed code doesn't capture the
> hierarchy thing at all.


The hierarchies is handled in the next patch as below.

But I once thought we only need to handle directly match. So it will be 
return immediately once a match found.
I believe we can fix it by simply remove the "return 0".

> +static int cgroup_visit_groups_merge(struct perf_event_groups *groups, int cpu,
> +				     int (*func)(struct perf_event *, void *, int (*)(struct perf_event *)),
> +				     void *data)
> +{
> +	struct sched_in_data *sid = data;
> +	struct cgroup_subsys_state *css;
> +	struct perf_cgroup *cgrp;
> +	struct perf_event *evt;
> +	u64 cgrp_id;
> +
> +	for (css = &sid->cpuctx->cgrp->css; css; css = css->parent) {
> +		/* root cgroup doesn't have events */
> +		if (css->id == 1)
> +			return 0;
> +
> +		cgrp = container_of(css, struct perf_cgroup, css);
> +		cgrp_id = *this_cpu_ptr(cgrp->cgrp_id);
> +		/* Only visit groups when the cgroup has events */
> +		if (cgrp_id) {
> +			evt = perf_event_groups_first_cgroup(groups, cpu, cgrp_id);
> +			while (evt) {
> +				if (func(evt, (void *)sid, pmu_filter_match))
> +					break;
> +				evt = perf_event_groups_next_cgroup(evt);
> +			}
> +			return 0;		<--- need to remove for hierarchies
> +		}
> +	}
> +
> +	return 0;
> +}

Thanks,
Kan



