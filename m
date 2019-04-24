Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C53020835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfDXHO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:14:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:56692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfDXHO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:14:26 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 8209FB1B41D55C96FEDA;
        Wed, 24 Apr 2019 15:14:23 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 24 Apr 2019 15:14:22 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 24 Apr 2019 15:14:22 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: allow unfixed
 f2fs_checkpoint.checksum_offset
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190422093353.61014-1-yuchao0@huawei.com>
 <20190423204351.GA87257@jaegeuk-macbookpro.roam.corp.google.com>
 <20190423205619.GB87257@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a2bf9e24-2c33-b9cd-c214-2887f7f099ba@huawei.com>
Date:   Wed, 24 Apr 2019 15:14:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190423205619.GB87257@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/24 4:56, Jaegeuk Kim wrote:
> On 04/23, Jaegeuk Kim wrote:
>> On 04/22, Chao Yu wrote:
>>> Previously, f2fs_checkpoint.checksum_offset points fixed position of
>>> f2fs_checkpoint structure:
>>>
>>> "#define CP_CHKSUM_OFFSET	4092"
>>>
>>> It is unnecessary, and it breaks the consecutiveness of nat and sit
>>> bitmap stored across checkpoint park block and payload blocks.
>>>
>>> This patch allows f2fs to handle unfixed .checksum_offset.
>>>
>>> In addition, for the case checksum value is stored in the middle of
>>> checkpoint park, calculating checksum value with superposition method
>>> like we did for inode_checksum.
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>  fs/f2fs/checkpoint.c    | 27 +++++++++++++++++++++------
>>>  include/linux/f2fs_fs.h |  4 ++++
>>>  2 files changed, 25 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 441814607b13..a25556aef8cc 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -794,13 +794,27 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
>>>  	}
>>>  }
>>>  
>>> +static __u32 f2fs_checkpoint_chksum(struct f2fs_sb_info *sbi,
>>> +						struct f2fs_checkpoint *ckpt)
>>> +{
>>> +	unsigned int chksum_ofs = le32_to_cpu(ckpt->checksum_offset);
>>> +	__u32 chksum;
>>> +
>>> +	chksum = f2fs_crc32(sbi, ckpt, chksum_ofs);
>>> +	if (chksum_ofs < CP_CHKSUM_OFFSET) {
>>> +		chksum_ofs += sizeof(chksum);
>>> +		chksum = f2fs_chksum(sbi, chksum, (__u8 *)ckpt + chksum_ofs,
>>> +						F2FS_BLKSIZE - chksum_ofs);
>>
>> Do we need to cover __cp_payload(sbi) * blksize - chksum_ofs?
> 
> Self answer - it'd be fine to get 4KB only, since payload will be covered
> by entire checkpoint pack.

Yup, ;)

Thanks,

> 
>>
>>> +	}
>>> +	return chksum;
>>> +}
>>> +
>>>  static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>>>  		struct f2fs_checkpoint **cp_block, struct page **cp_page,
>>>  		unsigned long long *version)
>>>  {
>>> -	unsigned long blk_size = sbi->blocksize;
>>>  	size_t crc_offset = 0;
>>> -	__u32 crc = 0;
>>> +	__u32 crc;
>>>  
>>>  	*cp_page = f2fs_get_meta_page(sbi, cp_addr);
>>>  	if (IS_ERR(*cp_page))
>>> @@ -809,15 +823,16 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>>>  	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
>>>  
>>>  	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
>>> -	if (crc_offset > (blk_size - sizeof(__le32))) {
>>> +	if (crc_offset < CP_MIN_CHKSUM_OFFSET ||
>>> +			crc_offset > CP_CHKSUM_OFFSET) {
>>>  		f2fs_put_page(*cp_page, 1);
>>>  		f2fs_msg(sbi->sb, KERN_WARNING,
>>>  			"invalid crc_offset: %zu", crc_offset);
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	crc = cur_cp_crc(*cp_block);
>>> -	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
>>> +	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
>>> +	if (crc != cur_cp_crc(*cp_block)) {
>>>  		f2fs_put_page(*cp_page, 1);
>>>  		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
>>>  		return -EINVAL;
>>> @@ -1425,7 +1440,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
>>>  	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
>>>  
>>> -	crc32 = f2fs_crc32(sbi, ckpt, le32_to_cpu(ckpt->checksum_offset));
>>> +	crc32 = f2fs_checkpoint_chksum(sbi, ckpt);
>>>  	*((__le32 *)((unsigned char *)ckpt +
>>>  				le32_to_cpu(ckpt->checksum_offset)))
>>>  				= cpu_to_le32(crc32);
>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>> index 55da9abed023..65559900d4d7 100644
>>> --- a/include/linux/f2fs_fs.h
>>> +++ b/include/linux/f2fs_fs.h
>>> @@ -164,6 +164,10 @@ struct f2fs_checkpoint {
>>>  	unsigned char sit_nat_version_bitmap[1];
>>>  } __packed;
>>>  
>>> +#define CP_CHKSUM_OFFSET	4092	/* default chksum offset in checkpoint */
>>> +#define CP_MIN_CHKSUM_OFFSET						\
>>> +	(offsetof(struct f2fs_checkpoint, sit_nat_version_bitmap))
>>> +
>>>  /*
>>>   * For orphan inode management
>>>   */
>>> -- 
>>> 2.18.0.rc1
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
