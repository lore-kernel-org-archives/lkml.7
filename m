Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E25C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C26208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560079360;
	bh=ptu/UtjTcmnAD1z/pLhf3hslt2ujtQSdCDjEoDsQr5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NDkCk6iIWDDn0G3sz8W0T9wtQUqpq22/gP9bJsdxeo8Ln9izCZShwx8E6NxaIUTVy
	 QpzrsGhSmXj2xRK3aJ79qIQfyXtEHW7Exje3UH2AzT+jxulqzukco+Dc7RUr57P0+f
	 FXv6vstldfAksmB1QZUtciF7X2AtJ4UdJbGIO1SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfFILWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfFILWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:22:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C3320840;
        Sun,  9 Jun 2019 11:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560079357;
        bh=ptu/UtjTcmnAD1z/pLhf3hslt2ujtQSdCDjEoDsQr5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NN9O7/gFk1Lu0voj3XZWaNIG3tO9qAqauL2HIr3aJNZYG6sErjLPD/exbvN6lYQiX
         bt8ZJM7fS52FYas4GwKAJpD71NzE+zmcpfiTEfC0+ZIbIASkYXNArIk6qOawWrFGB0
         2y4LIYHF8XI3bqdCNw+Vn5/+T2UNaKu0jbs4HNs4=
Date:   Sun, 9 Jun 2019 13:22:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V5 02/11] misc: xilinx-sdfec: add core driver
Message-ID: <20190609112235.GA16574@kroah.com>
References: <1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com>
 <1560038656-380620-3-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560038656-380620-3-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 01:04:07AM +0100, Dragan Cvetic wrote:
> Implement a platform driver that matches with xlnx,
> sd-fec-1.1 device tree node and registers as a character
> device, including:
> - SD-FEC driver binds to sdfec DT node.
> - creates and initialise an initial driver dev structure.
> - add the driver in Linux build and Kconfig.
> 
> Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> ---
>  drivers/misc/Kconfig        |  12 +++++
>  drivers/misc/Makefile       |   1 +
>  drivers/misc/xilinx_sdfec.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 drivers/misc/xilinx_sdfec.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 6b0417b..319a6bf 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -471,6 +471,18 @@ config PCI_ENDPOINT_TEST
>             Enable this configuration option to enable the host side test driver
>             for PCI Endpoint.
>  
> +config XILINX_SDFEC
> +	tristate "Xilinx SDFEC 16"
> +	help
> +	  This option enables support for the Xilinx SDFEC (Soft Decision
> +	  Forward Error Correction) driver. This enables a char driver
> +	  for the SDFEC.
> +
> +	  You may select this driver if your design instantiates the
> +	  SDFEC(16nm) hardened block. To compile this as a module choose M.
> +
> +	  If unsure, say N.
> +
>  config MISC_RTSX
>  	tristate
>  	default MISC_RTSX_PCI || MISC_RTSX_USB
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index b9affcd..0cb3546 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-y				+= cardreader/
>  obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
> +obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> new file mode 100644
> index 0000000..75cc980
> --- /dev/null
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx SDFEC
> + *
> + * Copyright (C) 2019 Xilinx, Inc.
> + *
> + * Description:
> + * This driver is developed for SDFEC16 (Soft Decision FEC 16nm)
> + * IP. It exposes a char device which supports file operations
> + * like  open(), close() and ioctl().
> + */
> +
> +#include <linux/miscdevice.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/poll.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +
> +static int xsdfec_ndevs;

You should use an idr for this, not just a number you bump up and down.
This will not work properly at all.

Think about this situation:
	probe device 0
	xsdfec_ndevs = 1
	probe device 1
	xsdfec_ndevs = 2
	remove device 0
	xsdfec_ndevs = 0
	probe another device
	misc device fails due to duplicate name.

thanks,

greg k-h
