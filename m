Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EDBC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1F421537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lMbDPIbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGKOyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:54:06 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37625 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfGKOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:54:06 -0400
Received: by mail-vs1-f66.google.com with SMTP id v6so4381891vsq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSRL99BIaLodkBG8Ur8XBaGK7O8DpdxuI0IXmHEfTNw=;
        b=lMbDPIbb0vvyUGWQdnCiasoDr4Yy47wih84OLLO3r9IgeHn7AFQirkDsZ+9bZv6a+X
         DJEbz83leO6ygDTze7wSrzwTG8b303QISowRG65eVyF3T+qaRAD97sq//wM3/4jpKRQH
         aHJYj7vqQUIQ92pFm8jlret5UmI8TNCWExeMqDLj6SM+yz0lJDsUEPy9ql4ZK/mymEY2
         C/lYAWQe9OeEl1jh9NtOjpnr3J0/mSWN6rpdBR3WGPbPaKQT6CJT6hAvOFDJdQziH1wH
         6od1oUQ52AMEnuaTZLM6eWhyh/Sw+Mb1IzzbgWpP9Ng+oJkpeLSGW9ubE23lLgR2MP0k
         dY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSRL99BIaLodkBG8Ur8XBaGK7O8DpdxuI0IXmHEfTNw=;
        b=dHl2cgv6CyyndH7HnZfrWVvGAKkBHjPx+E07ASdCywmJa3gKrtIDOEYGFFWtpzBjOD
         /jynSvBaL11xwRO2HSLNoFRfmWFno1WbGhh7rsY/0dL4s4HSPTQlxiHMVN4ZsM/kUXAL
         NnZeS8W6eHdatiw/HJ7ZnoikF0kt5s9uip8owpz9DaL66tvibItjvXmzDS5wuGqnXSMw
         kI5aYJXpoKCMpietNw0wCzmx2AtC4SGizIuXV8d9973yMM6zoV7EdKjdFHiwNRkIDPME
         uowEzlgzkip9+vTvBNzdetDc6Q/i//mA+PJAq4c8c5J9z7zd8DVDLBtyCwegeNUBGnRO
         sGdQ==
X-Gm-Message-State: APjAAAXAvDWBnEBi6XKkucz04XfQOz3qLEeS+8tBY4kOd6OY2pE4qldx
        ng+dim5auIcIz8RPM9o5m4tg8A==
X-Google-Smtp-Source: APXvYqzGv5XLpzcelYU2tuSxvoVuhMY+giJViUABBr/Bp/cZiVAevwOuDoKjZcXPaQJW1DVRDkKdnA==
X-Received: by 2002:a67:f492:: with SMTP id o18mr4970890vsn.62.1562856845452;
        Thu, 11 Jul 2019 07:54:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l20sm2290597vkl.2.2019.07.11.07.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 07:54:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlaSS-00068i-61; Thu, 11 Jul 2019 11:54:04 -0300
Date:   Thu, 11 Jul 2019 11:54:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Qian Cai <cai@lca.pw>
Cc:     leonro@mellanox.com, saeedm@mellanox.com, talgi@mellanox.com,
        yaminf@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/core: fix -Wunused-const-variable warnings
Message-ID: <20190711145404.GA23576@ziepe.ca>
References: <1562853356-11595-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562853356-11595-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 09:55:56AM -0400, Qian Cai wrote:
> The linux-next commit "linux/dim: Implement RDMA adaptive moderation
> (DIM)" [1] introduced a few compilation warnings.
> 
> In file included from ./include/rdma/ib_verbs.h:64,
>                  from ./include/linux/mlx5/device.h:37,
>                  from ./include/linux/mlx5/driver.h:51,
>                  from drivers/net/ethernet/mellanox/mlx5/core/uar.c:36:
> ./include/linux/dim.h:378:1: warning: 'rdma_dim_prof' defined but not
> used [-Wunused-const-variable=]
>  rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
>  ^~~~~~~~~~~~~
> In file included from ./include/rdma/ib_verbs.h:64,
>                  from ./include/linux/mlx5/device.h:37,
>                  from ./include/linux/mlx5/driver.h:51,
>                  from
> drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c:37:
> ./include/linux/dim.h:378:1: warning: 'rdma_dim_prof' defined but not
> used [-Wunused-const-variable=]
>  rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
>  ^~~~~~~~~~~~~
> 
> Since only ib_cq_rdma_dim_work() in drivers/infiniband/core/cq.c uses
> it, just move the definition over there.
> 
> [1] https://patchwork.kernel.org/patch/11031455/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/infiniband/core/cq.c | 13 +++++++++++++
>  include/linux/dim.h          | 13 -------------
>  2 files changed, 13 insertions(+), 13 deletions(-)

Applied to for-next, thanks

Jason
