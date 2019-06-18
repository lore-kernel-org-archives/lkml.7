Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7208C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBB420665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfFRHBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:01:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfFRHBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:01:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 97DBE610982C05AA1866;
        Tue, 18 Jun 2019 15:01:38 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 15:01:37 +0800
Subject: Re: [PATCH 4.19 034/118] f2fs: fix to avoid panic in
 f2fs_inplace_write_data()
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Sasha Levin" <sashal@kernel.org>
References: <20190613075643.642092651@linuxfoundation.org>
 <20190613075645.482628218@linuxfoundation.org> <20190616195430.GC6676@amd>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <73f254f6-c74d-fccb-2531-7b2951a2a418@huawei.com>
Date:   Tue, 18 Jun 2019 15:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190616195430.GC6676@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 2019/6/17 3:54, Pavel Machek wrote:
> Hi!
> 
>> [ Upstream commit 05573d6ccf702df549a7bdeabef31e4753df1a90 ]
>>
>> As Jungyeon reported in bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=203239
>>
>> - Overview
>> When mounting the attached crafted image and running program, following errors are reported.
>> Additionally, it hangs on sync after running program.
>>
>> The image is intentionally fuzzed from a normal f2fs image for testing.
>> Compile options for F2FS are as follows.
>> CONFIG_F2FS_FS=y
> ...
>> The reason is f2fs_inplace_write_data() will trigger kernel panic due
>> to data block locates in node type segment.
>>
>> To avoid panic, let's just return error code and set SBI_NEED_FSCK to
>> give a hint to fsck for latter repairing.
> 
>> index 03fa2c4d3d79..8fc3edb6760c 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3069,13 +3069,18 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>>  {
>>  	int err;
>>  	struct f2fs_sb_info *sbi = fio->sbi;
>> +	unsigned int segno;
>>  
>>  	fio->new_blkaddr = fio->old_blkaddr;
>>  	/* i/o temperature is needed for passing down write hints */
>>  	__get_segment_type(fio);
>>  
>> -	f2fs_bug_on(sbi, !IS_DATASEG(get_seg_entry(sbi,
>> -			GET_SEGNO(sbi, fio->new_blkaddr))->type));
>> +	segno = GET_SEGNO(sbi, fio->new_blkaddr);
>> +
>> +	if (!IS_DATASEG(get_seg_entry(sbi, segno)->type)) {
>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
>> +		return -EFAULT;
>> +	}
>>  
> 
> Would it make sense to print some kind of debug message, as we do in
> the other error cases?

Although it's corner case, I think it will be better to do that, let me add it
in another patch.

Thanks for reminding. :)

Thanks,

> 
> Best regards,
> 									Pavel
> 
