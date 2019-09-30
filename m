Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBD7C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E620120815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbfI3QSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:18:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:39177 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3QR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:17:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 09:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; 
   d="scan'208";a="202933894"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 30 Sep 2019 09:17:59 -0700
Received: from [10.251.2.197] (kliang2-mobl.ccr.corp.intel.com [10.251.2.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7CC0C5800FE;
        Mon, 30 Sep 2019 09:17:58 -0700 (PDT)
Subject: Re: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-8-kan.liang@linux.intel.com>
 <20190930130615.GN4553@hirez.programming.kicks-ass.net>
 <20190930140755.GE4581@hirez.programming.kicks-ass.net>
 <20190930145321.GF4581@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <06e16f73-f6af-5019-3d85-bc33740e0c8f@linux.intel.com>
Date:   Mon, 30 Sep 2019 12:17:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930145321.GF4581@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2019 10:53 AM, Peter Zijlstra wrote:
> 
> After that, I think we can simply do something like:
> 
> icl_update_topdown_event(..)

We should call this function in x86_pmu_commit_txn()?
In intel_pmu_read_event(), we just simply return, when TXN_READ is set 
and is_topdown_count().

If so, it looks like we need add a per-cpu variable to store the topdown 
group events which user tries to read. Then we can update these events 
in x86_pmu_commit_txn(). The same method as Power does.

Is my understanding correct?

> {
> 	int idx = event->hwc.idx;
> 
> 	if (is_metric_idx(idx))
> 		return;
> 
> 	// must be FIXED_SLOTS

The FIXED_SLOTS may not be in the group.

Thanks,
Kan
> 
> 	/* do teh thing and update SLOTS and METRIC together */
> }
> 
> Hmmm?
