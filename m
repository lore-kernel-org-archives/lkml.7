Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9991C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1522067D
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfHABTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:19:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfHABTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:19:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C43646972140852920FD;
        Thu,  1 Aug 2019 09:19:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019
 09:19:42 +0800
Subject: Re: [PATCH 4.19 077/113] f2fs: avoid out-of-range memory access
To:     Pavel Machek <pavel@denx.de>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, Ocean Chen <oceanchen@google.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20190729190655.455345569@linuxfoundation.org>
 <20190729190714.022413119@linuxfoundation.org> <20190731191115.GB4630@amd>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <15df49ee-0644-39a8-4c76-ed670f62fd62@huawei.com>
Date:   Thu, 1 Aug 2019 09:19:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190731191115.GB4630@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/1 3:11, Pavel Machek wrote:
> Hi!
> 
>> [ Upstream commit 56f3ce675103e3fb9e631cfb4131fc768bc23e9a ]
>>
>> blkoff_off might over 512 due to fs corrupt or security
>> vulnerability. That should be checked before being using.
>>
>> Use ENTRIES_IN_SUM to protect invalid value in cur_data_blkoff.
>>
>> Signed-off-by: Ocean Chen <oceanchen@google.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  fs/f2fs/segment.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 8fc3edb6760c..92f72bb5aff4 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3261,6 +3261,11 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
>>  		seg_i = CURSEG_I(sbi, i);
>>  		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
>>  		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
>> +		if (blk_off > ENTRIES_IN_SUM) {
>> +			f2fs_bug_on(sbi, 1);
>> +			f2fs_put_page(page, 1);
>> +			return -EFAULT;
>> +		}
>>  		seg_i->next_segno = segno;
> 
> We normally use -EUCLEAN to signal filesystem corruption. Plus, it is
> good idea to report it to the syslog and mark filesystem as "needing
> fsck" if filesystem can do that.

Thanks for pointing out this, I missed that restriction during review, since at
that time, my focus is on how that case happen...

Look at this again, I think we also need to add unlikely() keyword hint to
compiler to indicate this should never happen.

Thanks,

> 
> Thanks,
> 									Pavel
> 
