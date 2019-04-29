Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D86C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E225620675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556547244;
	bh=xf6NipygRwz8sNGT+uqf5PgnOsEKfKT1vm3IZ3bunjM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=m/ZhZKTSGh68dX3Jp+EnA/BUvsoyWB2F7tgQBUUHfVatZl7DodbArqUUbGboDAcgP
	 qhS+lH97RhX0Wmyji2v2K8wq6nUBlJFqOpjK4sTzAUtQbWdZ8hUp6g3pHWSv3Tls/S
	 sTkV35ctBEFTdjEDFxkSnunluL/WFjoyNCU+kvyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfD2OOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbfD2OOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:14:02 -0400
Received: from [192.168.0.101] (unknown [58.212.133.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D6320652;
        Mon, 29 Apr 2019 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556547241;
        bh=xf6NipygRwz8sNGT+uqf5PgnOsEKfKT1vm3IZ3bunjM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dso4WA3f9LnwH+OyLKzx9gjPszb+OcJsevJ1VxlQW5cC4aDph7RORwuDlkB86eNA8
         q/XDB8hJuEdwfD5rG8Fs5+ks4fTIp4o4MBiK1yNfIwPHETyf9GmAKyiUVj84nByrBk
         2x5gEM1+/soBwQiUPiA+Nykh6NB86t3bieQfx24c=
Subject: Re: [PATCH 1/2] f2fs: fix to avoid potential negative .f_bfree
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, drosen@google.com
References: <20190426095754.85784-1-yuchao0@huawei.com>
 <20190428134722.GC37346@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f8b890b8-22a3-bead-7df5-6ab87deb56e9@kernel.org>
Date:   Mon, 29 Apr 2019 22:13:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190428134722.GC37346@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-4-28 21:47, Jaegeuk Kim wrote:
> On 04/26, Chao Yu wrote:
>> When calculating .f_bfree value in f2fs_statfs(), sbi->unusable_block_count
>> can be increased after the judgment condition, result in overflow of
>> .f_bfree in later calculation. This patch fixes to use a temporary signed
>> variable to save the calculation result of .f_bfree.
>>
>> 	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
>>  		buf->f_bfree = 0;
>>  	else
>> 		buf->f_bfree -= sbi->unusable_block_count;
> 
> Do we just need stat_lock for this?

Like we access other stat value in statfs(), we just need the instantaneous
value of .unusable_block_count, so we don't need additional stat_lock, right?

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 2376bb01b5c4..fcc9793dbc2c 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1216,6 +1216,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
>>  	block_t total_count, user_block_count, start_count;
>>  	u64 avail_node_count;
>> +	long long bfree;
>>  
>>  	total_count = le64_to_cpu(sbi->raw_super->block_count);
>>  	user_block_count = sbi->user_block_count;
>> @@ -1226,10 +1227,12 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  	buf->f_blocks = total_count - start_count;
>>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
>>  						sbi->current_reserved_blocks;
>> -	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
>> +
>> +	bfree = buf->f_bfree - sbi->unusable_block_count;
>> +	if (unlikely(bfree < 0))
>>  		buf->f_bfree = 0;
>>  	else
>> -		buf->f_bfree -= sbi->unusable_block_count;
>> +		buf->f_bfree = bfree;
>>  
>>  	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
>>  		buf->f_bavail = buf->f_bfree -
>> -- 
>> 2.18.0.rc1
