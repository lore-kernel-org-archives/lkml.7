Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA07C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA85220B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+JeUMB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfDVTYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:24:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37830 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfDVTYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:24:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so6293640pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VK8B17RR7V1hJEdyIGSrqnzZReXpqya147YlzwRheNk=;
        b=q+JeUMB4qHso3PcI3ozaKJOlliwUmy7+PHA5JtD9u8eR/rxkd5/ZqLXzCW6RE5vhR6
         iqZeDTxF0iv+P2h4q57MbqvpOVQdFBsQKxe6sM8DPYlbOb/IQM3cZlLpPuJbZtzgbIRW
         MA4cJWQh9b6jgfzTUJ9KGt6jFupUPxIwJf4W3m3N/mhyOOps4EajJ7qtQ+/fCRJeieIP
         bY4vMoyWTxAhP4tm4KBuDpkpTOns0QcV246Ub0U8m9yzkk3K18dsUBzaQuV0hP6RrcMy
         nSiH4zknh9ORjf0r2uvaIEilDECttPGriIxfvZfFe6/sd65f655nBhwmYY7X/z72S2Io
         BVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VK8B17RR7V1hJEdyIGSrqnzZReXpqya147YlzwRheNk=;
        b=noZBhhMSwc9bbuuZjfjMhvejefquyekzkgr2A650r/RLifvaaVRPGU2uXuNeheS7y0
         SHOFWYKFBx4mhWHi9es+z7gng5Q/W4uGs2bm5O2k+DXga2xQVRlIg/DbJyI72JTO1T6g
         gGbazuTZvCRRV5hi1K1Cb3jG0oOL+UTViS3Zu2GStXBs4Tpu+aR4B7qU/qo9f5Leg0G9
         cNLkl8ojKDhXrqucj4Br8b/d0yGQGjfhuNpC6FkLSZxQv38GJTIStZRvyykfT0RH/rid
         MB8M55O2Tj+aKasdXgHxFQyh1KNGVFbJMBKVDI5Z1MZUvjYk1jsS4iIBgvzboBvpSa5G
         chYQ==
X-Gm-Message-State: APjAAAXQhQ/Nv2zJbqAHB7R4D12YKo1PDf1gf/TW5hVdUStf57lbnTez
        Ideyok3K8hQh8cgW40y5T2IulaGSTmGKY0BICd+4dQ==
X-Google-Smtp-Source: APXvYqzjN1ByaJ2pODuusNeGtJ6XCC59doxDfOovUj4IGAYD7uMguGCE8zRI2k+7f4vbw88HNg7pXDurlvfYArWHD8o=
X-Received: by 2002:a65:654c:: with SMTP id a12mr20707782pgw.101.1555961079255;
 Mon, 22 Apr 2019 12:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190422175419.189895-1-venture@google.com>
In-Reply-To: <20190422175419.189895-1-venture@google.com>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 22 Apr 2019 12:24:28 -0700
Message-ID: <CAO=notxpGXLBPwsHAJdt8CwQMdNcCE=EeFymgxez_goaqnGoHQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:54 AM Patrick Venture <venture@google.com> wrote:
>
> Create a SoC folder for the ASPEED parts and place the misc drivers
> currently present into this folder.  These drivers are not generic part
> drivers, but rather only apply to the ASPEED SoCs.
>
> Signed-off-by: Patrick Venture <venture@google.com>
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

Fixed CC on this reply (Gmail button didn't behave as expected) and
replied to the v2 patchset instead of accidentally the first.

Given this patchset, I have several patches that move the drivers into
the folder, and thought about writing it up as a series.  I wanted to
see how this patchset would do before I staged the rest -- my question
is, should this patchset create the folder with the empty Kconfig and
Makefile, and then have follow-on patches that provide content to
split out the process into multiple logical steps?
