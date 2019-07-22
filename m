Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82924C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4482084D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eZ5/5v39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfGVP0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:26:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46529 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbfGVP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:26:01 -0400
Received: by mail-vs1-f65.google.com with SMTP id r3so26337207vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qpgr4YRrDo+cYEiDdr1Ey4/KK+ijOMZHdWn8ArLcPCs=;
        b=eZ5/5v39C0Q7G62sp0kjVZq3sfqQqOwZ3299bCJEMfZ7R+d6gVbklh2UXaT5K2bNkf
         898/FCdClVFx1r9hIp8wJNcCe01qwi6557vSDRMc7yoTnjPUHJTcrXZOee7Bc6RLeMul
         qkLZAZ/CVPS5WFwldM5eV24aR1yBU9+GreFfS2muIC3xlcCy67kiR5FXuPzoKzmwOZ+W
         cTaN9ECJ7Ua3rBIDeuk1w+T4TedyUiuqjPdR8nwTS4ZolzgoVatlpfdy5xXII/FtAKNx
         2m5NtRziPKh4oOX+K2yIqXdPrJaW6tnHB4gOmlvXAqNrhk5I+vbBscwiVapeam4TQ32x
         IP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qpgr4YRrDo+cYEiDdr1Ey4/KK+ijOMZHdWn8ArLcPCs=;
        b=JHeHKLWY9QmCdNhNDh3uv16yK0dwJuAFXVIp6eTMc8t1tS2+L5hB5GgzMRIhA/3FMJ
         m3m8bzemZZLHA280v9s8kbCAN1jPs8bB8wqgw3XBsjgXFwFLIdazm+GWt169EdMiq52S
         EjilcvxKardFXf4phsq/tbWQH32FuNBztPYgLO3eU+ICV/pL4KwDRk0ctimmdzDsjMyn
         ibmFztl1xM5F4S2hljZptBdHQAOA4DIldN4n0kIk49eyuR/TaUDkrlJNZo7TjHIIjdg5
         UcpHhZ7xPMz0eHQsxzUIMqSqjmRadUH0rEiuBWsMnoLT9V2LDZRRron6cCet4xJX4OuG
         Um7w==
X-Gm-Message-State: APjAAAVOdK6gTac3lGD2qxA6dQDz99uGdgT7B9vEMvgeT707H1ac8M5i
        kxPCvMzE8lF4VicXDbsblFwsHg==
X-Google-Smtp-Source: APXvYqyEgFwa9PqOLbukPoHFWkcWbRjVTyWDfX3UbJmWvQ5wKfb6JqX+zCaZ9zh2TleSJBYuK6cwdg==
X-Received: by 2002:a67:e3d5:: with SMTP id k21mr42154034vsm.172.1563809160771;
        Mon, 22 Jul 2019 08:26:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b30sm8824082vkk.22.2019.07.22.08.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 08:26:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpaCN-0004p6-MM; Mon, 22 Jul 2019 12:25:59 -0300
Date:   Mon, 22 Jul 2019 12:25:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] Protect kref_put with the lock
Message-ID: <20190722152559.GD7607@ziepe.ca>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-5-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722151426.5266-5-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:14:20PM +0200, Maksym Planeta wrote:
> Need to ensure that kref_put does not run concurrently with the loop
> inside rxe_pool_get_key.
>
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
>  drivers/infiniband/sw/rxe/rxe_pool.c | 18 ++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_pool.h |  4 +---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index efa9bab01e02..30a887cf9200 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -536,3 +536,21 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
>  	read_unlock_irqrestore(&pool->pool_lock, flags);
>  	return node ? elem : NULL;
>  }
> +
> +static void rxe_dummy_release(struct kref *kref)
> +{
> +}
> +
> +void rxe_drop_ref(struct rxe_pool_entry *pelem)
> +{
> +	int res;
> +	struct rxe_pool *pool = pelem->pool;
> +	unsigned long flags;
> +
> +	write_lock_irqsave(&pool->pool_lock, flags);
> +	res = kref_put(&pelem->ref_cnt, rxe_dummy_release);
> +	write_unlock_irqrestore(&pool->pool_lock, flags);

This doesn't make sense..

If something is making the kref go to 0 while the node is still in the
RB tree then that is a bug.

You should never need to add locking around a kref_put.

Jason
