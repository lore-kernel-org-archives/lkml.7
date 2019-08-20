Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF1122DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lZbsZt+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfHTB2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 21:28:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42579 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfHTB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:28:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so3524188ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpCrccGQA8l7BTcc8eWw96H6pS6MQIOOzUEqeqPrzKU=;
        b=lZbsZt+/6d5yJAVD8m/RWxrbst/pw6mXm9sXy042kGJEQR9cu7lYZjLiBf6dwe8kdd
         x073MY1NIze1gOonl8UPKw/Tk5EF1OpFoPQGBl5XHSPHM3FU1oVNtDcJqg89FstWApDZ
         fcibc6V2UzCg8TM7EzkiczR5EkpxjjjuQLLKPRPQJq02SSicgxK0jB80zPnLkyusZNYE
         Slg72DBH/UYm3UkD6+qsNs8SVJRkNhZMpJr+9jeb1ioXRRn/PjlKF0yV+Nm9dfMO3FUR
         eIYBUiC3kTdhj84CPutziyMUYtE+g4LnP3j8x3sgoJ+m+Ui16TzkRosrQJJTFUJX8F4e
         dqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpCrccGQA8l7BTcc8eWw96H6pS6MQIOOzUEqeqPrzKU=;
        b=DbIbagSv5/bcSWhjFTVruIW7bI89c7raJMZGolSmhEiafzs3H4XUN5Ss7M5PEGw7AC
         NYlLij6w2Yb9fOdq1dvPCu991jEqzymT+LlvU9iX07uhFJVjaM9wb2YypeImgrqpvU4s
         Sln4oo6n/rXHRVJZIEXKNtHNN6khCb5c+SGwUHkwstlhxwaipkChZFIqW9ciDUKOqdkC
         JRlD8BfcNcdy6ZUvpSP2C+JJ45+5OX7vHCUq46sFIh1BGQpQoxebvH/uBs9654UgAqud
         jVbXKwnJvfVPcTgDlLIjOLyz3mIR5ZnAYXpkVs1XlEofYNxYKf+Vh175a9rtliLA09eg
         RJBw==
X-Gm-Message-State: APjAAAUwuk7c7oeZjKG1L+f5aauZ3FngEEhqkEMBrB+YV4gYrdPvolfy
        qmv2SRjC92+pxSqQDL0iYWgPAa18f01TDHw2n5piMg==
X-Google-Smtp-Source: APXvYqzHphAQuA/iOiJkSZOef8tOpXSCYjbbUJRyOK3xnSM7rIdYobKMnaOjdx9wCeE+nGliVWangEXZTLwnNbJUfas=
X-Received: by 2002:a05:6830:458:: with SMTP id d24mr19871635otc.126.1566264521208;
 Mon, 19 Aug 2019 18:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de> <20190818090557.17853-2-hch@lst.de>
In-Reply-To: <20190818090557.17853-2-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Aug 2019 18:28:30 -0700
Message-ID: <CAPcyv4iaNtmvU5e8_8SV9XsmVCfnv8e7_YfMi46LfOF4W155zg@mail.gmail.com>
Subject: Re: [PATCH 1/4] resource: add a not device managed
 request_free_mem_region variant
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 2:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Factor out the guts of devm_request_free_mem_region so that we can
> implement both a device managed and a manually release version as
> tiny wrappers around it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/ioport.h |  2 ++
>  kernel/resource.c      | 45 +++++++++++++++++++++++++++++-------------
>  2 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5b6a7121c9f0..7bddddfc76d6 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -297,6 +297,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>
>  struct resource *devm_request_free_mem_region(struct device *dev,
>                 struct resource *base, unsigned long size);
> +struct resource *request_free_mem_region(struct resource *base,
> +               unsigned long size, const char *name);
>
>  #endif /* __ASSEMBLY__ */
>  #endif /* _LINUX_IOPORT_H */
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 7ea4306503c5..74877e9d90ca 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1644,19 +1644,8 @@ void resource_list_free(struct list_head *head)
>  EXPORT_SYMBOL(resource_list_free);
>
>  #ifdef CONFIG_DEVICE_PRIVATE
> -/**
> - * devm_request_free_mem_region - find free region for device private memory
> - *
> - * @dev: device struct to bind the resource to
> - * @size: size in bytes of the device memory to add
> - * @base: resource tree to look in
> - *
> - * This function tries to find an empty range of physical address big enough to
> - * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
> - * memory, which in turn allocates struct pages.
> - */
> -struct resource *devm_request_free_mem_region(struct device *dev,
> -               struct resource *base, unsigned long size)
> +static struct resource *__request_free_mem_region(struct device *dev,
> +               struct resource *base, unsigned long size, const char *name)
>  {
>         resource_size_t end, addr;
>         struct resource *res;
> @@ -1670,7 +1659,10 @@ struct resource *devm_request_free_mem_region(struct device *dev,
>                                 REGION_DISJOINT)
>                         continue;
>
> -               res = devm_request_mem_region(dev, addr, size, dev_name(dev));
> +               if (dev)
> +                       res = devm_request_mem_region(dev, addr, size, name);
> +               else
> +                       res = request_mem_region(addr, size, name);
>                 if (!res)
>                         return ERR_PTR(-ENOMEM);
>                 res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> @@ -1679,7 +1671,32 @@ struct resource *devm_request_free_mem_region(struct device *dev,
>
>         return ERR_PTR(-ERANGE);
>  }
> +
> +/**
> + * devm_request_free_mem_region - find free region for device private memory
> + *
> + * @dev: device struct to bind the resource to
> + * @size: size in bytes of the device memory to add
> + * @base: resource tree to look in
> + *
> + * This function tries to find an empty range of physical address big enough to
> + * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
> + * memory, which in turn allocates struct pages.
> + */
> +struct resource *devm_request_free_mem_region(struct device *dev,
> +               struct resource *base, unsigned long size)
> +{

Previously we would loudly crash if someone passed NULL to
devm_request_free_mem_region(), but now it will silently work and the
result will leak. Perhaps this wants a:

if (!dev)
    return NULL;

...to head off those mistakes?

No major heartburn if you keep it as is, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
