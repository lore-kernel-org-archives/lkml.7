Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF47C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A5B206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfDAWMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:12:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35882 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDAWMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:12:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so8080514oia.3;
        Mon, 01 Apr 2019 15:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuVGX2jjm0nWqvcUdPFL6/Kf5uXYGMPModplisJCpd0=;
        b=m4rvNkOVD6sfGZQIsgoS0bcHwDHP2T3fVpkBH2CSDDRkfUldM3EnzUYrOahMCFkd+o
         tbVTTK4T16667aDXQjvMdSUCvNxanvLv7L/GetHGj3ltNhKdMi0uJnDW71lrO7MKzcdW
         +aqy/Bkgm2R2wNpYbBm0HMQYEdh1QIXom+OzBQ7O/6z3AwLUH4CyzF6P2FWjEAzzdywC
         AcDziSOdBIzjv+7ExhjuyLgSNWX93t9ve/WNxjOMeYDbMwEqg22SfQS4XLUHFbS1zMfp
         5WN6wjfkER+z/rDwWX28nAZkATKFbmV5MwyTtuXhi9JVTjOzoLEk50ITyY5FcfUVwymY
         XegA==
X-Gm-Message-State: APjAAAWkBLM+klFYa7DvBvAt2np5iO1iLoRP4OFLnPJLWnJoZnNe6kFY
        y6YfFA+VbwHn8ldH/HCAL2RjE1aAivo=
X-Google-Smtp-Source: APXvYqzZFnttYZ8BrE0jQsvu/ZshoIUjO6W3EEDGgOkRcKXcseh8nciFJ9rYN/3s0GYv5CUojYjVbw==
X-Received: by 2002:aca:f44a:: with SMTP id s71mr8093104oih.151.1554156740182;
        Mon, 01 Apr 2019 15:12:20 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id h26sm3865958oih.22.2019.04.01.15.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 15:12:19 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id y84so8708151oia.12;
        Mon, 01 Apr 2019 15:12:19 -0700 (PDT)
X-Received: by 2002:aca:48d0:: with SMTP id v199mr4315301oia.51.1554156739290;
 Mon, 01 Apr 2019 15:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com> <20190329140014.8126-7-laurentiu.tudor@nxp.com>
