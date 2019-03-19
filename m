Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69082C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD0720850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCSPMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:12:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43028 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfCSPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:12:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 00CBACE3CBBB3A038346;
        Tue, 19 Mar 2019 23:12:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 23:12:16 +0800
Subject: Re: [PATCH] perf tools: return errcode in
 cs_etm__process_auxtrace_info
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
References: <20190315022649.17848-1-yuehaibing@huawei.com>
 <20190318171518.GH22548@kernel.org>
 <CANLsYkzU25wAx0dMQqMVZ2asx+z-taOfffLO7DMd6mkDXc7D9A@mail.gmail.com>
 <20190319144631.GE3029@kernel.org> <20190319145525.GA7394@xps15>
CC:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a006e535-67a3-073b-b556-b6d3a4c31749@huawei.com>
Date:   Tue, 19 Mar 2019 23:12:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190319145525.GA7394@xps15>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/19 22:55, Mathieu Poirier wrote:
> On Tue, Mar 19, 2019 at 11:46:31AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Mar 19, 2019 at 08:38:32AM -0600, Mathieu Poirier escreveu:
>>> On Mon, 18 Mar 2019 at 11:15, Arnaldo Carvalho de Melo
>>> <arnaldo.melo@gmail.com> wrote:
>>>>
>>>> Em Fri, Mar 15, 2019 at 10:26:49AM +0800, Yue Haibing escreveu:
>>>>> From: YueHaibing <yuehaibing@huawei.com>
>>>>>
>>>>> 'err' is set in err path, but it's not returned to callers.
>>>>> Also fix a pass zero to PTR_ERR issue.
>>>>
>>>> Next time please submit two patches, one for the PTR_ERR and another for
>>>> not throwing away the err = -E!INVAL and returning just -EINVAL, I'm
>>>> doing it this time.
>>>>
>>>
>>> Please hold off on that - I've asked for other modifications to be
>>> done on this patch.
>>
>> Do you really think that it is necessary to hold? The fixes are trivial
>> and I already have them split and applied, see them below, I think
>> whatever other changes can be done in further patches, no?
> 
> Proceeding with the patches below would created two new bugs, hence asking Yue
> for modifications.


Sorry for late, then I can send a new patch to fix the two new bugs.

> 
> Mathieu  
> 
>>
>> - Arnaldo
>>
>> From 6c5c248935a4da12a582b1518a38ec35044833ee Mon Sep 17 00:00:00 2001
>> From: YueHaibing <yuehaibing@huawei.com>
>> Date: Fri, 15 Mar 2019 10:26:49 +0800
>> Subject: [PATCH 24/42] perf cs-etm: return errcode in
>>  cs_etm__process_auxtrace_info()
>>
>> 'err' is set in err path, but it's not returned to callers. Don't always return
>> -EINVAL, return err.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
>> Link: http://lkml.kernel.org/r/20190315022649.17848-1-yuehaibing@huawei.com
>> [ split from a larger patch ]
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> ---
>>  tools/perf/util/cs-etm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 110804936fc3..2257ac4dbff2 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -2023,5 +2023,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>>  err_free_hdr:
>>  	zfree(&hdr);
>>  
>> -	return -EINVAL;
>> +	return err;
>>  }
>> -- 
>> 2.20.1
>>
>> From 4ab1e71e45a91220bdca7fc3b79c600df81d9234 Mon Sep 17 00:00:00 2001
>> From: YueHaibing <yuehaibing@huawei.com>
>> Date: Fri, 15 Mar 2019 10:26:49 +0800
>> Subject: [PATCH 25/42] perf cs-etm: Remove errnoeous ERR_PTR() usage in in
>>  cs_etm__process_auxtrace_info
>>
>> intlist__findnew() doesn't uses ERR_PTR() as a return mechanism so its callers
>> shouldn't try to extract the error using PTR_ERR(ret-from-intlist__findnew()),
>> make cs_etm__process_auxtrace_info9) return -ENOMEM instead.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
>> Link: http://lkml.kernel.org/r/20190315022649.17848-1-yuehaibing@huawei.com
>> [ split from a larger patch ]
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> ---
>>  tools/perf/util/cs-etm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 2257ac4dbff2..111f33cd1204 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -1908,7 +1908,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>>  
>>  		/* Something went wrong, no need to continue */
>>  		if (!inode) {
>> -			err = PTR_ERR(inode);
>> +			err = -ENOMEM;
>>  			goto err_free_metadata;
>>  		}
>>  
>> -- 
>> 2.20.1
>>
> 
> .
> 

