Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E27C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B1621823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLFEcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:32:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbfLFEcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 23:32:12 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F0B0344229A131A50F8E;
        Fri,  6 Dec 2019 12:32:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Dec 2019
 12:32:05 +0800
Subject: Re: [PATCH] f2fs: fix to relocate f2fs_balance_fs() in mkwrite()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20191206033100.36345-1-yuchao0@huawei.com>
 <20191206040823.GA33758@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <21133017-e538-83b4-b295-abecbcb329df@huawei.com>
Date:   Fri, 6 Dec 2019 12:32:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191206040823.GA33758@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaeguek,

On 2019/12/6 12:08, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I was testing this.
> 
> https://github.com/jaegeuk/f2fs/commit/76be33b9f1fce70dd2d3f04f66d0f78b418fe3f5

The patch looks good.

BTW, do you mind adding below call stack into your patch? I guess it
describes this ABBA deadlock with more details. :)

Thanks,

> 
> On 12/06, Chao Yu wrote:
>> As Dinosaur Huang reported, there is a potential deadlock in between
>> GC and mkwrite():
>>
>> Thread A			Thread B
>> - do_page_mkwrite
>>  - f2fs_vm_page_mkwrite
>>   - lock_page
>> 				- f2fs_balance_fs
>>                                  - mutex_lock(gc_mutex)
>> 				 - f2fs_gc
>> 				  - do_garbage_collect
>> 				   - ra_data_block
>> 				    - grab_cache_page
>>   - f2fs_balance_fs
>>    - mutex_lock(gc_mutex)
>>
>> In order to fix this, we just move f2fs_balance_fs() out of page lock's
>> coverage in f2fs_vm_page_mkwrite().
>>
>> Reported-by: Dinosaur Huang <dinosaur.huang@unisoc.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/file.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index c0560d62dbee..ed3290225506 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -67,6 +67,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>  
>>  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>>  
>> +	f2fs_balance_fs(sbi, true);
>> +
>>  	file_update_time(vmf->vma->vm_file);
>>  	down_read(&F2FS_I(inode)->i_mmap_sem);
>>  	lock_page(page);
>> @@ -120,8 +122,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>  out_sem:
>>  	up_read(&F2FS_I(inode)->i_mmap_sem);
>>  
>> -	f2fs_balance_fs(sbi, dn.node_changed);
>> -
>>  	sb_end_pagefault(inode->i_sb);
>>  err:
>>  	return block_page_mkwrite_return(err);
>> -- 
>> 2.18.0.rc1
> .
> 
