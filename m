Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291DCC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82C420663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfHLHQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:16:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45458 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbfHLHQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:16:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B75B594C6662102285B6;
        Mon, 12 Aug 2019 15:15:54 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 12 Aug
 2019 15:15:50 +0800
Subject: Re: [PATCH v3 RESEND] f2fs: introduce sb.required_features to store
 incompatible features
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190801042215.GC84433@jaegeuk-macbookpro.roam.corp.google.com>
 <345c55ea-01c2-a9d1-4367-716dbd08ae9d@huawei.com>
 <20190801223509.GB27597@jaegeuk-macbookpro.roam.corp.google.com>
 <8e906ddb-81d8-b63e-0c19-1ee9fc7f5cbf@huawei.com>
 <20190806003522.GA98101@jaegeuk-macbookpro.roam.corp.google.com>
 <e48514d5-0f3f-8dd7-06ab-b7faf71101ba@huawei.com>
 <20190806012407.GB1029@jaegeuk-macbookpro.roam.corp.google.com>
 <103d1df0-eb5b-4854-0959-a84785eb85a8@huawei.com>
 <20190806021144.GB7280@jaegeuk-macbookpro.roam.corp.google.com>
 <a155121f-2e1b-c3c5-17bb-b5ac3f4a7b1f@huawei.com>
 <20190809152642.GC93481@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <aa25b5eb-bd4d-1236-4320-6df86eeae5ef@huawei.com>
