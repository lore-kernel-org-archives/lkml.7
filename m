Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC39214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfCMBbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 21:31:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfCMBbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 21:31:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A3CBC9EFE060B0512622;
        Wed, 13 Mar 2019 09:31:46 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Mar 2019
 09:31:43 +0800
Subject: Re: [PATCH] f2fs: fix to avoid deadlock in f2fs_read_inline_dir()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190312074427.75515-1-yuchao0@huawei.com>
 <20190312200932.GD45421@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d32c84cd-55fb-0cfa-82ae-157330fc6e81@huawei.com>
Date:   Wed, 13 Mar 2019 09:31:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190312200932.GD45421@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/13 4:09, Jaegeuk Kim wrote:
> On 03/12, Chao Yu wrote:
>> As Jiqun Li reported in bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=202883
>>
>> sometimes, dead lock when make system call SYS_getdents64 with fsync() is
>> called by another process.
>>
>> monkey running on android9.0
>>
>> 1.  task 9785 held sbi->cp_rwsem and waiting lock_page()
>> 2.  task 10349 held mm_sem and waiting sbi->cp_rwsem
>> 3. task 9709 held lock_page() and waiting mm_sem
>>
>> so this is a dead lock scenario.
>>
>> task stack is show by crash tools as following
>>
>> crash_arm64> bt ffffffc03c354080
>> PID: 9785   TASK: ffffffc03c354080  CPU: 1   COMMAND: "RxIoScheduler-3"
>>>> #7 [ffffffc01b50fac0] __lock_page at ffffff80081b11e8
>>
>> crash-arm64> bt 10349
>> PID: 10349  TASK: ffffffc018b83080  CPU: 1   COMMAND: "BUGLY_ASYNC_UPL"
>>>> #3 [ffffffc01f8cfa40] rwsem_down_read_failed at ffffff8008a93afc
>>      PC: 00000033  LR: 00000000  SP: 00000000  PSTATE: ffffffffffffffff
>>
>> crash-arm64> bt 9709
>> PID: 9709   TASK: ffffffc03e7f3080  CPU: 1   COMMAND: "IntentService[A"
>>>> #3 [ffffffc001e67850] rwsem_down_read_failed at ffffff8008a93afc
>>>> #8 [ffffffc001e67b80] el1_ia at ffffff8008084fc4
>>      PC: ffffff8008274114  [compat_filldir64+120]
>>      LR: ffffff80083584d4  [f2fs_fill_dentries+448]
>>      SP: ffffffc001e67b80  PSTATE: 80400145
>>     X29: ffffffc001e67b80  X28: 0000000000000000  X27: 000000000000001a
>>     X26: 00000000000093d7  X25: ffffffc070d52480  X24: 0000000000000008
>>     X23: 0000000000000028  X22: 00000000d43dfd60  X21: ffffffc001e67e90
>>     X20: 0000000000000011  X19: ffffff80093a4000  X18: 0000000000000000
>>     X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
>>     X14: ffffffffffffffff  X13: 0000000000000008  X12: 0101010101010101
>>     X11: 7f7f7f7f7f7f7f7f  X10: 6a6a6a6a6a6a6a6a   X9: 7f7f7f7f7f7f7f7f
>>      X8: 0000000080808000   X7: ffffff800827409c   X6: 0000000080808000
>>      X5: 0000000000000008   X4: 00000000000093d7   X3: 000000000000001a
>>      X2: 0000000000000011   X1: ffffffc070d52480   X0: 0000000000800238
>>>> #9 [ffffffc001e67be0] f2fs_fill_dentries at ffffff80083584d0
>>      PC: 0000003c  LR: 00000000  SP: 00000000  PSTATE: 000000d9
>>     X12: f48a02ff X11: d4678960 X10: d43dfc00  X9: d4678ae4
>>      X8: 00000058  X7: d4678994  X6: d43de800  X5: 000000d9
>>      X4: d43dfc0c  X3: d43dfc10  X2: d46799c8  X1: 00000000
>>      X0: 00001068
>>
>> Below potential deadlock will happen between three threads:
>> Thread A		Thread B		Thread C
>> - f2fs_do_sync_file
>>  - f2fs_write_checkpoint
>>   - down_write(&sbi->node_change) -- 1)
>> 			- do_page_fault
>> 			 - down_write(&mm->mmap_sem) -- 2)
>> 			  - do_wp_page
>> 			   - f2fs_vm_page_mkwrite
>> 						- getdents64
>> 						 - f2fs_read_inline_dir
>> 						  - lock_page -- 3)
>>   - f2fs_sync_node_pages
>>    - lock_page -- 3)
>> 			    - __do_map_lock
>> 			     - down_read(&sbi->node_change) -- 1)
>> 						  - f2fs_fill_dentries
>> 						   - dir_emit
>> 						    - compat_filldir64
>> 						     - do_page_fault
>> 						      - down_read(&mm->mmap_sem) -- 2)
>>
>> Since f2fs_readdir is protected by inode.i_rwsem, there should not be
> 
> Well, what about other dir operations which can convert inline_dentry?

All those operations which can add/update/delete dents will be covered with
down_write(inode.i_rwsem), so we are safe.

> How about allocating a buffer shortly like this?

If there is no race, allocating additional memory to store instantaneous
dents is unnecessary? How do you think?

Thanks

> 
> ---
>  fs/f2fs/inline.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index a1381d05956b..50a946d55778 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -647,12 +647,10 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
>  	struct inode *inode = file_inode(file);
>  	struct page *ipage = NULL;
>  	struct f2fs_dentry_ptr d;
> -	void *inline_dentry = NULL;
> +	void *inline_dentry = NULL, *buf = NULL;
>  	int err;
>  
> -	make_dentry_ptr_inline(inode, &d, inline_dentry);
> -
> -	if (ctx->pos == d.max)
> +	if (ctx->pos >= NR_INLINE_DENTRY(inode))
>  		return 0;
>  
>  	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
> @@ -660,14 +658,24 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
>  		return PTR_ERR(ipage);
>  
>  	inline_dentry = inline_data_addr(inode, ipage);
> +	buf = f2fs_kmalloc(F2FS_I_SB(inode),
> +				MAX_INLINE_DATA(inode), GFP_F2FS_ZERO);
> +	if (!buf) {
> +		f2fs_put_page(ipage, 1);
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	memcpy(buf, inline_dentry, MAX_INLINE_DATA(inode));
> +	make_dentry_ptr_inline(inode, &d, buf);
>  
> -	make_dentry_ptr_inline(inode, &d, inline_dentry);
> +	f2fs_put_page(ipage, 1);
>  
>  	err = f2fs_fill_dentries(ctx, &d, 0, fstr);
>  	if (!err)
>  		ctx->pos = d.max;
>  
> -	f2fs_put_page(ipage, 1);
> +	kvfree(buf);
> +out:
>  	return err < 0 ? err : 0;
>  }
>  
> 

