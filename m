Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8FCC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 23:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C3D20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 23:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CZiPuQaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfE0XMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 19:12:43 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42933 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfE0XMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 19:12:42 -0400
Received: by mail-vs1-f66.google.com with SMTP id z11so11571891vsq.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wX6N01CkJjaDlOJ1ros8bm2onANhDW8NXyCYvkrtemg=;
        b=CZiPuQaEwv3lqb5SZe/gadbr2on0uyWsxhzjtp+toaxSYDJsJ0veJ+MsHzoIX193A5
         tGyRL3+z39ibqHrkHL4ig8trKDTVq1uE+qiFVL+hYR3cMJo6o4Aspd5k9Fgs+fP8XTOZ
         EBxJZ1nObd0eaWg5uaSRpy2MVza2dQ+cCF/Qs41qm/fon5bRysCHkLJfqF4gN+OpH5zZ
         HsFELDr80DLkXDrbWdXyBCpSqjsGY+tiobrH4KQ86PlJi0KLZWAX8yW8dgduwngWgKtU
         Mr0WcxTALRjcOItn9ozWYXvUi+Rq2hQhmvWnN4sexsY5xyXZZ4wuDkWK4Q22BTIVNblW
         xkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wX6N01CkJjaDlOJ1ros8bm2onANhDW8NXyCYvkrtemg=;
        b=i+Z5dC2DPgTvJpYnKvp0eyPnBChtz3hkuZnDQ2s+v5j48wFbbOsMoUjYlpjhH6RNVu
         nvIGF1e8sWldr49NvvOb0aqKpD6ZX3O9yQAFTuenGG1qRDi7BlArQY3LBP4VL0WbbuP/
         0R0awTja97Yd4Mi6XR6HR/1XabiWjhfEbESwfB55D34PzhHEcHNrIls+EPkXeNN+cO7Y
         eUA/h4VJbqjC4iP4H4MZvPkfXDxPpG8PYcuKvZABA078XC6cmFIJg7pyP6HgyQRynqgz
         om4DvncKyT+orOwoObbB8MtAdfHuW5vIw0OkFqcqzn/lJ+SSA3z5tl+U2r4qJjjypuj6
         5bdA==
X-Gm-Message-State: APjAAAXQdvavJGr+Nen4tEr1+hgQtsRS20ATz6cZsRGLHunBP8UFGWvR
        AaMFrjUBERKD83c7BtpwlE0P2Q==
X-Google-Smtp-Source: APXvYqy4sB3fYsZi2sRGgGcMy7oWE4xaEc4c4gHWtniQFIlK09l6934M+QPzMYcjxy9CgA/oBmrq0Q==
X-Received: by 2002:a67:fa48:: with SMTP id j8mr50026871vsq.143.1558998761897;
        Mon, 27 May 2019 16:12:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a95sm5421589uaa.13.2019.05.27.16.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 16:12:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVOnI-000638-S7; Mon, 27 May 2019 20:12:40 -0300
Date:   Mon, 27 May 2019 20:12:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v2] infiniband/mm: convert put_page() to put_user_page*()
Message-ID: <20190527231240.GA23224@ziepe.ca>
References: <20190525014522.8042-1-jhubbard@nvidia.com>
 <20190525014522.8042-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190525014522.8042-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 06:45:22PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For infiniband code that retains pages via get_user_pages*(),
> release those pages via the new put_user_page(), or
> put_user_pages*(), instead of put_page()
> 
> This is a tiny part of the second step of fixing the problem described
> in [1]. The steps are:
> 
> 1) Provide put_user_page*() routines, intended to be used
>    for releasing pages that were pinned via get_user_pages*().
> 
> 2) Convert all of the call sites for get_user_pages*(), to
>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>    call sites, and will take some time.
> 
> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>    implement tracking of these pages. This tracking will be separate from
>    the existing struct page refcounting.
> 
> 4) Use the tracking and identification of these pages, to implement
>    special handling (especially in writeback paths) when the pages are
>    backed by a filesystem. Again, [1] provides details as to why that is
>    desirable.
> 
> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> 
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Christian Benvenuti <benve@cisco.com>
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c              |  7 ++++---
>  drivers/infiniband/core/umem_odp.c          | 10 +++++-----
>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  6 +++---
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 ++++---
>  7 files changed, 27 insertions(+), 31 deletions(-)

Applied to for-next, thanks

Jason
