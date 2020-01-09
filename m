Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FEEC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B141206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="groYf4qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbgAIQAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:00:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40997 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbgAIQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:00:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id k40so6239198qtk.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OaEt+p8c5E5h683JWpHMf2yCQzkuw0gp1DpJEBVRgAU=;
        b=groYf4qvDwUcEXNz8Oq2ZmeL1bWtKXTreNXy92kkoTVhg7ATX78oqQcJFJfPO+AxPr
         tPt/fimuZJhPLmUfAx4mQWVzbHABomBPjpxwzltqCczAr3HgRRgl7SgbKwxgasGpSafS
         Vp7SBM9rGXMv1/2yoKVRLnLcekHEWshlTlsN/5kOMXHiccmhvbTGgkDzK90qL99h+Xes
         DFxqHV4K0/A8ooCIPasaeEJ/yhCGRMMHa5Nc2lMmH9jf4kpjRBMYjJUQImoybUiJUof/
         +iSpE/1pAeqU2I7QgCJcJGNtoEdUpT4wPFK9a4Cq1Zdw9+Ru23MP5QxzvlOOYfbSkXmn
         HGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OaEt+p8c5E5h683JWpHMf2yCQzkuw0gp1DpJEBVRgAU=;
        b=Oz0R5Mmf+Z4G91ROsv0LQ1dnxgJI+ORdW/D2e92vY2A73Ngf0wiocc22vOr8rZuR9V
         pwtErKe1BMa3SzuHKFNfc4DcnHCtOYG0SxN5iXIq001Y3ZYvxJxWmTYnybfLGhbqCYA+
         LKo59eaJSgw/8ZYAHmxz3AvkeZCWtSCVnB858pQsS8ZQiKMV4xUjvfaQfgsY/S46lM1i
         M1FLW4ZBqdlxChuEsbC1OQjms6YlKQrF4OZ7Y7wrxctdwPFS/MYr2MX+MdUc/7pqyfj4
         CR6BuupY6wVf6wHqUyb8eLELNh2vt628uQSyee9z9rH73f1K1TOuiH2JbPXgS62gisAN
         AVmQ==
X-Gm-Message-State: APjAAAXLm2iMC6V4A1TYEhPks3qzEjL1WJOBUMBXDt/8LpP6BjQtG5J+
        k3KWCjG3hNWDCDnfu8GhT/URRA==
X-Google-Smtp-Source: APXvYqyiV5zk3f2Y0y9wNm4SSPCSNwLTXH6FgkyQLkIdEFHnzBQsiIXMDPBc/n50blulCbedc1x4HQ==
X-Received: by 2002:ac8:554b:: with SMTP id o11mr8569055qtr.36.1578585623451;
        Thu, 09 Jan 2020 08:00:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c6sm3149609qka.111.2020.01.09.08.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 08:00:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipaEQ-0007Y4-AJ; Thu, 09 Jan 2020 12:00:22 -0400
Date:   Thu, 9 Jan 2020 12:00:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Moni Shoua <monis@mellanox.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Fix build failure without hugepages
Message-ID: <20200109160022.GA28974@ziepe.ca>
References: <20200109084740.2872079-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109084740.2872079-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:47:30AM +0100, Arnd Bergmann wrote:
> HPAGE_SHIFT is only defined on architectures that support hugepages:
> 
> drivers/infiniband/core/umem_odp.c: In function 'ib_umem_odp_get':
> drivers/infiniband/core/umem_odp.c:245:26: error: 'HPAGE_SHIFT' undeclared (first use in this function); did you mean 'PAGE_SHIFT'?
> 
> Enclose this in an #ifdef.
> 
> Fixes: 9ff1b6466a29 ("IB/core: Fix ODP with IB_ACCESS_HUGETLB handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/core/umem_odp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
