Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA75C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4A8215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfI3Qp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:45:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:19859 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3Qp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:45:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 09:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; 
   d="scan'208";a="184892092"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 30 Sep 2019 09:45:28 -0700
Received: from [10.251.2.197] (kliang2-mobl.ccr.corp.intel.com [10.251.2.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A345D5803DA;
        Mon, 30 Sep 2019 09:45:27 -0700 (PDT)
Subject: Re: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>, ak@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-8-kan.liang@linux.intel.com>
 <20190930130615.GN4553@hirez.programming.kicks-ass.net>
 <20190930140755.GE4581@hirez.programming.kicks-ass.net>
 <20190930145321.GF4581@hirez.programming.kicks-ass.net>
 <06e16f73-f6af-5019-3d85-bc33740e0c8f@linux.intel.com>
 <20190930162153.GG4519@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8d255708-6b8d-c18d-1491-cb19e3c6be4d@linux.intel.com>
Date:   Mon, 30 Sep 2019 12:45:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930162153.GG4519@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2019 12:21 PM, Peter Zijlstra wrote:
>>> {
>>> 	int idx = event->hwc.idx;
>>>
>>> 	if (is_metric_idx(idx))
>>> 		return;
>>>
>>> 	// must be FIXED_SLOTS
>> The FIXED_SLOTS may not be in the group.
> Argh.. can we mandate that it is? that is, if you want a metric thing,
> you have to have a slots counter first?

If we mandate the FIXED_SLOTS in the group, we don't need the 
is_first_topdown_event_in_group() check. We just update everything for 
FIXED_SLOTS event. It will definitely simplify the code.

For perf sub-tool, I can add warning if users missed the SLOTs event or 
just implicitly add the event.

For RDPMC users, it looks like there is no way to warn them.
But they should always apply for both SLOTS and METRICS?

Andi, what do you think? Will it be a problem for RDPMC users?

Thanks,
Kan
