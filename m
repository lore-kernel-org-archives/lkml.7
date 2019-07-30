Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E17C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A3D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfG3Mfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:35:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfG3Mfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:35:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8BD895BB8DA0E72D615D;
        Tue, 30 Jul 2019 20:35:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 30 Jul
 2019 20:35:47 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix indefinite loop in f2fs_gc()
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <chao@kernel.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1564377626-12898-1-git-send-email-stummala@codeaurora.org>
 <a5acb5cb-2e77-902f-0a5e-063f7cbd0643@kernel.org>
 <20190730043630.GG8289@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <609a502b-1e7f-c9b2-e864-421ffeda298b@huawei.com>
Date:   Tue, 30 Jul 2019 20:35:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190730043630.GG8289@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2019/7/30 12:36, Sahitya Tummala wrote:
> Hi Chao,
> 
> On Tue, Jul 30, 2019 at 12:00:45AM +0800, Chao Yu wrote:
>> Hi Sahitya,
>>
>> On 2019-7-29 13:20, Sahitya Tummala wrote:
>>> Policy - foreground GC, LFS mode and greedy GC mode.
>>>
>>> Under this policy, f2fs_gc() loops forever to GC as it doesn't have
>>> enough free segements to proceed and thus it keeps calling gc_more
>>> for the same victim segment.  This can happen if the selected victim
>>> segment could not be GC'd due to failed blkaddr validity check i.e.
>>> is_alive() returns false for the blocks set in current validity map.
>>>
>>> Fix this by not resetting the sbi->cur_victim_sec to NULL_SEGNO, when
>>> the segment selected could not be GC'd. This helps to select another
>>> segment for GC and thus helps to proceed forward with GC.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>>  fs/f2fs/gc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 8974672..7bbcc4a 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1303,7 +1303,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>  		round++;
>>>  	}
>>>  
>>> -	if (gc_type == FG_GC)
>>> +	if (gc_type == FG_GC && seg_freed)
>>>  		sbi->cur_victim_sec = NULL_SEGNO;
>>
>> In some cases, we may remain last victim in sbi->cur_victim_sec, and jump out of
>> GC cycle, then SSR can skip the last victim due to sec_usage_check()...
>>
> 
> I see. I have a few questions on how to fix this issue. Please share your
> comments.
> 
> 1. Do you think the scenario described is valid? It happens rarely, not very

IIRC, we suffered endless gc loop due to there is valid block belong to an
opened atomic write file. (because we will skip directly once we hit atomic file)

For your case, I'm not sure that would happen, did you look into is_alive(), why
will it fail? block address not match? If so, it looks like summary info and
dnode block and nat entry are inconsistent.

> easy to reproduce.  From the dumps, I see that only block is set as valid in
> the sentry->cur_valid_map for which I see that summary block check is_alive()
> could return false. As only one block is set as valid, chances are there it
> can be always selected as the victim by get_victim_by_default() under FG_GC.
> 
> 2. What are the possible scenarios where summary block check is_alive() could
> fail for a segment?

I guess, maybe after check_valid_map(), the block is been truncated before
is_alive(). If so the victim should be prefree directly instead of being
selected again...

> 
> 3. How does GC handle such segments?

I think that's not a normal case, or I'm missing something.

Thanks,

> 
> Thanks,
> 
>> Thanks,
>>
>>>  
>>>  	if (sync)
>>>
> 
