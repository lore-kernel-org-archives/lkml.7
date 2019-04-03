Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A7C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E39D206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDCQw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:52:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33480 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:52:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBj7X-0003bq-AE; Wed, 03 Apr 2019 16:52:15 +0000
Date:   Wed, 3 Apr 2019 17:52:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, willemb@google.com, edumazet@google.com,
        fw@strlen.de, sagi@lightbitslabs.com, hch@lst.de,
        pabeni@redhat.com, pctammela@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] iov_iter: Fix build error without CONFIG_CRYPTO
Message-ID: <20190403165215.GQ2217@ZenIV.linux.org.uk>
References: <20190403095031.11720-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403095031.11720-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:50:31PM +0800, Yue Haibing wrote:
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
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I'm not sure it's the right fix; might be better to have something like

size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
                struct iov_iter *i)
{
#ifdef CONFIG_CRYPTO
        struct ahash_request *hash = hashp;
        struct scatterlist sg;
        size_t copied;

        copied = copy_to_iter(addr, bytes, i);
        sg_init_one(&sg, addr, copied);
        ahash_request_set_crypt(hash, &sg, NULL, copied);
        crypto_ahash_update(hash);
        return copied;
#else
	return 0;
#endif
}
EXPORT_SYMBOL(hash_and_copy_to_iter);

instead.  Objections?
