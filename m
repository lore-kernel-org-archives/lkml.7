Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97228C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D11A21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fN2uxUOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfGCR3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:29:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36754 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:29:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so3443327qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EBMQFasJpCX+PTTwEmNEjk8bFFZI4xEQmZHd3LrIOuQ=;
        b=fN2uxUORBsgoveZtq1a67vmCtpAu0F8UsRyDWrvF4oHRNSboqRYqCpD+fH8Dqu00jg
         u2HMkJ2EtmvuOJZFFfeOu1XyqLJtvGrm3HvbZG1BnTdM+r0YTMfvQ2BKmwVyzScFeL51
         z0WDWorfAQWg5mGGoTJHLGfVtzX5M0676+LGZW8EReZFsi+eSB+/NIcsoX2+wSZhFQ99
         StCvPFNmmUqc6DYgh2hwqL44KafbHVFF4f0pFaXR+0OnITHaU8ViQRB7LBaXeDi3Jqua
         e9ws/H4VjDnxbEK3LVSUY6F7ymTdCJj54P8KRv5XHry16/MaHnOXWRnmRKkQ4NBYiZKG
         IOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBMQFasJpCX+PTTwEmNEjk8bFFZI4xEQmZHd3LrIOuQ=;
        b=GKmeOKLH4YCZ029wSptqvv3xCg2CKn6tUwBLMFVx9ewZ95LjIh0psh0jNz7TG3F0lp
         J+nMrgRSVLHkuiWRV8EgxGRW9hnEt9Yi1IPvmIc4s7hCKbOFYsAKjkJ4EDDA3hOFHuAP
         XtX6aVFWjSk1rkolMOKy3f6K5zk1/x5LlyDNZG5Ge3mtGCj+amg5ttgl8tMU+SzvSUOa
         qlH+2bWuDZknp8vXK0MYqTIcadzHiseFfmymO2CxnbAIFIYfUH2m8QUJ5PU7y0DkCdLa
         43eYDcaMicTBFOWXAh9H8ziV6gJBP+5Fq2grhT6dMsePQh+XAjmYzyaTiCh2ay9ekqnB
         2Sww==
X-Gm-Message-State: APjAAAX+6Cqg3AVRC4usoD0PfIYQSyEcqBWEfo9H7UmcF4z4oX5tjLwm
        mu03hnWopQQmf+h4fbwim43gJg==
X-Google-Smtp-Source: APXvYqyHNguFJJ+zfsB6GZelTbf0Lg/xbfjbFDk9cED3uwMoIla8RUdBC9LGjF+B3FAbntbUDjOzOw==
X-Received: by 2002:a37:4bd3:: with SMTP id y202mr32173524qka.253.1562174979849;
        Wed, 03 Jul 2019 10:29:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u18sm1133622qkj.98.2019.07.03.10.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 10:29:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hij4c-0002kx-Rr; Wed, 03 Jul 2019 14:29:38 -0300
Date:   Wed, 3 Jul 2019 14:29:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Aaron Knister <aaron.s.knister@nasa.gov>,
        Denis Drozdov <denisd@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/87] infiniband: ulp: remove memset after vzalloc in
 ipoib_cm.c
Message-ID: <20190703172938.GA10574@ziepe.ca>
References: <20190627173806.3307-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627173806.3307-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 01:38:04AM +0800, Fuqian Huang wrote:
> vzalloc has already zeroed the memory.
> So memset is unneeded.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> index aa9dcfc36cd3..c59e00a0881f 100644
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> @@ -1153,7 +1153,6 @@ static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
>  		ret = -ENOMEM;
>  		goto err_tx;
>  	}
> -	memset(p->tx_ring, 0, ipoib_sendq_size * sizeof(*p->tx_ring));
>  
>  	p->qp = ipoib_cm_create_tx_qp(p->dev, p);
>  	memalloc_noio_restore(noio_flag);

Applied to for-next

Thanks,
Jason
