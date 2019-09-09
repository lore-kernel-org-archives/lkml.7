Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58690C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E4B218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfIIH7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:59:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfIIH7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:59:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F40D795C93E5CD7BE2F8;
        Mon,  9 Sep 2019 15:59:18 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019
 15:59:15 +0800
Subject: Re: [PATCH] f2fs: fix to avoid accessing uninitialized field of inode
 page in is_alive()
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190906105426.109151-1-yuchao0@huawei.com>
 <20190906234808.GC71848@jaegeuk-macbookpro.roam.corp.google.com>
 <080e8dee-4726-8294-622a-cac26e781083@kernel.org>
 <20190909074425.GB21625@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <79228eaa-776f-da89-89f8-a9b5a90034b6@huawei.com>
Date:   Mon, 9 Sep 2019 15:58:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190909074425.GB21625@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/9 15:44, Jaegeuk Kim wrote:
> On 09/07, Chao Yu wrote:
>> On 2019-9-7 7:48, Jaegeuk Kim wrote:
>>> On 09/06, Chao Yu wrote:
>>>> If inode is newly created, inode page may not synchronize with inode cache,
>>>> so fields like .i_inline or .i_extra_isize could be wrong, in below call
>>>> path, we may access such wrong fields, result in failing to migrate valid
>>>> target block.
>>>
>>> If data is valid, how can we get new inode page?
> 
> Let me rephrase the question. If inode is newly created, is this data block
> really valid to move in GC?

I guess it's valid, let double check that.

> 
>>
>> is_alive()
>> {
>> ...
>> 	node_page = f2fs_get_node_page(sbi, nid);  <--- inode page
> 
> Aren't we seeing the below version warnings?
> 
> if (sum->version != dni->version) {
> 	f2fs_warn(sbi, "%s: valid data with mismatched node version.",
>                            __func__);
>         set_sbi_flag(sbi, SBI_NEED_FSCK);
> }
> 
>>
>> 	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
> 
> So, we're getting this? Does this incur infinite loop in GC?
> 
> if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
> 	f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
> 	f2fs_bug_on(sbi, 1);
> }

Yes, I only get this with generic/269, rather than "valid data with mismatched
node version.".

With this patch, generic/269 won't panic again.

Thanks,

> 
>> ...
>> }
>>
>> datablock_addr()
>> {
>> ...
>> 	base = offset_in_addr(&raw_node->i);  <--- the base could be wrong here due to
>> accessing uninitialized .i_inline of raw_node->i.
>> ...
>> }
>>
>> Thanks,
>>
>>>
>>>>
>>>> - gc_data_segment
>>>>  - is_alive
>>>>   - datablock_addr
>>>>    - offset_in_addr
>>>>
>>>> Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/dir.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>>> index 765f13354d3f..b1840852967e 100644
>>>> --- a/fs/f2fs/dir.c
>>>> +++ b/fs/f2fs/dir.c
>>>> @@ -479,6 +479,9 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
>>>>  		if (IS_ERR(page))
>>>>  			return page;
>>>>  
>>>> +		/* synchronize inode page's data from inode cache */
>>>> +		f2fs_update_inode(inode, page);
>>>> +
>>>>  		if (S_ISDIR(inode->i_mode)) {
>>>>  			/* in order to handle error case */
>>>>  			get_page(page);
>>>> -- 
>>>> 2.18.0.rc1
> .
> 
