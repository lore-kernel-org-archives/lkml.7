Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BACCC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39CE20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V2pQCRMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfCFSp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:45:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38785 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfCFSp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:45:57 -0500
Received: by mail-qt1-f194.google.com with SMTP id s1so14049461qte.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wP4x1hH9ASA25vStqJ3tJGCz2jYo8u6wNo9sRUut+8M=;
        b=V2pQCRMHS1s6mmiWLTMzw9Ywz9BxY16RXHVXGkV3niNlpnB+mFV1VLlsophkQdsLKY
         2zX0WGYf21kPzTFJEHFymHSgJjUicWqvFegXwI7dJ02ONdTgbXy8tPVUnToWmvQiNmzv
         rr2w+eDAEDUk/TK4zkgOlp8tmeFWv141l7cZMMxV75Vlz/U+Nd0Glre4EuLwuQBs1Y+W
         RQTVaVh1CQS8BZ5RgDF3FPTsGhDR6WCsaWQQ82Ik2Fd0K1PVjkPmZqoHlrG5XVGyxcaF
         TWAh0xgJf8AHJBXBdy45No4KJa8kIvApq90vDKVujmF91qYNn1ZAJO9/izATrWi3xpHe
         sJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wP4x1hH9ASA25vStqJ3tJGCz2jYo8u6wNo9sRUut+8M=;
        b=mWXrFgkK9yz4NJi9Dt+qRarLUy3EFsUAlLpWvPjpjKxj27otqvTqaWg8UvGxMeWsfm
         eH9JCEVjeWBxS9SZhDT+q4dQrnoQiUlKZOotlMvZT+PrzTDAibR9pj8ywlrV6jwUnfVx
         wamHDzIsNW9Trxisl3/NJ8hIjF5ZKkHVO+ewJrma2A3mKv6EUarulPNj6VUMB/D4N9iA
         u3KyZ4vadfSsZv14G/eYuTSzxJB8Pu5FUZHnZrhRw+C2AIffrLStFfAAI3L0nT+vS9WZ
         4eUq9/1pkti0+qrqsMhH4BOQ2d5Xikq2mwt4DgUFMy9hd1x+oIqMeDkmEHgOKTIAHiWl
         8q4Q==
X-Gm-Message-State: APjAAAWOGYkgOoJnFY944Cm1hMydFc4SaJIs3/zzG/dQ3dEsI6tJdb+X
        JXVKhiB8Ih1qyzSYGCeGF9HAv0mEBaY=
X-Google-Smtp-Source: APXvYqxJhjubnP2c5kwOcRCIALiz3FeIJ/AsJUODcIi8OSpPh57S2nc20GPqu2e0uRk2rhdoVnXYzw==
X-Received: by 2002:ac8:148b:: with SMTP id l11mr6577506qtj.290.1551897955580;
        Wed, 06 Mar 2019 10:45:55 -0800 (PST)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id l31sm1519876qtb.20.2019.03.06.10.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 10:45:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h1bYA-00079W-2T; Wed, 06 Mar 2019 14:45:54 -0400
Date:   Wed, 6 Mar 2019 14:45:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     john.hubbard@gmail.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/umem: updated bug fix in error handling path
Message-ID: <20190306184554.GG1662@ziepe.ca>
References: <20190306020022.21828-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306020022.21828-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 06:00:22PM -0800, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> The previous attempted bug fix overlooked the fact that
> ib_umem_odp_map_dma_single_page() was doing a put_page()
> upon hitting an error. So there was not really a bug there.
> 
> Therefore, this reverts the off-by-one change, but
> keeps the change to use release_pages() in the error path.
> 
> Fixes: commit xxxxxxxxxxxx ("RDMA/umem: minor bug fix in error handling path")
> Suggested-by: Artemy Kovalyov <artemyko@mellanox.com>
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
