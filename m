Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89577C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669A12064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfF1CmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:42:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfF1CmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:42:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5CDEC5EA8D2C2FE829FE;
        Fri, 28 Jun 2019 10:42:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 10:42:04 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate blocks for pinned file
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190627170504.71700-1-jaegeuk@kernel.org>
 <f64cdddd-807e-2918-744b-56ced47a94dd@huawei.com>
 <20190628021551.GA10489@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a8bfab96-f98f-c637-8ba0-caf702080b6f@huawei.com>
Date:   Fri, 28 Jun 2019 10:42:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190628021551.GA10489@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/28 10:15, Jaegeuk Kim wrote:
> On 06/28, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2019/6/28 1:05, Jaegeuk Kim wrote:
>>> This patch allows fallocate to allocate physical blocks for pinned file.
>>
>> Quoted from manual of fallocate(2):
>> "
>> Any subregion within the range specified by offset and len that did not contain
>> data before the  call  will  be  initialized  to zero.
>>
>> If  the  FALLOC_FL_KEEP_SIZE  flag  is specified in mode .... Preallocating
>> zeroed blocks beyond the end of the file in this manner is useful for optimizing
>> append workloads.
>> "
>>
>> As quoted description, our change may break the rule of fallocate(, mode = 0),
>> because with after this change, we can't guarantee that preallocated physical
>> block contains zeroed data
>>
>> Should we introduce an additional ioctl for this case? Or maybe add one more
>> flag in fallocate() for unzeroed block preallocation, not sure.
> 
> I thought like that, but this is a very corner case for the pinned file only in
> f2fs. And, the pinned file is also indeed used by this purpose.

Okay, I think we need to find one place to document such behavior that is not
matching regular poxis fallocate's sematic, user should be noticed about it.

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/file.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index e7c368db8185..cdfd4338682d 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1528,7 +1528,12 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>>>  	if (off_end)
>>>  		map.m_len++;
>>>  
>>> -	err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
>>> +	if (f2fs_is_pinned_file(inode))
>>> +		map.m_seg_type = CURSEG_COLD_DATA;
>>> +
>>> +	err = f2fs_map_blocks(inode, &map, 1, (f2fs_is_pinned_file(inode) ?
>>> +						F2FS_GET_BLOCK_PRE_DIO :
>>> +						F2FS_GET_BLOCK_PRE_AIO));
>>>  	if (err) {
>>>  		pgoff_t last_off;
>>>  
>>>
> .
> 
