Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA80C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419862084D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403812AbfIILGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:06:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729692AbfIILGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:06:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D0E9A9812A091B1CFB3D;
        Mon,  9 Sep 2019 19:05:59 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019
 19:05:57 +0800
Subject: Re: [PATCH] f2fs: fix to avoid accessing uninitialized field of inode
 page in is_alive()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190906105426.109151-1-yuchao0@huawei.com>
 <20190906234808.GC71848@jaegeuk-macbookpro.roam.corp.google.com>
 <080e8dee-4726-8294-622a-cac26e781083@kernel.org>
 <20190909074425.GB21625@jaegeuk-macbookpro.roam.corp.google.com>
 <79228eaa-776f-da89-89f8-a9b5a90034b6@huawei.com>
 <873f4c07-5694-6554-5266-81812a6bd617@huawei.com>
 <20190909083725.GB25724@jaegeuk-macbookpro.roam.corp.google.com>
 <05393d3c-b78d-3bb3-ff26-64d2d3939618@huawei.com>
 <20190909093355.GA27742@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <94ea2431-d4da-f1bf-d949-3c36948aeeca@huawei.com>
Date:   Mon, 9 Sep 2019 19:05:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190909093355.GA27742@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/9 17:33, Jaegeuk Kim wrote:
> On 09/09, Chao Yu wrote:
>> On 2019/9/9 16:37, Jaegeuk Kim wrote:
>>> On 09/09, Chao Yu wrote:
>>>> On 2019/9/9 15:58, Chao Yu wrote:
>>>>> On 2019/9/9 15:44, Jaegeuk Kim wrote:
>>>>>> On 09/07, Chao Yu wrote:
>>>>>>> On 2019-9-7 7:48, Jaegeuk Kim wrote:
>>>>>>>> On 09/06, Chao Yu wrote:
>>>>>>>>> If inode is newly created, inode page may not synchronize with inode cache,
>>>>>>>>> so fields like .i_inline or .i_extra_isize could be wrong, in below call
>>>>>>>>> path, we may access such wrong fields, result in failing to migrate valid
>>>>>>>>> target block.
>>>>>>>>
>>>>>>>> If data is valid, how can we get new inode page?
>>>>>>
>>>>>> Let me rephrase the question. If inode is newly created, is this data block
>>>>>> really valid to move in GC?
>>>>>
>>>>> I guess it's valid, let double check that.
>>>>
>>>> We can see inode page:
>>>>
>>>> - f2fs_create
>>>>  - f2fs_add_link
>>>>   - f2fs_add_dentry
>>>>    - f2fs_init_inode_metadata
>>>>     - f2fs_add_inline_entry
>>>>      - ipage = f2fs_new_inode_page
>>>>      - f2fs_put_page(ipage)   <---- after this
>>>
>>> Can you print out how many block was assigned to this inode?
>>
>> Add log like this:
>>
>> 		if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
>> 			if (is_inode) {
>> 				for (i = 0; i < 923 - 50; i++) {
>> 					__le32 *base = blkaddr_in_node(node);
>> 					unsigned ofs = offset_in_addr(inode);
>>
>> 					printk("i:%u, addr:%x\n", i,
>> 						le32_to_cpu(*(base + i)));
>> 				}
>> 				printk("i_inline: %u\n", inode->i_inline);
>> 			}
>>
>> It shows:
>> ...
>> i:10, addr:e66a
>> ...
>> i:46, addr:e66c
>> i:47, addr:e66d
>> i:48, addr:e66e
>> i:49, addr:e66f
>> i:50, addr:e670
>> i:51, addr:e671
>> i:52, addr:e672
>> i:53, addr:e673
>> i:54, addr:e674
>> i:55, addr:e675
>> i:56, addr:e676
>> ...
>> i:140, addr:2c35    <--- we want to migrate this block, however, without correct
>> .i_inline and .i_extra_isize value, we can just find i_addr[i:140-6] = NULL_ADDR
> 
> So, the theory is the block is indeed valid and the address was updated before
> write_inode()?

I guess so. :)

Thanks,