Date:   Mon, 12 Aug 2019 15:15:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190809152642.GC93481@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/9 23:26, Jaegeuk Kim wrote:
> On 08/06, Chao Yu wrote:
>> On 2019/8/6 10:11, Jaegeuk Kim wrote:
>>> On 08/06, Chao Yu wrote:
>>>> On 2019/8/6 9:24, Jaegeuk Kim wrote:
>>>>> On 08/06, Chao Yu wrote:
>>>>>> On 2019/8/6 8:35, Jaegeuk Kim wrote:
>>>>>>> On 08/02, Chao Yu wrote:
>>>>>>>> On 2019/8/2 6:35, Jaegeuk Kim wrote:
>>>>>>>>> On 08/01, Chao Yu wrote:
>>>>>>>>>> On 2019/8/1 12:22, Jaegeuk Kim wrote:
>>>>>>>>>>> On 07/31, Chao Yu wrote:
>>>>>>>>>>>> On 2019/7/31 7:18, Jaegeuk Kim wrote:
>>>>>>>>>>>>> On 07/29, Chao Yu wrote:
>>>>>>>>>>>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Later after this patch was merged, all new incompatible feature's
>>>>>>>>>>>>>> bit should be added into sb.required_features field, and define new
>>>>>>>>>>>>>> feature function with F2FS_INCOMPAT_FEATURE_FUNCS() macro.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Then during mount, we will do sanity check with enabled features in
>>>>>>>>>>>>>> image, if there are features in sb.required_features that kernel can
>>>>>>>>>>>>>> not recognize, just fail the mount.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> v3:
>>>>>>>>>>>>>> - change commit title.
>>>>>>>>>>>>>> - fix wrong macro name.
>>>>>>>>>>>>>>  fs/f2fs/f2fs.h          | 15 +++++++++++++++
>>>>>>>>>>>>>>  fs/f2fs/super.c         | 10 ++++++++++
>>>>>>>>>>>>>>  include/linux/f2fs_fs.h |  3 ++-
>>>>>>>>>>>>>>  3 files changed, 27 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>>>>>>>>> index a6eb828af57f..b8e17d4ddb8d 100644
>>>>>>>>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>>>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>>>>>>>>> @@ -163,6 +163,15 @@ struct f2fs_mount_info {
>>>>>>>>>>>>>>  #define F2FS_CLEAR_FEATURE(sbi, mask)					\
>>>>>>>>>>>>>>  	(sbi->raw_super->feature &= ~cpu_to_le32(mask))
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> +#define F2FS_INCOMPAT_FEATURES		0
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +#define F2FS_HAS_INCOMPAT_FEATURE(sbi, mask)				\
>>>>>>>>>>>>>> +	((sbi->raw_super->required_features & cpu_to_le32(mask)) != 0)
>>>>>>>>>>>>>> +#define F2FS_SET_INCOMPAT_FEATURE(sbi, mask)				\
>>>>>>>>>>>>>> +	(sbi->raw_super->required_features |= cpu_to_le32(mask))
>>>>>>>>>>>>>> +#define F2FS_CLEAR_INCOMPAT_FEATURE(sbi, mask)				\
>>>>>>>>>>>>>> +	(sbi->raw_super->required_features &= ~cpu_to_le32(mask))
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>  /*
>>>>>>>>>>>>>>   * Default values for user and/or group using reserved blocks
>>>>>>>>>>>>>>   */
>>>>>>>>>>>>>> @@ -3585,6 +3594,12 @@ F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
>>>>>>>>>>>>>>  F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
>>>>>>>>>>>>>>  F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> +#define F2FS_INCOMPAT_FEATURE_FUNCS(name, flagname) \
>>>>>>>>>>>>>> +static inline int f2fs_sb_has_##name(struct f2fs_sb_info *sbi) \
>>>>>>>>>>>>>> +{ \
>>>>>>>>>>>>>> +	return F2FS_HAS_INCOMPAT_FEATURE(sbi, F2FS_FEATURE_##flagname); \
>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>>>>>>>>>>>>>  static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
>>>>>>>>>>>>>>  				    block_t blkaddr)
>>>>>>>>>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>>>>>>>>>>> index 5540fee0fe3f..3701dcce90e6 100644
>>>>>>>>>>>>>> --- a/fs/f2fs/super.c
>>>>>>>>>>>>>> +++ b/fs/f2fs/super.c
>>>>>>>>>>>>>> @@ -2513,6 +2513,16 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>>>>>>>>>>>>>  		return -EINVAL;
>>>>>>>>>>>>>>  	}
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> +	/* check whether current kernel supports all features on image */
>>>>>>>>>>>>>> +	if (le32_to_cpu(raw_super->required_features) &
>>>>>>>>>>>>>
>>>>>>>>>>>>> ...
>>>>>>>>>>>>> #define F2FS_FEATURE_VERITY	0x0400	/* reserved */
>>>>>>>>>>>>> ...
>>>>>>>>>>>>> #define F2FS_FEATURE_CASEFOLD	0x1000
>>>>>>>>>>>>> #define F2FS_FEATURE_SUPPORT	0x1BFF
>>>>>>>>>>>>>
>>>>>>>>>>>>> 	if (le32_to_cpu(raw_super->required_features) & ~F2FS_FEATURE_SUPPORT) {
>>>>>>>>>>>>> 		...
>>>>>>>>>>>>> 		return -EINVAL;
>>>>>>>>>>>>> 	}
>>>>>>>>>>>>
>>>>>>>>>>>> Um, I thought .required_features are used to store new feature flags from 0x0.
>>>>>>>>>>>>
>>>>>>>>>>>> All 'F2FS_FEATURE_SUPPORT' bits should be stored in sb.feature instead of
>>>>>>>>>>>> sb.required_features, I'm confused...
>>>>>>>>>>>
>>>>>>>>>>> I'm thinking,
>>>>>>>>>>>
>>>>>>>>>>> f2fs-tools     sb->required_features     f2fs    F2FS_FEATURE_SUPPORT
>>>>>>>>>>> v0             0                         v0      no_check -> ok
>>>>>>>>>>> v1             0x1BFF                    v0      no_check -> ok
>>>>>>>>>>> v0             0                         v1      0x1BFF -> ok
>>>>>>>>>>> v1             0x1BFF                    v1      0x1BFF -> ok
>>>>>>>>>>> v2             0x3BFF                    v1      0x1BFF -> fail
>>>>>>>>>>> v1             0x1BFF                    v2      0x3BFF -> ok
>>>>>>>>>>> v2             0x3BFF                    v2      0x3BFF -> ok
>>>>>>>>>>
>>>>>>>>>> I see, it's a bit waste for 0x1FFF low bits in sb->required_features. Why not
>>>>>>>>>> leaving 0x0FFF in sb->feature w/o sanity check. And make all new incompatible
>>>>>>>>>> features (including casefold) adding into sb->required_features.
>>>>>>>>>
>>>>>>>>> I don't think we can define like this, and we still have 32bits feature filed.
>>>>>>>>> This would give another confusion to understand. VERITY is reserved only now.
>>>>>>>>>
>>>>>>>>> #define F2FS_FEATURE_CASEFOLD		0x0001
>>>>>>>>
>>>>>>>> Oops, so you want to make .required_features being almost a mirror of .feature,
>>>>>>>> and do sanity check on it... I can see now. :P
>>>>>>>>
>>>>>>>> If so, why not just use .feature:
>>>>>>>
>>>>>>> Sometimes, we don't need to set the flag, but not required at some point.
>>>>>>> (e.g., verify)
>>>>>>
>>>>>> Sorry, I'm not sure whether I have understood your point... :(
>>>>>>
>>>>>> IIUC of your point, we have defined F2FS_FEATURE_SUPPORT (0x0BFF) which excludes
>>>>>> F2FS_FEATURE_VERITY (0x0400) feature bit, then once verity feature merged in
>>>>>> kernel, we can add it into F2FS_FEATURE_SUPPORT, any problem we may face here?
>>>>>
>>>>> I was thinking the cases like "don't care features" made by mkfs. For example,
>>>>> mkfs can set F2FS_FEATURE_BLKZONED, which doesn't need f2fs being supported.
>>>>
>>>> Yes, I can understand this.
>>>>
>>>> So F2FS_FEATURE_SUPPORT can exclude them directly?
>>>
>>> No, I'd like to control it via mkfs. Kernel always needs to say what they can
>>> support, IIUC your point.
>>
>> Oh, it's different macros, we will define F2FS_INCOMPAT_FEATURE_SUPPORT 0x19B9,
>> and F2FS_ALL_FEATURE_SUPPORT (0x0001 | 0x0002 ... ).
>>
>> In sanity check function, we only check .feature with
>> F2FS_INCOMPAT_FEATURE_SUPPORT. And of course, meanwhile kernel will say it
>> supports features in F2FS_ALL_FEATURE_SUPPORT.
> 
> Still I don't get the point where we need multiple macros. Why not user just can

We don't have to, but I just meant all supported and incompatible features are
different in kernel side.

> give required_feature in mkfs and check it by kernel later?

Yes, we can, I just doubt that we don't need the field .required_features...

Because .feature has included all features user wanted, and
F2FS_INCOMPAT_FEATURE_SUPPORT has included all features (need layout change)
kernel need to check. I didn't get the point why we need additional field, am I
missing something?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> excluded:
>>>>
>>>> #define F2FS_FEATURE_BLKZONED		0x0002
>>>> #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
>>>> #define F2FS_FEATURE_LOST_FOUND		0x0200
>>>>
>>>> included:
>>>>
>>>> #define F2FS_FEATURE_ENCRYPT		0x0001
>>>> #define F2FS_FEATURE_EXTRA_ATTR		0x0008
>>>> #define F2FS_FEATURE_PRJQUOTA		0x0010
>>>> #define F2FS_FEATURE_INODE_CHKSUM	0x0020
>>>> #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
>>>> #define F2FS_FEATURE_QUOTA_INO		0x0080
>>>> #define F2FS_FEATURE_INODE_CRTIME	0x0100
>>>> #define F2FS_FEATURE_SB_CHKSUM		0x0800
>>>> //#define F2FS_FEATURE_VERITY		0x0400	/* reserved */
>>>> #define F2FS_FEATURE_CASEFOLD		0x1000
>>>>
>>>> #define F2FS_FEATURE_SUPPORT		0x19B9
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> kernel	tool
>>>>>>>> v5.2 .. 1.12
>>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x0BFF
>>>>>>>>
>>>>>>>> v5.3 .. 1.13
>>>>>>>> #define F2FS_FEATURE_CASEFOLD		0x1000
>>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x1BFF
>>>>>>>>
>>>>>>>> v5.4 .. 1.14
>>>>>>>> #define F2FS_FEATURE_CASEFOLD		0x1000
>>>>>>>> #define F2FS_FEATURE_COMPRESS		0x2000
>>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x3BFF
>>>>>>>>
>>>>>>>> f2fs-tools	sb->feature		f2fs	F2FS_FEATURE_SUPPORT
>>>>>>>>
>>>>>>>> [enable all features in tools]
>>>>>>>> v1.12		0x0BFF			v5.2	no_check -> ok
>>>>>>>> v1.12		0x0BFF			v5.3	0x1BFF -> ok
>>>>>>>> v1.12		0x0BFF			v5.4	0x3BFF -> ok
>>>>>>>>
>>>>>>>> v1.13		0x1BFF			v5.2	that's issue we need to fix
>>>>>>>> v1.13		0x1BFF			v5.3	0x1BFF -> ok
>>>>>>>> v1.13		0x1BFF			v5.4	0x3BFF -> ok
>>>>>>>>
>>>>>>>> v1.14		0x3BFF			v5.2	that's issue we need to fix
>>>>>>>> v1.14		0x3BFF			v5.3	0x1BFF -> fail
>>>>>>>> v1.14		0x3BFF			v5.4	0x3BFF -> ok
>>>>>>>>
>>>>>>>> Or am I missing something?
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Then that would be:
>>>>>>>>>>
>>>>>>>>>> kernel	tool
>>>>>>>>>> v5.2 .. 1.12
>>>>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x0000
>>>>>>>>>>
>>>>>>>>>> v5.3 .. 1.13
>>>>>>>>>> #define F2FS_FEATURE_CASEFOLD		0x0001
>>>>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x0001
>>>>>>>>>>
>>>>>>>>>> v5.4 .. 1.14
>>>>>>>>>> #define F2FS_FEATURE_CASEFOLD		0x0001
>>>>>>>>>> #define F2FS_FEATURE_COMPRESS		0x0002
>>>>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x0003
>>>>>>>>>>
>>>>>>>>>> f2fs-tools	sb->required_features	f2fs	F2FS_FEATURE_SUPPORT
>>>>>>>>>>
>>>>>>>>>> v1.12		0x0000			v5.2	no_check -> ok
>>>>>>>>>> v1.12		0x0000			v5.3	0x0001 -> ok
>>>>>>>>>> v1.12		0x0000			v5.4	0x0003 -> ok
>>>>>>>>>>
>>>>>>>>>> v1.13		0x0001			v5.2	that's issue we need to fix
>>>>>>>>>> v1.13		0x0001			v5.3	0x0001 -> ok
>>>>>>>>>> v1.13		0x0001			v5.4	0x0003 -> ok
>>>>>>>>>>
>>>>>>>>>> v1.14		0x0003			v5.2	that's issue we need to fix
>>>>>>>>>> v1.14		0x0003			v5.3	0x0001 -> fail
>>>>>>>>>> v1.14		0x0003			v5.4	0x0003 -> ok
>>>>>>>>>>
>>>>>>>>>> And all compatible features can be added into sb->feature[_VERITY, ....].
>>>>>>>>>>
>>>>>>>>>> Would that okay to you?
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> +			~F2FS_INCOMPAT_FEATURES) {
>>>>>>>>>>>>>> +		f2fs_info(sbi, "Unsupported feature: %x: supported: %x",
>>>>>>>>>>>>>> +			  le32_to_cpu(raw_super->required_features) ^
>>>>>>>>>>>>>> +			  F2FS_INCOMPAT_FEATURES,
>>>>>>>>>>>>>> +			  F2FS_INCOMPAT_FEATURES);
>>>>>>>>>>>>>> +		return -EINVAL;
>>>>>>>>>>>>>> +	}
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>  	/* Check checksum_offset and crc in superblock */
>>>>>>>>>>>>>>  	if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
>>>>>>>>>>>>>>  		crc_offset = le32_to_cpu(raw_super->checksum_offset);
>>>>>>>>>>>>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>>>>>>>>>>>>> index a2b36b2e286f..4141be3f219c 100644
>>>>>>>>>>>>>> --- a/include/linux/f2fs_fs.h
>>>>>>>>>>>>>> +++ b/include/linux/f2fs_fs.h
>>>>>>>>>>>>>> @@ -117,7 +117,8 @@ struct f2fs_super_block {
>>>>>>>>>>>>>>  	__u8 hot_ext_count;		/* # of hot file extension */
>>>>>>>>>>>>>>  	__le16	s_encoding;		/* Filename charset encoding */
>>>>>>>>>>>>>>  	__le16	s_encoding_flags;	/* Filename charset encoding flags */
>>>>>>>>>>>>>> -	__u8 reserved[306];		/* valid reserved region */
>>>>>>>>>>>>>> +	__le32 required_features;       /* incompatible features to old kernel */
>>>>>>>>>>>>>> +	__u8 reserved[302];		/* valid reserved region */
>>>>>>>>>>>>>>  	__le32 crc;			/* checksum of superblock */
>>>>>>>>>>>>>>  } __packed;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> -- 
>>>>>>>>>>>>>> 2.22.0
>>>>>>>>>>>>> .
>>>>>>>>>>>>>
>>>>>>>>>>> .
>>>>>>>>>>>
>>>>>>>>> .
>>>>>>>>>
>>>>>>> .
>>>>>>>
>>>>> .
>>>>>
>>> .
>>>
> .
> 
