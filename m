Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F086C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF91B206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDDCSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:18:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDDCSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:18:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [10.3.19.212])
        by Forcepoint Email with ESMTP id 2F7561A4B14E1AAFF1C4;
        Thu,  4 Apr 2019 10:18:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 10:18:05 +0800
Subject: Re: [PATCH] iov_iter: Fix build error without CONFIG_CRYPTO
To:     Al Viro <viro@zeniv.linux.org.uk>
References: <20190403095031.11720-1-yuehaibing@huawei.com>
 <20190403165215.GQ2217@ZenIV.linux.org.uk>
CC:     <davem@davemloft.net>, <willemb@google.com>, <edumazet@google.com>,
        <fw@strlen.de>, <sagi@lightbitslabs.com>, <hch@lst.de>,
        <pabeni@redhat.com>, <pctammela@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <5277a8e8-bb0a-1a15-7cdf-02409f436773@huawei.com>
Date:   Thu, 4 Apr 2019 10:18:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190403165215.GQ2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/4 0:52, Al Viro wrote:
> On Wed, Apr 03, 2019 at 05:50:31PM +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> If CONFIG_CRYPTO is not set or set to m,
>> gcc building warn this:
>>
>> lib/iov_iter.o: In function `hash_and_copy_to_iter':
>> iov_iter.c:(.text+0x9129): undefined reference to `crypto_stats_get'
>> iov_iter.c:(.text+0x9152): undefined reference to `crypto_stats_ahash_update'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: d05f443554b3 ("iov_iter: introduce hash_and_copy_to_iter helper")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> I'm not sure it's the right fix; might be better to have something like
> 
> size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
>                 struct iov_iter *i)
> {
> #ifdef CONFIG_CRYPTO
>         struct ahash_request *hash = hashp;
>         struct scatterlist sg;
>         size_t copied;
> 
>         copied = copy_to_iter(addr, bytes, i);
>         sg_init_one(&sg, addr, copied);
>         ahash_request_set_crypt(hash, &sg, NULL, copied);
>         crypto_ahash_update(hash);
>         return copied;
> #else
> 	return 0;
> #endif
> }
> EXPORT_SYMBOL(hash_and_copy_to_iter);
> 
> instead.  Objections?

Indeed, this seems better. I can post v2 as your suggestion.

> 
> .
> 