> 
>> i:141, addr:2c38
>> i:142, addr:2c39
>> i:143, addr:2c3b
>> i:144, addr:2c3e
>> i:145, addr:2c40
>> i:146, addr:2c44
>> i:147, addr:2c48
>> i:148, addr:2c4a
>> i:149, addr:2c4c
>> i:150, addr:2c4f
>> i:151, addr:2c59
>> i:152, addr:2c5d
>> ...
>> i:188, addr:e677
>> i:189, addr:e678
>> i:190, addr:e679
>> i:191, addr:e67a
>> i:192, addr:e67b
>> i:193, addr:e67c
>> i:194, addr:e67d
>> i:195, addr:e67e
>> i:196, addr:e67f
>> i:197, addr:e680
>> i:198, addr:ffffffff
>> i:199, addr:ffffffff
>> i:200, addr:ffffffff
>> i:201, addr:ffffffff
>> i:202, addr:ffffffff
>> i:203, addr:ffffffff
>> i:204, addr:ffffffff
>> i:205, addr:ffffffff
>> i:206, addr:ffffffff
>> i:207, addr:ffffffff
>> i:208, addr:ffffffff
>> i:209, addr:ffffffff
>> i:210, addr:ffffffff
>> i:211, addr:ffffffff
>> i:212, addr:ffffffff
>> i:213, addr:ffffffff
>> i:214, addr:ffffffff
>> i:215, addr:ffffffff
>> i:216, addr:ffffffff
>> i:217, addr:ffffffff
>> i:218, addr:ffffffff
>> i:219, addr:ffffffff
>> i:220, addr:ffffffff
>> i:221, addr:ffffffff
>> i:222, addr:ffffffff
>> i:223, addr:ffffffff
>> i:224, addr:ffffffff
>> i:225, addr:ffffffff
>> i:226, addr:ffffffff
>> i:227, addr:ffffffff
>> i:228, addr:ffffffff
>> i:229, addr:ffffffff
>> i:230, addr:ffffffff
>> i:231, addr:ffffffff
>> i:232, addr:ffffffff
>> i:233, addr:ffffffff
>> i:234, addr:b032
>> i:235, addr:b033
>> i:236, addr:b034
>> i:237, addr:b035
>> i:238, addr:b036
>> i:239, addr:b038
>> ...
>> i:283, addr:e681
>> ...
>> i_inline: 0
>>
>> F2FS-fs (zram1): summary nid: 360, ofs: 134, ver: 0
>> F2FS-fs (zram1): blkaddr 2c35 (blkaddr in node 0) <-blkaddr in node is NULL_ADDR
>> F2FS-fs (zram1): expect: seg 14, ofs_in_seg: 53
>> F2FS-fs (zram1): real: seg 4294967295, ofs_in_seg: 0
>> F2FS-fs (zram1): ofs: 53, 0
>> F2FS-fs (zram1): node info ino:360, nid:360, nofs:0
>> F2FS-fs (zram1): ofs_in_addr: 0
>> F2FS-fs (zram1): end ========
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> is_alive()
>>>>>>> {
>>>>>>> ...
>>>>>>> 	node_page = f2fs_get_node_page(sbi, nid);  <--- inode page
>>>>>>
>>>>>> Aren't we seeing the below version warnings?
>>>>>>
>>>>>> if (sum->version != dni->version) {
>>>>>> 	f2fs_warn(sbi, "%s: valid data with mismatched node version.",
>>>>>>                            __func__);
>>>>>>         set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>> }
>>>>
>>>> The version of summary and dni are all zero.
>>>
>>> Then, this node was allocated and removed without being flushed.
>>>
>>>>
>>>> summary nid: 613, ofs: 111, ver: 0
>>>> blkaddr 2436 (blkaddr in node 0)
>>>> expect: seg 10, ofs_in_seg: 54
>>>> real: seg 4294967295, ofs_in_seg: 0
>>>> ofs: 54, 0
>>>> node info ino:613, nid:613, nofs:0
>>>> ofs_in_addr: 0
>>>>
>>>> Thanks,
>>>>
>>>>>>
>>>>>>>
>>>>>>> 	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
>>>>>>
>>>>>> So, we're getting this? Does this incur infinite loop in GC?
>>>>>>
>>>>>> if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
>>>>>> 	f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
>>>>>> 	f2fs_bug_on(sbi, 1);
>>>>>> }
>>>>>
>>>>> Yes, I only get this with generic/269, rather than "valid data with mismatched
>>>>> node version.".
>>>
>>> Was this block moved as valid? In either way, is_alive() returns false, no?
>>> How about checking i_blocks to detect the page is initialized in is_alive()?
>>>
>>>>>
>>>>> With this patch, generic/269 won't panic again.
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>> ...
>>>>>>> }
>>>>>>>
>>>>>>> datablock_addr()
>>>>>>> {
>>>>>>> ...
>>>>>>> 	base = offset_in_addr(&raw_node->i);  <--- the base could be wrong here due to
>>>>>>> accessing uninitialized .i_inline of raw_node->i.
>>>>>>> ...
>>>>>>> }
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> - gc_data_segment
>>>>>>>>>  - is_alive
>>>>>>>>>   - datablock_addr
>>>>>>>>>    - offset_in_addr
>>>>>>>>>
>>>>>>>>> Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
>>>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>>> ---
>>>>>>>>>  fs/f2fs/dir.c | 3 +++
>>>>>>>>>  1 file changed, 3 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>>>>>>>> index 765f13354d3f..b1840852967e 100644
>>>>>>>>> --- a/fs/f2fs/dir.c
>>>>>>>>> +++ b/fs/f2fs/dir.c
>>>>>>>>> @@ -479,6 +479,9 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
>>>>>>>>>  		if (IS_ERR(page))
>>>>>>>>>  			return page;
>>>>>>>>>  
>>>>>>>>> +		/* synchronize inode page's data from inode cache */
>>>>>>>>> +		f2fs_update_inode(inode, page);
>>>>>>>>> +
>>>>>>>>>  		if (S_ISDIR(inode->i_mode)) {
>>>>>>>>>  			/* in order to handle error case */
>>>>>>>>>  			get_page(page);
>>>>>>>>> -- 
>>>>>>>>> 2.18.0.rc1
>>>>>> .
>>>>>>
>>> .
>>>
> .
> 
