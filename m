Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64915CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E4F20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572885837;
	bh=ua5TnJiV9UElAM1ICyBSiRDTY3JpDWVR/RLyCZEi54I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wp1HD7kvhZaQppB+4DoeLVPblUGbe5Vbk+UyfcIOw1zqjoB2JJBUJuEBKQoKAwAiQ
	 O/jx80wDnfvNYOSKMjLBCSYfWyLIx4ynWhy7QeLO8WGZPZPvlMfjENK4Vp1tpnIq99
	 +MirMSNxD9apDiqcb7HtlqhtM3EesjRG2MvAdrYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfKDQn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:43:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfKDQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:43:56 -0500
Received: from localhost (host6-102.lan-isdn.imaginet.fr [195.68.6.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6698B20869;
        Mon,  4 Nov 2019 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572885834;
        bh=ua5TnJiV9UElAM1ICyBSiRDTY3JpDWVR/RLyCZEi54I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+9W5IlKUo5yoCZC2nYPNXOh2dPCwe1uffgh/kNyuEHQT0fzQH7c8QtiuBwxbjN9T
         Fy9Gh0aZ3xdSmHGM403Jkd79HthBlyWsEtGXa2h/tjn1hmVo4E8T8rVc+kX8TIgEA3
         qYFs2ZbThXaunfxLbVuC/Fotk1XFdggWV2Rhrm4M=
Date:   Mon, 4 Nov 2019 17:43:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung: rename to fix build warning
Message-ID: <20191104164351.GA2269025@kroah.com>
References: <20191018194707.27188-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018194707.27188-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 08:47:07PM +0100, Sudip Mukherjee wrote:
> The build of arm allmodconfig gives a warning:
> 
> warning: same module names found:
>   drivers/tty/serial/samsung.ko
>   drivers/mtd/nand/onenand/samsung.ko
> 
> Rename drivers/tty/serial/samsung.c to drivers/tty/serial/samsung_tty.c
> to fix the warning.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/tty/serial/Makefile                     | 2 +-
>  drivers/tty/serial/{samsung.c => samsung_tty.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)
> 
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 863f47056539..d056ee6cca33 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
>  obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
>  obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
>  obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
> -obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
> +obj-$(CONFIG_SERIAL_SAMSUNG) += samsung_tty.o
>  obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
>  obj-$(CONFIG_SERIAL_MAX310X) += max310x.o
>  obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung_tty.c
> similarity index 100%
> rename from drivers/tty/serial/samsung.c
> rename to drivers/tty/serial/samsung_tty.c
> -- 
> 2.11.0
> 


What are you going to break if you rename this module?

What configs enable both of these other than allmodconfig?  Why rename
the tty driver and not the mtd driver?  Why not both?

thanks,

greg k-h
