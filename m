Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5572CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F62D2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLKBmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:42:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfLKBmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:42:06 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D323C4F4F6E34CA96FF6;
        Wed, 11 Dec 2019 09:42:03 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 11 Dec
 2019 09:42:01 +0800
Subject: Re: [f2fs-dev] [PATCH 6/6] f2fs: set I_LINKABLE early to avoid wrong
 access by vfs
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
 <20191209222345.1078-6-jaegeuk@kernel.org>
 <88dcbca9-3757-a440-ed73-9d99a56b816c@huawei.com>
 <20191211012121.GA52962@jaegeuk-macbookpro.roam.corp.google.com>
 <00ced682-9522-236d-4078-4c8f2e348d39@huawei.com>
 <20191211013124.GB57416@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <dd2021ff-6968-43ad-d8b2-3689668cd79e@huawei.com>
Date:   Wed, 11 Dec 2019 09:42:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191211013124.GB57416@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/11 9:31, Jaegeuk Kim wrote:
> On 12/11, Chao Yu wrote:
>> On 2019/12/11 9:21, Jaegeuk Kim wrote:
>>> On 12/10, Chao Yu wrote:
>>>> On 2019/12/10 6:23, Jaegeuk Kim wrote:
>>>>> This patch moves setting I_LINKABLE early in rename2(whiteout) to avoid the
>>>>> below warning.
>>>>>
>>>>> [ 3189.163385] WARNING: CPU: 3 PID: 59523 at fs/inode.c:358 inc_nlink+0x32/0x40
>>>>> [ 3189.246979] Call Trace:
>>>>> [ 3189.248707]  f2fs_init_inode_metadata+0x2d6/0x440 [f2fs]
>>>>> [ 3189.251399]  f2fs_add_inline_entry+0x162/0x8c0 [f2fs]
>>>>> [ 3189.254010]  f2fs_add_dentry+0x69/0xe0 [f2fs]
>>>>> [ 3189.256353]  f2fs_do_add_link+0xc5/0x100 [f2fs]
>>>>> [ 3189.258774]  f2fs_rename2+0xabf/0x1010 [f2fs]
>>>>> [ 3189.261079]  vfs_rename+0x3f8/0xaa0
>>>>> [ 3189.263056]  ? tomoyo_path_rename+0x44/0x60
>>>>> [ 3189.265283]  ? do_renameat2+0x49b/0x550
>>>>> [ 3189.267324]  do_renameat2+0x49b/0x550
>>>>> [ 3189.269316]  __x64_sys_renameat2+0x20/0x30
>>>>> [ 3189.271441]  do_syscall_64+0x5a/0x230
>>>>> [ 3189.273410]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>> [ 3189.275848] RIP: 0033:0x7f270b4d9a49
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/namei.c | 27 +++++++++++++--------------
>>>>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>>>> index a1c507b0b4ac..5d9584281935 100644
>>>>> --- a/fs/f2fs/namei.c
>>>>> +++ b/fs/f2fs/namei.c
>>>>> @@ -797,6 +797,7 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
>>>>>  
>>>>>  	if (whiteout) {
>>>>>  		f2fs_i_links_write(inode, false);
>>>>> +		inode->i_state |= I_LINKABLE;
>>>>>  		*whiteout = inode;
>>>>>  	} else {
>>>>>  		d_tmpfile(dentry, inode);
>>>>> @@ -867,6 +868,12 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>>>  			F2FS_I(old_dentry->d_inode)->i_projid)))
>>>>>  		return -EXDEV;
>>>>>  
>>>>> +	if (flags & RENAME_WHITEOUT) {
>>>>> +		err = f2fs_create_whiteout(old_dir, &whiteout);
>>>>> +		if (err)
>>>>> +			return err;
>>>>> +	}
>>>>
>>>> To record quota info correctly, we need to create whiteout inode after
>>>> dquot_initialize(old_dir)?
>>>
>>> __f2fs_tmpfile() will do it.
>>
>> Okay.
>>
>> Any comments on below question?
>>
>>>
>>>>
>>>>> +
>>>>>  	err = dquot_initialize(old_dir);
>>>>>  	if (err)
>>>>>  		goto out;
>>>>> @@ -898,17 +905,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> -	if (flags & RENAME_WHITEOUT) {
>>>>> -		err = f2fs_create_whiteout(old_dir, &whiteout);
>>>>> -		if (err)
>>>>> -			goto out_dir;
>>>>> -	}
>>>>> -
>>>>>  	if (new_inode) {
>>>>>  
>>>>>  		err = -ENOTEMPTY;
>>>>>  		if (old_dir_entry && !f2fs_empty_dir(new_inode))
>>>>> -			goto out_whiteout;
>>>>> +			goto out_dir;
>>>>>  
>>>>>  		err = -ENOENT;
>>>>>  		new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name,
>>>>> @@ -916,7 +917,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>>>  		if (!new_entry) {
>>>>>  			if (IS_ERR(new_page))
>>>>>  				err = PTR_ERR(new_page);
>>>>> -			goto out_whiteout;
>>>>> +			goto out_dir;
>>>>>  		}
>>>>>  
>>>>>  		f2fs_balance_fs(sbi, true);
>>>>> @@ -948,7 +949,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>>>  		err = f2fs_add_link(new_dentry, old_inode);
>>>>>  		if (err) {
>>>>>  			f2fs_unlock_op(sbi);
>>>>> -			goto out_whiteout;
>>>>> +			goto out_dir;
>>>>>  		}
>>>>>  
>>>>>  		if (old_dir_entry)
>>>>> @@ -972,7 +973,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>>>  				if (IS_ERR(old_page))
>>>>>  					err = PTR_ERR(old_page);
>>>>>  				f2fs_unlock_op(sbi);
>>>>> -				goto out_whiteout;
>>>>> +				goto out_dir;
>>>>>  			}
>>>>>  		}
>>>>>  	}
>>>>> @@ -991,7 +992,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>>>  	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
>>>>>  
>>>>>  	if (whiteout) {
>>>>> -		whiteout->i_state |= I_LINKABLE;
>>>>>  		set_inode_flag(whiteout, FI_INC_LINK);
>>>>>  		err = f2fs_add_link(old_dentry, whiteout);
>>>>
>>>> [ 3189.256353]  f2fs_do_add_link+0xc5/0x100 [f2fs]
>>>> [ 3189.258774]  f2fs_rename2+0xabf/0x1010 [f2fs]
>>>>
>>>> Does the call stack point here? if so, we have set I_LINKABLE before
>>>> f2fs_add_link(), why the warning still be triggered?
>>
>> Am I missing something?
> 
> Not sure exactly tho, I suspect some races before/after unlock_new_inode().

Alright, I doubt some races on whiteout->i_state updating, as we set I_LINKABLE
w/o holding inode.i_lock.

Could you have a try with holding i_lock?

Thanks,

> 
>>
>> Thanks,
>>
>>>>
>>>> Thanks,
>>>>
>>>>>  		if (err)
>>>>> @@ -1027,15 +1027,14 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>>>  	f2fs_unlock_op(sbi);
>>>>>  	if (new_page)
>>>>>  		f2fs_put_page(new_page, 0);
>>>>> -out_whiteout:
>>>>> -	if (whiteout)
>>>>> -		iput(whiteout);
>>>>>  out_dir:
>>>>>  	if (old_dir_entry)
>>>>>  		f2fs_put_page(old_dir_page, 0);
>>>>>  out_old:
>>>>>  	f2fs_put_page(old_page, 0);
>>>>>  out:
>>>>> +	if (whiteout)
>>>>> +		iput(whiteout);
>>>>>  	return err;
>>>>>  }
>>>>>  
>>>>>
>>> .
>>>
> .
> 
