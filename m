Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61483C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B3120730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="poDEPVm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKOQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:42:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33870 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfKOQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:42:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id l202so9180340oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UZSpFkKNVNV5BKs7QN+kq39SLlJrWMnwXj2a0zo8qnE=;
        b=poDEPVm+GRR+otLxrdSAZ6RsFhwEqAB1QsJkDuE4KbprEHKb80CHLXH6PlYDj+gCJV
         aHoGJ3u18gqjviqy7N0LoTBLO0V2sac4WD6sUmk1cxf7Sedhny0n6g52TAzu+xTL5zcX
         tqsterSsgoqkXQTAK3rkgi24Qnqpvpccy1d9oiLUq5Jl0AXoSygIvE9v68gz5rB1E11H
         AQNZMSqmOY8G/6aXzE1okGyyRJT0rVFrhEFiY+ce5br0jvhm2hC5K3JKJVYJ547eYn4a
         fbU3FL4L9qINKtj5J6n+64VjPU/E93yKhOQa2y2aFvCUxcwPs94f7rvsImulrlR+aYaS
         u5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UZSpFkKNVNV5BKs7QN+kq39SLlJrWMnwXj2a0zo8qnE=;
        b=EF4PSanThQkiu+AIVLnwE2Wiw4HGEqQEaNUB09Rvx//0IOqrrHBa5nlxp1CIxNnLpw
         635590AEVHxmV6zF/lvGa0KW9ObB2Vg0bat6wDYoMvGiHbABmVxoU/OQVQlOb6lUrt3n
         MbAGnJDQo8c2mpIQ8PTlnnk9+eCfK3s6Y75tGBQ6UNQ+ZQFzIe987V2X06GSOdWJVpjc
         sEaKMGec/OQdS6r2HYIs0fAjzrlhAAeJ9ufvda+8PkZJQggJkS2KXjqIer2Y9Wehl93y
         1uA6NFn8iHnEuHtE0pDLicucISdEo/nGuNH57bxl6bhflKraOUFuRZAoB5O7G85QcSBV
         7Dfg==
X-Gm-Message-State: APjAAAUkrZeMU1ZFtNdGiWcWZw5qVEFdh46LHWenYM+A92lrHleDqzAh
        a8rpvUfU33qm8uxFnyWVhsJkTlkDoTMXSmGmuPvi497lhA0=
X-Google-Smtp-Source: APXvYqwos7WvYIQqqWWqUogHfETfT35eaGRAWlExs8ZOoMOJeR3E1BLLqRkliqxSdDz2iG5PlZ1EhrthGVA+LQklxHU=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr9249378oib.105.1573836126000;
 Fri, 15 Nov 2019 08:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20191115001134.2489505-1-jhubbard@nvidia.com> <20191115001134.2489505-3-jhubbard@nvidia.com>
In-Reply-To: <20191115001134.2489505-3-jhubbard@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Nov 2019 08:41:55 -0800
Message-ID: <CAPcyv4hWksbxM5h4b4hCfs_MSggDoEDoxiu4sw2uj1N=z+mOcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: devmap: refactor 1-based refcounting for
 ZONE_DEVICE pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 4:11 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> An upcoming patch changes and complicates the refcounting and
> especially the "put page" aspects of it. In order to keep
> everything clean, refactor the devmap page release routines:
>
> * Rename put_devmap_managed_page() to page_is_devmap_managed(),
>   and limit the functionality to "read only": return a bool,
>   with no side effects.
>
> * Add a new routine, put_devmap_managed_page(), to handle checking
>   what kind of page it is, and what kind of refcount handling it
>   requires.
>
> * Rename __put_devmap_managed_page() to free_devmap_managed_page(),
>   and limit the functionality to unconditionally freeing a devmap
>   page.
>
> This is originally based on a separate patch by Ira Weiny, which
> applied to an early version of the put_user_page() experiments.
> Since then, J=C3=A9r=C3=B4me Glisse suggested the refactoring described a=
bove.
>
> Cc: Jan Kara <jack@suse.cz>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h | 27 ++++++++++++++++++++++++---
>  mm/memremap.c      | 16 ++--------------
>  2 files changed, 26 insertions(+), 17 deletions(-)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
