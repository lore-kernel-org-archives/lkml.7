Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C6AC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8D720880
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391759AbfIQBmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:42:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728211AbfIQBmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:42:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2CBF6CCC4611D44823A1;
        Tue, 17 Sep 2019 09:42:34 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 17 Sep
 2019 09:42:33 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: do not select same victim right
 again
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190909012532.20454-1-jaegeuk@kernel.org>
 <69933b7f-48cc-47f9-ba6f-b5ca8f733cba@huawei.com>
 <20190909080654.GD21625@jaegeuk-macbookpro.roam.corp.google.com>
 <97237da2-897a-8420-94de-812e94aa751f@huawei.com>
 <20190909120443.GA31108@jaegeuk-macbookpro.roam.corp.google.com>
 <27725e65-53fe-5731-0201-9959b8ef6b49@huawei.com>
 <20190916153736.GA2493@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ab9561c9-db27-2967-e6fc-accd9bc58747@huawei.com>
Date:   Tue, 17 Sep 2019 09:42:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190916153736.GA2493@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/16 23:37, Jaegeuk Kim wrote:
> On 09/16, Chao Yu wrote:
>> On 2019/9/9 20:04, Jaegeuk Kim wrote:
>>> On 09/09, Chao Yu wrote:
>>>> On 2019/9/9 16:06, Jaegeuk Kim wrote:
>>>>> On 09/09, Chao Yu wrote:
>>>>>> On 2019/9/9 9:25, Jaegeuk Kim wrote:
>>>>>>> GC must avoid select the same victim again.
>>>>>>
>>>>>> Blocks in previous victim will occupy addition free segment, I doubt after this
>>>>>> change, FGGC may encounter out-of-free space issue more frequently.
>>>>>
>>>>> Hmm, actually this change seems wrong by sec_usage_check().
>>>>> We may be able to avoid this only in the suspicious loop?
>>>>>
>>>>> ---
>>>>>  fs/f2fs/gc.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index e88f98ddf396..5877bd729689 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -1326,7 +1326,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>>  		round++;
>>>>>  	}
>>>>>  
>>>>> -	if (gc_type == FG_GC)
>>>>> +	if (gc_type == FG_GC && seg_freed)
>>>>
>>>> That's original solution Sahitya provided to avoid infinite loop of GC, but I
>>>> suggest to find the root cause first, then we added .invalid_segmap for that
>>>> purpose.
>>>
>>> I've checked the Sahitya's patch. So, it seems the problem can happen due to
>>> is_alive or atomic_file.
>>
>> For some conditions, this doesn't help, for example, two sections contain the
>> same fewest valid blocks, it will cause to loop selecting them if it fails to
>> migrate blocks.
>>
>> How about keeping it as it is to find potential bug.
> 
> I think it'd be fine to merge this. Could you check the above scenario in more
> detail?

I haven't saw this in real scenario yet.

What I mean is if there is a bug (maybe in is_alive()) failing us to GC on one
section, when that bug happens in two candidates, there could be the same
condition that GC will run into loop (select A, fail to migrate; select B, fail
to migrate, select A...).

But I guess the benefit of this change is, if FGGC fails to migrate block due to
i_gc_rwsem race, selecting another section and later retrying previous one may
avoid lock race, right?

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>  		sbi->cur_victim_sec = NULL_SEGNO;
>>>>>  
>>>>>  	if (sync)
>>>>>
>>> .
>>>
> .
> 
