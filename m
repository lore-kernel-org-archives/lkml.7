Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F10C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E77B21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGDHLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:11:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49892 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfGDHLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:11:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4BE55896A52E89EC3414;
        Thu,  4 Jul 2019 15:11:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 4 Jul 2019
 15:11:28 +0800
Subject: Re: [PATCH v2] f2fs: avoid out-of-range memory access
To:     Ocean Chen <oceanchen@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190702080503.175149-1-oceanchen@google.com>
 <cfcd3737-3b03-87fe-39e8-566e545cab3a@huawei.com>
 <20190703150355.GA182283@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <65e4ad7b-ffbc-d5c9-9a0f-0532f4c4f5a9@huawei.com>
Date:   Thu, 4 Jul 2019 15:11:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190703150355.GA182283@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ocean,

On 2019/7/3 23:03, Ocean Chen wrote:
> Hi Yu Chao,
> 
> The cur_data_segno only was checked in mount process. In terms of
> security concern, it's better to check value before using it. I know the

Could you explain more about security concern.. Do you get any report from user
or tools that complaining f2fs issue/codes?

I'm not against sanity check for basic core data of filesystem in run-time, but,
in order to troubleshoot root cause of this issue we can trigger panic directly
to dump more info under F2FS_CHECK_FS macro.

So, maybe we can change as below?

blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
+if (blk_off > ENTRIES_IN_SUM) {
+	f2fs_bug_on(1);
+	f2fs_put_page(page, 1);
+	return -EFAULT;
+}

Thanks,

> risk is low. IMHO, it can be safer.
> BTW, I found we can only check blk_off before for loop instead of
> checking 'j' in each iteratoin.
> 
> On Wed, Jul 03, 2019 at 10:07:11AM +0800, Chao Yu wrote:
>> Hi Ocean,
>>
>> If filesystem is corrupted, it should fail mount due to below check in
>> f2fs_sanity_check_ckpt(), so we are safe in read_compacted_summaries() to access
>> entries[0,blk_off], right?
>>
>> 	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
>> 		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
>> 			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
>> 			return 1;
>>
>> Thanks,
>>
>> On 2019/7/2 16:05, Ocean Chen wrote:
>>> blk_off might over 512 due to fs corrupt.
>>> Use ENTRIES_IN_SUM to protect invalid memory access.
>>>
>>> v2:
>>> - fix typo
>>> Signed-off-by: Ocean Chen <oceanchen@google.com>
>>> ---
>>>  fs/f2fs/segment.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 8dee063c833f..a5e8af0bd62e 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
>>>  
>>>  		for (j = 0; j < blk_off; j++) {
>>>  			struct f2fs_summary *s;
>>> +			if (j >= ENTRIES_IN_SUM)
>>> +				return -EFAULT;
>>>  			s = (struct f2fs_summary *)(kaddr + offset);
>>>  			seg_i->sum_blk->entries[j] = *s;
>>>  			offset += SUMMARY_SIZE;
>>>
> .
> 
