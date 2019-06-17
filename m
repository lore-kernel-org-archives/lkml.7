Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84222C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3E82084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GEy6EGCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfFQRh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:37:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43672 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:37:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so10082035oth.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBoBuo4G3FSgEhDC+FoktVJNloMg07m1kebASNjaow0=;
        b=GEy6EGCLZL0UwYQ9PkUNByAPZFrQNOY55J4Isr3tPIqQ98XVq0fsFEiJHE9y337UnR
         z0ckb3F0Q8bUBMwOxk3FMovLMeLeRhGzCH4bMfXl//v4SZneAiWL2E3nXGQ0kfcbkMQ5
         r05Q0aOOGSCIoONjGAUc0NUdIqrqwt9uOKpttnI5/W0wpWZ0UjI/eMzHv96YMzDyw6ea
         Iw2XLIDHbY2xAKMBDynID8VFE/XZYZnxY6Kobfxb5Ee621xVhNNWauS73uuIqKg8WlP8
         DC4G2oI80ceWohUqqQoEpsB1uZSHUXQoqzfwbmLCxnomOs9Nh6gRUrBB4UmmNwcz2q++
         zoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBoBuo4G3FSgEhDC+FoktVJNloMg07m1kebASNjaow0=;
        b=NoKSEtm7/IZh+Eg3GEL0CnhJ4M581m7bMyWmcWBTq+HtOQ36Q2tC+Iagf/Uw2DzwyG
         XHUfvtgTkJmkmj5eojZHFLMLIc+iVXGBhnUvgpYYYtRj1YyVcn3tnwbpyuPWp0FiSahy
         7x0ZjSIQL+tarrRuOoIPMopfhnJ9Qn6iz1sGRkyIfaVXW6KKSaPb7rXLVmTQbuUKOBae
         nhGU2Wgz13fmpO1hBYIdmSj080ogp3maU2SM4Bx1nC30aN2m/qf43b35I9SjR8bKingW
         xT3CpvUbcVxJ9tekyAxT5cjP7NJUAAiNWj5pcxl0Ekumb+tSXVKcOTTT5ipaK2EerkzB
         6Xow==
X-Gm-Message-State: APjAAAWOB1dwLSyootcQ2L42StIah8eAF5NmCsr7u2k7xVZxpzA390b6
        Q1Oq3sgj6/hXBSFK7+dhjD01Y1SBi3VF7/vwJYomOg==
X-Google-Smtp-Source: APXvYqy6UHQ+8+yRan8DQxrtjWFO0AeHWuMCd0MZM6YFNNcDvh4g1h/fJSpQjjAZ+ZTnayEmtlW26P14xfxTxsyl170=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr25335686otf.126.1560793043776;
 Mon, 17 Jun 2019 10:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-7-hch@lst.de>
In-Reply-To: <20190617122733.22432-7-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 10:37:12 -0700
Message-ID: <CAPcyv4hoRR6gzTSkWnwMiUtX6jCKz2NMOhCUfXTji8f2H1v+rg@mail.gmail.com>
Subject: Re: [PATCH 06/25] mm: factor out a devm_request_free_mem_region helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Keep the physical address allocation that hmm_add_device does with the
> rest of the resource code, and allow future reuse of it without the hmm
> wrapper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/ioport.h |  2 ++
>  kernel/resource.c      | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/hmm.c               | 33 ++++-----------------------------
>  3 files changed, 45 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..76a33ae3bf6c 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -286,6 +286,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>         return (r1->start <= r2->end && r1->end >= r2->start);
>  }
>
> +struct resource *devm_request_free_mem_region(struct device *dev,
> +               struct resource *base, unsigned long size);

This appears to need a 'static inline' helper stub in the
CONFIG_DEVICE_PRIVATE=n case, otherwise this compile error triggers:

ld: mm/hmm.o: in function `hmm_devmem_add':
/home/dwillia2/git/linux/mm/hmm.c:1427: undefined reference to
`devm_request_free_mem_region'
