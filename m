Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9694AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678A920707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575546317;
	bh=MMPufC6YNe0Yck6ySDeWIGIg8ontQHPmLYnxR8od234=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v/CnHNnPOK62oGutmTLuhNQIZMStBSbs8vKivzB0t8ymqpppMTTFtOPOxq2ZdPV6U
	 265tmw9Eph5R7nF1GG0/qgQ8J0JsMnWNkjXieE4Ds78COP9+4odJlassq/yb7lflfd
	 wPqvMCfstP5V9OV/l3MfkxdyVewXPRzxAxDkg4H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfLELpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfLELpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:45:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6914224F8;
        Thu,  5 Dec 2019 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575546313;
        bh=MMPufC6YNe0Yck6ySDeWIGIg8ontQHPmLYnxR8od234=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SX5oS6KcWCEiCqZIzt7RAiWRdxKT6nfCx1zO5pzXJ5Zu60h3W0CAqCN20iC2H9Nh/
         il+55z3bS10BFwauWeeEureRuZQPq93H/Ym3GxEO1IqtbhNCQWUJ4/djOX9ni/on+9
         ICwEbRzk5a8sc/QAuAPnSSNrTvz0Oqm23MSUBkqk=
Date:   Thu, 5 Dec 2019 12:45:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     haver@linux.ibm.com, arnd@arndb.de, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: genwqe: fix compile warnings
Message-ID: <20191205114509.GA362619@kroah.com>
References: <20191205111655.170382-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205111655.170382-1-yaohongbo@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 07:16:55PM +0800, Hongbo Yao wrote:
> Using the following command will get compile warnings:
> make W=1 drivers/misc/genwqe/card_ddcb.o ARCH=x86_64
> 
> drivers/misc/genwqe/card_ddcb.c: In function setup_ddcb_queue:
> drivers/misc/genwqe/card_ddcb.c:1024:6: warning: variable rc set but not
> used [-Wunused-but-set-variable]
> drivers/misc/genwqe/card_ddcb.c: In function genwqe_card_thread:
> drivers/misc/genwqe/card_ddcb.c:1190:23: warning: variable rc set but
> not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---
>  drivers/misc/genwqe/card_ddcb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
> index 026c6ca24540..905106579935 100644
> --- a/drivers/misc/genwqe/card_ddcb.c
> +++ b/drivers/misc/genwqe/card_ddcb.c
> @@ -1084,7 +1084,7 @@ static int setup_ddcb_queue(struct genwqe_dev *cd, struct ddcb_queue *queue)
>  				queue->ddcb_daddr);
>  	queue->ddcb_vaddr = NULL;
>  	queue->ddcb_daddr = 0ull;
> -	return -ENODEV;
> +	return rc;
>  
>  }
>  
> @@ -1179,7 +1179,7 @@ static irqreturn_t genwqe_vf_isr(int irq, void *dev_id)
>   */
>  static int genwqe_card_thread(void *data)
>  {
> -	int should_stop = 0, rc = 0;
> +	int should_stop = 0;
>  	struct genwqe_dev *cd = (struct genwqe_dev *)data;
>  
>  	while (!kthread_should_stop()) {
> @@ -1187,12 +1187,12 @@ static int genwqe_card_thread(void *data)
>  		genwqe_check_ddcb_queue(cd, &cd->queue);
>  
>  		if (GENWQE_POLLING_ENABLED) {
> -			rc = wait_event_interruptible_timeout(
> +			wait_event_interruptible_timeout(
>  				cd->queue_waitq,
>  				genwqe_ddcbs_in_flight(cd) ||
>  				(should_stop = kthread_should_stop()), 1);
>  		} else {
> -			rc = wait_event_interruptible_timeout(
> +			wait_event_interruptible_timeout(
>  				cd->queue_waitq,
>  				genwqe_next_ddcb_ready(cd) ||
>  				(should_stop = kthread_should_stop()), HZ);

Why ignore the return value of these functions?

SHouldn't you fix the code to handle it properly?

thanks,

greg k-h
