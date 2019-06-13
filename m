Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6564C31E4B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F26F2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="OSBqGRX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfFMUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:13:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37161 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfFMUNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:13:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so437589otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdSbzBj3GN9lmFE97uLhhDp9bhFpPD/Ri2wBNX09PfQ=;
        b=OSBqGRX5/KZ8rtnYLy8/+VzWXJoy8dOkJHihIoyUXY2eP7FoiV7nziOVkOw4+nZKoB
         8BX3vQfUbWi26DrxuPJOZQTkwLvG8bcvI5bR3K46S8XaTPV6uYDB19u7pEoWDIMGVXIT
         76Gat4HdmnE0UfZtW6tDnTRkZMx/UjOMIIhYc/M0re4EVEJMI//Xgzy79OcW2RngZAFY
         Ex/a+k84aj46psorP2SyODhm0RWUknVG0v09x5bcP8Nl31V8edNccp6WpICo1yfvAEqk
         4PlHWylrgwZOgDTADWj7FVO4iX7LA9uouJaVlZvN2+vo54OtBLhCAxLVmuocFehTb/fy
         IX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdSbzBj3GN9lmFE97uLhhDp9bhFpPD/Ri2wBNX09PfQ=;
        b=I03T199idDCgdjBXVK7X2ZPoG+yTQCl2/0z6EBLhffSMzx/NbHBNA/hsI9W/R+8piO
         VtF6cYk2KVwFV3A3SqWYuSl90CmRk/dgHFeqQweva/9LcWjrWU6o6Bp4m7K8iAf4Bfr0
         /fDKZMhy7jBXGE0OKNtPuk6D92EKyojTh63PuldnvQbRhIzx13gsX4M0fgxSFpx+2W0n
         J910Rkx7UCsWaxWCPDnegV5wUMi8pDzPESIblYlXZ9RJnQGYjJI9cdAi30H43wKUAFnf
         wjlM26pCLXGJeYJ6S14cmnnEzXjkGFhV0uu37CdIWWm8jhh+euz8bahpmIqSI2GY9g39
         /Kew==
X-Gm-Message-State: APjAAAXCvuUp2rSsLogNhUMktKe8/trrXPh0sMCHkXZesnHdDuWiL6t3
        QDWQT5cZLcfQrZ4fZCoTwuvEGHYFMKXdkOxitB78Wg==
X-Google-Smtp-Source: APXvYqykaGayuOdeZmPun6lqMah28WqyaWO5bFenPtOzBFg0qXVTvO/T6gfkniMpvZVUXEcVxeJc+t1pW1I4QrwLh2Q=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr37784514otn.71.1560456832159;
 Thu, 13 Jun 2019 13:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-10-hch@lst.de>
 <20190613193427.GU22062@mellanox.com>
In-Reply-To: <20190613193427.GU22062@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 13:13:41 -0700
Message-ID: <CAPcyv4iwVPm2XBviR8E32VJG+ZZTHZLGxDdXS3et22CTT_3qNA@mail.gmail.com>
Subject: Re: [PATCH 09/22] memremap: lift the devmap_enable manipulation into devm_memremap_pages
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:35 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jun 13, 2019 at 11:43:12AM +0200, Christoph Hellwig wrote:
> > Just check if there is a ->page_free operation set and take care of the
> > static key enable, as well as the put using device managed resources.
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index c76a1b5defda..6dc769feb2e1 100644
> > +++ b/mm/hmm.c
> > @@ -1378,8 +1378,6 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
> >       void *result;
> >       int ret;
> >
> > -     dev_pagemap_get_ops();
> > -
>
> Where was the matching dev_pagemap_put_ops() for this hmm case? This
> is a bug fix too?
>

It never existed. HMM turned on the facility and made everyone's
put_page() operations slower regardless of whether HMM was in active
use.

> The nouveau driver is the only one to actually call this hmm function
> and it does it as part of a probe function.
>
> Seems reasonable, however, in the unlikely event that it fails to init
> 'dmem' the driver will retain a dev_pagemap_get_ops until it unloads.
> This imbalance doesn't seem worth worrying about.

Right, unless/until the overhead of checking for put_page() callbacks
starts to hurt leaving pagemap_ops tied to lifetime of the driver load
seems acceptable because who unbinds their GPU device at runtime? On
the other hand it was simple enough for the pmem driver to drop the
reference each time a device was unbound just to close the loop.

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

...minor typo.
