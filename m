Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89925C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494CE2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfIJMEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:04:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfIJMEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:04:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0AC0F1DF1C46A30BFBBD;
        Tue, 10 Sep 2019 20:04:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 10 Sep
 2019 20:04:15 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid infinite GC loop due to stale
 atomic files
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190909073011.GA21625@jaegeuk-macbookpro.roam.corp.google.com>
 <5a473076-14b8-768a-62ac-f686e850d5a6@huawei.com>
 <20190909080108.GC21625@jaegeuk-macbookpro.roam.corp.google.com>
 <bf0683d9-ac05-1edc-71ea-3d02f7b2fb55@huawei.com>
 <20190909082112.GA25724@jaegeuk-macbookpro.roam.corp.google.com>
 <2f5b844c-f722-6a80-a4ab-61bdd72b8be4@huawei.com>
 <20190909083844.GC25724@jaegeuk-macbookpro.roam.corp.google.com>
 <83759349-644a-b3a0-787d-e463b0565885@huawei.com>
 <20190909143419.GB31108@jaegeuk-macbookpro.roam.corp.google.com>
 <c48f8992-eaef-9b2e-56a3-f6a922daa4af@huawei.com>
 <20190910115850.GA98080@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2fd8940b-9ebd-d143-5ce6-c056750c596f@huawei.com>
