Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD523C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9F920675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556546287;
	bh=zzwvCRjip66ErSWdogjE1z3JyHQPKCTMH76hG95wY1w=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mK6apVQBPbvziZpQN9JAaFcU7RS6sl+RnYWVlPt7QyVWNtkuc5CffZ8wmgMYeM2LF
	 qRQ9UKCA3KUEdX8zU/WxcDQNCVr076b6hmUze+SFg433GfBt6giglOehigIV7wG9mT
	 pjgDy1rXAv9j3bnM77Kgw/wVxjwSUnwXjxEw4xfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfD2N6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfD2N6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:58:06 -0400
Received: from [192.168.0.101] (unknown [58.212.133.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E38320652;
        Mon, 29 Apr 2019 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556546285;
        bh=zzwvCRjip66ErSWdogjE1z3JyHQPKCTMH76hG95wY1w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DdkFCSpiMwzmY3iDUsGsYTswDof5oOHqj60kasboHy0kE0VndEZimiGBYSfWU204S
         9e5fv4bm6bzhFRrmIte5RaP39uJp9Ftbt7Xoa2yr6HHy+SSDfss8MRa74r9KBYVlck
         I2rqUVIFc6M0eZt8uIooocVHfOP9EajhbVgSOikQ=
Subject: Re: [PATCH] f2fs: fix to do sanity with enabled features in image
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20190424094850.118323-1-yuchao0@huawei.com>
 <20190428133802.GB37346@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <373f4633-d331-5cf3-74b7-e982072bc4b4@kernel.org>
Date:   Mon, 29 Apr 2019 21:57:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190428133802.GB37346@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-4-28 21:38, Jaegeuk Kim wrote:
> On 04/24, Chao Yu wrote:
>> This patch fixes to do sanity with enabled features in image, if
>> there are features kernel can not recognize, just fail the mount.
> 
> We need to figure out per-feature-based rejection, since some of them can
> be set without layout change.

So any suggestion on how to implement this?

Maybe:

if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 14, 0))
	check 4.14+ features
else if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 9, 0))
	check 4.9+ features
else if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 4, 0))
	check 4.4+ features

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h  | 13 +++++++++++++
>>  fs/f2fs/super.c |  9 +++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index f5ffc09705eb..15b640967e12 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -151,6 +151,19 @@ struct f2fs_mount_info {
>>  #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
>>  #define F2FS_FEATURE_SB_CHKSUM		0x0800
>>  
>> +#define F2FS_ALL_FEATURES	(F2FS_FEATURE_ENCRYPT |			\
>> +				F2FS_FEATURE_BLKZONED |			\
>> +				F2FS_FEATURE_ATOMIC_WRITE |		\
>> +				F2FS_FEATURE_EXTRA_ATTR |		\
>> +				F2FS_FEATURE_PRJQUOTA |			\
>> +				F2FS_FEATURE_INODE_CHKSUM |		\
>> +				F2FS_FEATURE_FLEXIBLE_INLINE_XATTR |	\
>> +				F2FS_FEATURE_QUOTA_INO |		\
>> +				F2FS_FEATURE_INODE_CRTIME |		\
>> +				F2FS_FEATURE_LOST_FOUND |		\
>> +				F2FS_FEATURE_VERITY |			\
>> +				F2FS_FEATURE_SB_CHKSUM)
>> +
>>  #define __F2FS_HAS_FEATURE(raw_super, mask)				\
>>  	((raw_super->feature & cpu_to_le32(mask)) != 0)
>>  #define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 4f8e9ab48b26..57f2fc6d14ba 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2573,6 +2573,15 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>  		return 1;
>>  	}
>>  
>> +	/* check whether kernel supports all features */
>> +	if (le32_to_cpu(raw_super->feature) & (~F2FS_ALL_FEATURES)) {
>> +		f2fs_msg(sb, KERN_INFO,
>> +			"Unsupported feature:%u: supported:%u",
>> +			le32_to_cpu(raw_super->feature),
>> +			F2FS_ALL_FEATURES);
>> +		return 1;
>> +	}
>> +
>>  	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
>>  	if (sanity_check_area_boundary(sbi, bh))
>>  		return 1;
>> -- 
>> 2.18.0.rc1
