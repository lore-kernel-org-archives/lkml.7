Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78DDC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3AB207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575887591;
	bh=rCACM0xwmsamn2/ogrOxDEqjuEUvfndKQSTzrV51TpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ujYyCbQk7uSdBJuCPNpXnF1i27hng2ir3pTd4BNOxHjSNXJrdh2pejm+pQLhIa5Lh
	 cmUm4Gw/uYzvHQv28Xhyx3vEGQxWQQJvMVKuHleL7JEZkW5X3ZY8jzNLRlLpPSMKtO
	 mFPUtuZZKQ1HjSMEznGByKrps5qMZ2pV1Au1HRWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLIKdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfLIKdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:33:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A3E2077B;
        Mon,  9 Dec 2019 10:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575887587;
        bh=rCACM0xwmsamn2/ogrOxDEqjuEUvfndKQSTzrV51TpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zb1FlgRPodazQxTq7Qeqc7O7FYVn42gIW/dUQmdeOvM580iJuIhlmW+j+Fx4DIZX0
         PnWDYqWABu/ouzsR1WAdjvHhkZlBVcv2mMDFbwaNaMh5WFf+s73QMGGIJKjAnlVhyL
         M/wVkolqrlP0u0QTDkG4URqHTXmnl66fER8VCxuU=
Date:   Mon, 9 Dec 2019 11:33:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>,
        Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Subject: Re: [PATCH] uio: uio_xilinx_apm: Add Xilinx AXI performance monitor
 driver
Message-ID: <20191209103305.GB999605@kroah.com>
References: <1575886035-19422-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575886035-19422-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 03:37:15PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Added driver for Xilinx AXI performance monitor IP.
> 
> Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
> Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/uio/Kconfig          |  12 ++
>  drivers/uio/Makefile         |   1 +
>  drivers/uio/uio_xilinx_apm.c | 369 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 382 insertions(+)
>  create mode 100644 drivers/uio/uio_xilinx_apm.c
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81..de30312 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -165,4 +165,16 @@ config UIO_HV_GENERIC
>  	  to network and storage devices from userspace.
>  
>  	  If you compile this as a module, it will be called uio_hv_generic.
> +
> +config UIO_XILINX_APM
> +	tristate "Xilinx AXI Performance Monitor driver"
> +	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
> +	help
> +	  This driver is developed for AXI Performance Monitor IP, designed to
> +	  monitor AXI4 traffic for performance analysis of AXI bus in the
> +	  system. Driver maps HW registers and parameters to userspace.
> +
> +	  To compile this driver as a module, choose M here; the module
> +	  will be called uio_xilinx_apm.
> +
>  endif
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index c285dd2..b3464d8 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
>  obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
>  obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
>  obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
> +obj-$(CONFIG_UIO_XILINX_APM)	+= uio_xilinx_apm.o
> diff --git a/drivers/uio/uio_xilinx_apm.c b/drivers/uio/uio_xilinx_apm.c
> new file mode 100644
> index 0000000..90d70a5
> --- /dev/null
> +++ b/drivers/uio/uio_xilinx_apm.c
> @@ -0,0 +1,369 @@
> +/*
> + * Xilinx AXI Performance Monitor
> + *
> + * Copyright (C) 2013 Xilinx, Inc. All rights reserved.

You have not touched this since 2013???

> + *
> + * Description:
> + * This driver is developed for AXI Performance Monitor IP,
> + * designed to monitor AXI4 traffic for performance analysis
> + * of AXI bus in the system. Driver maps HW registers and parameters
> + * to userspace. Userspace need not clear the interrupt of IP since
> + * driver clears the interrupt.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

Did you run this through checkpatch?  Please do so and add the proper
spdx header and remove all of the license boiler-plate text.

thanks,

greg k-h