In-Reply-To: <20190329140014.8126-7-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 1 Apr 2019 17:12:07 -0500
X-Gmail-Original-Message-ID: <CADRPPNT6=TOPfR9J3QtEaRPHx8cVOizWt1yneafghr46adNjBg@mail.gmail.com>
Message-ID: <CADRPPNT6=TOPfR9J3QtEaRPHx8cVOizWt1yneafghr46adNjBg@mail.gmail.com>
Subject: Re: [PATCH 06/13] soc/fsl/qbman_portals: add APIs to retrieve the
 probing status
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
> Add a couple of new APIs to check the probing status of the required
> cpu bound qman and bman portals:
>  'int bman_portals_probed()' and 'int qman_portals_probed()'.
> They return the following values.
>  *  1 if qman/bman portals were all probed correctly
>  *  0 if qman/bman portals were not yet probed
>  * -1 if probing of qman/bman portals failed
> Portals are considered successful probed if no error occurred during
> the probing of any of the portals and if enough portals were probed
> to have one available for each cpu.
> The error handling paths were slightly rearranged in order to fit this
> new functionality without being too intrusive.
> Drivers that use qman/bman portal driver services are required to use
> these APIs before calling any functions exported by these drivers or
> otherwise they will crash the kernel.
> First user will be the dpaa1 ethernet driver, coming in a subsequent
> patch.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_portal.c | 22 ++++++++++++++++++----
>  drivers/soc/fsl/qbman/qman_portal.c | 23 +++++++++++++++++++----
>  include/soc/fsl/bman.h              |  8 ++++++++
>  include/soc/fsl/qman.h              |  9 +++++++++
>  4 files changed, 54 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
> index 2c95cf59f3e7..7819bc29936d 100644
> --- a/drivers/soc/fsl/qbman/bman_portal.c
> +++ b/drivers/soc/fsl/qbman/bman_portal.c
> @@ -32,6 +32,7 @@
>
>  static struct bman_portal *affine_bportals[NR_CPUS];
>  static struct cpumask portal_cpus;
> +static int __bman_portals_probed;
>  /* protect bman global registers and global data shared among portals */
>  static DEFINE_SPINLOCK(bman_lock);
>
> @@ -87,6 +88,12 @@ static int bman_online_cpu(unsigned int cpu)
>         return 0;
>  }
>
> +int bman_portals_probed(void)
> +{
> +       return __bman_portals_probed;
> +}
> +EXPORT_SYMBOL_GPL(bman_portals_probed);
> +
>  static int bman_portal_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -104,8 +111,10 @@ static int bman_portal_probe(struct platform_device *pdev)
>         }
>
>         pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
> -       if (!pcfg)
> +       if (!pcfg) {
> +               __bman_portals_probed = -1;
>                 return -ENOMEM;
> +       }
>
>         pcfg->dev = dev;
>
> @@ -113,14 +122,14 @@ static int bman_portal_probe(struct platform_device *pdev)
>                                              DPAA_PORTAL_CE);
>         if (!addr_phys[0]) {
>                 dev_err(dev, "Can't get %pOF property 'reg::CE'\n", node);
> -               return -ENXIO;
> +               goto err_ioremap1;
>         }
>
>         addr_phys[1] = platform_get_resource(pdev, IORESOURCE_MEM,
>                                              DPAA_PORTAL_CI);
>         if (!addr_phys[1]) {
>                 dev_err(dev, "Can't get %pOF property 'reg::CI'\n", node);
> -               return -ENXIO;
> +               goto err_ioremap1;
>         }
>
>         pcfg->cpu = -1;
> @@ -128,7 +137,7 @@ static int bman_portal_probe(struct platform_device *pdev)
>         irq = platform_get_irq(pdev, 0);
>         if (irq <= 0) {
>                 dev_err(dev, "Can't get %pOF IRQ'\n", node);
> -               return -ENXIO;
> +               goto err_ioremap1;
>         }
>         pcfg->irq = irq;
>
> @@ -156,6 +165,9 @@ static int bman_portal_probe(struct platform_device *pdev)
>         }
>
>         cpumask_set_cpu(cpu, &portal_cpus);
> +       if (!__bman_portals_probed &&
> +           cpumask_weight(&portal_cpus) == num_online_cpus())
> +               __bman_portals_probed = 1;

Given the fact that the portal_cpus bit will get set even for offline
cpus, this is not correct either.  Probably the previous code for
checking cpu >= nr_cpu_ids is actually the right way to do it.

