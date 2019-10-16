Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1CFFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6CA21848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393889AbfJPORf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:17:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392279AbfJPORf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:17:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 11C14584243BE82D58B3;
        Wed, 16 Oct 2019 22:17:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 22:17:24 +0800
Subject: Re: [PATCH] perf kmem: Fix memory leak in compact_gfp_flags()
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <linfeilong@huawei.com>
References: <f9e9f458-96f3-4a97-a1d5-9feec2420e07@huawei.com>
 <20191016130403.GA22835@kernel.org> <20191016130921.GC22835@kernel.org>
 <f1dc9f3f-ce4a-9a62-1940-8ea8b7fea750@huawei.com>
 <20191016140856.GG22835@kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <af08fc9f-2da2-0b99-0298-554f8babf076@huawei.com>
Date:   Wed, 16 Oct 2019 22:17:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191016140856.GG22835@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/16 22:08, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 16, 2019 at 09:19:54PM +0800, Yunfeng Ye escreveu:
>>
>>
>> On 2019/10/16 21:09, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Oct 16, 2019 at 10:04:03AM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Em Wed, Oct 16, 2019 at 04:38:45PM +0800, Yunfeng Ye escreveu:
>>>>> The memory @orig_flags is allocated by strdup(), it is freed on the
>>>>> normal path, but leak to free on the error path.
>>>>
>>>> Are you using some tool to find out these problems? Or is it just visual
>>>> inspection?
>>>
>> By a static code anaylsis tool which not an open source tool. thanks.
> 
> Ok, so please state that next time, just for the fullest possible
> disclosure and for people to realize to what extent problems in the
> kernel and in tooling hosted in the kernel is being fixed by such tools.
> 
> I.e. you don't need to release the tool, not even give out its name,
> just something like:
> 
> "Found by internal static analysis tool."
> 
ok, thanks.

> Thanks,
> 
> - Arnaldo
>  
>>> Anyway, applied after adding this to the commit log message:
>>>
>>> Fixes: 0e11115644b3 ("perf kmem: Print gfp flags in human readable string")
>>>
>> ok, thanks.
>>
>>> - Arnaldo
>>>  
>>>> - Arnaldo
>>>>  
>>>>> Fix this by adding free(orig_flags) on the error path.
>>>>>
>>>>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>>>> ---
>>>>>  tools/perf/builtin-kmem.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
>>>>> index 1e61e353f579..9661671cc26e 100644
>>>>> --- a/tools/perf/builtin-kmem.c
>>>>> +++ b/tools/perf/builtin-kmem.c
>>>>> @@ -691,6 +691,7 @@ static char *compact_gfp_flags(char *gfp_flags)
>>>>>  			new = realloc(new_flags, len + strlen(cpt) + 2);
>>>>>  			if (new == NULL) {
>>>>>  				free(new_flags);
>>>>> +				free(orig_flags);
>>>>>  				return NULL;
>>>>>  			}
>>>>>
>>>>> -- 
>>>>> 2.7.4.3
>>>>
>>>> -- 
>>>>
>>>> - Arnaldo
>>>
> 

