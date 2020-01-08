Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B205DC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830D5206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgAHJds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:33:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727224AbgAHJds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:33:48 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E513B71813FFC5664CC6;
        Wed,  8 Jan 2020 17:33:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 Jan 2020
 17:33:41 +0800
Subject: Re: [PATCH 2/4] f2fs: compress: revert error path fix
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200106080144.52363-1-yuchao0@huawei.com>
 <20200106080144.52363-2-yuchao0@huawei.com>
 <20200106192631.GF50058@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d2d21997-42f2-217a-a4cb-66b7fe8ef3e8@huawei.com>
Date:   Wed, 8 Jan 2020 17:33:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200106192631.GF50058@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/7 3:26, Jaegeuk Kim wrote:
> Hi Chao,
> 
> Could you please check this out?
> https://github.com/jaegeuk/f2fs/commits/g-dev-test

Looks good to me, I add some minor comments on github.

Any comments on below thread?

Re: [f2fs-dev] [PATCH 3/4] f2fs: compress: fix error path in prepare_compress_overwrite()

Thanks,

> 
> Thanks,
> 
> On 01/06, Chao Yu wrote:
>> Revert incorrect fix in ("TEMP: f2fs: support data compression - fix1")
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/compress.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index f993b4ce1970..fc4510729654 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -601,7 +601,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>  							fgp_flag, GFP_NOFS);
>>  		if (!page) {
>>  			ret = -ENOMEM;
>> -			goto release_pages;
>> +			goto unlock_pages;
>>  		}
>>  
>>  		if (PageUptodate(page))
>> @@ -616,13 +616,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>  		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
>>  						&last_block_in_bio, false);
>>  		if (ret)
>> -			goto unlock_pages;
>> +			goto release_pages;
>>  		if (bio)
>>  			f2fs_submit_bio(sbi, bio, DATA);
>>  
>>  		ret = f2fs_init_compress_ctx(cc);
>>  		if (ret)
>> -			goto unlock_pages;
>> +			goto release_pages;
>>  	}
>>  
>>  	for (i = 0; i < cc->cluster_size; i++) {
>> -- 
>> 2.18.0.rc1
> .
> 
