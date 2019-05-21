Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F19C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB6A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KmrwjgH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfEUQyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:54:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38381 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfEUQyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:54:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id s19so16989190otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHyxxdCulthGGKCbcuDYU1DyzLMsf7EAoBxw15HJNqA=;
        b=KmrwjgH55rKUw5bqIvpvFnD07PXHH7SJsCt1oTLDYR+Ngbo95qTBMiDayK/T72vXZN
         Avx47DGuOuF1vapQph16LlsXG1juDYSt9PIzVC+ClWmLndroDTHzFUWCacgdagkgOfKB
         RZNUEEoUbhaWH5kvICIk9zR+I59+NAep489TP336aGQG6FqPf2MTL+jNJ2GMoHDKTGUR
         t3Xc4Wf6A+/2QtsYp3wdSbw8oTBXMmxpJA4v3cI7HA5pT9zYwL6ebm8BLJuLsAKMmYzZ
         qZQmGLZqAMLzcj0iPF8/V6TgDHh0HnEDyIlIpVTw/SlnvwzNv+at8W4uxA6DmyOMLZMe
         TRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHyxxdCulthGGKCbcuDYU1DyzLMsf7EAoBxw15HJNqA=;
        b=aEX/eH2Xl58G+ErO5ilyXy4J5Qp7ZLQMC+L8naB+11H1vyPtt5mn74+O+LOgbEmCdI
         yiPCJ/45NR/SwIzm4xBBek8pX2Ehdlv6CoJKqYQS6ZipEE2tyA8GZZnBwlk5RqkGjxUQ
         Hq7rtLoq4fc/Qf1R/bvyoYg8Po9YEWJmrny1eqBQULSibVr90HFnWKdSk1wKoUZNHYQ8
         vbsKbpzZLzhW3vyPF6VllMtbj9M1I53vmmYK1WXnBw+zkMT5L4zpFeyh/MRw13cwWAd1
         6zxFaGJjUElJtSHw0LZYzkz99pFfkV9U4WPrGqzeoWKKOWLF5ctFGBWHZv/drDCBgCPi
         i7sw==
X-Gm-Message-State: APjAAAVzF8U/bzlTFxBFF7G5rLtsD3fMoRo6S4tCvNm93Z2Do4uJ3Akd
        3K+Wqlgs2tT2x88hvTw0CyhagTB5HTwI8nNRDR9LSQ==
X-Google-Smtp-Source: APXvYqwIKt/XH22CjB9xbefxXBJf+2suHAPutL2reWSQeS/hGSPLUhtpc4EiRbPj70y29pq/8uIl/yv2T9ANELNfFz0=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr3999902otr.207.1558457654221;
 Tue, 21 May 2019 09:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190517215438.6487-1-pasha.tatashin@soleen.com> <20190517215438.6487-4-pasha.tatashin@soleen.com>
In-Reply-To: <20190517215438.6487-4-pasha.tatashin@soleen.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 May 2019 09:54:03 -0700
Message-ID: <CAPcyv4iZ7sx6L+3yDKSXth6b+qdtCmVrLxmCvCuRAYBMbSM+Bw@mail.gmail.com>
Subject: Re: [v6 3/3] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 2:54 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> It is now allowed to use persistent memory like a regular RAM, but
> currently there is no way to remove this memory until machine is
> rebooted.
>
> This work expands the functionality to also allows hotremoving
> previously hotplugged persistent memory, and recover the device for use
> for other purposes.
>
> To hotremove persistent memory, the management software must first
> offline all memory blocks of dax region, and than unbind it from
> device-dax/kmem driver. So, operations should look like this:
>
> echo offline > /sys/devices/system/memory/memoryN/state
> ...
> echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
>
> Note: if unbind is done without offlining memory beforehand, it won't be
> possible to do dax0.0 hotremove, and dax's memory is going to be part of
> System RAM until reboot.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/dax/dax-private.h |  2 ++
>  drivers/dax/kmem.c        | 41 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index a45612148ca0..999aaf3a29b3 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -53,6 +53,7 @@ struct dax_region {
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>   * @ref: pgmap reference count (driver owned)
>   * @cmp: @ref final put completion (driver owned)
> + * @dax_mem_res: physical address range of hotadded DAX memory
>   */
>  struct dev_dax {
>         struct dax_region *region;
> @@ -62,6 +63,7 @@ struct dev_dax {
>         struct dev_pagemap pgmap;
>         struct percpu_ref ref;
>         struct completion cmp;
> +       struct resource *dax_kmem_res;
>  };
>
>  static inline struct dev_dax *to_dev_dax(struct device *dev)
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 4c0131857133..3d0a7e702c94 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -71,21 +71,54 @@ int dev_dax_kmem_probe(struct device *dev)
>                 kfree(new_res);
>                 return rc;
>         }
> +       dev_dax->dax_kmem_res = new_res;
>
>         return 0;
>  }
>
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +static int dev_dax_kmem_remove(struct device *dev)
> +{
> +       struct dev_dax *dev_dax = to_dev_dax(dev);
> +       struct resource *res = dev_dax->dax_kmem_res;
> +       resource_size_t kmem_start = res->start;
> +       resource_size_t kmem_size = resource_size(res);
> +       int rc;
> +
> +       /*
> +        * We have one shot for removing memory, if some memory blocks were not
> +        * offline prior to calling this function remove_memory() will fail, and
> +        * there is no way to hotremove this memory until reboot because device
> +        * unbind will succeed even if we return failure.
> +        */
> +       rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> +       if (rc) {
> +               dev_err(dev,
> +                       "DAX region %pR cannot be hotremoved until the next reboot\n",
> +                       res);

Small quibbles with this error message... "DAX" is redundant since the
device name is printed by dev_err(). I'd suggest dropping "until the
next reboot" since there is no guarantee it will work then either and
the surefire mechanism to recover the memory from the kmem driver is
to not add it in the first place. Perhaps also print out the error
code in case it might specify a finer grained reason the memory is
pinned.

Other than that you can add

   Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...as it looks like Andrew will take this through -mm.
