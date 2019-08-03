Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB7C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 05:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157822067D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 05:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfHCFen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 01:34:43 -0400
Received: from mail1.windriver.com ([147.11.146.13]:41367 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfHCFen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 01:34:43 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x735YGQ7021285
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 2 Aug 2019 22:34:16 -0700 (PDT)
Received: from [128.224.162.221] (128.224.162.221) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 2 Aug
 2019 22:34:16 -0700
Subject: Re: [PATCH 1/2] perf: Fix failure to set cpumask when only one cpu
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <kan.liang@linux.intel.com>, <eranian@google.com>,
        <alexey.budankov@linux.intel.com>, <linux-kernel@vger.kernel.org>
References: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
 <20190802130607.GA27223@krava>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <70e58ead-f152-5697-d24c-45a8c8fa7a83@windriver.com>
Date:   Sat, 3 Aug 2019 13:34:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802130607.GA27223@krava>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.221]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/19 9:06 PM, Jiri Olsa wrote:
> On Fri, Aug 02, 2019 at 04:29:51PM +0800, zhe.he@windriver.com wrote:
>> From: He Zhe <zhe.he@windriver.com>
>>
>> The buffer containing string used to set cpumask is overwritten by end of
>> string later in cpu_map__snprint_mask due to not enough memory space, when
>> there is only one cpu. And thus causes the following failure.
>>
>> $ perf ftrace ls
>> failed to reset ftrace
>>
>> This patch fixes the calculation of cpumask string size.
>>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>>  tools/perf/builtin-ftrace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
>> index 66d5a66..0193128 100644
>> --- a/tools/perf/builtin-ftrace.c
>> +++ b/tools/perf/builtin-ftrace.c
>> @@ -173,7 +173,7 @@ static int set_tracing_cpumask(struct cpu_map *cpumap)
>>  	int last_cpu;
>>  
>>  	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
>> -	mask_size = (last_cpu + 3) / 4 + 1;
>> +	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
>>  	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
> ugh..  why do we care about last_cpu value in here at all?
>
> feels like using static buffer would be more reasonable

Thanks, and yes, a static buffer would be easy to handle. A 2KB buffer is enough
to cover 8196 cpus, the maximum numbers of cpus we can run with for now.

Let's see if there is any other concerns.

Zhe

>
> jirka
>
>>  
>>  	cpumask = malloc(mask_size);
>> -- 
>> 2.7.4
>>

