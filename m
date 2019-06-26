Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3335CC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146472133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfFZH7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:59:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40418 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:59:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so911184pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CD4j+26j4vYI/MfiMmLCViJItM6FC7GHNSI9G/XS8i0=;
        b=J+cxGE3zBGabj5xBckDAE7eRLBsoIaR+3KVe8FyBtjiT8megEz2x/bEn1JmE4nwyVI
         aJdejm4cM7pFhcDUoEMEDPZ1Klmlpu15J71PmwX9WRXgu0z9ts6SD65tle6lzvP0WTea
         C2DWYZQYGnMb+YXTa2M1Rn49itM2QbRo6fLjRlohp8UaMHPh4AAktjUPH//nnA86mqZD
         WHDwoQRg2b90Al2GmX8INuR6dptrddtO1ub8B56HxODoZTXg+0TTZYfWUkKHX7ud7N7F
         1+1u5iRAKcAPpxHbAN24uBRSVlH8cpFye9Xf9Kar8zohUVE8u7K02kiGlMaWbWpqi57j
         GGvg==
X-Gm-Message-State: APjAAAXvseCvypf+oVUs8yIM9JsfcU3ieqWeEgfcNZMVkpJB9Nw/h8eS
        Ea0bGCRWcW9SKtSi0LT/etSt5DhHMEe/IuUf
X-Google-Smtp-Source: APXvYqwn8kngp/HSSbBwmxPoLWNRdCfA+H3iCix/JVQZEda0wHy33yb36kbHr9Scb1i6pm+ak+U1/Q==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr3129805pjq.41.1561535939224;
        Wed, 26 Jun 2019 00:58:59 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id r1sm20866207pfq.100.2019.06.26.00.58.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 00:58:58 -0700 (PDT)
Date:   Wed, 26 Jun 2019 00:58:58 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Jun 2019 00:33:23 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: defconfig: enable MMC & SPI for RISC-V
In-Reply-To: <20190625225636.9288-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        Olof Johansson <olof@lixom.net>, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-2f9be7ae-da01-4cf8-b3b9-8a7b193acd9b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 15:56:36 PDT (-0700), Atish Patra wrote:
> Currently, riscv upstream defconfig doesn't let you boot
> through userspace if rootfs is on the SD card.
>
> Let's enable MMC & SPI drivers as well so that one can boot
> to the user space using default config in upstream kernel.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/configs/defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4f02967e55de..04944fb4fa7a 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -69,6 +69,7 @@ CONFIG_VIRTIO_MMIO=y
>  CONFIG_CLK_SIFIVE=y
>  CONFIG_CLK_SIFIVE_FU540_PRCI=y
>  CONFIG_SIFIVE_PLIC=y
> +CONFIG_SPI_SIFIVE=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y
> @@ -84,4 +85,8 @@ CONFIG_ROOT_NFS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_SPI=y
> +CONFIG_MMC_SPI=y
> +CONFIG_MMC=y
> +CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_RCU_TRACE is not set

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