>         spin_unlock(&bman_lock);
>         pcfg->cpu = cpu;
>
> @@ -175,6 +187,8 @@ static int bman_portal_probe(struct platform_device *pdev)
>  err_ioremap2:
>         memunmap(pcfg->addr_virt_ce);
>  err_ioremap1:
> +        __bman_portals_probed = -1;
> +
>         return -ENXIO;
>  }
>
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index bce56da2b01f..11ba6c77c0d6 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -39,6 +39,7 @@ EXPORT_SYMBOL(qman_dma_portal);
>  #define CONFIG_FSL_DPA_PIRQ_FAST  1
>
>  static struct cpumask portal_cpus;
> +static int __qman_portals_probed;
>  /* protect qman global registers and global data shared among portals */
>  static DEFINE_SPINLOCK(qman_lock);
>
> @@ -221,6 +222,12 @@ static int qman_online_cpu(unsigned int cpu)
>         return 0;
>  }
>
> +int qman_portals_probed(void)
> +{
> +       return __qman_portals_probed;
> +}
> +EXPORT_SYMBOL_GPL(qman_portals_probed);
> +
>  static int qman_portal_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -240,8 +247,10 @@ static int qman_portal_probe(struct platform_device *pdev)
>         }
>
>         pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
> -       if (!pcfg)
> +       if (!pcfg) {
> +               __qman_portals_probed = -1;
>                 return -ENOMEM;
> +       }
>
>         pcfg->dev = dev;
>
> @@ -249,19 +258,20 @@ static int qman_portal_probe(struct platform_device *pdev)
>                                              DPAA_PORTAL_CE);
>         if (!addr_phys[0]) {
>                 dev_err(dev, "Can't get %pOF property 'reg::CE'\n", node);
> -               return -ENXIO;
> +               goto err_ioremap1;
>         }
>
>         addr_phys[1] = platform_get_resource(pdev, IORESOURCE_MEM,
>                                              DPAA_PORTAL_CI);
>         if (!addr_phys[1]) {
>                 dev_err(dev, "Can't get %pOF property 'reg::CI'\n", node);
> -               return -ENXIO;
> +               goto err_ioremap1;
>         }
>
>         err = of_property_read_u32(node, "cell-index", &val);
>         if (err) {
>                 dev_err(dev, "Can't get %pOF property 'cell-index'\n", node);
> +               __qman_portals_probed = -1;
>                 return err;
>         }
>         pcfg->channel = val;
> @@ -269,7 +279,7 @@ static int qman_portal_probe(struct platform_device *pdev)
>         irq = platform_get_irq(pdev, 0);
>         if (irq <= 0) {
>                 dev_err(dev, "Can't get %pOF IRQ\n", node);
> -               return -ENXIO;
> +               goto err_ioremap1;
>         }
>         pcfg->irq = irq;
>
> @@ -314,6 +324,9 @@ static int qman_portal_probe(struct platform_device *pdev)
>         }
>
>         cpumask_set_cpu(cpu, &portal_cpus);
> +       if (!__qman_portals_probed &&
> +           cpumask_weight(&portal_cpus) == num_online_cpus())
> +               __qman_portals_probed = 1;
>         spin_unlock(&qman_lock);
>         pcfg->cpu = cpu;
>
> @@ -338,6 +351,8 @@ static int qman_portal_probe(struct platform_device *pdev)
>  err_ioremap2:
>         memunmap(pcfg->addr_virt_ce);
>  err_ioremap1:
> +       __qman_portals_probed = -1;
> +
>         return -ENXIO;
>  }
>
> diff --git a/include/soc/fsl/bman.h b/include/soc/fsl/bman.h
> index 5b99cb2ea5ef..173e4049d963 100644
> --- a/include/soc/fsl/bman.h
> +++ b/include/soc/fsl/bman.h
> @@ -133,5 +133,13 @@ int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num);
>   * failed to probe or 0 if the bman driver did not probed yet.
>   */
>  int bman_is_probed(void);
> +/**
> + * bman_portals_probed - Check if all cpu bound bman portals are probed
> + *
> + * Returns 1 if all the required cpu bound bman portals successfully probed,
> + * -1 if probe errors appeared or 0 if the bman portals did not yet finished
> + * probing.
> + */
> +int bman_portals_probed(void);
>
>  #endif /* __FSL_BMAN_H */
> diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
> index 5cc7af06c1ba..aa31c05a103a 100644
> --- a/include/soc/fsl/qman.h
> +++ b/include/soc/fsl/qman.h
> @@ -1194,6 +1194,15 @@ int qman_release_cgrid(u32 id);
>   */
>  int qman_is_probed(void);
>
> +/**
> + * qman_portals_probed - Check if all cpu bound qman portals are probed
> + *
> + * Returns 1 if all the required cpu bound qman portals successfully probed,
> + * -1 if probe errors appeared or 0 if the qman portals did not yet finished
> + * probing.
> + */
> +int qman_portals_probed(void);
> +
>  /**
>   * qman_dqrr_get_ithresh - Get coalesce interrupt threshold
>   * @portal: portal to get the value for
> --
> 2.17.1
>
