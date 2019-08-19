Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49411C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D72D2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rH337aQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHSEoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:44:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41192 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSEo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:44:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so7192347wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTdhTJlfOEvwMxtoOo8JgnOcQgqcJ7O6rfujPFqHNDs=;
        b=rH337aQk94SWC4IT60yJz1ozOzffxGCHpGpI+emUGND0A3/kgYnnSBEK6gpjmxFxXp
         iuYFCUFx5wyjY7wLk62+KIJavNt0eYH/GXtCHCjveXmnPvGiN5OixCTWxdfnqsgjxn9w
         2lcinCuOPQQySpK+QGLWFSuatxvnSJlh8MhxDp9csdOV9XsW7zqcSFXBjX6mPDhkIe34
         1AOQrEjGsSl39kOicGpeCeoVpbELRFY6k0FlA7xEmwKa0twcyyuxlKlJb13YTPAd4Tt8
         GgwlgGroYXUM9cgK5gMV1px5kHAahLOzoObnOfaO6DJ4LyQruK6G6kAZF/L72wkkS0wR
         TL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTdhTJlfOEvwMxtoOo8JgnOcQgqcJ7O6rfujPFqHNDs=;
        b=hvIbqwf90gheNB2JkHbjyA5dKprNW/ysXhz0ZU7Ji/ae7YrdxI+nvpUHRGa/1Dafk1
         o4mwJ3tMTMY7MsxcUtU8xtelO/mY6OvnjGS1nTjTsaLqHVACT2Zk7OZPI4qrOtUiOGTM
         yi7AcsZT3b0XBvRlzymuNKlTN+Wv8gaaamBoxaKz+qhBReCB1k0wMO1El6hapdy2pXd9
         o4ysG9jH13rd09ptd6RP6oKF7XLNYM+Dj5aGXMxQ8j5wjzOfeTmHgQuRDGornQAVYCbT
         xCWvzlqQ5wvTJI+NUzp76G0GWAnPCMO3Kv4H0lWJXU1xkSaKWusnHsgGV/winsNv+dXz
         UB/Q==
X-Gm-Message-State: APjAAAXFLkHp+QpafPH5McgSjEzeqjqSdhRHwGiy5HFSn9g7BrrAZtb/
        sNrOVHxuxdNjIrgC1jZEVPYVZeVAoJNE5BH3cCve9g==
X-Google-Smtp-Source: APXvYqwUQPkud8m3pn3JD+iQBOJ9pDvE11srZt37VrKVieKqD5k2pI6Be57Z3epvvVVDV/zbKoPQvn8POiUVFTV1Zn8=
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr16468225wrv.323.1566189866336;
 Sun, 18 Aug 2019 21:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190818082935.14869-1-hch@lst.de>
In-Reply-To: <20190818082935.14869-1-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 19 Aug 2019 10:14:14 +0530
Message-ID: <CAAhSdy18rh+3nSrpeMPoxmi_St4FUEy=48oPZmDnOndWUFegbg@mail.gmail.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 2:01 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The sifive_l2_cache.c is in no way related to RISC-V architecture
> memory management.  It is a little stub driver working around the fact
> that the EDAC maintainers prefer their drivers to be structured in a
> certain way that doesn't fit the SiFive SOCs.
>
> Move the file to drivers/soc and add a Kconfig option for it, as well
> as the whole drivers/soc boilerplate for CONFIG_SOC_SIFIVE.
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
>         bool "Sifive platform EDAC driver"
> -       depends on EDAC=y && RISCV
> +       depends on EDAC=y && SIFIVE_L2
>         help
>           Support for error detection and correction on the SiFive SoCs.
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
> @@ -20,6 +20,7 @@ obj-y                         += qcom/
>  obj-y                          += renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)    += rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)      += samsung/
> +obj-$(CONFIG_SOC_SIFIVE)       += sifive/
>  obj-y                          += sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>  obj-y                          += ti/
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
> +       tristate "Sifive L2 Cache controller"
> +       help
> +         Support for the L2 cache controller on SiFive platforms.
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
> +obj-$(CONFIG_SIFIVE_L2)        += sifive_l2_cache.o
> +
> diff --git a/arch/riscv/mm/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> similarity index 100%
> rename from arch/riscv/mm/sifive_l2_cache.c
> rename to drivers/soc/sifive/sifive_l2_cache.c
> --
> 2.20.1
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
