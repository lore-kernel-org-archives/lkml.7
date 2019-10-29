Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB3CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D80204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ton5hZMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfJ2TSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:18:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33588 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbfJ2TR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:17:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id 71so25911qkl.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MiZaBDLtkGC2+waxhGGq8xdyCqxWB6WzvPaoZbLYYg8=;
        b=Ton5hZMNO5L6j3O6Z0aT/yd/JiU0tb2UFOa3Lt4/kYYMZRYpDjtEhDgH+720i0OupF
         oOnyZm3MWbhesFgyeSTZMO2C4rlW40SbvQTgVbrDzGTbsB+MCNT2dtw1NqXVERP3v93q
         CfLXpAjFiJczmrrYHI5uQxwcpb0W+HooWILvY4wO18bocUIcM6ZWZLRnMJdyYFjZqDR7
         qp7/3Jv9hJIwBrvNKRdCaI8HcGUznwlTqz4HFP5XqBMniwEt/ZU+BFYCynbOB4SbZOiR
         cTNabChaoEJORLIHlrYYUF4fopM6WGtGw2+BqnLTzl7aLh1EVKUsJ6UrzYBejZZhyUO5
         sCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MiZaBDLtkGC2+waxhGGq8xdyCqxWB6WzvPaoZbLYYg8=;
        b=nFB6iPnuGwHzM54R1lK8C82pEEfJUGGTdUyRyLKX3/hrjRiNOgbH+tYPurFNAlbYrf
         OQIvymgPYdJnExW7dfIGYZL6HVushh/XNW0YIMgAx9jBJFMDFuJ5y31qc62cADzhYg3p
         /oQlIARzXrYq5qnJC4BcvGAWQkCVHLn0p2roplHuGGF1E9knucMoJmzgvrW1wS4zPKoE
         v/6eBobg4WkBk8nthkttN0secaEWw10x/slOz2wcSXQoMXWHNtkCp692jg2z7FKqRgv9
         mFHcml2IrgmYnD/diZbNJI81hCRJoEJvPSFXKkFxuD086zhtXGmDFDPGd3gpTRBXVlxS
         ug6Q==
X-Gm-Message-State: APjAAAVfE4MJ/l4/8ZTFlPtNC1z3kNsOw7uNlkaw+OmIW5x0Z5SgK4SW
        3SMxcQVeFfypnQK+SpGtaHVweQ==
X-Google-Smtp-Source: APXvYqyfe73AOsu7OurMFcQnitG+NcgjcutExlfR6KLT234Oi1qps677i71FzyM0AyWOVZFNarrx0w==
X-Received: by 2002:a37:ad1a:: with SMTP id f26mr11054372qkm.170.1572376677332;
        Tue, 29 Oct 2019 12:17:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id l186sm2596650qkc.58.2019.10.29.12.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 12:17:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPX08-00031S-0a; Tue, 29 Oct 2019 16:17:56 -0300
Date:   Tue, 29 Oct 2019 16:17:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Shaobo Xu <xushaobo2@huawei.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Xi Wang <wangxi11@huawei.com>, Tao Tian <tiantao6@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix build error again
Message-ID: <20191029191755.GA11530@ziepe.ca>
References: <20191007211826.3361202-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007211826.3361202-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 11:18:08PM +0200, Arnd Bergmann wrote:
> This is not the first attempt to fix building random configurations,
> unfortunately the attempt in commit a07fc0bb483e ("RDMA/hns: Fix build
> error") caused a new problem when CONFIG_INFINIBAND_HNS_HIP06=m
> and CONFIG_INFINIBAND_HNS_HIP08=y:
> 
> drivers/infiniband/hw/hns/hns_roce_main.o:(.rodata+0xe60): undefined reference to `__this_module'
> 
> Revert commits a07fc0bb483e ("RDMA/hns: Fix build error") and
> a3e2d4c7e766 ("RDMA/hns: remove obsolete Kconfig comment") to get
> back to the previous state, then fix the issues described there
> differently, by adding more specific dependencies: INFINIBAND_HNS
> can now only be built-in if at least one of HNS or HNS3 are
> built-in, and the individual back-ends are only available if
> that code is reachable from the main driver.
> 
> Fixes: a07fc0bb483e ("RDMA/hns: Fix build error")
> Fixes: a3e2d4c7e766 ("RDMA/hns: remove obsolete Kconfig comment")
> Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
> Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/hns/Kconfig  | 17 ++++++++++++++---
>  drivers/infiniband/hw/hns/Makefile |  8 ++++++--
>  2 files changed, 20 insertions(+), 5 deletions(-)

Applied to for-next, let us give it some time in linux-next I guess?

Thanks,
Jason
