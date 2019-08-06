Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B62C0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61ED52070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfHFAUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:20:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:20244 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfHFAUQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:20:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="192535248"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.69]) ([10.239.196.69])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2019 17:20:13 -0700
Subject: Re: [PATCH] perf pmu-events: Fix the missing "cpu_clk_unhalted.core"
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <20190729072755.2166-1-yao.jin@linux.intel.com>
 <20190729181658.GH25319@tassilo.jf.intel.com>
 <0100c287-21b0-4754-a0a7-aee2318fdf0d@linux.intel.com>
Message-ID: <0622176c-dc29-a8df-e83d-c793e54c40dc@linux.intel.com>
Date:   Tue, 6 Aug 2019 08:20:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0100c287-21b0-4754-a0a7-aee2318fdf0d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2019 9:43 AM, Jin, Yao wrote:
> 
> 
> On 7/30/2019 2:16 AM, Andi Kleen wrote:
>>> diff --git a/tools/perf/pmu-events/jevents.c 
>>> b/tools/perf/pmu-events/jevents.c
>>> index 1a91a197cafb..d413761621b0 100644
>>> --- a/tools/perf/pmu-events/jevents.c
>>> +++ b/tools/perf/pmu-events/jevents.c
>>> @@ -453,6 +453,7 @@ static struct fixed {
>>>       { "inst_retired.any_p", "event=0xc0" },
>>>       { "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
>>>       { "cpu_clk_unhalted.thread", "event=0x3c" },
>>> +    { "cpu_clk_unhalted.core", "event=0x3c" },
>>
>> Not sure this is correct for non Atom.
>>
>> On Atom thread==core, but that is not true with SMT/HyperThreading.
>>
>> The big cores currently don't have this event, so it would
>> match incorrectly.
>>
>> This has to be handled on the event list level, perhaps with
>> some enhancements.
>>
>> -Andi
>>
> 
> Hi Andi,
> 
> It is used to handle the fixed counter encodings between JSON and perf. 
> If big cores don't have this event, nothing will be generated in perf list.
> 
> In big cores pipeline.json, there is only "CPU_CLK_UNHALTED.THREAD", and 
> there is no "CPU_CLK_UNHALTED.CORE" defined. So at least for now, 
> CPU_CLK_UNHALTED.CORE will not be generated for big core.
> 
> Thanks
> Jin Yao

Hi Andi,

Does this fix and the above explanation make sense?

Thanks
Jin Yao