Date:   Tue, 10 Sep 2019 20:04:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190910115850.GA98080@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/10 19:58, Jaegeuk Kim wrote:
> On 09/10, Chao Yu wrote:
>> On 2019/9/9 22:34, Jaegeuk Kim wrote:
>>> On 09/09, Chao Yu wrote:
>>>> On 2019/9/9 16:38, Jaegeuk Kim wrote:
>>>>> On 09/09, Chao Yu wrote:
>>>>>> On 2019/9/9 16:21, Jaegeuk Kim wrote:
>>>>>>> On 09/09, Chao Yu wrote:
>>>>>>>> On 2019/9/9 16:01, Jaegeuk Kim wrote:
>>>>>>>>> On 09/09, Chao Yu wrote:
>>>>>>>>>> On 2019/9/9 15:30, Jaegeuk Kim wrote:
>>>>>>>>>>> On 09/09, Chao Yu wrote:
>>>>>>>>>>>> On 2019/9/9 9:25, Jaegeuk Kim wrote:
>>>>>>>>>>>>> If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
>>>>>>>>>>>>> get commited pages but atomic_file being still set like:
>>>>>>>>>>>>>
>>>>>>>>>>>>> - inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)
>>>>>>>>>>>>>
>>>>>>>>>>>>> If GC selects this block, we can get an infinite loop like this:
>>>>>>>>>>>>>
>>>>>>>>>>>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
>>>>>>>>>>>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
>>>>>>>>>>>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
>>>>>>>>>>>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
>>>>>>>>>>>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
>>>>>>>>>>>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
>>>>>>>>>>>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
>>>>>>>>>>>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
>>>>>>>>>>>>>
>>>>>>>>>>>>> In that moment, we can observe:
>>>>>>>>>>>>>
>>>>>>>>>>>>> [Before]
>>>>>>>>>>>>> Try to move 5084219 blocks (BG: 384508)
>>>>>>>>>>>>>   - data blocks : 4962373 (274483)
>>>>>>>>>>>>>   - node blocks : 121846 (110025)
>>>>>>>>>>>>> Skipped : atomic write 4534686 (10)
>>>>>>>>>>>>>
>>>>>>>>>>>>> [After]
>>>>>>>>>>>>> Try to move 5088973 blocks (BG: 384508)
>>>>>>>>>>>>>   - data blocks : 4967127 (274483)
>>>>>>>>>>>>>   - node blocks : 121846 (110025)
>>>>>>>>>>>>> Skipped : atomic write 4539440 (10)
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>  fs/f2fs/file.c | 10 +++++-----
>>>>>>>>>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>>>>>>>> index 7ae2f3bd8c2f..68b6da734e5f 100644
>>>>>>>>>>>>> --- a/fs/f2fs/file.c
>>>>>>>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>>>>>>>> @@ -1997,11 +1997,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>>>>>>>>>>>>  			goto err_out;
>>>>>>>>>>>>>  
>>>>>>>>>>>>>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
>>>>>>>>>>>>> -		if (!ret) {
>>>>>>>>>>>>> -			clear_inode_flag(inode, FI_ATOMIC_FILE);
>>>>>>>>>>>>> -			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
>>>>>>>>>>>>> -			stat_dec_atomic_write(inode);
>>>>>>>>>>>>> -		}
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +		/* doesn't need to check error */
>>>>>>>>>>>>> +		clear_inode_flag(inode, FI_ATOMIC_FILE);
>>>>>>>>>>>>> +		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
>>>>>>>>>>>>> +		stat_dec_atomic_write(inode);
>>>>>>>>>>>>
>>>>>>>>>>>> If there are still valid atomic write pages linked in .inmem_pages, it may cause
>>>>>>>>>>>> memory leak when we just clear FI_ATOMIC_FILE flag.
>>>>>>>>>>>
>>>>>>>>>>> f2fs_commit_inmem_pages() should have flushed them.
>>>>>>>>>>
>>>>>>>>>> Oh, we failed to flush its nodes.
>>>>>>>>>>
>>>>>>>>>> However we won't clear such info if we failed to flush inmen pages, it looks
>>>>>>>>>> inconsistent.
>>>>>>>>>>
>>>>>>>>>> Any interface needed to drop inmem pages or clear ATOMIC_FILE flag in that two
>>>>>>>>>> error path? I'm not very clear how sqlite handle such error.
>>>>>>>>>
>>>>>>>>> f2fs_drop_inmem_pages() did that, but not in this case.
>>>>>>>>
>>>>>>>> What I mean is, for any error returned from atomic_commit() interface, should
>>>>>>>> userspace application handle it with consistent way, like trigger
>>>>>>>> f2fs_drop_inmem_pages(), so we don't need to handle it inside atomic_commit().
>>>>>>>
>>>>>>> f2fs_ioc_abort_volatile_write() will be triggered.
>>>>>>
>>>>>> If userspace can do this, we can get rid of this patch, or am I missing sth?
>>>>>
>>>>> We don't know when that will come. And, other threads are waiting for GC here.
>>>>
>>>> Yes, however, even atomic_write won't be called sometimes... that's why we add
>>>> handling logic in f2fs_gc().
>>>
>>> We need to clean this up like:
>>>
>>> If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
>>> get commited pages but atomic_file being still set like:
>>>
>>> - inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)
>>>
>>> If GC selects this block, we can get an infinite loop like this:
>>>
>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
>>>
>>> In that moment, we can observe:
>>>
>>> [Before]
>>> Try to move 5084219 blocks (BG: 384508)
>>>   - data blocks : 4962373 (274483)
>>>   - node blocks : 121846 (110025)
>>> Skipped : atomic write 4534686 (10)
>>>
>>> [After]
>>> Try to move 5088973 blocks (BG: 384508)
>>>   - data blocks : 4967127 (274483)
>>>   - node blocks : 121846 (110025)
>>> Skipped : atomic write 4539440 (10)
>>>
>>> So, refactor atomic_write flow like this:
>>> 1. start_atomic_write
>>>  - add inmem_list and set atomic_file
>>>
>>> 2. write()
>>>  - register it in inmem_pages
>>>
>>> 3. commit_atomic_write
>>>  - if no error, f2fs_drop_inmem_pages()
>>>  - f2fs_commit_inmme_pages() failed
>>>    : __revoked_inmem_pages() was done
>>>  - f2fs_do_sync_file failed
>>>    : abort_atomic_write later
>>>
>>> 4. abort_atomic_write
>>>  - f2fs_drop_inmem_pages
>>>
>>> 5. f2fs_drop_inmem_pages
>>>  - clear atomic_file
>>>  - remove inmem_list
>>
>> Looks good.
>>
>>>
>>> Based on this change, when GC fails to move block in atomic_file,
>>> f2fs_drop_inmem_pages_all() can call f2fs_drop_inmem_pages().
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/file.c    | 17 +++++++++++------
>>>  fs/f2fs/segment.c | 24 +++++-------------------
>>>  2 files changed, 16 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 10927a0b8df3..1f499ac13d9a 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1830,6 +1830,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>>  {
>>>  	struct inode *inode = file_inode(filp);
>>>  	int ret;
>>> +	struct f2fs_inode_info *fi = F2FS_I(inode);
>>>  
>>>  	if (!inode_owner_or_capable(inode))
>>>  		return -EACCES;
>>> @@ -1871,10 +1872,17 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>>  		goto out;
>>>  	}
>>>  
>>> -	set_inode_flag(inode, FI_ATOMIC_FILE);
>>>  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
>>>  	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>  
>>> +	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
>>> +	if (list_empty(&fi->inmem_ilist))
>>> +		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
>>> +	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>>> +
>>> +	/* add inode in inmem_list first and set atomic_file */
>>> +	set_inode_flag(inode, FI_ATOMIC_FILE);
>>
>> Should call up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]) here? Then in f2fs_gc(),
>> we can check FI_ATOMIC_FILE atomically under i_gc_rwsem.
> 
> Yup.
> 
> If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
> get commited pages but atomic_file being still set like:
> 
> - inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)
> 
> If GC selects this block, we can get an infinite loop like this:
> 
> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> 
> In that moment, we can observe:
> 
> [Before]
> Try to move 5084219 blocks (BG: 384508)
>   - data blocks : 4962373 (274483)
>   - node blocks : 121846 (110025)
> Skipped : atomic write 4534686 (10)
> 
> [After]
> Try to move 5088973 blocks (BG: 384508)
>   - data blocks : 4967127 (274483)
>   - node blocks : 121846 (110025)
> Skipped : atomic write 4539440 (10)
> 
> So, refactor atomic_write flow like this:
> 1. start_atomic_write
>  - add inmem_list and set atomic_file
> 
> 2. write()
>  - register it in inmem_pages
> 
> 3. commit_atomic_write
>  - if no error, f2fs_drop_inmem_pages()
>  - f2fs_commit_inmme_pages() failed
>    : __revoked_inmem_pages() was done
>  - f2fs_do_sync_file failed
>    : abort_atomic_write later
> 
> 4. abort_atomic_write
>  - f2fs_drop_inmem_pages
> 
> 5. f2fs_drop_inmem_pages
>  - clear atomic_file
>  - remove inmem_list
> 
> Based on this change, when GC fails to move block in atomic_file,
> f2fs_drop_inmem_pages_all() can call f2fs_drop_inmem_pages().
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c    | 15 ++++++++++-----
>  fs/f2fs/segment.c | 27 ++++++---------------------
>  2 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 10927a0b8df3..fab6e4cf8f06 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1829,6 +1829,8 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
>  static int f2fs_ioc_start_atomic_write(struct file *filp)
>  {
>  	struct inode *inode = file_inode(filp);
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	int ret;
>  
>  	if (!inode_owner_or_capable(inode))
> @@ -1871,6 +1873,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  		goto out;
>  	}
>  
> +	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> +	if (list_empty(&fi->inmem_ilist))
> +		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
> +	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> +
> +	/* add inode in inmem_list first and set atomic_file */
>  	set_inode_flag(inode, FI_ATOMIC_FILE);
>  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
>  	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> @@ -1912,11 +1920,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>  			goto err_out;
>  
>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
> -		if (!ret) {
> -			clear_inode_flag(inode, FI_ATOMIC_FILE);
> -			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> -			stat_dec_atomic_write(inode);
> -		}
> +		if (!ret)
> +			f2fs_drop_inmem_pages(inode);
>  	} else {
>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 18584d4c078a..66343f451d73 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -185,8 +185,6 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
>  
>  void f2fs_register_inmem_page(struct inode *inode, struct page *page)
>  {
> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	struct inmem_pages *new;
>  
>  	f2fs_trace_pid(page);
> @@ -200,15 +198,9 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
>  	INIT_LIST_HEAD(&new->list);
>  
>  	/* increase reference count with clean state */
> -	mutex_lock(&fi->inmem_lock);

The lock is used to protect F2FS_I(inode)->inmem_pages list... it should be kept?

Thanks,

>  	get_page(page);
> -	list_add_tail(&new->list, &fi->inmem_pages);
> -	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> -	if (list_empty(&fi->inmem_ilist))
> -		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
> -	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> +	list_add_tail(&new->list, &F2FS_I(inode)->inmem_pages);
>  	inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
> -	mutex_unlock(&fi->inmem_lock);
>  
>  	trace_f2fs_register_inmem_page(page, INMEM);
>  }
> @@ -330,19 +322,17 @@ void f2fs_drop_inmem_pages(struct inode *inode)
>  		mutex_lock(&fi->inmem_lock);
>  		__revoke_inmem_pages(inode, &fi->inmem_pages,
>  						true, false, true);
> -
> -		if (list_empty(&fi->inmem_pages)) {
> -			spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> -			if (!list_empty(&fi->inmem_ilist))
> -				list_del_init(&fi->inmem_ilist);
> -			spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> -		}
>  		mutex_unlock(&fi->inmem_lock);
>  	}
>  
>  	clear_inode_flag(inode, FI_ATOMIC_FILE);
>  	fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
>  	stat_dec_atomic_write(inode);
> +
> +	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> +	if (!list_empty(&fi->inmem_ilist))
> +		list_del_init(&fi->inmem_ilist);
> +	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>  }
>  
>  void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
> @@ -471,11 +461,6 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>  
>  	mutex_lock(&fi->inmem_lock);
>  	err = __f2fs_commit_inmem_pages(inode);
> -
> -	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> -	if (!list_empty(&fi->inmem_ilist))
> -		list_del_init(&fi->inmem_ilist);
> -	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>  	mutex_unlock(&fi->inmem_lock);
>  
>  	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
> 
