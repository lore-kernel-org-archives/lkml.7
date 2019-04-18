Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15487C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B12217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbfDRA5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:57:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2541 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729331AbfDRA5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:57:16 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 79A5A18C1165C9251781;
        Thu, 18 Apr 2019 08:57:13 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 18 Apr 2019 08:57:12 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 18 Apr 2019 08:57:12 +0800
Subject: Re: linux-next: build warning after merge of the block tree
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20190417123125.3de22f73@canb.auug.org.au>
 <0879e11b-c84c-65b8-581f-bf7adcb5e231@huawei.com>
 <20190417140305.GB23731@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b1fcb057-6d89-9846-766b-dd1b710f7654@huawei.com>
Date:   Thu, 18 Apr 2019 08:57:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190417140305.GB23731@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/17 22:03, Jaegeuk Kim wrote:
> On 04/17, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2019/4/17 10:31, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the block tree, today's linux-next build (x86_64
>>> allmodconfig) produced this warning:
>>>
>>> fs/f2fs/node.c: In function 'f2fs_remove_inode_page':
>>> fs/f2fs/node.c:1193:47: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'blkcnt_t' {aka 'long long unsigned int'} [-Wformat=]
>>>     "Inconsistent i_blocks, ino:%lu, iblocks:%zu",
>>>                                              ~~^
>>>                                              %llu
>>>     inode->i_ino, inode->i_blocks);
>>>                   ~~~~~~~~~~~~~~~       
>>
>> Could you please help to fix that as below in your dev branch directly?
>>
>> "Inconsistent i_blocks, ino:%lu, iblocks:%llu",
> 
> We can just use "%lu"?

We'd better follow sample in Documentation/core-api/printk-formats.rst:

If <type> is dependent on a config option for its size (e.g., sector_t,
blkcnt_t) or is architecture-dependent for its size (e.g., tcflag_t), use a
format specifier of its largest possible type and explicitly cast to it.

Example::

        printk("test: sector number/total blocks: %llu/%llu\n",
                (unsigned long long)sector, (unsigned long long)blockcount);

Thanks,

> 
>> inode->i_ino, (unsigned long long)inode->i_blocks)
>>
>>
>> It looks that we need to fix below commits as well:
>>
>> f2fs: fix to avoid panic in dec_valid_block_count()
>> f2fs: fix to avoid panic in dec_valid_node_count()
>>
>> Thanks,
>>
>>>
>>> Introduced by commit
>>>
>>>   90ae238d9dac ("f2fs: fix to avoid panic in f2fs_remove_inode_page()")
>>>
>>> from the f2fs tree interacting with commit
>>>
>>>   72deb455b5ec ("block: remove CONFIG_LBDAF")
>>>
> .
> 
