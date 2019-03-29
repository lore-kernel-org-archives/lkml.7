Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A109C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028182184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfC2WHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:07:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37886 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfC2WHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:07:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id v84so2892613oif.4;
        Fri, 29 Mar 2019 15:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMejZq18/+Wxs5n8oH4gqh9wWmcSonpiJfOlZddBtnY=;
        b=NyPgix371uB4hs+hxccZIHJGjhTjlX/+2Hb7w/cfX4p/DGsnSdipHvjTboO3rfDpwj
         LKWfVPM56iBssZFjp9DtflI5nqZo0emJUGJBQKV/4VUDJUKD+8f079XtnNoFW6AvXm95
         HZzELfoD3oBqBubEelL1pfcpqAeMfbabbETMCbIhqPBVQ7qhPa7w73buBqR4ve40IB5u
         Ejn2jUmJyqt9AOU5TzE1fcUEz6YBfS7w6chyPU94hqQ5NQA3Uxvctvca41YmwSVhg0+U
         dY4B9iSivJzGzdWAl8k1fFIFvQBArWvJEhc9QIm0sZWH3/e7sONnWJCtmuR9oeC+C/JV
         3ysA==
X-Gm-Message-State: APjAAAV5TgLDVschNpk5jUm4KlHXznelNbyid52AgllWa4Tj2PWTz8Rr
        LEkS2otnSszMDuhpkO4eU4t5cr21Kqo=
X-Google-Smtp-Source: APXvYqx2t8j621CXtdcf0yX0DtSmIM8onrrEjJEVYUhk7UM0Rl+hYEHgmF2+3jV/MVVDq4CV/MGaYw==
X-Received: by 2002:aca:c782:: with SMTP id x124mr5261837oif.61.1553897218647;
        Fri, 29 Mar 2019 15:06:58 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id q23sm1362602oic.45.2019.03.29.15.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:06:58 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id m10so3534174otp.2;
        Fri, 29 Mar 2019 15:06:57 -0700 (PDT)
X-Received: by 2002:a9d:6a47:: with SMTP id h7mr3522537otn.158.1553897217564;
 Fri, 29 Mar 2019 15:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com> <20190329140014.8126-6-laurentiu.tudor@nxp.com>
In-Reply-To: <20190329140014.8126-6-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 29 Mar 2019 17:06:45 -0500
X-Gmail-Original-Message-ID: <CADRPPNTh65rwPVVzJBWt-cNrbQWAoo0FeTGnCHDiqSxvARa_5g@mail.gmail.com>
Message-ID: <CADRPPNTh65rwPVVzJBWt-cNrbQWAoo0FeTGnCHDiqSxvARa_5g@mail.gmail.com>
Subject: Re: [PATCH 05/13] soc/fsl/bqman: page align iommu mapping sizes
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Netdev <netdev@vger.kernel.org>, madalin.bucur@nxp.com,
        Roy Pledge <roy.pledge@nxp.com>, camelia.groza@nxp.com,
        David Miller <davem@davemloft.net>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 9:01 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Prior to calling iommu_map()/iommu_unmap() page align the size or
> failures such as below could happen:
>
> iommu: unaligned: iova 0x... pa 0x... size 0x4000 min_pagesz 0x10000
> qman_portal 500000000.qman-portal: failed to iommu_map() -22
>
> Seen when booted a kernel compiled with 64K page size support.

This will silently incease the actual space mapped to 64K when the
driver is actually trying to map 4K.  Will this potentially cause
security breaches?  If it is really safe to map 64K, probably the
better way is to increase the region size to 64k in the device tree
explicitly.

>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c   | 2 +-
>  drivers/soc/fsl/qbman/qman_ccsr.c   | 4 ++--
>  drivers/soc/fsl/qbman/qman_portal.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index b209c79511bb..3a6e01bde32d 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -230,7 +230,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>         /* Create an 1-to-1 iommu mapping for FBPR area */
>         domain = iommu_get_domain_for_dev(dev);
>         if (domain) {
> -               ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +               ret = iommu_map(domain, fbpr_a, fbpr_a, PAGE_ALIGN(fbpr_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "failed to iommu_map() %d\n", ret);
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index eec7700507e1..8d3c950ce52d 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -783,11 +783,11 @@ static int fsl_qman_probe(struct platform_device *pdev)
>         /* Create an 1-to-1 iommu mapping for fqd and pfdr areas */
>         domain = iommu_get_domain_for_dev(dev);
>         if (domain) {
> -               ret = iommu_map(domain, fqd_a, fqd_a, fqd_sz,
> +               ret = iommu_map(domain, fqd_a, fqd_a, PAGE_ALIGN(fqd_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "iommu_map(fqd) failed %d\n", ret);
> -               ret = iommu_map(domain, pfdr_a, pfdr_a, pfdr_sz,
> +               ret = iommu_map(domain, pfdr_a, pfdr_a, PAGE_ALIGN(pfdr_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "iommu_map(pfdr) failed %d\n", ret);
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index dfb62f9815e9..bce56da2b01f 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -297,7 +297,7 @@ static int qman_portal_probe(struct platform_device *pdev)
>                  */
>                 err = iommu_map(domain,
>                                 addr_phys[0]->start, addr_phys[0]->start,
> -                               resource_size(addr_phys[0]),
> +                               PAGE_ALIGN(resource_size(addr_phys[0])),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (err)
>                         dev_warn(dev, "failed to iommu_map() %d\n", err);
> --
> 2.17.1
>
