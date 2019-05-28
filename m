Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8F120717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfE1TFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:05:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:18972 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfE1TFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:05:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 12:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,524,1549958400"; 
   d="scan'208";a="179304574"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2019 12:05:52 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 262A95802C9;
        Tue, 28 May 2019 12:05:51 -0700 (PDT)
Subject: Re: [PATCH 3/3] perf header: Rename "sibling cores" to "sibling
 sockets"
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
References: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
 <1558644081-17738-3-git-send-email-kan.liang@linux.intel.com>
 <20190528085942.GA27906@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <be44271c-3a87-fa48-a269-18277ecf5a06@linux.intel.com>
Date:   Tue, 28 May 2019 15:05:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528085942.GA27906@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 4:59 AM, Jiri Olsa wrote:
> On Thu, May 23, 2019 at 01:41:21PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The "sibling cores" actually shows the sibling CPUs of a socket.
>> The name "sibling cores" is very misleading.
>>
>> Rename "sibling cores" to "sibling sockets"
> 
> by checking on die topology, I found that thread_siblings_list
> is deprecated/renamed to core_cpus_list.. we should keep that
> in mind and support both
>

Sure, I will introduce THRD_SIB_FMT_NEW for the new name.
#define THRD_SIB_FMT_NEW \
	"%s/devices/system/cpu/cpu%d/topology/core_cpus_list"

I will check new name first, (if N/A, then check the old name), before 
parsing the topology information.

I will add the change in V2.

Thanks,
Kan



> jirka
> 
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/Documentation/perf.data-file-format.txt | 2 +-
>>   tools/perf/util/header.c                           | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index c731416..dd85163 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -168,7 +168,7 @@ struct {
>>   };
>>   
>>   Example:
>> -	sibling cores   : 0-8
>> +	sibling sockets : 0-8
>>   	sibling dies	: 0-3
>>   	sibling dies	: 4-7
>>   	sibling threads : 0-1
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index faa1e38..eb79495 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -1465,7 +1465,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
>>   	str = ph->env.sibling_cores;
>>   
>>   	for (i = 0; i < nr; i++) {
>> -		fprintf(fp, "# sibling cores   : %s\n", str);
>> +		fprintf(fp, "# sibling sockets : %s\n", str);
>>   		str += strlen(str) + 1;
>>   	}
>>   
>> -- 
>> 2.7.4
>>
