Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E50C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B292085A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="QxWCrGsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390225AbfGRLkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:40:37 -0400
Received: from chill.innovation.ch ([216.218.245.220]:59668 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:40:37 -0400
Date:   Thu, 18 Jul 2019 04:40:36 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 9CF5C640133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1563450036;
        bh=/Gd8UQZ1mrsbeFBwUzjuWBFXOklRWeccLWlERV4HCYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxWCrGsREfcpGjSPjb6uZmuVfvnYglXNoI1h6LgYGvF6xZucl7XZdI+nQgBlwDJDG
         TN2qGDXqYc9tIvRAcesBm2273zbWB7oeoA/z/UbSUti7j7YPSWzcFdFNEatm2ks1PC
         R248Lzr6LEJlKe+aLHz4KV2XBsAPH+w3l6mB7IAyaOEF8in/NOoL8QDkc+PUzM/bcN
         KecaUybx3wUzj1N+H1+SmluHtWrCaikhOTZuGS+lWzZTrhsV5uOLJWacMQygEeRBmj
         j4GdUI6HIWDLGwjpQovMNtdNAevRfI4sHmrBBEFh56p1SNAZ8RJgNeZ6gDTuyHM3ZB
         brM9HGDYtwn7A==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dmitry.torokhov@gmail.com, hsweeten@visionengravers.com,
        robh@kernel.org, arnd@arndb.de, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: applespi: Fix build error without CONFIG_PCI
Message-ID: <20190718114036.GA2872@innovation.ch>
References: <20190718020654.39860-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190718020654.39860-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jul 18, 2019 at 10:06:54AM +0800, YueHaibing wrote:
> If CONFIG_KEYBOARD_APPLESPI is set to y, but
> CONFIG_PCI is not set, building will fails:
> 
> drivers/spi/spi-pxa2xx-pci.c: In function pxa2xx_spi_pci_probe:
> drivers/spi/spi-pxa2xx-pci.c:208:8: error: implicit declaration of function pcim_enable_device;
>  did you mean pci_enable_device? [-Werror=implicit-function-declaration]
>   ret = pcim_enable_device(dev);
>         ^~~~~~~~~~~~~~~~~~
>         pci_enable_device
> drivers/spi/spi-pxa2xx-pci.c:239:8: error: implicit declaration of function pci_alloc_irq_vectors;
>  did you mean pci_alloc_consistent? [-Werror=implicit-function-declaration]
>   ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
>         ^~~~~~~~~~~~~~~~~~~~~
> 
> Make CONFIG_KEYBOARD_APPLESPI depends on CONFIG_PCI
> to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: b426ac045209 ("Input: add Apple SPI keyboard and trackpad driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index dd934c4..fefcc46 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -74,7 +74,7 @@ config ATARI_KBD_CORE
>  config KEYBOARD_APPLESPI
>  	tristate "Apple SPI keyboard and trackpad"
>  	depends on ACPI && EFI
> -	depends on SPI
> +	depends on SPI && PCI
>  	depends on X86 || COMPILE_TEST
>  	imply SPI_PXA2XX
>  	imply SPI_PXA2XX_PCI
> -- 
> 2.7.4

I think this is more properly fixed by Dmitry's suggestion of making
SPI_PXA2XX_PCI depend on PCI, since it's that module, not applespi,
that actually needs PCI - see
https://www.spinics.net/lists/linux-input/msg62351.html


  Cheers,

  Ronald

