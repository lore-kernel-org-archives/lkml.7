Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ED3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3DA2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCVAkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:40:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:36030 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfCVAkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:40:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 17:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216402050"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 17:40:08 -0700
Received: from [10.254.81.6] (kliang2-mobl.ccr.corp.intel.com [10.254.81.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C1117580261;
        Thu, 21 Mar 2019 17:40:06 -0700 (PDT)
Subject: Re: [PATCH V2 04/23] perf/x86/intel: Support adaptive PEBSv4
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190321205703.4256-1-kan.liang@linux.intel.com>
 <20190321205703.4256-5-kan.liang@linux.intel.com>
 <20190321212059.GD7905@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <701a0cb7-d2ae-2d55-b5ef-57f4094c994f@linux.intel.com>
Date:   Thu, 21 Mar 2019 20:40:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190321212059.GD7905@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2019 5:20 PM, Peter Zijlstra wrote:
> On Thu, Mar 21, 2019 at 01:56:44PM -0700, kan.liang@linux.intel.com wrote:
>> @@ -933,6 +1001,34 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc, struct pmu *pmu)
>>   		update = true;
>>   	}
>>   
>> +	/*
>> +	 * The PEBS record doesn't shrink on the del. Because to get
>> +	 * an accurate config needs to go through all the existing pebs events.
>> +	 * It's not necessary.
>> +	 * There is no harmful for a bigger PEBS record, except little
>> +	 * performance impacts.
>> +	 * Also, for most cases, the same pebs config is applied for all
>> +	 * pebs events.
>> +	 */
>> +	if (x86_pmu.intel_cap.pebs_baseline && add) {
>> +		u64 pebs_data_cfg;
>> +
>> +		/* Clear pebs_data_cfg and pebs_record_size for first PEBS. */
>> +		if (cpuc->n_pebs == 1) {
>> +			cpuc->pebs_data_cfg = 0;
>> +			cpuc->pebs_record_size = sizeof(struct pebs_basic);
>> +		}
> 
> Argh, no. This is daft. The previous site was fine, it was just the
> pebs_record_size assignment I'm confused about.
> 
> Note how by setting ->pebs_data_cfs to 0, you force the below branch to
> true and call adaptive_pebs_record_size_update() ? So _why_ do you have
> to set pebs_record_size()?
>

I think we have to reset both cpuc->pebs_data_cfg and 
cpuc->pebs_record_size. Because pebs_update_adaptive_cfg() can return 0.
If so, adaptive_pebs_record_size_update() will not be called. The 
cpuc->pebs_record_size still use the stale data, which may be wrong.

I think there is no difference to reset them in first add or last del.
If so, I will keep the code here unchanged.

I will prepare V3 to address other comments.

Thanks,
Kan

>> +
>> +		pebs_data_cfg = pebs_update_adaptive_cfg(event);
>> +
>> +		/* Update pebs_record_size if new event requires more data. */
>> +		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
>> +			cpuc->pebs_data_cfg |= pebs_data_cfg;
>> +			adaptive_pebs_record_size_update();
>> +			update = true;
>> +		}
>> +	}
>> +
>>   	if (update)
>>   		pebs_update_threshold(cpuc);
>>   }
