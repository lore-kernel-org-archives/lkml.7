Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8B2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D3220651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWvIQ6U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfDOTdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:33:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41546 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfDOTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:33:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so23424246wrq.8;
        Mon, 15 Apr 2019 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ma5uDlcJg/vAc/B3lffKq0xAllAv/cjyeMuwGpJId8U=;
        b=MWvIQ6U+dwRQXBjdUoyeIhDPUeJLewF10K1omsHHKi1+xPKZzPN8kodzetTeAIse+3
         xM2vn31dTbUwQ0TJRIxYb0lbR3bbtT6qe0yS2IhUQk/+0BCHM66lS3Vq9k0MN4tJn19K
         Ot7m8Ph+DIpn7z4NX18fVCph/4IdtzJxAk8oAhD1n/27gfzSQjcJSEosGigevD3Ua8LN
         YPSBzismWkwkW3VJ2uBcpG4ImzU0lLL8N+8DcvcagjRrd3Cryyi7NRh5BpCDf+L4iVKi
         2Ij4wBMsDL0AG1kVBbJMJ7JdAVErVLnz4LsxmZZ/TZX+LOE/zi18H+9IF5s8rSGc7zJF
         7OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ma5uDlcJg/vAc/B3lffKq0xAllAv/cjyeMuwGpJId8U=;
        b=QprFPV+wDhNRverj/zFnNultXHpDrQ+585st17OP6aJ//TlCj6yy24aD0Sj9a3+uCv
         PSnT2OkZhBvI03lqB6gO2iWDQbwZNVQchhJJlrfAjs5Ora0lbBeY0fUL+5J32JJdKFMN
         1KuXI+2VkFoq5ZSibqFiCoRc+8PjIKpwg7MAED938dtQhNgw9MJuEj8SXwb0UYx9O5yw
         p/e7Siy1VoXFx9E6vovTDUMymHWZNTvIZ+YIy9iVCuY1K/mzCH5xrvycCVfp42k/YfX0
         w+QFjDet8kdqqLxohxs+51PRtoitpjK0arQwqoLgR5C66mOeJDHT2bjVwqeD9QUSnoZ+
         Krcg==
X-Gm-Message-State: APjAAAXfYd3VBXEYq040+1oIp5H4vSos6i/ZkK3Ae/7hA+11iLZSAkXJ
        adGnP/DYbkyXB82QCrpAofmHVWkzn/I=
X-Google-Smtp-Source: APXvYqxbGFhRp+F7YmjhEyLmQRTyubsCd7p1LGLgNlVTU3F0hGxx+wf6pJAl7TUMWnh+RLUutwZmHg==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr50263531wrp.268.1555356783158;
        Mon, 15 Apr 2019 12:33:03 -0700 (PDT)
Received: from [192.168.1.221] ([195.245.38.118])
        by smtp.gmail.com with ESMTPSA id j9sm56018749wrr.93.2019.04.15.12.33.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:33:02 -0700 (PDT)
Subject: Re: [PATCH 1/4] ARM: ep93xx: move network platform data to separate
 header
To:     Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Ahern <dsahern@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190415192734.935387-1-arnd@arndb.de>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <d6b40eb3-0f4f-efdc-44cd-bd09dfdf2927@gmail.com>
Date:   Mon, 15 Apr 2019 21:31:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190415192734.935387-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 15/04/2019 21:25, Arnd Bergmann wrote:
> The header file is the only thing preventing us from building the
> driver in a cross-platform configuration, so move the structure
> we are interested in to the global platform_data location
> and enable compile testing.

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ep93xx/include/mach/platform.h |  7 +------
>  drivers/net/ethernet/cirrus/Kconfig          |  2 +-
>  drivers/net/ethernet/cirrus/ep93xx_eth.c     |  2 +-
>  include/linux/platform_data/eth-ep93xx.h     | 10 ++++++++++
>  4 files changed, 13 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/platform_data/eth-ep93xx.h
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
> index 6c41c794bed5..43446f33c2be 100644
> --- a/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ b/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -5,6 +5,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/platform_data/eth-ep93xx.h>
>  #include <linux/reboot.h>
>  
>  struct device;
> @@ -15,12 +16,6 @@ struct ep93xxfb_mach_info;
>  struct ep93xx_keypad_platform_data;
>  struct ep93xx_spi_info;
>  
> -struct ep93xx_eth_data
> -{
> -	unsigned char	dev_addr[6];
> -	unsigned char	phy_id;
> -};
> -
>  void ep93xx_map_io(void);
>  void ep93xx_init_irq(void);
>  
> diff --git a/drivers/net/ethernet/cirrus/Kconfig b/drivers/net/ethernet/cirrus/Kconfig
> index e9a0213b08c4..6238e6951336 100644
> --- a/drivers/net/ethernet/cirrus/Kconfig
> +++ b/drivers/net/ethernet/cirrus/Kconfig
> @@ -41,7 +41,7 @@ config CS89x0_PLATFORM
>  
>  config EP93XX_ETH
>  	tristate "EP93xx Ethernet support"
> -	depends on ARM && ARCH_EP93XX
> +	depends on (ARM && ARCH_EP93XX) || COMPILE_TEST
>  	select MII
>  	help
>  	  This is a driver for the ethernet hardware included in EP93xx CPUs.
> diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> index 13dfdfca49fc..a6da9873570b 100644
> --- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
> +++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> @@ -25,7 +25,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  
> -#include <mach/hardware.h>
> +#include <linux/platform_data/eth-ep93xx.h>
>  
>  #define DRV_MODULE_NAME		"ep93xx-eth"
>  #define DRV_MODULE_VERSION	"0.1"
> diff --git a/include/linux/platform_data/eth-ep93xx.h b/include/linux/platform_data/eth-ep93xx.h
> new file mode 100644
> index 000000000000..8eef637a804d
> --- /dev/null
> +++ b/include/linux/platform_data/eth-ep93xx.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PLATFORM_DATA_ETH_EP93XX
> +#define _LINUX_PLATFORM_DATA_ETH_EP93XX
> +
> +struct ep93xx_eth_data {
> +	unsigned char	dev_addr[6];
> +	unsigned char	phy_id;
> +};
> +
> +#endif
> 
