Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97956C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727142080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbfITOOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:14:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387716AbfITOOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:14:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 325F7AD5DC0900924C3E;
        Fri, 20 Sep 2019 22:14:01 +0800 (CST)
Received: from [127.0.0.1] (10.57.88.168) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 22:13:53 +0800
Subject: Re: [PATCH] jffs2:freely allocate memory when parameters are invalid
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <dwmw2@infradead.org>, <dilinger@queued.net>, <richard@nod.at>,
        <houtao1@huawei.com>, <bbrezillon@kernel.org>,
        <daniel.santos@pobox.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
 <20190920114336.GM1131@ZenIV.linux.org.uk>
 <206f8d57-dad9-26c3-6bf6-1d000f5698d4@huawei.com>
 <20190920124532.GN1131@ZenIV.linux.org.uk>
 <20190920125442.GA20754@ZenIV.linux.org.uk>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <eb679ad2-4020-951c-e4d1-60cb059a5ca8@huawei.com>
Date:   Fri, 20 Sep 2019 22:13:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920125442.GA20754@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.88.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/20 20:54, Al Viro wrote:
> On Fri, Sep 20, 2019 at 01:45:33PM +0100, Al Viro wrote:
>> On Fri, Sep 20, 2019 at 08:21:53PM +0800, Xiaoming Ni wrote:
>>>
>>>
>>> On 2019/9/20 19:43, Al Viro wrote:
>>>> On Fri, Sep 20, 2019 at 02:54:38PM +0800, Xiaoming Ni wrote:
>>>>> Use kzalloc() to allocate memory in jffs2_fill_super().
>>>>> Freeing memory when jffs2_parse_options() fails will cause
>>>>> use-after-free and double-free in jffs2_kill_sb()
>>>>
>>>> ... so we are not freeing it there.  What's the problem?
>>>
>>> No code logic issues, no memory leaks
>>>
>>> But there is too much code logic between memory allocation and free,
>>> which is difficult to understand.
>>
>> Er?  An instance of jffs2 superblock might have a related object
>> attached to it; it is created in jffs2 superblock constructor and
>> freed in destructor.
>>
>>> The modified code is easier to understand.
>>
>> You are making the cleanup logics harder to follow.
> 
> PS: the whole point of ->kill_sb() is that it's always called on
> superblock destruction, whether that instance had been fully set
> up of failed halfway through.
> 
> In particular, anything like foofs_fill_super() *will* be followed
> by ->kill_sb().  Always.  Which allows for simpler logics in
> failure exits.  And the main thing about those is that they are
> always the bitrot hot spots - they are systematically undertested,
> so that's the last place where you want something non-trivial.
> 
> As for "too much code between"...  Huh?  We fail jffs2_fill_super()
> immediately, which has get_tree_mtd() (or mount_mtd() in slightly
> earlier kernels) destroy the superblock there and then...
> 

Currently releasing jffs2_sb_info in jffs2_kill_sb(),
Then the current code path is
1. drivers/mtd/mtdsuper.c
mount_mtd_aux() {
....
   /* jffs2_sb_info is allocated in jffs2_fill_super, */
    ret = fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
    if (ret < 0) {
        deactivate_locked_super(sb); /* If the parameter is wrong, release it here*/
        return ERR_PTR(ret);
    }
...
}

2. fs/super.c
deactivate_locked_super()
---> fs->kill_sb(s);

3. fs/jffs2/super.c
 jffs2_kill_sb()
    kfree(c); /*release jffs2_sb_info allocated by jffs2_fill_super here

Here memory allocation and release,
experienced the function of mount_mtd_aux/deactivate_locked_super/jffs2_kill_sb three different files,
the path is relatively long,
if any of the three functions between the errors,
it will cause problems (such as memory leaks)

Analyze the code of jffs2_kill_sb:
static void jffs2_kill_sb(struct super_block *sb)
{
    struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
    if (c && !sb_rdonly(sb))
		/* If sb is not read only,
		 * then jffs2_stop_garbage_collect_thread() will be executed
		 * when the jffs2_fill_super parameter is invalid.
		 */
        jffs2_stop_garbage_collect_thread(c);
    kill_mtd_super(sb);
    kfree(c);
}

void jffs2_stop_garbage_collect_thread(struct jffs2_sb_info *c)
{
    int wait = 0;
	/* When the jffs2_fill_super parameter is invalid,
	 * this lock is not initialized.
	 * Is this a code problem ?
	 */
    spin_lock(&c->erase_completion_lock);
.....

I still think this is easier to understand:
 Free the memory allocated by the current function in the failed branch

thanks
Xiaoming Ni

