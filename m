Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3393DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D3D2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565254854;
	bh=LWy4gsiJ5ZweJScVxi16KwqfP/e1w1Xari3HQ0g8eUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g/iNfOu6KTD4mEJKMGo70VJlFqFaSp+T788PyjvKHLoDfTqKI5w+Vnt/TJUVDk6XL
	 6wr5a/YSSkWGiMXFokqUu8p9/whdpxlPqSkZo6VDrxpd6DrEHRXJERs2aeI2p6fb5b
	 wxo+IOGjvnEx66s2k7PJrzmcU18/KJukdrB/jWZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfHHJAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731031AbfHHJAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:00:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D009F2173E;
        Thu,  8 Aug 2019 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565254852;
        bh=LWy4gsiJ5ZweJScVxi16KwqfP/e1w1Xari3HQ0g8eUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRMBZdNlC3OarhMdbUvZyH9rpcMZ0NIOzNZNxpAYxT3agvRxGW5ALR8sv+kjtw/KA
         2jtJPhNDqF0DG+4RXDgyTcFSQq4/d/XwSTB/vg4wX/PSL1pHBemABxrYgOgQ5G479t
         Yi7a4rf5hwaF+YtT4Z7gWrqNi4InQOL60F9lzdPg=
Date:   Thu, 8 Aug 2019 11:00:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alessio Balsini <balsini@android.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, xiao jin <jin.xiao@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3.18.y 4.4.y 4.9.y] block: blk_init_allocated_queue() set
 q->fq as NULL in the fail case
Message-ID: <20190808090049.GC1265@kroah.com>
References: <20190808022819.108337-1-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808022819.108337-1-balsini@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:28:19AM +0100, Alessio Balsini wrote:
> From: xiao jin <jin.xiao@intel.com>
> 
> commit 54648cf1ec2d7f4b6a71767799c45676a138ca24 upstream.
> 
> We find the memory use-after-free issue in __blk_drain_queue()
> on the kernel 4.14. After read the latest kernel 4.18-rc6 we
> think it has the same problem.
> 
> Memory is allocated for q->fq in the blk_init_allocated_queue().
> If the elevator init function called with error return, it will
> run into the fail case to free the q->fq.
> 
> Then the __blk_drain_queue() uses the same memory after the free
> of the q->fq, it will lead to the unpredictable event.
> 
> The patch is to set q->fq as NULL in the fail case of
> blk_init_allocated_queue().
> 
> Fixes: commit 7c94e1c157a2 ("block: introduce blk_flush_queue to drive flush machinery")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: xiao jin <jin.xiao@intel.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  block/blk-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 50d77c90070d..7662f97dded6 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -870,6 +870,7 @@ blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
>  
>  fail:
>  	blk_free_flush_queue(q->fq);
> +	q->fq = NULL;
>  	return NULL;
>  }
>  EXPORT_SYMBOL(blk_init_allocated_queue);
> -- 
> 2.22.0.770.g0f2c4a37fd-goog
> 

Guenter sent this backport a day before you did, so I took his version
and added your s-o-b to it.

thanks,

greg k-h
