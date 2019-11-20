Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19225C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E147B2251D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhKpg5kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfKTM73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:59:29 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42301 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfKTM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:59:29 -0500
Received: by mail-vs1-f67.google.com with SMTP id a143so16744238vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reg+u6Ufqx+Qb5fUs6duceGWbZdpC8NenI3jDOLXWTU=;
        b=xhKpg5khG5RW1qOITZitDBxS2C7DqgXhLEZOamHcFELNW2cznvACwrrGwDH1yH2WSH
         LeV2k5lGNLj7Kpns+1e9ww5QpDR+lFKkA1sZeb5TYJYfC8dzE+NLQtC16MxsFpGGzewB
         sW0334cYpG4Pzahd0U13q6bwESrC3ZUNOvmOmELvoSdNPLXN0ORCGjWwF1xVAdhpH0Kr
         77nmApFKBsmba/clzKDEPYNbsw7tBbsohYS6Q+S/Vg7pVi4ANSJaBU7YgPRb4hM1vyxB
         pt0wHleuPpOJdzwgbejQrjxV+PohjEVqbrNUXj8wBmgdSZ4CSMJiC3jnNkHMB4hQR74w
         CtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reg+u6Ufqx+Qb5fUs6duceGWbZdpC8NenI3jDOLXWTU=;
        b=OULuoFrJparUUZzgPlvSNcs+K/J2I9IQ1R934LjaUloxARl0Avi3z2QBTqayhDh6W5
         0CRlsWwcL2b6N5RIpZeAuVd1jd/vx9iJPCPQR7Qo5gWI/JJOQ21S6OVSJOukxedrrB0D
         nnJZ/kpSOEGJxsnHwuvQo0GZlxZumUU0h1K2/fHvmBnXcB7HqHf0UV827WlBA1OLBWmx
         DW1RWIKK978UUYli6uNfIAGZ2T+pnTv7lrICJwTN7n5M9LL7bgQUG5JrPHC6ltJCsva/
         Biha5+jXzB3rtwQYKAEeVBmM+1F3OFGLpbX6mrSyyTgeCLNsrBysEPImmddJIjmn5HKQ
         B8fA==
X-Gm-Message-State: APjAAAXWrv3kCs4XdD387CFiDZki7W+0+AuxsklPEaYCLgsYAEzgrgk9
        FVMi/QLHtN1VvXIU3gXXigQOg3nwLlmI8w4afoVUuw==
X-Google-Smtp-Source: APXvYqy77oJJ56tYlpAjUpMq/dboj1WH7TC8AycuG30Fw12lfMi99fDh1Wu7ROVl+IwOWBLiX0BXVKnkZK7+JNnk9Uc=
X-Received: by 2002:a67:5ec1:: with SMTP id s184mr1524979vsb.200.1574254766308;
 Wed, 20 Nov 2019 04:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20191118073609.22921-1-faiz_abbas@ti.com>
In-Reply-To: <20191118073609.22921-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 13:58:49 +0100
Message-ID: <CAPDyKFrBakP8anTp4Uebq9oEJHPF+=HEuJZ-ezLD-P83+RRsMw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add Support for Command Queuing
 Engine to J721E
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 at 08:35, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add Support for CQHCI (Command Queuing Host Controller Interface)
> for each of the host controllers present in TI's J721E devices.
> Add cqhci_ops and a .irq() callback to handle cqhci specific interrupts.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Applied for next, dropping the reported-by tag, thanks!

Kind regards
Uffe


> ---
>
> v2: Dropped CONFIG_ prefix from select MMC_CQHCI which led to build
> failures. Successfully built with the .config provided by the kbuild test robot.
>
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci_am654.c | 71 +++++++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..7c1310ed26c6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1011,6 +1011,7 @@ config MMC_SDHCI_AM654
>         tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
>         depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
>         select MMC_SDHCI_IO_ACCESSORS
> +       select MMC_CQHCI
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in TI's AM654 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index bb90757ecace..b8e897e31e2e 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -12,6 +12,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>
> +#include "cqhci.h"
>  #include "sdhci-pltfm.h"
>
>  /* CTL_CFG Registers */
> @@ -68,6 +69,9 @@
>
>  #define CLOCK_TOO_SLOW_HZ      400000
>
> +/* Command Queue Host Controller Interface Base address */
> +#define SDHCI_AM654_CQE_BASE_ADDR 0x200
> +
>  static struct regmap_config sdhci_am654_regmap_config = {
>         .reg_bits = 32,
>         .val_bits = 32,
> @@ -259,6 +263,19 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
>         .flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
>  };
>
> +static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +       int cmd_error = 0;
> +       int data_error = 0;
> +
> +       if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +               return intmask;
> +
> +       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +       return 0;
> +}
> +
>  static struct sdhci_ops sdhci_j721e_8bit_ops = {
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -267,6 +284,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
>         .set_power = sdhci_am654_set_power,
>         .set_clock = sdhci_am654_set_clock,
>         .write_b = sdhci_am654_write_b,
> +       .irq = sdhci_am654_cqhci_irq,
>         .reset = sdhci_reset,
>  };
>
> @@ -290,6 +308,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
>         .set_power = sdhci_am654_set_power,
>         .set_clock = sdhci_j721e_4bit_set_clock,
>         .write_b = sdhci_am654_write_b,
> +       .irq = sdhci_am654_cqhci_irq,
>         .reset = sdhci_reset,
>  };
>
> @@ -304,6 +323,40 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
>         .pdata = &sdhci_j721e_4bit_pdata,
>         .flags = IOMUX_PRESENT,
>  };
> +
> +static void sdhci_am654_dumpregs(struct mmc_host *mmc)
> +{
> +       sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static const struct cqhci_host_ops sdhci_am654_cqhci_ops = {
> +       .enable         = sdhci_cqe_enable,
> +       .disable        = sdhci_cqe_disable,
> +       .dumpregs       = sdhci_am654_dumpregs,
> +};
> +
> +static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
> +{
> +       struct cqhci_host *cq_host;
> +       int ret;
> +
> +       cq_host = devm_kzalloc(host->mmc->parent, sizeof(struct cqhci_host),
> +                              GFP_KERNEL);
> +       if (!cq_host)
> +               return -ENOMEM;
> +
> +       cq_host->mmio = host->ioaddr + SDHCI_AM654_CQE_BASE_ADDR;
> +       cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
> +       cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +       cq_host->ops = &sdhci_am654_cqhci_ops;
> +
> +       host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +       ret = cqhci_init(cq_host, host->mmc, 1);
> +
> +       return ret;
> +}
> +
>  static int sdhci_am654_init(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -344,7 +397,23 @@ static int sdhci_am654_init(struct sdhci_host *host)
>         regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
>                            ctl_cfg_2);
>
> -       return sdhci_add_host(host);
> +       ret = sdhci_setup_host(host);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdhci_am654_cqe_add_host(host);
> +       if (ret)
> +               goto err_cleanup_host;
> +
> +       ret = __sdhci_add_host(host);
> +       if (ret)
> +               goto err_cleanup_host;
> +
> +       return 0;
> +
> +err_cleanup_host:
> +       sdhci_cleanup_host(host);
> +       return ret;
>  }
>
>  static int sdhci_am654_get_of_property(struct platform_device *pdev,
> --
> 2.19.2
>
