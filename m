Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A07AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50532075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfC0OZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:25:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:6766 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfC0OZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:25:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 07:25:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="137703528"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2019 07:25:49 -0700
Received: from [10.254.82.239] (kliang2-mobl.ccr.corp.intel.com [10.254.82.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 19D0D5804E0;
        Wed, 27 Mar 2019 07:25:49 -0700 (PDT)
Subject: Re: [PATCH V4 04/23] perf/x86/intel: Support adaptive PEBSv4
To:     Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
 <20190326160901.4887-5-kan.liang@linux.intel.com>
 <20190326222441.GP18020@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9d267395-fda8-d111-52a2-e7cdcdf7d24b@linux.intel.com>
Date:   Wed, 27 Mar 2019 10:25:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190326222441.GP18020@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2019 6:24 PM, Andi Kleen wrote:
>> +	for (at = base; at < top; at += cpuc->pebs_record_size) {
>> +		u64 pebs_status;
>> +
>> +		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
>> +		pebs_status &= mask;
>> +
>> +		for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
>> +			counts[bit]++;
>> +	}
> 
> On Icelake pebs_status is always reliable, so I don't think we need
> the two pass walking.
>

We need to call perf_event_overflow() for the last record of each event. 
It's hard to detect which record is the last record of the event with 
one pass walking.

Also, I'm not sure how much we can save with one pass walking. The 
optimization should only benefit large PEBS. The total number of records 
for large PEBS should not be huge.
I will evaluate the performance impact of one pass walking. If there is 
observed performance improvement, I will submit a separate patch later.

For now, I think we can still use the mature two pass walking method.

Thanks,
Kan

> -Andi
> 
>> +
>> +	for (bit = 0; bit < size; bit++) {
>> +		if (counts[bit] == 0)
>> +			continue;
>> +
>> +		event = cpuc->events[bit];
>> +		if (WARN_ON_ONCE(!event))
>> +			continue;
>> +
>> +		if (WARN_ON_ONCE(!event->attr.precise_ip))
>> +			continue;
>> +
>> +		__intel_pmu_pebs_event(event, iregs, base,
>> +				       top, bit, counts[bit],
>> +				       setup_pebs_adaptive_sample_data);
>> +	}
>> +}
