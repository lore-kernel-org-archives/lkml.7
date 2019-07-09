Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6DEC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08F3216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562649075;
	bh=9a0/TdkdAwOfuiX8hAnAaCfx0WMSxTnhXh1MNmLUKnM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=VS27zd4KPfUvY7IhCfmk4Mhnycw5qHo+qtCU/I+qEEBKe9U7lAtld4HEpC+SmFmI2
	 JoieTXp2UiFHiMm6FY53YlW/nDWuoteGoreA+PasfXmqYoz/cfdVunDZeAVevwoH2p
	 utYGRhlNuqYiKcEoEQpN4cBNDVGDkASHikgGVFuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGIFLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfGIFLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:11:13 -0400
Received: from [192.168.0.101] (unknown [49.65.245.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4164E2166E;
        Tue,  9 Jul 2019 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562649073;
        bh=9a0/TdkdAwOfuiX8hAnAaCfx0WMSxTnhXh1MNmLUKnM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0boYBNg1LeeIlzWKJ7/LVu975Uykz8MHdNdYWn59kwhOmWM8N2r/jV4lo4skyTe5j
         UWfH7+iCuKgAjD5lDk6X6Mp99bWvmiHHonzrfuy7dKDsWiJ+Psp4CogCPF8OiBwzUx
         aYl0n/8xlwMfDr5klGYA6scd1Ma1f4rMpxayz90g=
Subject: Re: [PATCH] f2fs: improve print log in f2fs_sanity_check_ckpt()
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Park Ju Hyung <qkrwngud825@gmail.com>
References: <20190708062912.104815-1-yuchao0@huawei.com>
 <20190708234743.GC21769@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2d0f938a-94d2-2c1c-9c80-aa7a1c0dd4bb@kernel.org>
Date:   Tue, 9 Jul 2019 13:11:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190708234743.GC21769@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-7-9 7:47, Jaegeuk Kim wrote:
> On 07/08, Chao Yu wrote:
>> As Park Ju Hyung suggested:
>>
>> "I'd like to suggest to write down an actual version of f2fs-tools
>> here as we've seen older versions of fsck doing even more damage
>> and the users might not have the latest f2fs-tools installed."
>>
>> This patch give a more detailed info of how we fix such corruption
>> to user to avoid damageable repair with low version fsck.
>>
>> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 019422a0844c..3cd6c8d810f9 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2737,7 +2737,8 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>  
>>  	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
>>  		le32_to_cpu(ckpt->checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
>> -		f2fs_warn(sbi, "layout of large_nat_bitmap is deprecated, run fsck to repair, chksum_offset: %u",
>> +		f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap, "
>> +			  "please run fsck v1.13.0 or higher to repair, chksum_offset: %u",
> 
> How about adding the patch name as well?

For end-user, I think they don't care about commit id or patch title...

But anyway, let me send v2 as you suggested, either one is okay to me.

Thanks,

> 
>>  			  le32_to_cpu(ckpt->checksum_offset));
>>  		return 1;
>>  	}
>> -- 
>> 2.18.0.rc1
