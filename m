Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E67C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC3D233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Axfhikvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfHUTxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:53:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46879 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfHUTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:53:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id p13so2934833qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Avf248fSzuypFcso7Kkr0yA+lcmduhMaWHH94TkjpAI=;
        b=AxfhikvjRrOipQcntJRqjdr/eKvR8BEra5qlDG10hvhnCuoV2Y1rax7uZg5mfRHTHC
         uPaWNuH6Em8WzNOLx9kTZ3NE540jiIjPDyL116dF2ihKw7XrA7R8XahBlEtlmkpTrEca
         iiMP7POS3K8y6Kjq4ZtTUy8g4uMiJ8gVVTdfnXrqGDdfUfCnK8ClM5wD8SM+V4khKCtG
         GxBMkz9dMuyiKJVS7YQukqCbImb4gRl3aNgGS/xQvglUUbXbj0EYMXZXq6GP+7adG5Jr
         vBXarNpeiZyR7KKPZZeJfz7rr0BkCL3tTmpq3tB8OjRr7Lbf17hUatbpQDkomugG4wri
         qr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Avf248fSzuypFcso7Kkr0yA+lcmduhMaWHH94TkjpAI=;
        b=tBvtpKyLNLVpxMCuiAmBddW/spKegyMF7MhofHD+nteAd9QFkCkfFJnd61/kWwhPw4
         nxfL+ynSdPYHawlFzoTpo/h6rn+9grcP6BXS5Je5IMVGCV+3qc1moCt7SmCPMtnE4YG2
         3Dyjr7vtmpSOAl561DAos3dzWNYOBr+C+XL4fqzUvLu37AuVQWpe9vq1GZRe9M+ERZJs
         3klE/5VdRCpEisuuIXElcZUFjyfkSiSY03BcRdAF6MvqEZb+Tl51N3nZcsSkrSj4xNNA
         hLl4eftiNr/FgXhn4yqoYcISR7e5dDyWEp1237g6D8L17N+bl29OA4kzfXzlSoyn8D/n
         MOaA==
X-Gm-Message-State: APjAAAUGX4iILpioPOSSafakbECf2dVbRFwLfR+MSsLgyXcUmA2pyE2H
        f3JnFdoD/cAertdf+gJgtrwK9Q==
X-Google-Smtp-Source: APXvYqwPksLN/jmRrXTfKl1JB/9WM5tJ8kTKLiTdMf+ZNHYSP0hbNDBV4ZLxlKKKGF2mGcl3vHw8pg==
X-Received: by 2002:a37:9701:: with SMTP id z1mr17576531qkd.66.1566417183189;
        Wed, 21 Aug 2019 12:53:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b202sm10311656qkg.83.2019.08.21.12.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 12:53:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0WfG-0005oO-5E; Wed, 21 Aug 2019 16:53:02 -0300
Date:   Wed, 21 Aug 2019 16:53:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>
Subject: Re: [PATCH v3 hmm 00/11] Add mmu_notifier_get/put for managing mmu
 notifier registrations
Message-ID: <20190821195302.GA22164@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:15:37PM -0300, Jason Gunthorpe wrote:
 
> This series is already entangled with patches in the hmm & RDMA tree and
> will require some git topic branches for the RDMA ODP stuff. I intend for
> it to go through the hmm tree.

The RDMA related patches have been applied to the RDMA tree on a
shared topic branch, so I've merged that into hmm.git and applied the
last patches from this series on top:

>   RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'
>   RDMA/odp: remove ib_ucontext from ib_umem
>   mm/mmu_notifiers: remove unregister_no_release

There was some conflict churn in the RDMA ODP patches vs what was used
to the patches from this series, I fixed it up. Now I'm waiting for
some testing feedback before pushing it to linux-next

Thanks,
Jason
