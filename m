Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16A3C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E7120835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfDQKFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:05:34 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:45662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729039AbfDQKFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:05:33 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 4A6F8C364437082983B6;
        Wed, 17 Apr 2019 18:05:31 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 17 Apr 2019 18:05:30 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 17 Apr 2019 18:05:30 +0800
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20190417123125.3de22f73@canb.auug.org.au>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0879e11b-c84c-65b8-581f-bf7adcb5e231@huawei.com>
Date:   Wed, 17 Apr 2019 18:05:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190417123125.3de22f73@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2019/4/17 10:31, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> fs/f2fs/node.c: In function 'f2fs_remove_inode_page':
> fs/f2fs/node.c:1193:47: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'blkcnt_t' {aka 'long long unsigned int'} [-Wformat=]
>     "Inconsistent i_blocks, ino:%lu, iblocks:%zu",
>                                              ~~^
>                                              %llu
>     inode->i_ino, inode->i_blocks);
>                   ~~~~~~~~~~~~~~~       

Could you please help to fix that as below in your dev branch directly?

"Inconsistent i_blocks, ino:%lu, iblocks:%llu",
inode->i_ino, (unsigned long long)inode->i_blocks)


It looks that we need to fix below commits as well:

f2fs: fix to avoid panic in dec_valid_block_count()
f2fs: fix to avoid panic in dec_valid_node_count()

Thanks,

> 
> Introduced by commit
> 
>   90ae238d9dac ("f2fs: fix to avoid panic in f2fs_remove_inode_page()")
> 
> from the f2fs tree interacting with commit
> 
>   72deb455b5ec ("block: remove CONFIG_LBDAF")
> 
