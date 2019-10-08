Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E7BC47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1FD20835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfJHDKy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 23:10:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41452 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbfJHDKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 23:10:53 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1iHftk-0004pD-1V
        for linux-kernel@vger.kernel.org; Tue, 08 Oct 2019 03:10:52 +0000
Received: by mail-wm1-f70.google.com with SMTP id z205so715538wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 20:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PcQE/Ilpx4wUgVDFDSmrOJyPXD+8IDPDe8f7G2pEYPY=;
        b=gg+YfcFGZYcLUr9SNViquCM3foFKZuuDsjyw+GCs8tqJV8KuxiGB0R+VLDZtNrqxJZ
         xIwSoNxLZohIZQsc8TovOSruXtDnZxl9Yk5capaW4moZu/6FQHnGjye/rD43IMIL0Q2e
         v1b8OI1ZUSCd9ZagmIlp4xXRX5fricKnaIWE/3oetn1vG2Bm96m/dkRF+EsGcz2yPON7
         LdbdMrVcC4wXxl/FAcuT3nlYXNDCmpye4ZonGLQJXnlMKh2Auh7aUXzG3TSroYsSB01m
         gLGJBfAUbDuttVGqdCXKojq/CbvZS50r4u3QoibyWeC6aZ6qbfMnHK1S9z5HDbKd3h3q
         Of3Q==
X-Gm-Message-State: APjAAAXrrPtmYJpA1uQoZSgf1fVW3LdiW2bRs9KWIQjgjP14XCHJZ5mz
        LZ3Hvir895v7SCmPfRveEkGn5cJBvjT+AbKs0OUnwYTUGq//y9YegZXV3Tl9Tel7DpwiGMgBuWv
        fNzK3IHVGz/vn59tFoJKkPyGNZuPagAT1jEWRS4tDXkAE4OUIh2xvBoBXrQ==
X-Received: by 2002:adf:e387:: with SMTP id e7mr12803434wrm.306.1570504251192;
        Mon, 07 Oct 2019 20:10:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBrHtTIIlDToIUIbq7+MsGB/KzIpYQHFIGjbFAr1e35SIsPjII6WCSb2+0AQzhPRI8KeusJIdT5gb/pC5YhUo=
X-Received: by 2002:adf:e387:: with SMTP id e7mr12803415wrm.306.1570504250806;
 Mon, 07 Oct 2019 20:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191007184231.13256-1-ztuowen@gmail.com>
In-Reply-To: <20191007184231.13256-1-ztuowen@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Tue, 8 Oct 2019 11:10:39 +0800
Message-ID: <CAFv23Qmt7BFJgE+=kJFbnJwYDtVrsX56cN6QtZbs=pRwKjbK0Q@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Confirmed the patch works well on Dell XPS 7390 2-in-1 machine.

Tested-by: AceLan Kao <acelan.kao@canonical.com>

Tuowen Zhao <ztuowen@gmail.com> 於 2019年10月8日 週二 上午2:43寫道：
>
> Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> in MTRR. This will cause the system to hang during boot. If possible,
> this bug could be corrected with a firmware update.
>
> This patch adds devm_ioremap_uc as a new managed wrapper to ioremap_uc
> and with it overwrite the MTRR settings to force the use of strongly
> uncachable pages for intel-lpss.
>
> The BIOS bug is present on Dell XPS 13 7390 2-in-1:
>
> [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
>
> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0 (i915)
>   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> ---
> Changes from previous version:
>
>   * changed commit message
>
>  drivers/mfd/intel-lpss.c |  2 +-
>  include/linux/io.h       |  2 ++
>  lib/devres.c             | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index bfe4ff337581..b0f0781a6b9c 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -384,7 +384,7 @@ int intel_lpss_probe(struct device *dev,
>         if (!lpss)
>                 return -ENOMEM;
>
> -       lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
> +       lpss->priv = devm_ioremap_uc(dev, info->mem->start + LPSS_PRIV_OFFSET,
>                                   LPSS_PRIV_SIZE);
>         if (!lpss->priv)
>                 return -ENOMEM;
> diff --git a/include/linux/io.h b/include/linux/io.h
> index accac822336a..a59834bc0a11 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -64,6 +64,8 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
>
>  void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>                            resource_size_t size);
> +void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
> +                                  resource_size_t size);
>  void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>                                    resource_size_t size);
>  void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> diff --git a/lib/devres.c b/lib/devres.c
> index 6a0e9bd6524a..beb0a064b891 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -9,6 +9,7 @@
>  enum devm_ioremap_type {
>         DEVM_IOREMAP = 0,
>         DEVM_IOREMAP_NC,
> +       DEVM_IOREMAP_UC,
>         DEVM_IOREMAP_WC,
>  };
>
> @@ -39,6 +40,9 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
>         case DEVM_IOREMAP_NC:
>                 addr = ioremap_nocache(offset, size);
>                 break;
> +       case DEVM_IOREMAP_UC:
> +               addr = ioremap_uc(offset, size);
> +               break;
>         case DEVM_IOREMAP_WC:
>                 addr = ioremap_wc(offset, size);
>                 break;
> @@ -68,6 +72,21 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  }
>  EXPORT_SYMBOL(devm_ioremap);
>
> +/**
> + * devm_ioremap_uc - Managed ioremap_uc()
> + * @dev: Generic device to remap IO address for
> + * @offset: Resource address to map
> + * @size: Size of map
> + *
> + * Managed ioremap_uc().  Map is automatically unmapped on driver detach.
> + */
> +void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
> +                             resource_size_t size)
> +{
> +       return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_UC);
> +}
> +EXPORT_SYMBOL(devm_ioremap_uc);
> +
>  /**
>   * devm_ioremap_nocache - Managed ioremap_nocache()
>   * @dev: Generic device to remap IO address for
> --
> 2.23.0
>
