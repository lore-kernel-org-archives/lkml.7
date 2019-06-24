Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1DFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEA92063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFXBwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:52:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19061 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbfFXBwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:52:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5CCA224ABF6BFC940E38;
        Mon, 24 Jun 2019 09:06:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 24 Jun
 2019 09:06:38 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add a rw_sem to cover quota flag
 changes
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190530033115.16853-1-jaegeuk@kernel.org>
 <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
 <20190604183619.GA8507@jaegeuk-macbookpro.roam.corp.google.com>
 <2afe0416-fe2d-8ba8-7625-0246aca9eba6@huawei.com>
 <20190614024655.GA18113@jaegeuk-macbookpro.roam.corp.google.com>
 <6f70ae56-45eb-666d-ae55-48eb0cc96f32@huawei.com>
 <20190619172651.GB57884@jaegeuk-macbookpro.roam.corp.google.com>
 <ba6555c9-b864-d0cc-1c65-4077e7f15175@huawei.com>
 <20190621173807.GB79502@jaegeuk-macbookpro.roam.corp.google.com>
 <20190621175135.GC79502@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8c1eb98f-6d32-7ceb-5ae5-ba0234d38f78@huawei.com>
Date:   Mon, 24 Jun 2019 09:06:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190621175135.GC79502@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/22 1:51, Jaegeuk Kim wrote:
> On 06/21, Jaegeuk Kim wrote:
>> On 06/20, Chao Yu wrote:
>>> On 2019/6/20 1:26, Jaegeuk Kim wrote:
>>>> On 06/18, Chao Yu wrote:
>>>>> On 2019/6/14 10:46, Jaegeuk Kim wrote:
>>>>>> On 06/11, Chao Yu wrote:
>>>>>>> On 2019/6/5 2:36, Jaegeuk Kim wrote:
>>>>>>>> Two paths to update quota and f2fs_lock_op:
>>>>>>>>
>>>>>>>> 1.
>>>>>>>>  - lock_op
>>>>>>>>  |  - quota_update
>>>>>>>>  `- unlock_op
>>>>>>>>
>>>>>>>> 2.
>>>>>>>>  - quota_update
>>>>>>>>  - lock_op
>>>>>>>>  `- unlock_op
>>>>>>>>
>>>>>>>> But, we need to make a transaction on quota_update + lock_op in #2 case.
>>>>>>>> So, this patch introduces:
>>>>>>>> 1. lock_op
>>>>>>>> 2. down_write
>>>>>>>> 3. check __need_flush
>>>>>>>> 4. up_write
>>>>>>>> 5. if there is dirty quota entries, flush them
>>>>>>>> 6. otherwise, good to go
>>>>>>>>
>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> v3 from v2:
>>>>>>>>  - refactor to fix quota corruption issue
>>>>>>>>   : it seems that the previous scenario is not real and no deadlock case was
>>>>>>>>     encountered.
>>>>>>>
>>>>>>> - f2fs_dquot_commit
>>>>>>>  - down_read(&sbi->quota_sem)
>>>>>>> 					- block_operation
>>>>>>> 					 - f2fs_lock_all
>>>>>>> 					  - need_flush_quota
>>>>>>> 					   - down_write(&sbi->quota_sem)
>>>>>>>   - f2fs_quota_write
>>>>>>>    - f2fs_lock_op
>>>>>>>
>>>>>>> Why can't this happen?
>>>>>>>
>>>>>>> Once more question, should we hold quota_sem during checkpoint to avoid further
>>>>>>> quota update? f2fs_lock_op can do this job as well?
>>>>>>
>>>>>> I couldn't find write_dquot() call to make this happen, and f2fs_lock_op was not
>>>>>
>>>>> - f2fs_dquot_commit
>>>>>  - dquot_commit
>>>>>   ->commit_dqblk (v2_write_dquot)
>>>>>    - qtree_write_dquot
>>>>>     ->quota_write (f2fs_quota_write)
>>>>>      - f2fs_lock_op
>>>>>
>>>>> Do you mean there is no such way that calling f2fs_lock_op() from
>>>>> f2fs_quota_write()? So that deadlock condition is not existing?
>>>>
>>>> I mean write_dquot->f2fs_dquot_commit and block_operation seems not racing
>>>> together.
>>>
>>> quota ioctl has the path calling write_dquot->f2fs_dquot_commit as below, which
>>> can race with checkpoint().
>>>
>>> - do_quotactl
>>>  - sb->s_qcop->quota_sync (f2fs_quota_sync)
>>>   - down_read(&sbi->quota_sem);      ----  First
>>>    - dquot_writeback_dquots
>>>     - sb->dq_op->write_dquot (f2fs_dquot_commit)
>>> 							- block_operation can race here
>>>      - down_read(&sbi->quota_sem);   ----  Second
>>
>> Adding f2fs_lock_op() in f2fs_quota_sync() should be fine?
> 
> Something like this?

I'm okay with this diff. :)

Thanks,

> 
> ---
>  fs/f2fs/super.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7f2829b1192e..1d33ca1a8c09 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1919,6 +1919,17 @@ int f2fs_quota_sync(struct super_block *sb, int type)
>  	int cnt;
>  	int ret;
>  
> +	/*
> +	 * do_quotactl
> +	 *  f2fs_quota_sync
> +	 *  down_read(quota_sem)
> +	 *  dquot_writeback_dquots()
> +	 *  f2fs_dquot_commit
> +	 *                            block_operation
> +	 *                            down_read(quota_sem)
> +	 */
> +	f2fs_lock_op(sbi);
> +
>  	down_read(&sbi->quota_sem);
>  	ret = dquot_writeback_dquots(sb, type);
>  	if (ret)
> @@ -1958,6 +1969,7 @@ int f2fs_quota_sync(struct super_block *sb, int type)
>  	if (ret)
>  		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>  	up_read(&sbi->quota_sem);
> +	f2fs_unlock_op(sbi);
>  	return ret;
>  }
>  
> 
