Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9D3C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B9B20821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbfDRBZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:25:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728268AbfDRBZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:25:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6A092368AF0E10907C64;
        Thu, 18 Apr 2019 09:25:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Thu, 18 Apr 2019
 09:25:19 +0800
Subject: Re: [alsa-devel] [PATCH -next] ASoC: Intel: Haswell: Remove set but
 not used variable 'stage_type'
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
References: <20190417151140.20320-1-yuehaibing@huawei.com>
 <ba043cd7-07af-717f-7498-d6bda7d6b79e@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <48184039-4c08-ed17-c933-3b697e4aac08@huawei.com>
Date:   Thu, 18 Apr 2019 09:25:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <ba043cd7-07af-717f-7498-d6bda7d6b79e@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/18 1:41, Pierre-Louis Bossart wrote:
> On 4/17/19 10:11 AM, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
>> sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]
>>
>> It is never used since introduction in
>> commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")
> 
> Thanks for the patch.
> 
> I think you could go further in the cleanup and remove both the variable declaration and the static inline mst_get_stage_type that will also be useless as a consequence of this assignment removal.

You are right.
> 
> Care to send a v2?

Sure, will do that,thanks!
> 
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
>> index 31fcdf12..4d3de99 100644
>> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
>> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
>> @@ -672,7 +672,6 @@ static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
>>         stream_msg = msg_get_stream_type(header);
>>       stream_id = msg_get_stream_id(header);
>> -    stage_type = msg_get_stage_type(header);
>>         stream = get_stream_by_id(hsw, stream_id);
>>       if (stream == NULL)
>>
> 
> 
> .
> 

