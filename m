Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B39C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B202182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIzwJ/ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfGQLvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:51:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44464 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbfGQLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:51:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so10711210pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GIJbr25lVT/D/Vy27DLzuKerhv8UbYHOIOCQJikwBFA=;
        b=uIzwJ/ze91LaMB3BoL1PAbHbciev+otvhS8f4ghjEtZICozZi6YfWLlksybW7RfJ0w
         ol5s203a37yS0N/j6P6msr0Cn7wmAtOdEA+oSWiYe8+nJcErHR2bCcuQ8lqR1s42okzP
         fFrIHf6Uc38uyBGRDbcz2YxUkNNMN7d3DXupfXAH3T4izSWPcr9xnXFGgHDgZGRDNWFm
         xXKfS3WW53MdkuPvAXfZUbvsyzckXH+dcknPhehbXdI3zL8kbZK9W7Kp8OymyGg/1FPk
         y+tEpiS4sguwTasF3IEkweGCeeoDZUcXb/7UEKMuKaU2Qsm8N7Jan9Q5KeuRT0VVz23W
         FmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIJbr25lVT/D/Vy27DLzuKerhv8UbYHOIOCQJikwBFA=;
        b=qBPp3A2I7qDZa3/E0we4Y0pzw28qzv/qrng69RhCdPkelxr7NoDYlE2vQLyhqEsYsy
         n3yfWkeip5fKlJyHY3sqLcbRX+toZ1VTwz8narCce4O646cCylJBW2k53hi9pBJoo3Lf
         XTaK4tfaCepL6mmV5sUGJx656LLD/Aty7j1Xa6akfRCW+YfDSfdp6+N10MoN5OdnwSNA
         Vb01Oci3sNV/p8mVjklW5f+rPOTxsUvkesYrOYYqguBkx/Qgse4Hou/c0qWLPutQP2CD
         HUhKYKolCeaWRDsWhg/1fG+QH+CcrEk3kBBRkwLPxD6ZPyrz4uw2be7OiUbACPdCElbu
         wjvg==
X-Gm-Message-State: APjAAAWNXOVvUhlIZAmXF7/HatCnc8OQU2cMDIZ6QAHwhTZL3s4m5E64
        rUMrZ/FnbGAwvdBBpwkixIg=
X-Google-Smtp-Source: APXvYqzZd5w1gpD8uRbzHmNaVRtBwb7cvYeYpwZdI59MbwsKJhhvaXtRon+6DReuMIy9nrRfH9xrow==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr16191189pgi.70.1563364309173;
        Wed, 17 Jul 2019 04:51:49 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id u6sm20799749pjx.23.2019.07.17.04.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 04:51:48 -0700 (PDT)
Date:   Wed, 17 Jul 2019 20:51:45 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v2 2/3] nvme-pci: Add support for variable IO SQ element
 size
Message-ID: <20190717115145.GB10495@minwoo-desktop>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
 <20190717004527.30363-2-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717004527.30363-2-benh@kernel.crashing.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-17 10:45:26, Benjamin Herrenschmidt wrote:
> The size of a submission queue element should always be 6 (64 bytes)
> by spec.
> 
> However some controllers such as Apple's are not properly implementing
> the standard and require a different size.
> 
> This provides the ground work for the subsequent quirks for these
> controllers.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/nvme/host/pci.c | 11 ++++++++---
>  include/linux/nvme.h    |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8f006638452b..1637677afb78 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -28,7 +28,7 @@
>  #include "trace.h"
>  #include "nvme.h"
>  
> -#define SQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_command))
> +#define SQ_SIZE(q)	((q)->q_depth << (q)->sqes)
>  #define CQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_completion))
>  
>  #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> @@ -100,6 +100,7 @@ struct nvme_dev {
>  	unsigned io_queues[HCTX_MAX_TYPES];
>  	unsigned int num_vecs;
>  	int q_depth;
> +	int io_sqes;
>  	u32 db_stride;
>  	void __iomem *bar;
>  	unsigned long bar_mapped_size;
> @@ -162,7 +163,7 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
>  struct nvme_queue {
>  	struct nvme_dev *dev;
>  	spinlock_t sq_lock;
> -	struct nvme_command *sq_cmds;
> +	void *sq_cmds;

It would be great if it can remain the existing data type for the
SQEs...  But I'm fine with this also.

It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,
