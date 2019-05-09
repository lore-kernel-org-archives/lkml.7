Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756BEC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D38216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEIBP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:15:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3005 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfEIBPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:15:55 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id B279296CE9A30478F184;
        Thu,  9 May 2019 09:15:53 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 9 May 2019 09:15:53 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 9 May 2019 09:15:52 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity with enabled features
 in image
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190424094850.118323-1-yuchao0@huawei.com>
 <20190428133802.GB37346@jaegeuk-macbookpro.roam.corp.google.com>
 <373f4633-d331-5cf3-74b7-e982072bc4b4@kernel.org>
 <20190501032242.GA84420@jaegeuk-macbookpro.roam.corp.google.com>
 <3f170d86-e556-13ae-ce19-3bba3944f5fa@huawei.com>
Message-ID: <192bae92-2193-570f-7b50-00334271bd2e@huawei.com>
Date:   Thu, 9 May 2019 09:15:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3f170d86-e556-13ae-ce19-3bba3944f5fa@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/5 10:51, Chao Yu wrote:
> On 2019/5/1 11:22, Jaegeuk Kim wrote:
>> On 04/29, Chao Yu wrote:
>>> On 2019-4-28 21:38, Jaegeuk Kim wrote:
>>>> On 04/24, Chao Yu wrote:
>>>>> This patch fixes to do sanity with enabled features in image, if
>>>>> there are features kernel can not recognize, just fail the mount.
>>>>
>>>> We need to figure out per-feature-based rejection, since some of them can
>>>> be set without layout change.
>>>
>>> So any suggestion on how to implement this?
>>
>> Which features do we need to disallow? When we introduce new features, they
> 
> I guess it should be the new features.
> 
>> didn't hurt the previous flow by checking f2fs_sb_has_###().
> 
> Yes, but new features may use new disk layout, if old kernel handled it with old
> disk layout, there must be problematic.
> 
> e.g. format image with -O extra_attr, and mount it with kernel who don't
> recognize new inode layout.

Jaegeuk,

Any thoughts?

Thanks,

> 
> Thanks,
> 
>>
>>>
>>> Maybe:
>>>
>>> if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 14, 0))
>>> 	check 4.14+ features
>>> else if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 9, 0))
>>> 	check 4.9+ features
>>> else if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 4, 0))
>>> 	check 4.4+ features
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>> ---
>>>>>  fs/f2fs/f2fs.h  | 13 +++++++++++++
>>>>>  fs/f2fs/super.c |  9 +++++++++
>>>>>  2 files changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index f5ffc09705eb..15b640967e12 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -151,6 +151,19 @@ struct f2fs_mount_info {
>>>>>  #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
>>>>>  #define F2FS_FEATURE_SB_CHKSUM		0x0800
>>>>>  
>>>>> +#define F2FS_ALL_FEATURES	(F2FS_FEATURE_ENCRYPT |			\
>>>>> +				F2FS_FEATURE_BLKZONED |			\
>>>>> +				F2FS_FEATURE_ATOMIC_WRITE |		\
>>>>> +				F2FS_FEATURE_EXTRA_ATTR |		\
>>>>> +				F2FS_FEATURE_PRJQUOTA |			\
>>>>> +				F2FS_FEATURE_INODE_CHKSUM |		\
>>>>> +				F2FS_FEATURE_FLEXIBLE_INLINE_XATTR |	\
>>>>> +				F2FS_FEATURE_QUOTA_INO |		\
>>>>> +				F2FS_FEATURE_INODE_CRTIME |		\
>>>>> +				F2FS_FEATURE_LOST_FOUND |		\
>>>>> +				F2FS_FEATURE_VERITY |			\
>>>>> +				F2FS_FEATURE_SB_CHKSUM)
>>>>> +
>>>>>  #define __F2FS_HAS_FEATURE(raw_super, mask)				\
>>>>>  	((raw_super->feature & cpu_to_le32(mask)) != 0)
>>>>>  #define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index 4f8e9ab48b26..57f2fc6d14ba 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -2573,6 +2573,15 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>>>>  		return 1;
>>>>>  	}
>>>>>  
>>>>> +	/* check whether kernel supports all features */
>>>>> +	if (le32_to_cpu(raw_super->feature) & (~F2FS_ALL_FEATURES)) {
>>>>> +		f2fs_msg(sb, KERN_INFO,
>>>>> +			"Unsupported feature:%u: supported:%u",
>>>>> +			le32_to_cpu(raw_super->feature),
>>>>> +			F2FS_ALL_FEATURES);
>>>>> +		return 1;
>>>>> +	}
>>>>> +
>>>>>  	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
>>>>>  	if (sanity_check_area_boundary(sbi, bh))
>>>>>  		return 1;
>>>>> -- 
>>>>> 2.18.0.rc1
>> .
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
