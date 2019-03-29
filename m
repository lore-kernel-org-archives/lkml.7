Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5513A2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfC2VQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:16:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46724 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfC2VQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:16:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id x188so2769870oia.13;
        Fri, 29 Mar 2019 14:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaV0olP+PRVr93TPoHK2LvE8ZTF6aplfAuvUXORDfRg=;
        b=t4QZRvJKN6YKQl7C156HzfSeD6MNXurvPT29eSVxvHylizKdhc/1q3nc7aIXrza5Me
         2GqXYgxowlgS4B5qbUva2f2TqPc54dhkHsg5CEgKnI+oujvLvzkpWw4UE2YpYWV6/OWn
         hpr/66VV4AdhA+P4SzXUg5vuc+Ti/vtPA4et9A96Qu0bsbzOAMHaXSNm951f/fWTcT1/
         CVxmU9ksnhk4VfyccEUWcdIjsBPXEwZZza+rx7UUc6JofiuOyDDGu2IgnvarU+tubgJz
         ka+AZixsbuHUXG9tTkycOpGbpcQl/4F8MHmwmSqG4det5n+CSW5mp/a/o6x7MSZobRGp
         /GDA==
X-Gm-Message-State: APjAAAV5zFqwcOUlqyTZuQa+/XcEN9NkXWAyhLmWCyJmpvEG9dL3iQ+H
        76dFg9agFl/hKfx5vneknKgZ1P8H0Y8=
X-Google-Smtp-Source: APXvYqzjnFM+ymLtSbRZ5IAChptmJlP2bA56DiGle8aA0QWPGqXGnKsC6nJn1Xg+Xm6ttQIgF9pkgg==
X-Received: by 2002:aca:ad8e:: with SMTP id w136mr4955377oie.109.1553894192646;
        Fri, 29 Mar 2019 14:16:32 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id k3sm1163403oic.11.2019.03.29.14.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 14:16:31 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 103so3302532otd.9;
        Fri, 29 Mar 2019 14:16:31 -0700 (PDT)
X-Received: by 2002:a9d:30d1:: with SMTP id r17mr34948159otg.331.1553894191481;
 Fri, 29 Mar 2019 14:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com> <20190329140014.8126-3-laurentiu.tudor@nxp.com>
In-Reply-To: <20190329140014.8126-3-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 29 Mar 2019 16:16:20 -0500
X-Gmail-Original-Message-ID: <CADRPPNTPZ1xhYr_YKZvrXVJhVqhV9RNAu6ekVHDeOudXTZx3=g@mail.gmail.com>
Message-ID: <CADRPPNTPZ1xhYr_YKZvrXVJhVqhV9RNAu6ekVHDeOudXTZx3=g@mail.gmail.com>
Subject: Re: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
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

On Fri, Mar 29, 2019 at 9:03 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Add a one-to-one iommu mapping for bman private data memory (FBPR).
> This is required for BMAN to work without faults behind an iommu.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index 7c3cc968053c..b209c79511bb 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -29,6 +29,7 @@
>   */
>
>  #include "bman_priv.h"
> +#include <linux/iommu.h>
>
>  u16 bman_ip_rev;
>  EXPORT_SYMBOL(bman_ip_rev);
> @@ -178,6 +179,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>         int ret, err_irq;
>         struct device *dev = &pdev->dev;
>         struct device_node *node = dev->of_node;
> +       struct iommu_domain *domain;
>         struct resource *res;
>         u16 id, bm_pool_cnt;
>         u8 major, minor;
> @@ -225,6 +227,15 @@ static int fsl_bman_probe(struct platform_device *pdev)
>
>         dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
>
> +       /* Create an 1-to-1 iommu mapping for FBPR area */
> +       domain = iommu_get_domain_for_dev(dev);
> +       if (domain) {
> +               ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +                               IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> +               if (ret)
> +                       dev_warn(dev, "failed to iommu_map() %d\n", ret);
> +       }

Like Robin has pointed out, could you explain why the mapping in this
patch and other similar patches cannot be dealt with the dma APIs
automatically?  If the current bqman driver doesn't use the dma APIs
correctly, we need to fix that instead of doing the mapping
explicitly.

> +
>         bm_set_memory(fbpr_a, fbpr_sz);
>
>         err_irq = platform_get_irq(pdev, 0);
> --
> 2.17.1
>
