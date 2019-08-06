Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A70C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BAE20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbfHFLjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:39:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:34843 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHFLjW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:39:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 04:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="198287394"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.212.182]) ([10.254.212.182])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2019 04:39:20 -0700
Subject: Re: [PATCH v2] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190724221432.26297-1-yao.jin@linux.intel.com>
 <20190806083413.GG7695@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <085edaa4-e8f2-f501-5ffc-4d07b4ea85ad@linux.intel.com>
Date:   Tue, 6 Aug 2019 19:39:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806083413.GG7695@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2019 4:34 PM, Jiri Olsa wrote:
> On Thu, Jul 25, 2019 at 06:14:32AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +}
>> +
>>   double avg_stats(struct stats *stats)
>>   {
>>   	return stats->mean;
>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>> index 95b4de7a9d51..3448d319a220 100644
>> --- a/tools/perf/util/stat.h
>> +++ b/tools/perf/util/stat.h
>> @@ -8,14 +8,18 @@
>>   #include <sys/time.h>
>>   #include <sys/resource.h>
>>   #include <sys/wait.h>
>> +#include <stdio.h>
>>   #include "xyarray.h"
>>   #include "rblist.h"
>>   #include "perf.h"
>>   #include "event.h"
>>   
>> +#define NUM_SPARK_VALS	8 /* support spark line on first N items */
>> +
>>   struct stats {
>>   	double n, mean, M2;
>>   	u64 max, min;
>> +	unsigned long svals[NUM_SPARK_VALS];
>>   };
> 
> please do it without changing the 'struct stats', it's all
> over the place and diff would be the only user
> 
> thanks
> jirka
> 

OK, I see. I will save the svals[] in other struct.

Thanks
Jin Yao



