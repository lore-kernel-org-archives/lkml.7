Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B9221734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QM11JzkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfC0NUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:20:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35849 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfC0NUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:20:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id k130so9827355qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l4fjnacWfr7ROwk+qn6pHWtMzGtc/5ptQvPedds8vQ0=;
        b=QM11JzkUcYckTxkGOmUsCXn78K9ej64Kyie6ZInvxKkNvyXA6N6olJ1d9rAq5YKECk
         w/FoIoKVU23QLqRUvKI0WPlTzq6O5zjyy/Reake4SxUU51O/oCOPypfPR/guzp2f+UvS
         1L9NN3PWTdEYy4yAtFWn8MyK1iEq4+i2d816zi4ydMkr3oohkoK1mhrq0k2TmNl45hsP
         ImJaMqIuYKvV42KBthtOeVGbIfWh7EN12hiUUnZObpg5XuKCYsAKQ43URQHhnEOBTVC7
         xsCmGVcZQWOm8mSX3yXce6BNwj+DkyS/ceNhhTsvNZ66YmSm+U7icH9hetfPkzEWgXyB
         ei4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l4fjnacWfr7ROwk+qn6pHWtMzGtc/5ptQvPedds8vQ0=;
        b=O3H5wk5gi9t/KSCfaBPRVkuwxLBjNwmfw1vmAdvMra+glP+EJVJ2kwaUwNJ1Ddk9Xf
         zoaxTx5Sh3RwoX/REKOwLmA7c6fa0TUS0bFRokDVgI88IKnc03r1CtAQOKRqGD1yPtIH
         VrxSMVZtQQ3WgfjjIhims8KgSN7MUblqKiib3ZGFydZ9CoXoJYPZM8DVjkj8FAmsyb15
         c4AYy5GkXgp2WYD7qeQ2YGlbPWMFdnQER7HPWRgwNtjHE+f6Jr5UZr71y/HrS5qBkHlo
         eHrz1jcgsZZSMnGTcQnkZSkIJusmmSIBjk8Wgzt9QwZVEBX4fcnovse0ge0Zfelmd0xO
         4ktg==
X-Gm-Message-State: APjAAAUgzqGsbgqalpMtQHoLLP3d7/ESUGdE7ykgiwn79keLC+B5+P9U
        rewqhCTq/hnuxv88n6uN5olKNQ==
X-Google-Smtp-Source: APXvYqzHkbT75ETj1cUC3d+8FYiORFm2d7QB5VlMsyOUuZ4K27p9q7fzIWAMDLRHDXVx1696y9aNgw==
X-Received: by 2002:a37:e315:: with SMTP id y21mr29721733qki.233.1553692805095;
        Wed, 27 Mar 2019 06:20:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id q6sm817560qkj.87.2019.03.27.06.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 06:20:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h98TL-0003Mi-6v; Wed, 27 Mar 2019 10:20:03 -0300
Date:   Wed, 27 Mar 2019 10:20:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] infiniband: i40iw: fix potential NULL pointer
 dereferences
Message-ID: <20190327132003.GA12891@ziepe.ca>
References: <9DD61F30A802C4429A01CA4200E302A7A5A6FAA8@fmsmsx124.amr.corp.intel.com>
 <20190315065715.18249-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315065715.18249-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 01:57:14AM -0500, Kangjie Lu wrote:
> alloc_ordered_workqueue may fail and return NULL.
> The fix captures the failure and handles it properly to avoid
> potential NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> V2: add return value to capture the error code
> ---
>  drivers/infiniband/hw/i40iw/i40iw.h      |  2 +-
>  drivers/infiniband/hw/i40iw/i40iw_cm.c   | 19 ++++++++++++++++---
>  drivers/infiniband/hw/i40iw/i40iw_main.c |  5 ++++-
>  3 files changed, 21 insertions(+), 5 deletions(-)

applied to for-next thanks
 
> diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
> index 2f2b4426ded7..8feec35f95a7 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw.h
> +++ b/drivers/infiniband/hw/i40iw/i40iw.h
> @@ -552,7 +552,7 @@ enum i40iw_status_code i40iw_obj_aligned_mem(struct i40iw_device *iwdev,
>  
>  void i40iw_request_reset(struct i40iw_device *iwdev);
>  void i40iw_destroy_rdma_device(struct i40iw_ib_device *iwibdev);
> -void i40iw_setup_cm_core(struct i40iw_device *iwdev);
> +int i40iw_setup_cm_core(struct i40iw_device *iwdev);
>  void i40iw_cleanup_cm_core(struct i40iw_cm_core *cm_core);
>  void i40iw_process_ceq(struct i40iw_device *, struct i40iw_ceq *iwceq);
>  void i40iw_process_aeq(struct i40iw_device *);
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> index 206cfb0016f8..2e20786b9a57 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> @@ -3237,7 +3237,7 @@ void i40iw_receive_ilq(struct i40iw_sc_vsi *vsi, struct i40iw_puda_buf *rbuf)
>   * core
>   * @iwdev: iwarp device structure
>   */
> -void i40iw_setup_cm_core(struct i40iw_device *iwdev)
> +int i40iw_setup_cm_core(struct i40iw_device *iwdev)
>  {
>  	struct i40iw_cm_core *cm_core = &iwdev->cm_core;
>  
> @@ -3256,9 +3256,20 @@ void i40iw_setup_cm_core(struct i40iw_device *iwdev)
>  
>  	cm_core->event_wq = alloc_ordered_workqueue("iwewq",
>  						    WQ_MEM_RECLAIM);
> +	if (!cm_core->event_wq)
> +		goto error;
>  
>  	cm_core->disconn_wq = alloc_ordered_workqueue("iwdwq",
>  						      WQ_MEM_RECLAIM);
> +	if (!cm_core->disconn_wq)
> +		goto error;
> +
> +	return 0;
> +error:
> +	i40iw_cleanup_cm_core(&iwdev->cm_core);
> +	i40iw_pr_err("fail to setup CM core");

But I deleted this print, memory allocation failures already print
enough

Jason
