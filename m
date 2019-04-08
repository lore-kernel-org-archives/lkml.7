Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC56C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827422147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDHQZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:25:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:52944 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfDHQZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:25:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 09:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="149057309"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 09:25:19 -0700
Received: from [10.254.87.204] (kliang2-mobl.ccr.corp.intel.com [10.254.87.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 366405807AA;
        Mon,  8 Apr 2019 09:25:18 -0700 (PDT)
Subject: Re: [PATCH V5 00/12] perf: Add Icelake support (kernel only, except
 Topdown)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190408154112.GW12232@hirez.programming.kicks-ass.net>
 <ec9e3a07-4b29-b698-83d7-5b8bbcd48dc4@linux.intel.com>
Message-ID: <c22d3a18-3a49-dc27-5abe-b284021578c0@linux.intel.com>
Date:   Mon, 8 Apr 2019 12:25:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ec9e3a07-4b29-b698-83d7-5b8bbcd48dc4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -963,40 +963,42 @@ static u64 pebs_update_adaptive_cfg(stru
>>       u64 pebs_data_cfg = 0;
>>       bool gprs, tsx_weight;
>> -    if ((sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) ||
>> -        attr->precise_ip < 2) {
>> +    if (!(sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) &&
>> +        attr->precise_ip > 1)
>> +        return pebs_data_cfs;

Sorry, there are two typos. I didn't find in the previous email.
Should be pebs_data_cfg.

>> -        if (sample_type & PERF_PEBS_MEMINFO_TYPE)
>> -            pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
>> +    if (sample_type & PERF_PEBS_MEMINFO_TYPE)
>> +        pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
>> +    /*
>> +     * We need GPRs when:
>> +     * + user requested them
>> +     * + precise_ip < 2 for the non event IP
>> +     * + For RTM TSX weight we need GPRs for the abort code.
>> +     */
>> +    gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
>> +           (attr->sample_regs_intr & PEBS_GPRS_REGS);
>> +
>> +    tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
>> +             ((attr->config & INTEL_ARCH_EVENT_MASK) ==
>> +              x86_pmu.rtm_abort_event);
>> +
>> +    if (gprs || (attr->precise_ip < 2) || tsx_weight)
>> +        pebs_data_cfg |= PEBS_DATACFG_GPRS;
>> +
>> +    if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
>> +        (attr->sample_regs_intr & PERF_XMM_REGS))

Should be PEBS_XMM_REGS.


Thanks,
Kan
