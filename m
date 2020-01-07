Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75663C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5139B2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgAGBfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:35:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbgAGBfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:35:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C72D9F1DEBA7F58D88D2;
        Tue,  7 Jan 2020 09:35:05 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 7 Jan 2020
 09:35:00 +0800
Subject: Re: [PATCH 3/4] f2fs: compress: fix error path in
 prepare_compress_overwrite()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200106080144.52363-1-yuchao0@huawei.com>
 <20200106080144.52363-3-yuchao0@huawei.com>
 <20200106190809.GE50058@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e5c45ba2-6437-c84a-11b3-abe8c16a5c6c@huawei.com>
Date:   Tue, 7 Jan 2020 09:35:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200106190809.GE50058@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/7 3:08, Jaegeuk Kim wrote:
> On 01/06, Chao Yu wrote:
>> - fix to release cluster pages in retry flow
>> - fix to call f2fs_put_dnode() & __do_map_lock() in error path
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/compress.c | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index fc4510729654..3390351d2e39 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -626,20 +626,26 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>  	}
>>  
>>  	for (i = 0; i < cc->cluster_size; i++) {
>> +		f2fs_bug_on(sbi, cc->rpages[i]);
>> +
>>  		page = find_lock_page(mapping, start_idx + i);
>>  		f2fs_bug_on(sbi, !page);
>>  
>>  		f2fs_wait_on_page_writeback(page, DATA, true, true);
>>  
>> -		cc->rpages[i] = page;
>> +		f2fs_compress_ctx_add_page(cc, page);
>>  		f2fs_put_page(page, 0);
>>  
>>  		if (!PageUptodate(page)) {
>> -			for (idx = 0; idx < cc->cluster_size; idx++) {
>> -				f2fs_put_page(cc->rpages[idx],
>> -						(idx <= i) ? 1 : 0);
>> +			for (idx = 0; idx <= i; idx++) {
>> +				unlock_page(cc->rpages[idx]);
>>  				cc->rpages[idx] = NULL;
>>  			}
>> +			for (idx = 0; idx < cc->cluster_size; idx++) {
>> +				page = find_lock_page(mapping, start_idx + idx);
> 
> Why do we need to lock the pages again?

Here, all pages in cluster has one extra reference count, we need to find all
pages, and release those references on them.

cc->rpages may not record all pages' pointers, so we can not use

f2fs_put_page(cc->rpages[idx], (idx <= i) ? 1 : 0); to release all pages' references.

BTW, find_get_page() should be fine to instead find_lock_page().

> 
>> +				f2fs_put_page(page, 1);
>> +				f2fs_put_page(page, 0);
>> +			}
>>  			kvfree(cc->rpages);
>>  			cc->nr_rpages = 0;
>>  			goto retry;
>> @@ -654,16 +660,20 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>  		for (i = cc->cluster_size - 1; i > 0; i--) {
>>  			ret = f2fs_get_block(&dn, start_idx + i);
>>  			if (ret) {
>> -				/* TODO: release preallocate blocks */
>>  				i = cc->cluster_size;
>> -				goto unlock_pages;
>> +				break;
>>  			}
>>  
>>  			if (dn.data_blkaddr != NEW_ADDR)
>>  				break;
>>  		}
>>  
>> +		f2fs_put_dnode(&dn);
> 
> We don't neeed this, since f2fs_reserve_block() put the dnode.

Correct.

Thanks,

> 
>> +
>>  		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
>> +
>> +		if (ret)
>> +			goto unlock_pages;
>>  	}
>>  
>>  	*fsdata = cc->rpages;
>> -- 
>> 2.18.0.rc1
> .
> 
