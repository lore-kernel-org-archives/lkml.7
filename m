Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21139C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1C621842
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfG2HUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:20:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfG2HUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:20:40 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BCCAF10CE33B05C4950F;
        Mon, 29 Jul 2019 15:20:38 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 15:20:37 +0800
Subject: Re: [PATCH v2] f2fs: separate NOCoW and pinfile semantics
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190719073903.9138-1-yuchao0@huawei.com>
 <20190723023640.GC60778@jaegeuk-macbookpro.roam.corp.google.com>
 <d4d064a2-2b3c-3536-6488-39e7cfdb1ea4@huawei.com>
 <20190729055738.GA95664@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <07cd3aba-3516-9ba5-286e-277abb98e244@huawei.com>
Date:   Mon, 29 Jul 2019 15:20:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190729055738.GA95664@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/29 13:57, Jaegeuk Kim wrote:
> On 07/23, Chao Yu wrote:
>> On 2019/7/23 10:36, Jaegeuk Kim wrote:
>>> On 07/19, Chao Yu wrote:
>>>> Pinning a file is heavy, because skipping pinned files make GC
>>>> running with heavy load or no effect.
>>>
>>> Pinned file is a part of NOCOW files, so I don't think we can simply drop it
>>> for backward compatibility.
>>
>> Yes,
>>
>> But what I concerned is that pin file is too heavy, so in order to satisfy below
>> demand, how about introducing pin_file_2 flag to triggering IPU only during
>> flush/writeback.
> 
> That can be done by cold files?

Then it may inherit property of cold type file, e.g. a) goes into cold area; b)
update with very low frequency.

Actually pin_file_2 could be used by db-wal/log file, which are updated
frequently, and should go to hot/warm area, it does not match above two property.

Thank,

> 
>>
>>>
>>>>
>>>> So that this patch propose to separate nocow and pinfile semantics:
>>>> - NOCoW flag can only be set on regular file.
>>>> - NOCoW file will only trigger IPU at common writeback/flush.
>>>> - NOCow file will do OPU during GC.
>>>>
>>>> For the demand of 1) avoid fragment of file's physical block and
>>>> 2) userspace don't care about file's specific physical address,
>>>> tagging file as NOCoW will be cheaper than pinned one.
>>
>> ^^^
>>
>> Thanks,
>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>> v2:
>>>> - rebase code to fix compile error.
>>>>  fs/f2fs/data.c |  3 ++-
>>>>  fs/f2fs/f2fs.h |  1 +
>>>>  fs/f2fs/file.c | 22 +++++++++++++++++++---
>>>>  3 files changed, 22 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index a2a28bb269bf..15fb8954c363 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -1884,7 +1884,8 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>>>>  
>>>>  bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
>>>>  {
>>>> -	if (f2fs_is_pinned_file(inode))
>>>> +	if (f2fs_is_pinned_file(inode) ||
>>>> +			F2FS_I(inode)->i_flags & F2FS_NOCOW_FL)
>>>>  		return true;
>>>>  
>>>>  	/* if this is cold file, we should overwrite to avoid fragmentation */
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 596ab3e1dd7b..f6c5a3d2e659 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -2374,6 +2374,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>>>>  #define F2FS_NOATIME_FL			0x00000080 /* do not update atime */
>>>>  #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
>>>>  #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
>>>> +#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
>>>>  #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
>>>>  
>>>>  /* Flags that should be inherited by new inodes from their parent. */
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index 7ca545874060..ae0fec54cac6 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -1692,6 +1692,7 @@ static const struct {
>>>>  	{ F2FS_NOATIME_FL,	FS_NOATIME_FL },
>>>>  	{ F2FS_INDEX_FL,	FS_INDEX_FL },
>>>>  	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
>>>> +	{ F2FS_NOCOW_FL,	FS_NOCOW_FL },
>>>>  	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
>>>>  };
>>>>  
>>>> @@ -1715,7 +1716,8 @@ static const struct {
>>>>  		FS_NODUMP_FL |		\
>>>>  		FS_NOATIME_FL |		\
>>>>  		FS_DIRSYNC_FL |		\
>>>> -		FS_PROJINHERIT_FL)
>>>> +		FS_PROJINHERIT_FL |	\
>>>> +		FS_NOCOW_FL)
>>>>  
>>>>  /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
>>>>  static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
>>>> @@ -1753,8 +1755,6 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
>>>>  		fsflags |= FS_ENCRYPT_FL;
>>>>  	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
>>>>  		fsflags |= FS_INLINE_DATA_FL;
>>>> -	if (is_inode_flag_set(inode, FI_PIN_FILE))
>>>> -		fsflags |= FS_NOCOW_FL;
>>>>  
>>>>  	fsflags &= F2FS_GETTABLE_FS_FL;
>>>>  
>>>> @@ -1794,6 +1794,22 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
>>>>  	if (ret)
>>>>  		goto out;
>>>>  
>>>> +	if ((fsflags ^ old_fsflags) & FS_NOCOW_FL) {
>>>> +		if (!S_ISREG(inode->i_mode)) {
>>>> +			ret = -EINVAL;
>>>> +			goto out;
>>>> +		}
>>>> +
>>>> +		if (f2fs_should_update_outplace(inode, NULL)) {
>>>> +			ret = -EINVAL;
>>>> +			goto out;
>>>> +		}
>>>> +
>>>> +		ret = f2fs_convert_inline_inode(inode);
>>>> +		if (ret)
>>>> +			goto out;
>>>> +	}
>>>> +
>>>>  	ret = f2fs_setflags_common(inode, iflags,
>>>>  			f2fs_fsflags_to_iflags(F2FS_SETTABLE_FS_FL));
>>>>  out:
>>>> -- 
>>>> 2.18.0.rc1
>>> .
>>>
> .
> 
