Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F44FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DCC2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562176235;
	bh=UYmA/xT4ezWnn7ewUd7Eak4QYGhMlv9i0miWbo+Nfo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H/zMAM/bzMfw90gpOTpEDrLMNN7jjfUfSis7R4KpH34wxZd8dPjFL25X3GcGRPcmt
	 M+HTXgPY6fzSMR7+SeCEOPnVhwikkPbG4PgsAJWCzZRWNO2/oram7Ew7ig56S/t71g
	 ygCyhv9idMjCqJzwCO+3PUtgbiKiPHhYIaVF2v9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGCRud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCRud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:50:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFD921881;
        Wed,  3 Jul 2019 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562176232;
        bh=UYmA/xT4ezWnn7ewUd7Eak4QYGhMlv9i0miWbo+Nfo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjtAt9nCYFGimdGv7fcAe1hWuX+iiD5AEuZrwOzJzloozpO6r2YGSJp19bDqH0sU/
         j3a03fyANCdR8XlmfF10rI+mwSxpIK/N/EsuKqdsx9Ddfk2HGnfrurge+iqo18qWKt
         NrSEfDULUkFF7LgMA7xB0UJdohsPVt3cKcw2y7Q4=
Date:   Wed, 3 Jul 2019 19:50:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch v3 2/5] build configuration for AST2500 DMA UART driver
Message-ID: <20190703175029.GB12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
 <1561459476-14268-3-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561459476-14268-3-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 04:14:33PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> build config for DMA based UART driver in AST2500.
> Total Available  UARTs in AST2500 are 4
> 
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
> ---
> 
> Changes in v3:
> - change logs added
> 
> drivers/tty/serial/8250/Kconfig  | 35 +++++++++++++++++++++++++++++++-
>  drivers/tty/serial/8250/Makefile |  1 +
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 15c2c5463835..c793466a1c47 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -45,7 +45,7 @@ config SERIAL_8250_DEPRECATED_OPTIONS
>  	  keep the 8250_core.* options around until they revert the changes
>  	  they already did.
>  
> -	  If 8250 is built as a module, this adds 8250_core alias instead. 
> +	  If 8250 is built as a module, this adds 8250_core alias instead.
>  
>  	  If you did not notice yet and/or you have userspace from pre-3.7, it
>  	  is safe (and recommended) to say N here.

Why did you change this line?

> @@ -189,6 +189,39 @@ config SERIAL_8250_RUNTIME_UARTS
>  	  with the module parameter "nr_uarts", or boot-time parameter
>  	  8250.nr_uarts
>  
> +config  AST_SERIAL_DMA_UART
> +        tristate "AST UART driver with DMA"
> +        select SERIAL_CORE
> +        help
> +          UART driver with DMA support for Aspeed BMC AST25XX.
> +          this driver supports UARTs in AST2500,AST2600. It uses
> +          DMA channel of DMA engines present in these chips.
> +          since this dma engine is used only by UARTs it is not
> +          added as a separate DMA driver instead added as a layer
> +          within UART driver.
> +
> +
> +config AST_NR_DMA_UARTS
> +        int "Maximum number of uart dma serial ports"
> +        depends on AST_SERIAL_DMA_UART
> +        default "4"
> +        help
> +          Set this to the number of serial ports you want the driver
> +          to support.  This includes any ports discovered via ACPI or
> +          PCI enumeration and any ports that may be added at run-time
> +          via hot-plug, or any ISA multi-port serial cards.
> +
> +config AST_RUNTIME_DMA_UARTS
> +        int "Number of uart dma serial ports to register at runtime"
> +        depends on AST_SERIAL_DMA_UART
> +        range 0 AST_NR_DMA_UARTS
> +        default "4"
> +        help
> +          Set this to the maximum number of serial ports you want
> +          the kernel to register at boot time.  This can be overridden
> +          with the module parameter "nr_uarts", or boot-time parameter
> +          8250.nr_uarts

That boot paramter is not correct, right?

Are you sure these all work like you think they work?

thanks,

greg k-h
