Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D5CFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3686E2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393336AbfJPMtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:49:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390639AbfJPMtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:49:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34BB285F6FBDE307F700;
        Wed, 16 Oct 2019 20:49:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 20:49:09 +0800
Subject: Re: [PATCH] perf jevents: Fix resource leak in process_mapfile()
To:     John Garry <john.garry@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <lukemujica@google.com>, <kan.liang@linux.intel.com>,
        <yuzenghui@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
References: <bf113089-e3cd-50f9-f7ed-17d07512a702@huawei.com>
 <87e66585-1564-3523-59f6-cab15b7e1717@huawei.com>
 <0cd0d259-e806-effd-5e44-fccd13842697@huawei.com>
 <5dcbcd6f-3789-69e1-b0c1-33416aa0790d@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <6dc4d5bc-3a1e-3849-a0d3-0f9635bb77fe@huawei.com>
Date:   Wed, 16 Oct 2019 20:49:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5dcbcd6f-3789-69e1-b0c1-33416aa0790d@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/16 20:08, John Garry wrote:
>>>> +            ret = -1;
>>>> +            goto out;
>>>
>>> There's a subtle change of behaviour here, i.e. now calling print_mapping_table_suffix(), but I don't think that it makes any difference.
>>>
>> yes, I know that "goto out" will run print_mapping_table_suffix(outfp), because the error path before is done like this.
>> so I think it should be use "goto out" to run run print_mapping_table_suffix(outfp).
>>
>>> However, does outfp remain open also in this case:
>>>
>> Because it has a comment that "Make build fail", so I am not handle the outfp, only modify the process_mapfile() function.
>>
>>> main(int argc, char *argv[])
>>> {
>>> ...
>>>
>>> if (process_mapfile(eventsfp, mapfile)) {
>>>     pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
>>>     /* Make build fail */
>>>     return 1;
>>> }
>>>
>>> return 0;
>>>
>>> empty_map:
>>>     fclose(eventsfp);
>>>     ...
>>> }
>>>
>>> I think that this code works on the basis that the program exits on any sort of error and releases resources automatically. Having said that, it is a good practice to tidy up.
>>>
>> I agree with you, when program exits, it will releases resources automatically. It's just to make the program clearer and more correct.
> 
> So can you make that change also (to close outfp)?
> 
ok, I will modify by adding fclose(eventsfp) on the error path, In addition, free_arch_std_events() is need too.

> Thanks,
> John
> 
>>
>>> John
>>>
>>>>          }
>>>>          line[strlen(line)-1] = '\0';
>>>>
>>>> @@ -825,7 +828,9 @@ static int process_mapfile(FILE *outfp, char *fpath)
>>>>
>>>>  out:
>>>>      print_mapping_table_suffix(outfp);
>>>> -    return 0;
>>>> +    fclose(mapfp);
>>>> +    free(line);
>>>> +    return ret;
>>>>  }
>>>>
>>>>  /*
>>>>
>>>
>>>
>>>
>>> .
>>>
>>
>>
>> .
>>
> 
> 
> 
> .
> 

