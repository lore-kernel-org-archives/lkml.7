Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B2D2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390444AbfJWImt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:42:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:43742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390272AbfJWImt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:42:49 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 11C1CFFCF3A22F217689;
        Wed, 23 Oct 2019 16:42:45 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 16:42:44 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 23 Oct 2019 16:42:44 +0800
Date:   Wed, 23 Oct 2019 16:45:36 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     Chao Yu <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Gao Xiang <xiang@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] erofs: support superblock checksum
Message-ID: <20191023084536.GA16289@architecture4>
References: <20191022180620.19638-1-pratikshinde320@gmail.com>
 <20191023040557.230886-1-gaoxiang25@huawei.com>
 <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Oct 23, 2019 at 04:15:29PM +0800, Chao Yu wrote:
> Hi, Xiang, Pratik,
> 
> On 2019/10/23 12:05, Gao Xiang wrote:

<snip>

> >  }
> >  
> > +static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
> > +{
> > +	struct erofs_super_block *dsb;
> > +	u32 expected_crc, nblocks, crc;
> > +	void *kaddr;
> > +	struct page *page;
> > +	int i;
> > +
> > +	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
> > +		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
> > +	if (!dsb)
> > +		return -ENOMEM;
> > +
> > +	expected_crc = le32_to_cpu(dsb->checksum);
> > +	nblocks = le32_to_cpu(dsb->chksum_blocks);
> 
> Now, we try to use nblocks's value before checking its validation, I guess fuzz
> test can easily make the value extreme larger, result in checking latter blocks
> unnecessarily.
> 
> IMO, we'd better
> 1. check validation of superblock to make sure all fields in sb are valid
> 2. use .nblocks to count and check payload blocks following sb

That is quite a good point. :-)

My first thought is to check the following payloads of sb (e.g, some per-fs
metadata should be checked at mount time together. or for small images, check
the whole image at the mount time) as well since if we introduce a new feature
to some kernel version, forward compatibility needs to be considered. So it's
better to make proper scalability, for this case, we have some choices:
 1) limit `chksum_blocks' upbound at runtime (e.g. refuse >= 65536 blocks,
    totally 256M.)
 2) just get rid of the whole `chksum_blocks' mess and checksum the first 4k
    at all, don't consider any latter scalability.

Some perferred idea about this? I plan to release erofs-utils v1.0 tomorrow
and hold up this feature for the next erofs-utils release, but I think we can
get it ready for v5.5 since it is not quite complex feature...

Thanks,
Gao Xiang

