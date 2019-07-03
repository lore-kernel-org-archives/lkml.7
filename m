Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F7C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3231E21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IB/gQuwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfGCRcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:32:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41717 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:32:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so3215214qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dUTBg9L/T43a75q7/k9LSYq+FZ7PK2ujIg6IXIgWCWg=;
        b=IB/gQuwPL24eJFfmxzZDzOj6SgXQ9wFHhOA94R1+q+N+rW7BTdcJFvleZ8+KhYCLcg
         N2dYX+HUcj+iLsL2D/rYcwJ2Bt1M8lmF8WnL5s8rZCYw/PkQp/VX2eb3OuvfYZp2WNZi
         1+8OMtLMUNyRHUM4BbZr5ZmFIg8m7bCpmk2Km3q8uNggJwbmqxQEX8F47Vt1UP+/UZ41
         uSaFFdwn8kOAm3GaNQ498qqYIetHIQymJgVtslcyi+65XemToXmNfkg9dr3owe+IVEk7
         Q+tWBnwQ0wBOtaHZqjUT3ga3GFO1COwj9uaJAGcbNrjgsyNJbuDLJxT2ypPG+E0Awev4
         kVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUTBg9L/T43a75q7/k9LSYq+FZ7PK2ujIg6IXIgWCWg=;
        b=AZ+d2sigqb/OzhXweWJ5yM8HEvDT+QHV8/kVzG/MUVkudm2WbZI1YzzLJmQ5os1YcW
         sGRMsgZKbVhCiSlgfsQH74o/pZN3fnx0ai9VvhEnHvy2sAl1JD7LbaKDVWRBaiZ7Caox
         GrNol9wz/E4SJd+T0blRVkT1lZgAwokZk2bXrO2f/ZfELuGQ4pxkyk2+SB3mRsqj4eUE
         YUeGZb2H5vkumOPjclaJqAnm4Gs33ptIkLgU0LKdJibkh1wnktIsAYrC2wAG+jasB5fN
         gIgyQ4k+uQYsZzIQx95/EKnePfwE8v87kBnqCqEbf9x1HVtCUMqX4LYZU88N5LlQmb7I
         l32A==
X-Gm-Message-State: APjAAAVbgFbErrbjCCPwjKE5UX1Q5sMgW8B15fZF80nPjzDcdhDre70R
        /4vV2lziWKkfkmS4VzWXucWCFA==
X-Google-Smtp-Source: APXvYqz0xBfXdBw9BpScRLZ33MAmFJzNtbyFZbj07iqg/UuZi+78tz+nEusdRi7mimxV63JOVZTZvA==
X-Received: by 2002:ac8:3325:: with SMTP id t34mr31878426qta.172.1562175128474;
        Wed, 03 Jul 2019 10:32:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o17sm1092794qkm.6.2019.07.03.10.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 10:32:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hij71-0002nd-CC; Wed, 03 Jul 2019 14:32:07 -0300
Date:   Wed, 3 Jul 2019 14:32:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Parav Pandit <parav@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Aaron Knister <aaron.s.knister@nasa.gov>,
        Denis Drozdov <denisd@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/27] infiniband: remove unneeded memset
Message-ID: <20190703173207.GA10729@ziepe.ca>
References: <20190628024723.15257-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628024723.15257-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:47:19AM +0800, Fuqian Huang wrote:
> pci_alloc_consistent calls dma_alloc_coherent directly.
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dma_alloc_coherent/dmam_alloc_coherent has already zeroed the memory.
> So the memset after these 3 function calls is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb3/cxio_hal.c        | 3 ---
>  drivers/infiniband/hw/cxgb4/cq.c              | 1 -
>  drivers/infiniband/hw/cxgb4/qp.c              | 1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c    | 1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 3 ---
>  drivers/infiniband/hw/mthca/mthca_allocator.c | 2 --
>  drivers/infiniband/hw/nes/nes_verbs.c         | 3 ---
>  drivers/infiniband/hw/ocrdma/ocrdma_hw.c      | 3 ---
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c       | 1 -
>  9 files changed, 18 deletions(-)

Thanks, applied to rdma for-next

> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> index aa9dcfc36cd3..c59e00a0881f 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> @@ -1153,7 +1153,6 @@ static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
>  		ret = -ENOMEM;
>  		goto err_tx;
>  	}
> -	memset(p->tx_ring, 0, ipoib_sendq_size * sizeof(*p->tx_ring));
>  
>  	p->qp = ipoib_cm_create_tx_qp(p->dev, p);
>  	memalloc_noio_restore(noio_flag);

I dropped this hunk and used the seperate patch since this has nothing
to do with dma_alloc_coherent.

Jason
