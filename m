Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D74C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E64D20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCGCLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:11:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfCGCLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:11:49 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A34591FC3C0FEEE3495B;
        Thu,  7 Mar 2019 10:11:46 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Mar 2019
 10:11:39 +0800
Subject: Re: [PATCH 3/8] aio_poll(): sanitize the logics after vfs_poll(), get
 rid of leak on error
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, <kgraul@linux.ibm.com>,
        <ktkhai@virtuozzo.com>, <kyeongdon.kim@lge.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <syzkaller-bugs@googlegroups.com>, <xiyou.wangcong@gmail.com>,
        Christoph Hellwig <hch@lst.de>, <bcrl@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
 <20190307000316.31133-3-viro@ZenIV.linux.org.uk>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <0c631d6f-48b6-3691-eec5-29eb55817346@huawei.com>
Date:   Thu, 7 Mar 2019 10:11:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190307000316.31133-3-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+	if (async && !apt.error)  --->may be this should be if (!async && !apt.error) ?

On 2019/3/7 8:03, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> We want iocb_put() happening on errors, to balance the extra reference
> we'd taken.  As it is, we end up with a leak.  The rules should be
> 	* error: iocb_put() to deal with the extra ref, return error,
> let the caller do another iocb_put().
> 	* async: iocb_put() to deal with the extra ref, return 0.
> 	* no error, event present immediately: aio_poll_complete() to
> report it, iocb_put() to deal with the extra ref, return 0.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/aio.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 3a8b894378e0..22b288997441 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1724,6 +1724,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>  	struct kioctx *ctx = aiocb->ki_ctx;
>  	struct poll_iocb *req = &aiocb->poll;
>  	struct aio_poll_table apt;
> +	bool async = false;
>  	__poll_t mask;
>  
>  	/* reject any unknown events outside the normal event mask. */
> @@ -1760,30 +1761,26 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>  
>  	spin_lock_irq(&ctx->ctx_lock);
>  	spin_lock(&req->head->lock);
> -	if (req->woken) {
> -		/* wake_up context handles the rest */
> -		mask = 0;
> +	if (req->woken) { /* already taken up by aio_poll_wake() */
> +		async = true;
>  		apt.error = 0;
> -	} else if (mask || apt.error) {
> -		/* if we get an error or a mask we are done */
> -		WARN_ON_ONCE(list_empty(&req->wait.entry));
> -		list_del_init(&req->wait.entry);
> -	} else {
> -		/* actually waiting for an event */
> +	} else if (!mask && !apt.error) { /* actually waiting for an event */
>  		list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
>  		aiocb->ki_cancel = aio_poll_cancel;
> +		async = true;
> +	} else { /* if we get an error or a mask we are done */
> +		WARN_ON_ONCE(list_empty(&req->wait.entry));
> +		list_del_init(&req->wait.entry);
> +		/* no wakeup in the future either; aiocb is ours to dispose of */
>  	}
>  	spin_unlock(&req->head->lock);
>  	spin_unlock_irq(&ctx->ctx_lock);
>  
>  out:
> -	if (unlikely(apt.error))
> -		return apt.error;
> -
> -	if (mask)
> +	if (async && !apt.error)
>  		aio_poll_complete(aiocb, mask);
>  	iocb_put(aiocb);
> -	return 0;
> +	return apt.error;
>  }
>  
>  static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
> 

