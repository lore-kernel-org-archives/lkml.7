Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F603C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D79214AE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfEHDq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 23:46:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbfEHDq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 23:46:27 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 3DD319077D78086EC061;
        Wed,  8 May 2019 11:46:25 +0800 (CST)
Received: from dggeme754-chm.china.huawei.com (10.3.19.100) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 8 May 2019 11:46:24 +0800
Received: from [127.0.0.1] (10.184.212.80) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 8
 May 2019 11:46:24 +0800
Subject: Re: [PATCH] fix use-after-free in perf_sched__lat
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <acme@kernel.org>, <namhyung@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <xiezhipeng1@huawei.com>
References: <20190503023555.24736-1-liwei391@huawei.com>
 <20190507085153.GC17416@krava>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <87032042-d814-dde9-8c35-31794e91209f@huawei.com>
Date:   Wed, 8 May 2019 11:45:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190507085153.GC17416@krava>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.212.80]
X-ClientProxiedBy: dggeme767-chm.china.huawei.com (10.3.19.113) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri，
Thanks for your reply.

On 2019/5/7 16:51, Jiri Olsa wrote:
> On Fri, May 03, 2019 at 10:35:55AM +0800, Wei Li wrote:
>> After thread is added to machine->threads[i].dead in
>> __machine__remove_thread, the machine->threads[i].dead is freed
>> when calling free(session) in perf_session__delete(). So it get a
>> Segmentation fault when accessing it in thread__put().
>>
>> In this patch, we delay the perf_session__delete until all threads
>> have been deleted.
>>
>> This can be reproduced by following steps:
>> 	ulimit -c unlimited
>> 	export MALLOC_MMAP_THRESHOLD_=0
> 
> what's this for?

When we set env "MALLOC_MMAP_THRESHOLD_=0"，the memory-allocation functions employ
mmap instead of increasing the program break using sbrk what may be maintained
with cache. Thus it can report "Segmentation fault" immediately when going into
this use-after-free code.

> 
>> 	perf sched record sleep 10
>> 	perf sched latency --sort max
>> 	Segmentation fault (core dumped)
>>
>> Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>>  tools/perf/builtin-sched.c | 44 ++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 42 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index cbf39dab19c1..17849ae2eb1e 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -3130,11 +3130,48 @@ static void perf_sched__merge_lat(struct perf_sched *sched)
>>  static int perf_sched__lat(struct perf_sched *sched)
>>  {
>>  	struct rb_node *next;
>> +	const struct perf_evsel_str_handler handlers[] = {
>> +		{ "sched:sched_switch",	      process_sched_switch_event, },
>> +		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
>> +		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
>> +		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
>> +		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
>> +	};
>> +	struct perf_session *session;
>> +	struct perf_data data = {
>> +		.file      = {
>> +			.path = input_name,
>> +		},
> 
> I can't compile this:
> 
> builtin-sched.c: In function ‘perf_sched__lat’:
> builtin-sched.c:3144:12: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>     .path = input_name,
> 
Sorry, this place has been changed recently in mainline code, i will update to
the latest code.

> 
>> +		.mode      = PERF_DATA_MODE_READ,
>> +		.force     = sched->force,
>> +	};
>> +	int rc = -1;
>>  
>>  	setup_pager();
>>  
>> -	if (perf_sched__read_events(sched))
> 
> so it's basically perf_sched__read_events code in here now, right?
> 
> might be better to add __perf_sched__read_events function
> that would take session argument, something like:
> 
>         session = perf_session__new(&data, false, &sched->tool);
> 	...
> 	__perf_sched__read_events(sched, session)
> 	...
> 	perf_session__delete(session);
> 
> to avoid the code ducplication

Yes, what you suggest is reasonable, i will send a v2 with your suggestion soon.

Thanks，
Wei

