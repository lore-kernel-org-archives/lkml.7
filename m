Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128A7C4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 01:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FBA20830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 01:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfIPBXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 21:23:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728872AbfIPBXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 21:23:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AD0EDE2B2C97BAF21A9E;
        Mon, 16 Sep 2019 09:23:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 16 Sep
 2019 09:23:06 +0800
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
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <27725e65-53fe-5731-0201-9959b8ef6b49@huawei.com>
Date:   Mon, 16 Sep 2019 09:22:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190909120443.GA31108@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/9 20:04, Jaegeuk Kim wrote:
> On 09/09, Chao Yu wrote:
>> On 2019/9/9 16:06, Jaegeuk Kim wrote:
>>> On 09/09, Chao Yu wrote:
>>>> On 2019/9/9 9:25, Jaegeuk Kim wrote:
>>>>> GC must avoid select the same victim again.
>>>>
>>>> Blocks in previous victim will occupy addition free segment, I doubt after this
>>>> change, FGGC may encounter out-of-free space issue more frequently.
>>>
>>> Hmm, actually this change seems wrong by sec_usage_check().
>>> We may be able to avoid this only in the suspicious loop?
>>>
>>> ---
>>>  fs/f2fs/gc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index e88f98ddf396..5877bd729689 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1326,7 +1326,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>  		round++;
>>>  	}
>>>  
>>> -	if (gc_type == FG_GC)
>>> +	if (gc_type == FG_GC && seg_freed)
>>
>> That's original solution Sahitya provided to avoid infinite loop of GC, but I
>> suggest to find the root cause first, then we added .invalid_segmap for that
>> purpose.
> 
> I've checked the Sahitya's patch. So, it seems the problem can happen due to
> is_alive or atomic_file.

For some conditions, this doesn't help, for example, two sections contain the
same fewest valid blocks, it will cause to loop selecting them if it fails to
migrate blocks.

How about keeping it as it is to find potential bug.

Thanks,

> 
>>
>> Thanks,
>>
>>>  		sbi->cur_victim_sec = NULL_SEGNO;
>>>  
>>>  	if (sync)
>>>
> .
> 
