Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77265FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A3B2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392876AbfJPMJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:09:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389612AbfJPMJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:09:08 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DC2D7FF522453C16920F;
        Wed, 16 Oct 2019 20:09:06 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 20:08:55 +0800
Subject: Re: [PATCH] perf jevents: Fix resource leak in process_mapfile()
To:     Yunfeng Ye <yeyunfeng@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <lukemujica@google.com>, <kan.liang@linux.intel.com>,
        <yuzenghui@huawei.com>
References: <bf113089-e3cd-50f9-f7ed-17d07512a702@huawei.com>
 <87e66585-1564-3523-59f6-cab15b7e1717@huawei.com>
 <0cd0d259-e806-effd-5e44-fccd13842697@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5dcbcd6f-3789-69e1-b0c1-33416aa0790d@huawei.com>
Date:   Wed, 16 Oct 2019 13:08:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <0cd0d259-e806-effd-5e44-fccd13842697@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +            ret = -1;
>>> +            goto out;
>>
>> There's a subtle change of behaviour here, i.e. now calling print_mapping_table_suffix(), but I don't think that it makes any difference.
>>
> yes, I know that "goto out" will run print_mapping_table_suffix(outfp), because the error path before is done like this.
> so I think it should be use "goto out" to run run print_mapping_table_suffix(outfp).
>
>> However, does outfp remain open also in this case:
>>
> Because it has a comment that "Make build fail", so I am not handle the outfp, only modify the process_mapfile() function.
>
>> main(int argc, char *argv[])
>> {
>> ...
>>
>> if (process_mapfile(eventsfp, mapfile)) {
>>     pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
>>     /* Make build fail */
>>     return 1;
>> }
>>
>> return 0;
>>
>> empty_map:
>>     fclose(eventsfp);
>>     ...
>> }
>>
>> I think that this code works on the basis that the program exits on any sort of error and releases resources automatically. Having said that, it is a good practice to tidy up.
>>
> I agree with you, when program exits, it will releases resources automatically. It's just to make the program clearer and more correct.

So can you make that change also (to close outfp)?

Thanks,
John

>
>> John
>>
>>>          }
>>>          line[strlen(line)-1] = '\0';
>>>
>>> @@ -825,7 +828,9 @@ static int process_mapfile(FILE *outfp, char *fpath)
>>>
>>>  out:
>>>      print_mapping_table_suffix(outfp);
>>> -    return 0;
>>> +    fclose(mapfp);
>>> +    free(line);
>>> +    return ret;
>>>  }
>>>
>>>  /*
>>>
>>
>>
>>
>> .
>>
>
>
> .
>


