Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8794ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9934E217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfJOCAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 22:00:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:30512 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfJOCAX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:00:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 19:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,297,1566889200"; 
   d="scan'208";a="220278934"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.81]) ([10.239.196.81])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2019 19:00:20 -0700
Subject: Re: [PATCH v1 0/5] perf report: Support sorting all blocks by cycles
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191008070502.22551-1-yao.jin@linux.intel.com>
 <20191014153213.GE9700@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <18bb0f66-363d-8bd5-5c06-3dd5fb7977bb@linux.intel.com>
Date:   Tue, 15 Oct 2019 10:00:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014153213.GE9700@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2019 11:32 PM, Jiri Olsa wrote:
> On Tue, Oct 08, 2019 at 03:04:57PM +0800, Jin Yao wrote:
>> It would be useful to support sorting for all blocks by the
>> sampled cycles percent per block. This is useful to concentrate
>> on the globally busiest/slowest blocks.
>>
>> This patch series implements a new sort option "total_cycles" which
>> sorts all blocks by 'Sampled Cycles%'. The 'Sampled Cycles%' is
>> block sampled cycles aggregation / total sampled cycles
>>
>> For example,
>>
>> perf record -b ./div
>> perf report -s total_cycles --stdio
>>
>>   # To display the perf.data header info, please use --header/--header-only options.
>>   #
>>   #
>>   # Total Lost Samples: 0
>>   #
>>   # Samples: 2M of event 'cycles'
>>   # Event count (approx.): 2753248
>>   #
>>   # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                              [Program Block Range]         Shared Object
>>   # ...............  ..............  ...........  ..........  .................................................................  ....................
>>   #
>>              26.04%            2.8M        0.40%          18                                             [div.c:42 -> div.c:39]                   div
>>              15.17%            1.2M        0.16%           7                                 [random_r.c:357 -> random_r.c:380]          libc-2.27.so
>>               5.11%          402.0K        0.04%           2                                             [div.c:27 -> div.c:28]                   div
>>               4.87%          381.6K        0.04%           2                                     [random.c:288 -> random.c:291]          libc-2.27.so
>>               4.53%          381.0K        0.04%           2                                             [div.c:40 -> div.c:40]                   div
>>               3.85%          300.9K        0.02%           1                                             [div.c:22 -> div.c:25]                   div
>>               3.08%          241.1K        0.02%           1                                           [rand.c:26 -> rand.c:27]          libc-2.27.so
>>               3.06%          240.0K        0.02%           1                                     [random.c:291 -> random.c:291]          libc-2.27.so
>>               2.78%          215.7K        0.02%           1                                     [random.c:298 -> random.c:298]          libc-2.27.so
>>               2.52%          198.3K        0.02%           1                                     [random.c:293 -> random.c:293]          libc-2.27.so
>>               2.36%          184.8K        0.02%           1                                           [rand.c:28 -> rand.c:28]          libc-2.27.so
>>               2.33%          180.5K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
>>               2.28%          176.7K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
>>               2.20%          168.8K        0.02%           1                                         [rand@plt+0 -> rand@plt+0]                   div
>>               1.98%          158.2K        0.02%           1                                 [random_r.c:388 -> random_r.c:388]          libc-2.27.so
>>               1.57%          123.3K        0.02%           1                                             [div.c:42 -> div.c:44]                   div
>>               1.44%          116.0K        0.42%          19                                 [random_r.c:357 -> random_r.c:394]          libc-2.27.so
>>   ......
>>
>> This patch series supports both stdio and tui. And also with the supporting
>> of --percent-limit.
>>
>> Jin Yao (5):
>>    perf util: Create new block.h/block.c for block related functions
>>    perf util: Count the total cycles of all samples
>>    perf report: Sort by sampled cycles percent per block for stdio
>>    perf report: Support --percent-limit for total_cycles
>>    perf report: Sort by sampled cycles percent per block for tui
> 
> sry for delay, but I can no longer apply this
> could you please rebase?
> 

Sure, I'd like to rebase to latest perf/core branch. I will send v2 soon. :)

Thanks
Jin Yao

> thanks,
> jirka
> 
