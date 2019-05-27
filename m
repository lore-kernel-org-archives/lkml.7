Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FBEC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 23:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8D820859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 23:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gsqyniXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfE0XKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 19:10:11 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45368 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfE0XKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 19:10:10 -0400
Received: by mail-vs1-f66.google.com with SMTP id k187so11557209vsk.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ezp1Hn9AbIO4hckSeW5sCUSNd2N5pmPnDQddQvNKSGo=;
        b=gsqyniXyUF19E5m7ZfASYYRkQqwsEiWGcrX1exwgyHwe0duQMvMgHhjrROSH9eSqKm
         HfY+xOwrVNAe2FSV+KQGKDl51AWaeooKEBhgJBlKGYwSLTZhCKOiRxZOX96VxDyleN2c
         mS/HrTAogDyiY3afza9sJrDi7rKB8jPoh+Sfri67UBb8HoWuumrz1keCworfE5KElZmm
         AIfhTyWfi1t5Mysr0fBtzjyb5+ud3V+GnDw7KGKnxBqgkTozlZiB1gJGnXTW/m1cbIUJ
         fswxzRqMogSyA6in/9J/B844lYmtAmzkrkC94Iv0uHaeAbvwmQraJ5t5IcUVcuwOA5S8
         GiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ezp1Hn9AbIO4hckSeW5sCUSNd2N5pmPnDQddQvNKSGo=;
        b=dSEkygj5Dz0DCEUN2ou5n+MNdE2D1VOw/+OHsrvb71GJrvsEM3BTLH16kWjsJs3fh+
         MTOCDew7o2UnI6A4qQ/BCWU9AkohnDKkxsJzJL1g7+4QwcPVPdVk863/E2ZxozaS4Mgs
         ys8Y/xdmjGu89BWWExjnK6QZjI1zpXp3iz3WRHd5ue3XoXtxwMd1w/KVtUT1jHiN4GFB
         7mfi3Z0Hr6Hz1xQvYtahCzrU9EMgxRCzEfLYpg6WIILG3k8UhYuz+INsN8qQ80qcC1Zq
         Ew0dd5DaOvV5P9kvrb0drcsCBiTqX3A5Kl2Qg9B16CePUA4BuJYrbOw9cfFa5Do8Kn3u
         V83A==
X-Gm-Message-State: APjAAAVQ1xi1G03zAOIcVX8QJwF5mrtbzdSp423MEkP3y12AWs4511dB
        xy6bVnSFg32jJjhGhihYDredAzw55vM=
X-Google-Smtp-Source: APXvYqyXbk8qBnXm89jGFjwmZfJXulmQsoFfKI1jbjPGbbMOPxp7WHfYcvwefmI02uAlama9XdnuEg==
X-Received: by 2002:a67:e905:: with SMTP id c5mr16598554vso.97.1558998609740;
        Mon, 27 May 2019 16:10:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 126sm3269179vkt.14.2019.05.27.16.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 16:10:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVOkq-000551-H5; Mon, 27 May 2019 20:10:08 -0300
Date:   Mon, 27 May 2019 20:10:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
        dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] IB/hfi1: remove set but not used variables
 'offset' and 'fspsn'
Message-ID: <20190527231008.GA19493@ziepe.ca>
References: <20190525125737.15648-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525125737.15648-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 08:57:37PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/infiniband/hw/hfi1/tid_rdma.c: In function tid_rdma_rcv_error:
> drivers/infiniband/hw/hfi1/tid_rdma.c:2029:7: warning: variable offset set but not used [-Wunused-but-set-variable]
> drivers/infiniband/hw/hfi1/tid_rdma.c: In function hfi1_rc_rcv_tid_rdma_ack:
> drivers/infiniband/hw/hfi1/tid_rdma.c:4555:35: warning: variable fspsn set but not used [-Wunused-but-set-variable]
> 
> 'offset' is never used since introduction in
> commit d0d564a1caac ("IB/hfi1: Add functions to receive TID RDMA READ request")
> 
> 'fspsn' is never used since introduciotn in
> commit 9e93e967f7b4 ("IB/hfi1: Add a function to receive TID RDMA ACK packet")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied to for-next

Thanks,
Jason
