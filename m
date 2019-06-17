Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B8C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059642085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zsU6x4/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfFQTZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:25:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43093 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfFQTZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:25:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id i8so10667094oth.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNxPoXz08Bkv6XLKAsIWbiHb1gnesryRGgT+tAFHLoc=;
        b=zsU6x4/n004yGk33kbKQd/6ii5ctCApqWKr2xXu2QHfi+ncPf+6aOer/hnDk2UAkcB
         jGunUn0he2nTR0uU2859WbUUtlv6pvLc41AXK2T6AWHriY76vgq0YRD//La6/nHXzo1Z
         YPIa/GBGOk0VXAfuIX+0DmRt+mlbZWG/S7zDJ2J1W8prL2gnJon9QkcM3fcOMMdwSo4e
         4OrGQSbgcfUmMeefb3e2ZPd0f7T54UdNfjjuNpUJ/GMYEaMNtkVI6YVgubTvq1/bIgZo
         qVrNws/T9AqY75DGEixSkuSqStvevZuszwTUzd/rSGi9BdsaPARyVCoYryGFhOd3HmF5
         Pgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNxPoXz08Bkv6XLKAsIWbiHb1gnesryRGgT+tAFHLoc=;
        b=VpCn6Gmvgkw/YefNweuHalCucfLw5g/2EpPIYxLovqmBEXXjPBLgqXMGmNsuUQnmxv
         /n9RrrGuIx6qgl0VOjVmMWEpt+f2V2fta2SBoV9VILmJI5pXDmbaEkxAXqzBYa/e/Cyr
         GAvM031AC0co/cxYQ5mt1iPsop5yFmK80QaqMJvWTaRT3MYUs+rp/3hRr0oEdyQKnegt
         2mFsI6c2ETKjJf2BZvHajl1dYR9sc9aLlzmeggobIHboQF2pbAK8UxWPuMvvnpmfjE7f
         SgWyzTVNSbEp+uPRnCzXONGU0Ai2Kfon+EeKybUUFKOzuUD0epVqnC9nbTVeAyr3QiRe
         7tRg==
X-Gm-Message-State: APjAAAWwvfnTMqejxT+sHXZ6Gtit3tEoKBAymKFzVGFMc1qVrLHjqOks
        FirY1i3COsErW2Tr2Ifwn+kcEnrCwGNcoy3htxxK4w==
X-Google-Smtp-Source: APXvYqyQusXzMIvOnOSDlzozCSKeY3iIGkQ0PmM8jIAxg1c9m+Lhh4LXmnIB3y6iM6i/y/0k5RVphJmN2SXJiVLtpbU=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr55333952otn.247.1560799528939;
 Mon, 17 Jun 2019 12:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-11-hch@lst.de>
In-Reply-To: <20190617122733.22432-11-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 12:25:17 -0700
Message-ID: <CAPcyv4jtZSK7bgQX_Sm1E-Thqmyhs30SrZKoSApjghRLL12Ngg@mail.gmail.com>
Subject: Re: [PATCH 10/25] memremap: lift the devmap_enable manipulation into devm_memremap_pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 5:28 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Just check if there is a ->page_free operation set and take care of the
> static key enable, as well as the put using device managed resources.
> Also check that a ->page_free is provided for the pgmaps types that
> require it, and check for a valid type as well while we are at it.
>
> Note that this also fixes the fact that hmm never called
> dev_pagemap_put_ops and thus would leave the slow path enabled forever,
> even after a device driver unload or disable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvdimm/pmem.c | 23 +++--------------
>  include/linux/mm.h    | 10 --------
>  kernel/memremap.c     | 57 ++++++++++++++++++++++++++-----------------
>  mm/hmm.c              |  2 --
>  4 files changed, 39 insertions(+), 53 deletions(-)
>
[..]
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index ba7156bd52d1..7272027fbdd7 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
[..]
> @@ -190,6 +219,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>                 return ERR_PTR(-EINVAL);
>         }
>
> +       if (pgmap->type != MEMORY_DEVICE_PCI_P2PDMA) {

Once we have MEMORY_DEVICE_DEVDAX then this check needs to be fixed up
to skip that case as well, otherwise:

 Missing page_free method
 WARNING: CPU: 19 PID: 1518 at kernel/memremap.c:33
devm_memremap_pages+0x745/0x7d0
 RIP: 0010:devm_memremap_pages+0x745/0x7d0
 Call Trace:
  dev_dax_probe+0xc6/0x1e0 [device_dax]
  really_probe+0xef/0x390
  ? driver_allows_async_probing+0x50/0x50
  driver_probe_device+0xb4/0x100
