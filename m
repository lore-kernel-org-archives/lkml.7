Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0155AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9B62082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDDCkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:40:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfDDCky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:40:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [10.3.19.210])
        by Forcepoint Email with ESMTP id 8B9A1F60972690A75907;
        Thu,  4 Apr 2019 10:40:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 10:40:47 +0800
Subject: Re: [PATCH v2] iov_iter: Fix build error without CONFIG_CRYPTO
To:     <davem@davemloft.net>, <viro@zeniv.linux.org.uk>,
        <willemb@google.com>, <edumazet@google.com>, <fw@strlen.de>,
        <sagi@lightbitslabs.com>, <hch@lst.de>, <pabeni@redhat.com>,
        <pctammela@gmail.com>
References: <20190403095031.11720-1-yuehaibing@huawei.com>
 <20190404023114.30304-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <944510e2-798d-b0aa-407d-242c7f0c11da@huawei.com>
Date:   Thu, 4 Apr 2019 10:40:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190404023114.30304-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls ignore this, sorry.

On 2019/4/4 10:31, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> If CONFIG_CRYPTO is not set or set to m,
> gcc building warn this:
> 
> lib/iov_iter.o: In function `hash_and_copy_to_iter':
> iov_iter.c:(.text+0x9129): undefined reference to `crypto_stats_get'
> iov_iter.c:(.text+0x9152): undefined reference to `crypto_stats_ahash_update'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d05f443554b3 ("iov_iter: introduce hash_and_copy_to_iter helper")
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> ---
>  lib/iov_iter.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 50e77ec..f74fa83 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1531,6 +1531,7 @@ EXPORT_SYMBOL(csum_and_copy_to_iter);
>  size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
>  		struct iov_iter *i)
>  {
> +#ifdef CONFIG_CRYPTO
>  	struct ahash_request *hash = hashp;
>  	struct scatterlist sg;
>  	size_t copied;
> @@ -1540,6 +1541,9 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
>  	ahash_request_set_crypt(hash, &sg, NULL, copied);
>  	crypto_ahash_update(hash);
>  	return copied;
> +#else
> +	return 0;
> +#endif
>  }
>  EXPORT_SYMBOL(hash_and_copy_to_iter);
>  
> 

