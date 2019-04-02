Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5DC20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k1/zO0Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfDBDr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:47:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45254 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDBDr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:47:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so5808095pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H47pxTGtMqAzpyNByDNqwgHUGsiBgDc5ThKwFxITzSM=;
        b=k1/zO0XueqoX2VBC5fclqpGHwCv3RNMzC9HrZQqn3QJ73kcF/+F2EilHCa3A98//Ti
         eOHUaTKBlix9ZG5vzm9gPeM9MmwRmHJ5ZZldCPBVZvpd7W/zULZMfR8AwuTso/7e4i07
         OOYW/TmJW9+tRwF2ch5jUPGIHw1gLdHdp6dR7V7QG+ZM4rZhem4MQJRzTlOEC0MxblAe
         iR9wq+7+4zDG51YSQ3sX/AXcewFwSutpXcYohCu6oTWdQv3bLYAOrSxMlrmUKS25Nwrp
         jvy61+KqWKiz4GmVfN1U0sj9Xibxgpk/4c3s0zT/qdRBXe/W4pwYmb77P6pz1TvMGCHF
         iYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H47pxTGtMqAzpyNByDNqwgHUGsiBgDc5ThKwFxITzSM=;
        b=IK3W4AjvZcSyjp4wfWLhXOHEoTHCCYwtThpXmXXQX4ATBSo4fi9nyc8DNdfkckUB+b
         jYrFtPReopU1nTXvrrH0R3bp8cBJ/3izi0wr/rPvcRNrPBA6RXCoznagdFkTisEQA8Do
         gz3dfE6eYl+y87AsKyBQ7Xtqzm9YcnjOzHrQYA4QGhLsdzPD8AGJgtgTyCbhx3BzPALX
         1S5oyrb17Nfh3IdC/v7BoqsYq+C21ihZGPSzNSvHRgmrMTPNCqqpNq8IPieQvibxdsOB
         iSpFxp97LX8juiKmeG95DGWshhhaqezDl3ipt5L+JaFjwRB+kwhmqVKc8qgXoEtvy58t
         JduA==
X-Gm-Message-State: APjAAAWqs+sTFgW4yiktaUKBdoVJ13r2qI0Y57XAXTw1ZcEkbzm7xphV
        ZZtvE98yUuXMP7rh2f81zmDEohPL+p7qkw==
X-Google-Smtp-Source: APXvYqxgyOI5WuPz1nMnHqGB3Ct+Ww6rpAftqJvxMgw5L/OtM8xsyx9Sx3vJcbMtOnzkpdx3YPNHzw==
X-Received: by 2002:aa7:8b96:: with SMTP id r22mr65854202pfd.223.1554176845400;
        Mon, 01 Apr 2019 20:47:25 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm15247317pff.105.2019.04.01.20.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 20:47:24 -0700 (PDT)
Subject: Re: [PATCH] io_uring: introduce inline reqs for IORING_SETUP_IOPOLL &
 direct_io
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554174646-1715-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15be30c1-db76-d446-16c0-f2ef340658ec@kernel.dk>
Date:   Mon, 1 Apr 2019 21:47:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554174646-1715-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 9:10 PM, Jianchao Wang wrote:
> For the IORING_SETUP_IOPOLL & direct_io case, all of the submission
> and completion are handled under ctx->uring_lock or in SQ poll thread
> context, so io_get_req and io_put_req has been serialized well.
> 
> Based on this, we introduce the preallocated reqs ring per ctx and
> needn't to provide any lock to serialize the updating of the head
> and tail. The performacne benefits from this. The test result of
> following fio command
> 
> fio --name=io_uring_test --ioengine=io_uring --hipri --fixedbufs
> --iodepth=16 --direct=1 --numjobs=1 --filename=/dev/nvme0n1 --bs=4k
> --group_reporting --runtime=10
> 
> shows IOPS upgrade from 197K to 206K.

I like this idea, but not a fan of the execution of it. See below.

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 6aaa3058..40837e4 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -104,11 +104,17 @@ struct async_list {
>  	size_t			io_pages;
>  };
>  
> +#define INLINE_REQS_TOTAL 128
> +
>  struct io_ring_ctx {
>  	struct {
>  		struct percpu_ref	refs;
>  	} ____cacheline_aligned_in_smp;
>  
> +	struct io_kiocb *inline_reqs[INLINE_REQS_TOTAL];
> +	struct io_kiocb *inline_req_array;
> +	unsigned long inline_reqs_h, inline_reqs_t;

Why not just use a list? The req has a list member anyway. Then you don't
need a huge array, just a count.

> +
>  	struct {
>  		unsigned int		flags;
>  		bool			compat;
> @@ -183,7 +189,9 @@ struct io_ring_ctx {
>  
>  struct sqe_submit {
>  	const struct io_uring_sqe	*sqe;
> +	struct file 			*file;
>  	unsigned short			index;
> +	bool 				is_fixed;
>  	bool				has_user;
>  	bool				needs_lock;
>  	bool				needs_fixed_file;

Not sure why you're moving these to the sqe_submit?

> @@ -228,7 +236,7 @@ struct io_kiocb {
>  #define REQ_F_PREPPED		16	/* prep already done */
>  	u64			user_data;
>  	u64			error;
> -
> +	bool 			ctx_inline;
>  	struct work_struct	work;
>  };

ctx_inline should just be a req flag.

>  
> @@ -397,7 +405,8 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
>  }
>  
>  static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
> -				   struct io_submit_state *state)
> +				   struct io_submit_state *state,
> +				   bool direct_io)
>  {
>  	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
>  	struct io_kiocb *req;
> @@ -405,10 +414,19 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  	if (!percpu_ref_tryget(&ctx->refs))
>  		return NULL;
>  
> -	if (!state) {
> +	/*
> +	 * Avoid race with workqueue context that handle buffered IO.
> +	 */
> +	if (direct_io &&
> +	    ctx->inline_reqs_h - ctx->inline_reqs_t < INLINE_REQS_TOTAL) {
> +	    req = ctx->inline_reqs[ctx->inline_reqs_h % INLINE_REQS_TOTAL];
> +	    ctx->inline_reqs_h++;
> +	    req->ctx_inline = true;
> +	} else if (!state) {

What happens for O_DIRECT that ends up being punted to async context?
We need a clearer indication of whether or not we're under the lock or
not, and then get rid of the direct_io "limitation" for this. Arguably,
cached buffered IO needs this even more than O_DIRECT does, since that
is much faster.

-- 
Jens Axboe

