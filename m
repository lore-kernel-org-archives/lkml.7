Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8600C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBA222DA7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567466995;
	bh=jktFROyoNclol0SVpnEc3+lR5Zp2bhVwsBQa5fF6h1Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WkUswGuHxkMwprqirMps/Q4GgXuT9TCxCoqMGGmGETzMonGyFsIlKF0EP29qpkNOF
	 HUBDeG2WMDALwVohBvz5mGhz8zbL1M15ZsMJULb4xq8heuovxXD9CVhizhklSTWYfn
	 NVEu2Tnccl7EGCVooPJ54jjkXsiBI43H63hdeINc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfIBX3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 19:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfIBX3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:29:54 -0400
Received: from [192.168.0.102] (unknown [180.111.100.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1949922CF7;
        Mon,  2 Sep 2019 23:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567466993;
        bh=jktFROyoNclol0SVpnEc3+lR5Zp2bhVwsBQa5fF6h1Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kSTXcfElviGkco8WfWy6NIeEmeXTfRASF0B+FJaM1EHkxa8LAqPCFXflw2g8UZ/Ox
         xmp0eSQg2frue27ytelfXXyw63OhSo1SUz//EARj6vx6iURs2ceB8dPCcsoZsQCM2z
         YABV2JfJdUJCF4uXaRBEZVd8bsWzvNjr07j+BLQI=
Subject: Re: [PATCH v2 1/2] f2fs: introduce get_available_block_count() for
 cleanup
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20190831095401.8142-1-yuchao0@huawei.com>
 <20190902225413.GC71929@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <6c5da795-4929-3bb6-fdbf-e103a2bcd431@kernel.org>
Date:   Tue, 3 Sep 2019 07:29:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190902225413.GC71929@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-9-3 6:54, Jaegeuk Kim wrote:
> On 08/31, Chao Yu wrote:
>> There are very similar codes in inc_valid_block_count() and
>> inc_valid_node_count() which is used for available user block
>> count calculation.
>>
>> This patch introduces a new helper get_available_block_count()
>> to include those common codes, and used it instead for cleanup.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - fix panic during recovery
>>  fs/f2fs/f2fs.h | 47 +++++++++++++++++++++++++++--------------------
>>  1 file changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index a89ad8cab821..9c010e6cba5c 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1756,6 +1756,27 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
>>  	return false;
>>  }
>>  
>> +static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
>> +						struct inode *inode, bool cap)
>> +{
>> +	block_t avail_user_block_count;
>> +
>> +	avail_user_block_count = sbi->user_block_count -
>> +					sbi->current_reserved_blocks;
>> +
>> +	if (!__allow_reserved_blocks(sbi, inode, cap))
>> +		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>> +
>> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>> +		if (avail_user_block_count > sbi->unusable_block_count)
>> +			avail_user_block_count -= sbi->unusable_block_count;
>> +		else
>> +			avail_user_block_count = 0;
>> +	}
>> +
>> +	return avail_user_block_count;
>> +}
>> +
>>  static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
>>  static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>>  				 struct inode *inode, blkcnt_t *count)
>> @@ -1782,17 +1803,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>>  
>>  	spin_lock(&sbi->stat_lock);
>>  	sbi->total_valid_block_count += (block_t)(*count);
>> -	avail_user_block_count = sbi->user_block_count -
>> -					sbi->current_reserved_blocks;
>> +	avail_user_block_count = get_available_block_count(sbi, inode, true);
>>  
>> -	if (!__allow_reserved_blocks(sbi, inode, true))
>> -		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>> -		if (avail_user_block_count > sbi->unusable_block_count)
>> -			avail_user_block_count -= sbi->unusable_block_count;
>> -		else
>> -			avail_user_block_count = 0;
>> -	}
>>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>>  		diff = sbi->total_valid_block_count - avail_user_block_count;
>>  		if (diff > *count)
>> @@ -2005,7 +2017,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>  					struct inode *inode, bool is_inode)
>>  {
>>  	block_t	valid_block_count;
>> -	unsigned int valid_node_count, user_block_count;
>> +	unsigned int valid_node_count;
>> +	unsigned int avail_user_block_count;
>>  	int err;
>>  
>>  	if (is_inode) {
>> @@ -2027,16 +2040,10 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>  
>>  	spin_lock(&sbi->stat_lock);
>>  
>> -	valid_block_count = sbi->total_valid_block_count +
>> -					sbi->current_reserved_blocks + 1;
>> -
>> -	if (!__allow_reserved_blocks(sbi, inode, false))
>> -		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
>> -	user_block_count = sbi->user_block_count;
>> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>> -		user_block_count -= sbi->unusable_block_count;
>> +	valid_block_count = sbi->total_valid_block_count + 1;
>> +	avail_user_block_count = get_available_block_count(sbi, inode, false);
> 
> This doesn't look like same?

Actually, calculations of block count in inc_valid_node_count() and
inc_valid_block_count() should be the same, I've no idea why we use different
policy for reserved block for root user.

Thanks,

> 
>>  
>> -	if (unlikely(valid_block_count > user_block_count)) {
>> +	if (unlikely(valid_block_count > avail_user_block_count)) {
>>  		spin_unlock(&sbi->stat_lock);
>>  		goto enospc;
>>  	}
>> -- 
>> 2.18.0.rc1
