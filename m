Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247CBC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01FA2240E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QQpEdvQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKSUbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:31:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37238 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:31:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id e187so19141078qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 12:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ffL3XiM0LtkLjeoyTC4fynmObhqLJBu0oAAkB1Sv6bg=;
        b=QQpEdvQrv3VxEyEYawc6fHFuZTPgaWu6FsHVD1e1ezyhaWuRpUshlK+MeazAk2Yb5c
         WdHqQAt7ivBcTNSFX+SeqsrF/JATfpYGHbtKF9ZWf/kyX3NaiwyEQMwEL1nkfMSCAwYZ
         t4OIx6yol25quBvST7aX7t+bwogjXEt24v+18KV7WVflf5ZgdKKOBb1IJsebR8NVP7MP
         03sq5wcV+rHoLsGqOZhto/2fT/FHkbdJD+L0KtvgjAaXKCGBqOT1pcW4JFQcZWrCjMLx
         ADqyaSIsUC/Vs7bEx9q9hfSBfSAD83fckZKmhgYBNkAHRMgRj9Teu0ct9fKFBDZsDIhs
         MmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ffL3XiM0LtkLjeoyTC4fynmObhqLJBu0oAAkB1Sv6bg=;
        b=CyB75FRiApcRuSlPpekRAo4OQbqysrCwKGD5wJFTw4in6uVBpdXOcgk1hnLoNZq+yZ
         siAyWGDeaU6y/bDMft2BWshoqwRlP1ggZDoqb1HrWZtD/lcRg1mcC6DRxyFeOJZH01mE
         +PaOm7kP0TUBpEjw11uKRiXPlXJ8VyebZsoaZdC7WBTKDOu8OsJ5AkPhxWIWHm9XbHQn
         AdxRnesY1Zd9uQbuSqXeBrfpq6wQxlcUrRi4uEaPfbvTPMi+oX2ZvmFMNlPC8FaiWrNq
         QHb51lWDT2LaeRlseRasU6MpWaNQEshgN6qwgmV7JBCutBLDmBza78jRkSt/wsOz2zLn
         xFxg==
X-Gm-Message-State: APjAAAXw5NwPzKxFcTJBS8idHbjGtKSSRgHi2vwTzHOIIYgPCpFG8Qr/
        CW50ldZM8enHE4YmcYDMDUOVEA==
X-Google-Smtp-Source: APXvYqzq78z4Kwl63piCU4DA6NkhH7ZUgZoHCweA3yZzD+3qAZFN3jAYRSTk9DhNa8iA9vWigiyilw==
X-Received: by 2002:a05:620a:1375:: with SMTP id d21mr1191457qkl.285.1574195499276;
        Tue, 19 Nov 2019 12:31:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k199sm10614778qke.0.2019.11.19.12.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 12:31:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXA9y-0003RM-6w; Tue, 19 Nov 2019 16:31:38 -0400
Date:   Tue, 19 Nov 2019 16:31:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Message-ID: <20191119203138.GA13145@ziepe.ca>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 11:54:38AM -0800, rao Shoaib wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> 
> Introduce maximum WQE size to impose limits on max SGE's and inline data
> 
> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>  drivers/infiniband/sw/rxe/rxe_param.h | 3 ++-
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 7 +++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 1b596fb..31fb5c7 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -68,7 +68,6 @@ enum rxe_device_param {
>  	RXE_HW_VER			= 0,
>  	RXE_MAX_QP			= 0x10000,
>  	RXE_MAX_QP_WR			= 0x4000,
> -	RXE_MAX_INLINE_DATA		= 400,
>  	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
>  					| IB_DEVICE_BAD_QKEY_CNTR
>  					| IB_DEVICE_AUTO_PATH_MIG
> @@ -79,7 +78,9 @@ enum rxe_device_param {
>  					| IB_DEVICE_RC_RNR_NAK_GEN
>  					| IB_DEVICE_SRQ_RESIZE
>  					| IB_DEVICE_MEM_MGT_EXTENSIONS,
> +	RXE_MAX_WQE_SIZE		= 0x2d0, /* For RXE_MAX_SGE */

This shouldn't just be a random constant, I think you are trying to
say:

  RXE_MAX_WQE_SIZE = sizeof(struct rxe_send_wqe) + sizeof(struct ib_sge)*RXE_MAX_SGE

Just say that

>  	RXE_MAX_SGE			= 32,
> +	RXE_MAX_INLINE_DATA		= RXE_MAX_WQE_SIZE,

This is mixed up now, it should be

  RXE_MAX_INLINE_DATA = RXE_MAX_WQE_SIZE - sizeof(rxe_send_wqe)

> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index aeea994..323e43d 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -78,9 +78,12 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
>  		}
>  	}
>  
> -	if (cap->max_inline_data > rxe->max_inline_data) {
> +	if (cap->max_inline_data >
> +	    rxe->max_inline_data - sizeof(struct rxe_send_wqe)) {
>  		pr_warn("invalid max inline data = %d > %d\n",
> -			cap->max_inline_data, rxe->max_inline_data);
> +			cap->max_inline_data,
> +			rxe->max_inline_data -
> +			    (u32)sizeof(struct rxe_send_wqe));

Then this isn't needed

And this code in the other patch:

+	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
+			 init->cap.max_inline_data);
+	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
+	qp->sq.max_inline = wqe_size;

Makes sense as both max_inline_data and 'init->cap.max_send_sge *
sizeof(struct ib_sge)' are exclusive of the wqe header

Jason
