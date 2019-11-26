Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C6C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2362B2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfKZDAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:00:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfKZDAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:00:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A7212AE2EC6CABDAF300;
        Tue, 26 Nov 2019 11:00:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 26 Nov 2019
 11:00:40 +0800
Subject: Re: [PATCH] perf c2c: Fix memory leak in c2c_he_zalloc()
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>,
        <arnaldo.melo@gmail.com>
References: <9d5f26f8-9429-bcb6-d491-cb789f761ea2@huawei.com>
 <20191025120154.GA25352@krava>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <1847ad5d-05b6-5680-f08d-bdd8fbf54da3@huawei.com>
Date:   Tue, 26 Nov 2019 11:00:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191025120154.GA25352@krava>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/25 20:01, Jiri Olsa wrote:
> On Fri, Oct 25, 2019 at 05:42:47PM +0800, Yunfeng Ye wrote:
>> A memory leak in c2c_he_zalloc() is found by visual inspection.
>>
>> Fix this by adding memory free on the error paths in c2c_he_zalloc().
>>
>> Fixes: 7f834c2e84bb ("perf c2c report: Display node for cacheline address")
>> Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 

Is this patch applied? thanks

> thanks,
> jirka
> 
>> ---
>>  tools/perf/builtin-c2c.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>> index e69f44941aad..ad7d38a9dcbe 100644
>> --- a/tools/perf/builtin-c2c.c
>> +++ b/tools/perf/builtin-c2c.c
>> @@ -138,21 +138,29 @@ static void *c2c_he_zalloc(size_t size)
>>
>>  	c2c_he->cpuset = bitmap_alloc(c2c.cpus_cnt);
>>  	if (!c2c_he->cpuset)
>> -		return NULL;
>> +		goto free_c2c_he;
>>
>>  	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
>>  	if (!c2c_he->nodeset)
>> -		return NULL;
>> +		goto free_cpuset;
>>
>>  	c2c_he->node_stats = zalloc(c2c.nodes_cnt * sizeof(*c2c_he->node_stats));
>>  	if (!c2c_he->node_stats)
>> -		return NULL;
>> +		goto free_nodeset;
>>
>>  	init_stats(&c2c_he->cstats.lcl_hitm);
>>  	init_stats(&c2c_he->cstats.rmt_hitm);
>>  	init_stats(&c2c_he->cstats.load);
>>
>>  	return &c2c_he->he;
>> +
>> +free_nodeset:
>> +	free(c2c_he->nodeset);
>> +free_cpuset:
>> +	free(c2c_he->cpuset);
>> +free_c2c_he:
>> +	free(c2c_he);
>> +	return NULL;
>>  }
>>
>>  static void c2c_he_free(void *he)
>> -- 
>> 2.7.4
>>
> 
> 
> .
> 

