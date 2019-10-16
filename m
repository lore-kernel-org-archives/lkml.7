Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE643FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDA421925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393941AbfJPOUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:20:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbfJPOUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:20:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2C655EECCF023BF90BBA;
        Wed, 16 Oct 2019 22:20:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 22:19:54 +0800
Subject: Re: [PATCH v2] perf kmem: Fix memory leak in compact_gfp_flags()
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <linfeilong@huawei.com>
References: <7fd48f77-fbc4-b99f-60c1-ccc7d8d287e9@huawei.com>
 <20191016140651.GF22835@kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <fc49d489-3ea3-104d-6409-ea0438818ef3@huawei.com>
Date:   Wed, 16 Oct 2019 22:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191016140651.GF22835@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/16 22:06, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 16, 2019 at 09:26:50PM +0800, Yunfeng Ye escreveu:
>> The memory @orig_flags is allocated by strdup(), it is freed on the
>> normal path, but leak to free on the error path.
>>
>> Fix this by adding free(orig_flags) on the error path.
>>
>> Fixes: 0e11115644b3 ("perf kmem: Print gfp flags in human readable string")
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>> v1 -> v2:
>>  - add "Fixes:" message
> 
> No need for that, I did it already, just next time look for when the
> problem you fixed was introduced, that way the various bots out there
> can pick this up for backports, i.e. your fix has a higher chance of
> being beneficial to more systems.
> 
Normally I will add "Fixes:", this time is forgot. thanks.

> - Arnaldo
>  
>>  tools/perf/builtin-kmem.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
>> index 1e61e353f579..9661671cc26e 100644
>> --- a/tools/perf/builtin-kmem.c
>> +++ b/tools/perf/builtin-kmem.c
>> @@ -691,6 +691,7 @@ static char *compact_gfp_flags(char *gfp_flags)
>>  			new = realloc(new_flags, len + strlen(cpt) + 2);
>>  			if (new == NULL) {
>>  				free(new_flags);
>> +				free(orig_flags);
>>  				return NULL;
>>  			}
>>
>> -- 
>> 2.7.4.3
> 

