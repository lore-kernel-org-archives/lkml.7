Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F95EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE3206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKKHSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:18:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfKKHSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:18:17 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A14D48DEC969A6888331;
        Mon, 11 Nov 2019 15:18:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 11 Nov
 2019 15:18:12 +0800
Subject: Re: [PATCH] f2fs: Fix deadlock under storage almost full/dirty
 condition
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1573211027-30785-1-git-send-email-stummala@codeaurora.org>
 <5c491884-91d3-5b85-6d49-569a8d06f3a3@huawei.com>
 <20191111034026.GA15669@codeaurora.org>
 <9ece86fd-ff53-3a70-627e-c6acb03b9264@huawei.com>
 <20191111064441.GC15669@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <46f2e438-a1b9-c7fa-4c83-241dc85253e8@huawei.com>
Date:   Mon, 11 Nov 2019 15:18:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191111064441.GC15669@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2019/11/11 14:44, Sahitya Tummala wrote:
> Hi Chao,
> 
> On Mon, Nov 11, 2019 at 02:28:47PM +0800, Chao Yu wrote:
>> Hi Sahitya,
>>
>> On 2019/11/11 11:40, Sahitya Tummala wrote:
>>> Hi Chao,
>>>
>>> On Mon, Nov 11, 2019 at 10:51:10AM +0800, Chao Yu wrote:
>>>> On 2019/11/8 19:03, Sahitya Tummala wrote:
>>>>> There could be a potential deadlock when the storage capacity
>>>>> is almost full and theren't enough free segments available, due
>>>>> to which FG_GC is needed in the atomic commit ioctl as shown in
>>>>> the below callstack -
>>>>>
>>>>> schedule_timeout
>>>>> io_schedule_timeout
>>>>> congestion_wait
>>>>> f2fs_drop_inmem_pages_all
>>>>> f2fs_gc
>>>>> f2fs_balance_fs
>>>>> __write_node_page
>>>>> f2fs_fsync_node_pages
>>>>> f2fs_do_sync_file
>>>>> f2fs_ioctl
>>>>>
>>>>> If this inode doesn't have i_gc_failures[GC_FAILURE_ATOMIC] set,
>>>>> then it waits forever in f2fs_drop_inmem_pages_all(), for this
>>>>> atomic inode to be dropped. And the rest of the system is stuck
>>>>> waiting for sbi->gc_mutex lock, which is acquired by f2fs_balance_fs()
>>>>> in the stack above.
>>>>
>>>> I think the root cause of this issue is there is potential infinite loop in
>>>> f2fs_drop_inmem_pages_all() for the case of gc_failure is true, because once the
>>>> first inode in inode_list[ATOMIC_FILE] list didn't suffer gc failure, we will
>>>> skip dropping its in-memory cache and calling iput(), and traverse the list
>>>> again, most possibly there is the same inode in the head of that list.
>>>>
>>>
>>> I thought we are expecting for those atomic updates (without any gc failures) to be
>>> committed by doing congestion_wait() and thus retrying again. Hence, I just
>>
>> Nope, we only need to drop inode which encounter gc failures, and keep the rest
>> inodes.
>>
>>> fixed only if we are ending up waiting for commit to happen in the atomic
>>> commit path itself, which will be a deadlock.
>>
>> Look into call stack you provide, I don't think it's correct to drop such inode,
>> as its dirty pages should be committed before f2fs_fsync_node_pages(), so
>> calling f2fs_drop_inmem_pages won't release any inmem pages, and won't help
>> looped GC caused by skipping due to inmem pages.
>>
>> And then I figure out below fix...
>>
> 
> Thanks for the explanation.
> The fix below looks good to me.

So could you submit v2? :)

Thanks,

> 
> Thanks,
> Sahitya.
> 
>>>
>>>> Could you please check below fix:
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 7bf7b0194944..8a3a35b42a37 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -1395,6 +1395,7 @@ struct f2fs_sb_info {
>>>>  	unsigned int gc_mode;			/* current GC state */
>>>>  	unsigned int next_victim_seg[2];	/* next segment in victim section */
>>>>  	/* for skip statistic */
>>>> +	unsigned int atomic_files;		/* # of opened atomic file */
>>>>  	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
>>>>  	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
>>>>
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index ecd063239642..79f4b348951a 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -2047,6 +2047,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>>>  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
>>>>  	if (list_empty(&fi->inmem_ilist))
>>>>  		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
>>>> +	sbi->atomic_files++;
>>>>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>>>>
>>>>  	/* add inode in inmem_list first and set atomic_file */
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 8b977bbd6822..6aa0bb693697 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -288,6 +288,8 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi,
>>>> bool gc_failure)
>>>>  	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
>>>>  	struct inode *inode;
>>>>  	struct f2fs_inode_info *fi;
>>>> +	unsigned int count = sbi->atomic_files;
>>>
>>> If the sbi->atomic_files decrements just after this, then the below exit condition
>>> may not work. In that case, looped will never be >= count.
>>>
>>>> +	unsigned int looped = 0;
>>>>  next:
>>>>  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
>>>>  	if (list_empty(head)) {
>>>> @@ -296,22 +298,29 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi,
>>>> bool gc_failure)
>>>>  	}
>>>>  	fi = list_first_entry(head, struct f2fs_inode_info, inmem_ilist);
>>>>  	inode = igrab(&fi->vfs_inode);
>>>> +	if (inode)
>>>> +		list_move_tail(&fi->inmem_ilist, head);
>>>>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>>>>
>>>>  	if (inode) {
>>>>  		if (gc_failure) {
>>>> -			if (fi->i_gc_failures[GC_FAILURE_ATOMIC])
>>>> -				goto drop;
>>>> -			goto skip;
>>>> +			if (!fi->i_gc_failures[GC_FAILURE_ATOMIC])
>>>> +				goto skip;
>>>>  		}
>>>> -drop:
>>>>  		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
>>>>  		f2fs_drop_inmem_pages(inode);
>>>> +skip:
>>>>  		iput(inode);
>>>
>>> Does this result into f2fs_evict_inode() in this context for this inode?
>>
>> Yup, we need to call igrab/iput in pair in f2fs_drop_inmem_pages_all() anyway.
>>
>> Previously, we may have .i_count leak...
>>
>> Thanks,
>>
>>>
>>> thanks,
>>>
>>>>  	}
>>>> -skip:
>>>> +
>>>>  	congestion_wait(BLK_RW_ASYNC, HZ/50);
>>>>  	cond_resched();
>>>> +
>>>> +	if (gc_failure) {
>>>> +		if (++looped >= count)
>>>> +			return;
>>>> +	}
>>>> +
>>>>  	goto next;
>>>>  }
>>>>
>>>> @@ -334,6 +343,7 @@ void f2fs_drop_inmem_pages(struct inode *inode)
>>>>  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
>>>>  	if (!list_empty(&fi->inmem_ilist))
>>>>  		list_del_init(&fi->inmem_ilist);
>>>> +	sbi->atomic_files--;
>>>>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>>>>  }
>>>>
>>>> Thanks,
>>>
> 
