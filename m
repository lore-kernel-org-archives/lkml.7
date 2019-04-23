Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F324C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E94206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZyhprUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfDWPWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:22:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43356 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:22:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so7765041pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xomeS4jxB5sMnjBSQQzSc3iV4YUXP2cIxd6Nn379/so=;
        b=XZyhprUgvQtzIkAP6iWf7UjyiMu2yAajZsLD35XVpQTiYQkEfGldvNWIqO2LpKP6wU
         3BM24HIThnKgaTDGrqM/UPEOgZ/ddZrkN4C1EM4VUElE16fjD6ywYKNLtKGfEW3PafKn
         2xpmWaFcKDtxgEUNfXFl6IGTUGVCC8SAY0TqCIjxvuGvyF9QhcxrB/9sz4IFXHQUsI3D
         hoNHg7UjtX3VCVb1XhztpZEnBVxeKbkJg1WrHZvIXVeSYoOzj6Giev+eBJJAbZ45bMV+
         VitmwYnvjFMZNqxB3CnkOWv9tEHtlWcVQIy5oMNBDmj8RPKoBRYVS2YxJgrVWeynLzaS
         xtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xomeS4jxB5sMnjBSQQzSc3iV4YUXP2cIxd6Nn379/so=;
        b=qq0gX9TAfKnAug8oHEtejujH9iMDFBSFQYuLVueuDx4YAlcBy7ATcKww+P2FH/US0S
         sz/SqEkQNWRovt7dZF+ypKTkv4G2yDJIzHiwXj7bDX9+8pdVRp2OcW9AW1S6FYvmr1ur
         jSUYb69YIIVW1JvI553V+zP7IcaF322atihI37FFWgkduqWoX/JcpFNrMJXocda5SEu6
         Rm1eWT7mMnkFNbm3sS5QR6AnSO+oz8VyFYqpg4s57UPcb59HtTUlncXOKzfTGTljolue
         jV+RvH9ZEDK3a0MMRfjHZ4qnEm6BUw/ikWUc5Tq3MnLQwjGkN9no36WZVWBgQNyXrEHO
         c3sA==
X-Gm-Message-State: APjAAAUY5C+fPHCwUcsoQUMqWHWU1Yc0qjnr5KXXz5VGJHBJT1mgA2K2
        VYSYFG3pZzhMr4jry6didvBo9uKpZIggnclhs55c8KysRjs=
X-Google-Smtp-Source: APXvYqwwFlMxMqlO7nP4Vu9PP/3oOfNbhYb8Sakfqtu/UgNXAEThfoiQG2Bv08Wc/107VYxKQvoY7Lasx1+SkZS2uWY=
X-Received: by 2002:a62:b602:: with SMTP id j2mr27415829pff.68.1556032951482;
 Tue, 23 Apr 2019 08:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com>
In-Reply-To: <20190423142629.120717-1-venture@google.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 23 Apr 2019 08:22:20 -0700
Message-ID: <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
>
> Create a SoC folder for the ASPEED parts and place the misc drivers
> currently present into this folder.  These drivers are not generic part
> drivers, but rather only apply to the ASPEED SoCs.
>
> Signed-off-by: Patrick Venture <venture@google.com>

Accidentally lost the Acked-by when re-sending this patchset as I
didn't see it on v1 before re-sending v2 to the larger audience.

