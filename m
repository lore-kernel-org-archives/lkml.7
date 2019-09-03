Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBDBC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CCC21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KAqD+boV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfICFbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:31:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46349 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfICFbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:31:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id z17so15463722otk.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 22:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGKYy9yMsvJ2kTO5n+BuY7ZyhZgTpOWzHalFTSpyidQ=;
        b=KAqD+boVKcoC0ROi4cYqnfBlJFSf5Ilc6evakbMhCji7VI5iw3xDhL39RH8t5pGCeP
         HCa+3Yf+XVz9FUJJWu2kv0MUJnvsEla+rZJ2uBTa22jzYTZisfxqS8kEQPBex0nchX3o
         7JLJP+fNEfoCJhrtvwxvS/M7ouJ+YNGgBi8y5xtVc1xOTCLN9oq8qdyqFykdlfYXiNiS
         EAHLIl+e8mOVQF6tjgfW81cVNoxSx+83LGYiafqMA8EGPbM6IGPrds5WszbCFYZI+3Vu
         Od4LWGVOan+V/9wQi3GBhzNIgoDzga26KzAI/bvAnwSthkfkKnuL9VAWb1eUsXk+q7oU
         puEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGKYy9yMsvJ2kTO5n+BuY7ZyhZgTpOWzHalFTSpyidQ=;
        b=LAI2YUPRSTB4PxZXxh3w2K4IH2cxp5ihgvhImS7P7jFGC3rS2A1kx2YF/ODSJ4feYr
         WzlDhp7aUje93rL10MSrKwNA8EdIWl+ry8Qbo/ECgxjuawhLDoRAP4qr7ZcB9bWvT0JH
         h7Q33fzbryLLfsWW9xYJng5pyDbBeRz4rpVLXvZfZwlSOAAq70+GCet6s63XZsgzhQYC
         HSAYo/i13fgdOzSIQYn+1wPbbUQe4gH8/xPiYYO4vgCIuJd/G9DFxlKmjAUmt/s/+GgI
         E216RH9mcyZAYw087kDpFNesbn5i5TeJLdj9ey06UUkPKUPIrC9bz/pRVmqQAcfXL+jq
         /PTg==
X-Gm-Message-State: APjAAAXzUSsZpsEPIY5PvTlGujHwY4hWXr8RtE1vqpk4hggloYardAj0
        FIFCnEuFAGKN7m6eCPV0bGgRrL4rah4BkMeRQ6IM1g==
X-Google-Smtp-Source: APXvYqxICI33147suMA8tn/fNIGFMIb76QryDyObOhkgiI2hJnHiBjE0kEVaAW0OE+xuduvcFwDqLWBdPgXh0HoLOYk=
X-Received: by 2002:a9d:6d15:: with SMTP id o21mr1117891otp.363.1567488671666;
 Mon, 02 Sep 2019 22:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190902205017.3eca5b70@canb.auug.org.au> <20190902105137.GC20@mellanox.com>
 <20190903094511.2704484a@canb.auug.org.au>
In-Reply-To: <20190903094511.2704484a@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Sep 2019 22:31:00 -0700
Message-ID: <CAPcyv4hyEK=jA=ATyzjKbJDeQfpOyRo4pxoFCTf1LHa-muC14w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the hmm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 4:45 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Jason,
>
> On Mon, 2 Sep 2019 10:51:41 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Mon, Sep 02, 2019 at 08:50:17PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> >
> > > ERROR: "nd_region_provider_data" [drivers/acpi/nfit/nfit.ko] undefined!
> > > ERROR: "to_nd_blk_region" [drivers/acpi/nfit/nfit.ko] undefined!
> > > ERROR: "nvdimm_region_notify" [drivers/acpi/nfit/nfit.ko] undefined!
> > > ERROR: "nvdimm_blk_region_create" [drivers/acpi/nfit/nfit.ko] undefined!
> > >
> > > Caused by commit
> > >
> > >   126470c8a58b ("libnvdimm: Enable unit test infrastructure compile checks")
> > >
> > > I have reverted that commit for today.
> >
> > Looks like more kconfig trouble, can you send Dan your kconfig? I'll
> > drop this patch again
> >
>
> Thanks.  It was just an x86_64 allmodconfig build.  I don't actually
> have the .config file (it gets cleaned up, sorry).

Strange. x86_64 allmodconfig is certainly a 0day build target. Could
this be toolchain dependent?
