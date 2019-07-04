Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B2C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28BB218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfGDLVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:21:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2965 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfGDLVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:21:41 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 0C9124EBB6BABD9ABB88;
        Thu,  4 Jul 2019 19:21:40 +0800 (CST)
Received: from dggeme754-chm.china.huawei.com (10.3.19.100) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 19:21:39 +0800
Received: from [127.0.0.1] (10.184.212.80) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 4
 Jul 2019 19:21:38 +0800
Subject: Re: [PATCH v2] fix use-after-free in perf_sched__lat
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiezhipeng1@huawei.com>
References: <20190508143648.8153-1-liwei391@huawei.com>
 <20190522065555.GA206606@google.com> <20190522110823.GR8945@kernel.org>
 <20190523025011.GC196218@google.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <d14c02f2-4962-ad42-697e-224ddb599f43@huawei.com>
Date:   Thu, 4 Jul 2019 19:21:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190523025011.GC196218@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.212.80]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,
I found this issue has not been fixed in mainline now, please take a glance at this.

On 2019/5/23 10:50, Namhyung Kim wrote:
> On Wed, May 22, 2019 at 08:08:23AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, May 22, 2019 at 03:56:10PM +0900, Namhyung Kim escreveu:
>>> On Wed, May 08, 2019 at 10:36:48PM +0800, Wei Li wrote:
>>>> After thread is added to machine->threads[i].dead in
>>>> __machine__remove_thread, the machine->threads[i].dead is freed
>>>> when calling free(session) in perf_session__delete(). So it get a
>>>> Segmentation fault when accessing it in thread__put().
>>>>
>>>> In this patch, we delay the perf_session__delete until all threads
>>>> have been deleted.
>>>>
>>>> This can be reproduced by following steps:
>>>> 	ulimit -c unlimited
>>>> 	export MALLOC_MMAP_THRESHOLD_=0
>>>> 	perf sched record sleep 10
>>>> 	perf sched latency --sort max
>>>> 	Segmentation fault (core dumped)
>>>>
>>>> Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
>>>> Signed-off-by: Wei Li <liwei391@huawei.com>
>>>
>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>
>> I'll try to analyse this one soon, but my first impression was that we
>> should just grab reference counts when keeping a pointer to those
>> threads instead of keeping _all_ threads alive when supposedly we could
>> trow away unreferenced data structures.
>>
>> But this is just a first impression from just reading the patch
>> description, probably I'm missing something.
> 
> No, thread refcounting is fine.  We already did it and threads with the
> refcount will be accessed only.
> 
> But the problem is the head of the list.  After using the thread, the
> refcount is gone and thread is removed from the list and destroyed.
> However the head of list is in a struct machine which was freed with
> session already.
> 
> Thanks,
> Namhyung
> 
> 
>>
>> Thanks for providing instructions on readily triggering the segfault.
>>
>> - Arnaldo
> 
> .
> 

Thanks,
Wei