> ---
> v2:
>  Added configuration option for ASPEED to soc/Makefile
> ---
>  drivers/misc/Kconfig                          | 16 ----------------
>  drivers/misc/Makefile                         |  2 --
>  drivers/soc/Kconfig                           |  1 +
>  drivers/soc/Makefile                          |  1 +
>  drivers/soc/aspeed/Kconfig                    | 19 +++++++++++++++++++
>  drivers/soc/aspeed/Makefile                   |  2 ++
>  .../{misc => soc/aspeed}/aspeed-lpc-ctrl.c    |  0
>  .../{misc => soc/aspeed}/aspeed-lpc-snoop.c   |  0
>  8 files changed, 23 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/soc/aspeed/Kconfig
>  create mode 100644 drivers/soc/aspeed/Makefile
>  rename drivers/{misc => soc/aspeed}/aspeed-lpc-ctrl.c (100%)
>  rename drivers/{misc => soc/aspeed}/aspeed-lpc-snoop.c (100%)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 42ab8ec92a04..b80cb6af0cb4 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -496,22 +496,6 @@ config VEXPRESS_SYSCFG
>           bus. System Configuration interface is one of the possible means
>           of generating transactions on this bus.
>
> -config ASPEED_LPC_CTRL
> -       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> -       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> -       ---help---
> -         Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
> -         ioctl()s, the driver also provides a read/write interface to a BMC ram
> -         region where the host LPC read/write region can be buffered.
> -
> -config ASPEED_LPC_SNOOP
> -       tristate "Aspeed ast2500 HOST LPC snoop support"
> -       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> -       help
> -         Provides a driver to control the LPC snoop interface which
> -         allows the BMC to listen on and save the data written by
> -         the host to an arbitrary LPC I/O port.
> -
>  config PCI_ENDPOINT_TEST
>         depends on PCI
>         select CRC32
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index d5b7d3404dc7..b9affcdaa3d6 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -54,8 +54,6 @@ obj-$(CONFIG_GENWQE)          += genwqe/
>  obj-$(CONFIG_ECHO)             += echo/
>  obj-$(CONFIG_VEXPRESS_SYSCFG)  += vexpress-syscfg.o
>  obj-$(CONFIG_CXL_BASE)         += cxl/
> -obj-$(CONFIG_ASPEED_LPC_CTRL)  += aspeed-lpc-ctrl.o
> -obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)             += ocxl/
>  obj-y                          += cardreader/
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index c07b4a85253f..b750a88547c7 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
>
>  source "drivers/soc/actions/Kconfig"
>  source "drivers/soc/amlogic/Kconfig"
> +source "drivers/soc/aspeed/Kconfig"
>  source "drivers/soc/atmel/Kconfig"
>  source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 90b686e586c6..814128fe479f 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -4,6 +4,7 @@
>  #
>
>  obj-$(CONFIG_ARCH_ACTIONS)     += actions/
> +obj-$(CONFIG_ARCH_ASPEED)      += aspeed/
>  obj-$(CONFIG_ARCH_AT91)                += atmel/
>  obj-y                          += bcm/
>  obj-$(CONFIG_ARCH_DOVE)                += dove/
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> new file mode 100644
> index 000000000000..457282cd1da5
> --- /dev/null
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -0,0 +1,19 @@
> +menu "Aspeed SoC drivers"
> +
> +config ASPEED_LPC_CTRL
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> +       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> +       ---help---
> +         Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
> +         ioctl()s, the driver also provides a read/write interface to a BMC ram
> +         region where the host LPC read/write region can be buffered.
> +
> +config ASPEED_LPC_SNOOP
> +       tristate "Aspeed ast2500 HOST LPC snoop support"
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> +       help
> +         Provides a driver to control the LPC snoop interface which
> +         allows the BMC to listen on and save the data written by
> +         the host to an arbitrary LPC I/O port.
> +
> +
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> new file mode 100644
> index 000000000000..cfaa9adc67b5
> --- /dev/null
> +++ b/drivers/soc/aspeed/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_ASPEED_LPC_CTRL)  += aspeed-lpc-ctrl.o
> +obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> similarity index 100%
> rename from drivers/misc/aspeed-lpc-ctrl.c
> rename to drivers/soc/aspeed/aspeed-lpc-ctrl.c
> diff --git a/drivers/misc/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> similarity index 100%
> rename from drivers/misc/aspeed-lpc-snoop.c
> rename to drivers/soc/aspeed/aspeed-lpc-snoop.c
> --
> 2.21.0.593.g511ec345e18-goog
>
