Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD25C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ADB2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKUCgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:36:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfKUCgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:36:36 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D29A86C6613290C8A35D;
        Thu, 21 Nov 2019 10:36:34 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 21 Nov 2019
 10:36:06 +0800
Subject: Re: [PATCH] tmpfs: use ida to get inode number
To:     Matthew Wilcox <willy@infradead.org>
CC:     <viro@zeniv.linux.org.uk>, <hughd@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
 <20191120154552.GS20752@bombadil.infradead.org>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com>
Date:   Thu, 21 Nov 2019 10:36:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191120154552.GS20752@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/20 23:45, Matthew Wilcox wrote:
> On Wed, Nov 20, 2019 at 10:23:18PM +0800, zhengbin wrote:
>> I have tried to change last_ino type to unsigned long, while this was
>> rejected, see details on https://patchwork.kernel.org/patch/11023915.
> Did you end up trying sbitmap?

Maybe sbitmap is not a good solution, max_inodes of tmpfs are controlled by mount options--nrinodes,

which can be modified by remountfs(bigger or smaller), as the comment of function sbitmap_resize says:

 * Doesn't reallocate anything. It's up to the caller to ensure that the new
 * depth doesn't exceed the depth that the sb was initialized with.

We can modify this to meet the growing requirements, there will still be questions as follows:

1. tmpfs is a ram filesystem, we need to allocate sbitmap memory for sbinfo->max_inodes(while this maybe huge)

2.If remountfs changes  max_inode, we have to deal with it, while this may take a long time

(bigger: we need to free the old sbitmap memory, allocate new memory, copy the old sbitmap to new sbitmap

smaller: How do we deal with it?ie: we use sb->map[inode number/8] to find the sbitmap, we need to change the exist

inode numbers?while this maybe used by userspace application.)

>
> What I think is fundamentally wrong with this patch is that you've found a
> problem in get_next_ino() and decided to use a different scheme for this
> one filesystem, leaving every other filesystem which uses get_next_ino()
> facing the same problem.
>
> That could be acceptable if you explained why tmpfs is fundamentally
> different from all the other filesystems that use get_next_ino(), but
> you haven't (and I don't think there is such a difference.  eg pipes,
> autofs and ipc mqueue could all have the same problem.

tmpfs is same with all the other filesystems that use get_next_ino(), but we need to solve this problem one by one.

If tmpfs is ok, we can modify the other filesystems too. Besides, I do not  recommend all file systems share the same

global variable, for performance impact consideration.

>
> There are some other problems I noticed, but they're not worth bringing
> up until this fundamental design choice is justified.
Agree, thanks.
>

