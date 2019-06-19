Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B9C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481B92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfFSHEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:04:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35865 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:04:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so5830939plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 00:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PbYeBHsXCZa7rfwxfeGbM1ofQD9jWLYTMyvYxIoxevc=;
        b=BnMNQePr/8yEyzHTBQAmJ9s0/gRcn3FC/O4ENXxegwR4Hoq/IPpgFltyRssxUN3f+q
         5pfs7dTr21XYO97AuXr6szopCMNvIdOWxY8xOb9ZTL57BSOhS0qyV8b8pKk1e9jejAq5
         9/4g0lUrBA/GCVZdbYs/fXw7Ckf/FwLLPEd9HD0UUhT3nL8LI5x/5S8WIauzXF2Aqffy
         j/Nn+4ejyWgGO4uHlf2DFeWY10euHCUgj43Z8xTgI9JJtQgxeWZl6KpBaaIcYsr+LJxH
         RDB/rHKxpufd/OoMDAUC5gDxXvd9Ih8ZXuQolpJCcii6ZroOH1EpDI4DMcvtiR2NQAUI
         j83w==
X-Gm-Message-State: APjAAAUdtMq36aU7aCQwolL2qQbaY0mRvaO0mf7K9IbvpAA6iwpHp9hB
        Vgzzgg4ewPez8UiJANCsrxODAmUsMnwYAnsC
X-Google-Smtp-Source: APXvYqy+pIFCp1pdmlOYEhY+tkWW1f8ElGIIEfuWVp0uAyCklawr9uR1wjJDEfCeh8fUXLizyuYroA==
X-Received: by 2002:a17:902:848b:: with SMTP id c11mr95273759plo.217.1560927853629;
        Wed, 19 Jun 2019 00:04:13 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id 125sm16255713pfg.99.2019.06.19.00.04.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 00:04:12 -0700 (PDT)
Date:   Wed, 19 Jun 2019 00:04:12 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 00:02:47 PDT (-0700)
Subject:     Re: [PATCH 1/3] arch: riscv: add config option for building SiFive's SoC resource
In-Reply-To: <1560799790-20287-2-git-send-email-lollivier@baylibre.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, lollivier@baylibre.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     lollivier@baylibre.com
Message-ID: <mhng-57108556-f1ec-4ff8-a6a0-98ddfee8232a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 12:29:48 PDT (-0700), lollivier@baylibre.com wrote:
> Create a config option for building SiFive SoC specific resources
> e.g. SiFive device tree, platform drivers...
>
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/Kconfig                  | 2 ++
>  arch/riscv/Kconfig.socs             | 8 ++++++++
>  arch/riscv/boot/dts/sifive/Makefile | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/Kconfig.socs
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ee32c66e1af3..eace5857c9e9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -94,6 +94,8 @@ config PGTABLE_LEVELS
>  	default 3 if 64BIT
>  	default 2
>
> +source "arch/riscv/Kconfig.socs"
> +
>  menu "Platform type"
>
>  choice
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> new file mode 100644
> index 000000000000..60dae1b5f276
> --- /dev/null
> +++ b/arch/riscv/Kconfig.socs
> @@ -0,0 +1,8 @@
> +menu "SoC selection"
> +
> +config SOC_SIFIVE
> +       bool "SiFive SoCs"
> +       help
> +         This enables support for SiFive SoC platform hardware.
> +
> +endmenu
> diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
> index baaeef9efdcb..6d6189e6e4af 100644
> --- a/arch/riscv/boot/dts/sifive/Makefile
> +++ b/arch/riscv/boot/dts/sifive/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-y += hifive-unleashed-a00.dtb
> +dtb-$(CONFIG_SOC_SIFIVE) += hifive-unleashed-a00.dtb

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
