Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D36C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DC020835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JFeTGKR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfCDUbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:31:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34308 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:31:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id a15so3559394qkc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 12:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z9mIcxxt8Vhpd9V+/EyizlMRIl0unlkK0sf4EYC970w=;
        b=JFeTGKR46hqecjdgXUCXA+PrbOcfhOUKyqsz887pdoaKWDSgn6hDTL0Vw2FtXeY27z
         uqHxm+aSfSxHxZ04/5/ZtHeiRLJEW7inwMIPplCUR4hpul8lUHW40ct3ly1elJgUOtl3
         2f7QDs6t+X10nndWu2iI0sbpfI2fUOIuDRKNJlnEQK9p17hrAo/g/LtwaD8rWGOATZG9
         /Z+HAQhJD3m9L4bWuMRZNEIloPHbC/1kenvBf/HdjZ5ZRgkljDYALHNnXkZn20kyTsfd
         u/JCaroIdy8grFikzQJOZwoS9sX/C/R/aTXdqEFhaZl9tooNa1cnx7fhZisHUuw/d1Zy
         cd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9mIcxxt8Vhpd9V+/EyizlMRIl0unlkK0sf4EYC970w=;
        b=WiU5yrCTrBbf3SknF0nbcvNw8S9etdjku/LfffMJ1LaDuGtiVVFhwgosqI6R6Slg6z
         xFH1nITSieyw07auDUN0h0ldfSbogGEu9Fd+gVE7SEEZtHnmok9Dxeh9NQDSlmM398j8
         KaVJums7/6sRqLjj5vvAvxbgnN/vnawWUnrO1ajgZu+iYXA0SOxdfc9fBs/B0MQn1HZ5
         mKeoKFyDNPBVRlnhWru+BVNpW/RvJHm9FZ+A3ML+Z9phgb11vCLCvSZMXxODrP7qdZ90
         0NcYFSecJHtisw2txk+zBu73cCji86ystpTl9IhKQ9rlR7oSfIjTKKM1nsIwmZgDi30s
         wkfA==
X-Gm-Message-State: APjAAAXtynDRE0WPZkWrgtfpv/1e3CACJ4sS9AV//LHeZ1q3wo6Ez1r9
        t+CkxTqsJouQeyX9cNIeqjTjLA==
X-Google-Smtp-Source: APXvYqyctoESLU+Xtxd++N/+Ff3gZfUlHc/dMEjqqr/V+Al9QV4wBeo2newWfQLW5Xw86infcw5cnQ==
X-Received: by 2002:ae9:ec19:: with SMTP id h25mr15120648qkg.122.1551731493848;
        Mon, 04 Mar 2019 12:31:33 -0800 (PST)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id f58sm4696098qtc.14.2019.03.04.12.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 12:31:33 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h0uFI-0000Hb-73; Mon, 04 Mar 2019 16:31:32 -0400
Date:   Mon, 4 Mar 2019 16:31:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     john.hubbard@gmail.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3] RDMA/umem: minor bug fix in error handling path
Message-ID: <20190304203132.GA1055@ziepe.ca>
References: <20190304194645.10422-1-jhubbard@nvidia.com>
 <20190304194645.10422-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304194645.10422-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 11:46:45AM -0800, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> 1. Bug fix: fix an off by one error in the code that
> cleans up if it fails to dma-map a page, after having
> done a get_user_pages_remote() on a range of pages.
> 
> 2. Refinement: for that same cleanup code, release_pages()
> is better than put_page() in a loop.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
