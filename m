Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8634C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895A5214DE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfI2CxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 22:53:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbfI2CxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 22:53:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98C497E082E28D6D271F;
        Sun, 29 Sep 2019 10:52:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 29 Sep
 2019 10:52:50 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix comment of f2fs_evict_inode
To:     Gao Xiang <gaoxiang25@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190925093050.118921-1-yuchao0@huawei.com>
 <20190927183150.GA54001@jaegeuk-macbookpro.roam.corp.google.com>
 <8c54adaf-163f-fcbe-7731-0c18b12410e0@huawei.com>
 <20190929021939.GA136917@architecture4>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bcfbe250-09f4-3cb2-391f-97f574e82d35@huawei.com>
Date:   Sun, 29 Sep 2019 10:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190929021939.GA136917@architecture4>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/29 10:20, Gao Xiang wrote:
> On Sun, Sep 29, 2019 at 08:53:05AM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2019/9/28 2:31, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> On 09/25, Chao Yu wrote:
>>>> evict() should be called once i_count is zero, rather than i_nlinke
>>>> is zero.
>>>>
>>>> Reported-by: Gao Xiang <gaoxiang25@huawei.com>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/inode.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>> index db4fec30c30d..8262f4a483d3 100644
>>>> --- a/fs/f2fs/inode.c
>>>> +++ b/fs/f2fs/inode.c
>>>> @@ -632,7 +632,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>>>>  }
>>>>  
>>>>  /*
>>>> - * Called at the last iput() if i_nlink is zero
>>>
>>> I don't think this comment is wrong. You may be able to add on top of this.
>>
>> It actually misleads the developer or user.
>>
>> How do you think of:
>>
>> "Called at the last iput() if i_count is zero, and will release all meta/data
>> blocks allocated in the inode if i_nlink is zero"
> 
> (sigh... side note: I just took some time to check the original meaning
>  out of curiosity. AFAIK, the above word was added in Linux-2.1.45 [1]
>  due to ext2_delete_inode behavior, which is called when i_nlink == 0,
>  and .delete_inode was gone in 2010 (commit 72edc4d0873b merge ext2
>  delete_inode and clear_inode, switch to ->evict_inode()), it may be
>  helpful to understand the story so I write here for later folks reference.
>  And it's also good to just kill it. )

Xiang,

Thanks for providing tracked info, I guess it's due to historical reason, we
kept the wrong comments in f2fs, anyway I agree that it should be fixed in
ext*/f2fs codes, let me send patches to fix comment in ext* as well.

Thanks,

> 
> +
> +/*
> + * Called at the last iput() if i_nlink is zero.
> + */
> +void ext2_delete_inode (struct inode * inode)
> +{
> +	if (inode->i_ino == EXT2_ACL_IDX_INO ||
>  	    inode->i_ino == EXT2_ACL_DATA_INO)
>  		return;
>  	inode->u.ext2_i.i_dtime	= CURRENT_TIME;
> -	inode->i_dirt = 1;
> +	mark_inode_dirty(inode);
>  	ext2_update_inode(inode, IS_SYNC(inode));
>  	inode->i_size = 0;
>  	if (inode->i_blocks)
> @@ -248,7 +258,7 @@
>  	if (IS_SYNC(inode) || inode->u.ext2_i.i_osync)
>  		ext2_sync_inode (inode);
>  	else
> -		inode->i_dirt = 1;
> +		mark_inode_dirty(inode);
>  	return result;
>  }
> 
> +void iput(struct inode *inode)
>  {
> -	struct inode * inode = get_empty_inode();
> +	if (inode) {
> +		struct super_operations *op = NULL;
>  
> -	PIPE_BASE(*inode) = (char*)__get_free_page(GFP_USER);
> -	if (!(PIPE_BASE(*inode))) {
> -		iput(inode);
> -		return NULL;
> +		if (inode->i_sb && inode->i_sb->s_op)
> +			op = inode->i_sb->s_op;
> +		if (op && op->put_inode)
> +			op->put_inode(inode);
> +
> +		spin_lock(&inode_lock);
> +		if (!--inode->i_count) {
> +			if (!inode->i_nlink) {
> +				list_del(&inode->i_hash);
> +				INIT_LIST_HEAD(&inode->i_hash);
> +				if (op && op->delete_inode) {
> +					void (*delete)(struct inode *) = op->delete_inode;
> +					spin_unlock(&inode_lock);
> +					delete(inode);
> +					spin_lock(&inode_lock);
> +				}
> +			}
> +			if (list_empty(&inode->i_hash)) {
> +				list_del(&inode->i_list);
> +				list_add(&inode->i_list, &inode_unused);
> +			}
> +		}
> +		spin_unlock(&inode_lock);
>  	}
> 
> [1] https://www.kernel.org/pub/linux/kernel/v2.1/patch-2.1.45.xz
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
>>>
>>>> + * Called at the last iput() if i_count is zero
>>>>   */
>>>>  void f2fs_evict_inode(struct inode *inode)
>>>>  {
>>>> -- 
>>>> 2.18.0.rc1
>>> .
>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
