Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC0C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160A1207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YupL3jZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405006AbfIFW1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:27:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35532 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbfIFW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:27:47 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so15623492ion.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8UChFRti7FriSKfd749PLP6AnWejrsOvB1UAiDMJe3s=;
        b=YupL3jZr/TWgAojD2Ci7M0GvJ+WdRcFE8WDZnIFv/N6RgArGLyiY5qbGsdraqSuraE
         iWP8AtBHFnAGhl+d9fk3PrEQSwnEJNt7BxH5d/IH/ty5yXUttOKB0kUoHUNAlHGOHM5A
         BKl7Z9xaKLYVKf0oWs4Fi1LhyoqHwisD8upJ+TE0CNInnHWeaeqRWBkz996JdLrsTrjK
         Lb1uHuAOnPqgGGjP6EH0xCFZXzryDbi6UWLrc7Aydx3kPdr5KtqgIR+wRonLB1jbhNmN
         Wj3eFnVJ3sVfXKXHfuVPrhlOR7vK/YKTEJ5ZHT8xTHJcWaZviYwoXONTcr9QxXNrbriK
         XQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8UChFRti7FriSKfd749PLP6AnWejrsOvB1UAiDMJe3s=;
        b=dmF59PSsU85Gb1neI6b6BaUuQKnHekMvsfsm0jtRp9+mhb6LS4+DzsRjJ6pb5sB4sJ
         tqk0a6NqgPCeMMu45guUjMb/Cf/fbcxVlMk40dw5LpLFCYmbnNMcNsRsXQuj0HRiDI53
         QbN0+5iX5DAKvqvhQDdoUH3nVg16+Yv5fZAQHY3ZB349x9uc/gJB4OEfM/T+v4PYz+3K
         EN1ZckPM3kkClmyIS28Niu735uEvazAWqRVeEhDma18KWLSsiGfn4KCTAec/H6DdHQyC
         /9Al/ZOg4H4W8jbtU67uajtblgN+/CZE6W18TCqzNoYTOFL0GenhEEcmyzjb585rR3s6
         yT9w==
X-Gm-Message-State: APjAAAVAcxNCWjriBfKIb+Z783YPs9vb95p1QvfxLMgsm38FiuZwOlyI
        xDuXWUMELc0UAp0zy8jVBYAJCjEfQhU=
X-Google-Smtp-Source: APXvYqz6f3d1f7tO/KV0O5SAVfRLbfjlx9lkm8ZmPnAeOjQ8XT1oSirK57IB5SNTZ6UgHwq6dHAj1g==
X-Received: by 2002:a6b:c947:: with SMTP id z68mr14000572iof.132.1567808866295;
        Fri, 06 Sep 2019 15:27:46 -0700 (PDT)
Received: from localhost (75-161-11-128.albq.qwest.net. [75.161.11.128])
        by smtp.gmail.com with ESMTPSA id a22sm5346826iot.80.2019.09.06.15.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 15:27:45 -0700 (PDT)
Date:   Fri, 6 Sep 2019 15:27:44 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     palmer@sifive.com, bp@alien8.de, mchehab@kernel.org,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
In-Reply-To: <20190818082935.14869-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
References: <20190818082935.14869-1-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2019, Christoph Hellwig wrote:

> The sifive_l2_cache.c is in no way related to RISC-V architecture
> memory management.  It is a little stub driver working around the fact
> that the EDAC maintainers prefer their drivers to be structured in a
> certain way that doesn't fit the SiFive SOCs.
> 
> Move the file to drivers/soc and add a Kconfig option for it, as well
> as the whole drivers/soc boilerplate for CONFIG_SOC_SIFIVE.

The code in the patch looks OK to me.  However, two topics that need 
action:

- Since the patch doesn't fix any bugs, there shouldn't be a Fixes: line.  
Please let me know whether I can drop the line locally before I apply the 
patch, or whether you'd like to resend it.

- Since the patch touches drivers/edac/Kconfig, it needs to be acked by 
the EDAC maintainers.  I've added them to this message, but I need you to 
do the work of chasing down the ack, as is standard Linux practice.

If we can get those within the next few days, I'll add it to the queue for 
v5.4-rc1.

thanks -

- Paul

> 
> Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/mm/Makefile                                 |  1 -
>  drivers/edac/Kconfig                                   |  2 +-
>  drivers/soc/Kconfig                                    |  1 +
>  drivers/soc/Makefile                                   |  1 +
>  drivers/soc/sifive/Kconfig                             | 10 ++++++++++
>  drivers/soc/sifive/Makefile                            |  4 ++++
>  .../riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c  |  0
>  7 files changed, 17 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soc/sifive/Kconfig
>  create mode 100644 drivers/soc/sifive/Makefile
>  rename {arch/riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c (100%)
> 
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 74055e1d6f21..d2101d0741d4 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -11,6 +11,5 @@ obj-y += extable.o
>  obj-y += ioremap.o
>  obj-y += cacheflush.o
>  obj-y += context.o
> -obj-y += sifive_l2_cache.o
>  
>  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 200c04ce5b0e..9241b3e7a050 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
>  
>  config EDAC_SIFIVE
>  	bool "Sifive platform EDAC driver"
> -	depends on EDAC=y && RISCV
> +	depends on EDAC=y && SIFIVE_L2
>  	help
>  	  Support for error detection and correction on the SiFive SoCs.
>  
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 833e04a7835c..1778f8c62861 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -14,6 +14,7 @@ source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/renesas/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
>  source "drivers/soc/samsung/Kconfig"
> +source "drivers/soc/sifive/Kconfig"
>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/tegra/Kconfig"
>  source "drivers/soc/ti/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 2ec355003524..8b49d782a1ab 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -20,6 +20,7 @@ obj-y				+= qcom/
>  obj-y				+= renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
> +obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
>  obj-y				+= sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-y				+= ti/
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> new file mode 100644
> index 000000000000..9ffb2e8a48cd
> --- /dev/null
> +++ b/drivers/soc/sifive/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if SOC_SIFIVE
> +
> +config SIFIVE_L2
> +	tristate "Sifive L2 Cache controller"
> +	help
> +	  Support for the L2 cache controller on SiFive platforms.
> +
> +endif
> diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
> new file mode 100644
> index 000000000000..9b4a85558347
> --- /dev/null
> +++ b/drivers/soc/sifive/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_SIFIVE_L2)	+= sifive_l2_cache.o
> +
> diff --git a/arch/riscv/mm/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> similarity index 100%
> rename from arch/riscv/mm/sifive_l2_cache.c
> rename to drivers/soc/sifive/sifive_l2_cache.c
> -- 
> 2.20.1
> 
> 


