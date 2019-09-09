Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E129C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E010E218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfIINka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:40:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:50293 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfIINk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:40:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 06:40:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="191514217"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Sep 2019 06:40:28 -0700
Received: from [10.251.7.109] (kliang2-mobl.ccr.corp.intel.com [10.251.7.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 581CF580522;
        Mon,  9 Sep 2019 06:40:27 -0700 (PDT)
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828150238.GC17205@worktop.programming.kicks-ass.net>
 <20190828190445.GQ5447@tassilo.jf.intel.com>
 <20190831091931.GJ2369@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9ec0a847-2b6b-3422-72bd-ac738f1c0d10@linux.intel.com>
Date:   Mon, 9 Sep 2019 09:40:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190831091931.GJ2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2019 5:19 AM, Peter Zijlstra wrote:
>>> Then there is no mucking about with that odd counter/metrics msr pair
>>> reset nonsense. Becuase that really stinks.
>> You have to write them to reset the internal counters.
> But not for ever read, only on METRIC_OVF.

The precision are lost if the counters were running much longer than the 
measured delta. We have to reset the counters after every read.
For example, the worst case is:
The previous reading was rounded up and the current reading is rounded 
down. The error of METRICS is 1/256 - 1/SLOTS, which is related to 
SLOTS. The error for each Topdown event is  (1/256 - 1/SLOTS) * SLOTS.
With the SLOTS increasing, the precision will get worse and worse.
Therefor, we have to reset the counters periodically.

Thanks,
Kan


