Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615192171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfCMBXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 21:23:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfCMBXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 21:23:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7DDE1CE67EC91307116C;
        Wed, 13 Mar 2019 09:23:37 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Mar 2019
 09:23:34 +0800
Subject: Re: [PATCH v2] f2fs: fix to check inline_xattr_size boundary
 correctly
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190214160825.4973-1-chao@kernel.org>
 <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
 <20190312185057.GB45421@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7b028daf-538e-a10e-6b79-f686021ee899@huawei.com>
Date:   Wed, 13 Mar 2019 09:23:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190312185057.GB45421@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/13 2:50, Jaegeuk Kim wrote:
> On 03/04, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2019/2/15 0:08, Chao Yu wrote:
>>> ---
>>> v2:
>>> - fix lower bound check, inline xattr size should be larger than
>>> xattr_header's size at least.
>>
>> ...
>>
>>> +		if (F2FS_OPTION(sbi).inline_xattr_size <
>>> +			sizeof(struct f2fs_xattr_header) / sizeof(__le32)
>>
>> No sure we should set this low bound as above... now I guess original
>> non-zero check is enough.
>>
>> How do you think of setting inline_xattr_size range as
>> (0, MAX_INLINE_XATTR_SIZE]?
> 
> How about this?

If you think it's necessary to check low bound with size of xattr header,
I'm also okay with that.

And below diff looks good to me, could you please merge this into original one?

Thanks,

> 
> ---
>  fs/f2fs/super.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 42eb5c86330a..96302a428fdc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -821,6 +821,8 @@ static int parse_options(struct super_block *sb, char *options)
>  	}
>  
>  	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
> +		int min_size, max_size;
> +
>  		if (!f2fs_sb_has_extra_attr(sbi) ||
>  			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
>  			f2fs_msg(sb, KERN_ERR,
> @@ -834,15 +836,18 @@ static int parse_options(struct super_block *sb, char *options)
>  					"set with inline_xattr option");
>  			return -EINVAL;
>  		}
> -		if (F2FS_OPTION(sbi).inline_xattr_size <
> -			sizeof(struct f2fs_xattr_header) / sizeof(__le32) ||
> -			F2FS_OPTION(sbi).inline_xattr_size >
> -			DEF_ADDRS_PER_INODE -
> +
> +		min_size = sizeof(struct f2fs_xattr_header) / sizeof(__le32);
> +		max_size = DEF_ADDRS_PER_INODE -
>  			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
>  			DEF_INLINE_RESERVED_SIZE -
> -			MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
> +			MIN_INLINE_DENTRY_SIZE / sizeof(__le32);
> +
> +		if (F2FS_OPTION(sbi).inline_xattr_size < min ||
> +				F2FS_OPTION(sbi).inline_xattr_size > max) {
>  			f2fs_msg(sb, KERN_ERR,
> -					"inline xattr size is out of range");
> +				"inline xattr size is out of range: %d ~ %d",
> +				min, max);
>  			return -EINVAL;
>  		}
>  	}
> 

