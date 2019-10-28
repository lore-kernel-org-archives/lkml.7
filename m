Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CAECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBA2205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbfJ1MgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:36:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389043AbfJ1MgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:36:11 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21712E3E9323C23C9E06;
        Mon, 28 Oct 2019 20:36:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 28 Oct
 2019 20:36:01 +0800
Subject: Re: [PATCH v4] erofs: support superblock checksum
To:     Gao Xiang <gaoxiang25@huawei.com>
CC:     Chao Yu <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Gao Xiang <xiang@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191022180620.19638-1-pratikshinde320@gmail.com>
 <20191023040557.230886-1-gaoxiang25@huawei.com>
 <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
 <20191023084536.GA16289@architecture4>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <df7d7427-e7ca-5135-5db2-640eda30d253@huawei.com>
Date:   Mon, 28 Oct 2019 20:36:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023084536.GA16289@architecture4>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/23 16:45, Gao Xiang wrote:
> Hi Chao,
> 
> On Wed, Oct 23, 2019 at 04:15:29PM +0800, Chao Yu wrote:
>> Hi, Xiang, Pratik,
>>
>> On 2019/10/23 12:05, Gao Xiang wrote:
> 
> <snip>
> 
>>>  }
>>>  
>>> +static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
>>> +{
>>> +	struct erofs_super_block *dsb;
>>> +	u32 expected_crc, nblocks, crc;
>>> +	void *kaddr;
>>> +	struct page *page;
>>> +	int i;
>>> +
>>> +	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
>>> +		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
>>> +	if (!dsb)
>>> +		return -ENOMEM;
>>> +
>>> +	expected_crc = le32_to_cpu(dsb->checksum);
>>> +	nblocks = le32_to_cpu(dsb->chksum_blocks);
>>
>> Now, we try to use nblocks's value before checking its validation, I guess fuzz
>> test can easily make the value extreme larger, result in checking latter blocks
>> unnecessarily.
>>
>> IMO, we'd better
>> 1. check validation of superblock to make sure all fields in sb are valid
>> 2. use .nblocks to count and check payload blocks following sb
> 
> That is quite a good point. :-)
> 
> My first thought is to check the following payloads of sb (e.g, some per-fs
> metadata should be checked at mount time together. or for small images, check
> the whole image at the mount time) as well since if we introduce a new feature
> to some kernel version, forward compatibility needs to be considered. So it's
> better to make proper scalability, for this case, we have some choices:
>  1) limit `chksum_blocks' upbound at runtime (e.g. refuse >= 65536 blocks,
>     totally 256M.)
>  2) just get rid of the whole `chksum_blocks' mess and checksum the first 4k
>     at all, don't consider any latter scalability.

Xiang, sorry for later reply...

I prefer method 2), let's enable chksum feature only on superblock first,
chksum_blocks feature can be added later.

Thanks,

> 
> Some perferred idea about this? I plan to release erofs-utils v1.0 tomorrow
> and hold up this feature for the next erofs-utils release, but I think we can
> get it ready for v5.5 since it is not quite complex feature...
> 
> Thanks,
> Gao Xiang
> 
> .
> 
