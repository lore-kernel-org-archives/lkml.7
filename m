Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A56C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D713207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578382073;
	bh=P8hFPp3uFnhyZu1oBLEErxPKN0es1u5EN8j7fBkb+1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zlvIhMH/lWm5y/OGvyECZ49/tONR8DhgJ06S20zYCRJd1AZ8zKVqEC47uHbwtoKdR
	 HtP7smX8uwdFRMiYz1JJ/CGJEZAP6o20+H82MgYSj1tJL12sK7I3R7P+O81XLOU5KK
	 ZQGZPRTlAFqHT6mop70cssNzgjnoMWTW9TF9DRds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgAGH1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgAGH1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:27:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3B02075A;
        Tue,  7 Jan 2020 07:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578382071;
        bh=P8hFPp3uFnhyZu1oBLEErxPKN0es1u5EN8j7fBkb+1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v1dsSi51n4knQ1iqV/Uw3nGuiblGG3wE4PmUSVVxBOLzv9kys/wbELrAaBTUDiwFQ
         1DF2Pt0li7WvQAZubrHHDPKM+/TTA3HWN+KE7HGP3VJorxVc7eb/qTC4caaJvWUfm4
         t9bj9MnVwagZemwIh2+FIRjqXu7e9PYLNksf4WFg=
Date:   Tue, 7 Jan 2020 08:27:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Sistik <sistik@3ksolutions.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support
Message-ID: <20200107072748.GA1014453@kroah.com>
References: <20200106235203.27256-1-sistik@3ksolutions.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106235203.27256-1-sistik@3ksolutions.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:52:03AM +0100, Ivan Sistik wrote:
> AMBA PL011 do not have hardware support for RS485. This implementation is
> for drive enable signal (DE), which switch direction of RS485 driver chip.
> This signal si drived by RTS pin. Correct multiplexor settings have to be
> provided to Device Tree. Usually it is 'ctsrts', which is used for enabling
> of HW flow control, too.
> 
> DE signal is switched by starting transmition from serial core and data
> transfer is initiated by first hrtimer if there is delay before send
> enabled.
> 
> There is missing FIFO empty interrupt in PL011. It is replaced by second
> hrtimer which is started if there are no more data in port transmit buffer.
> Notice that port transmit buffer is not the same as HW TX FIFO. Time of
> this timmer is set to char send time and it is running until fifo is empty.
> This kind of implementation cause that there can be unwanted delay of one
> timer tick before DE signal is switched. This is used to prevent data loss
> during transmit. Second timer can start first if there is delay after send
> enabled.
> 
> Signed-off-by: Ivan Sistik <sistik@3ksolutions.sk>
> ---
>  arch/arm/configs/bcm2835_defconfig |   1 +
>  drivers/tty/serial/Kconfig         |  12 +
>  drivers/tty/serial/amba-pl011.c    | 470 ++++++++++++++++++++++++++++-
>  3 files changed, 480 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index e9bc88937b1e..514888681913 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -78,6 +78,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
>  CONFIG_SERIAL_8250_BCM2835AUX=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> +CONFIG_SERIAL_AMBA_PL011_SOFT_RS485=y
>  CONFIG_SERIAL_DEV_BUS=y
>  CONFIG_TTY_PRINTK=y
>  CONFIG_I2C_CHARDEV=y
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index df8bd0c7b97d..3cecd8a75691 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -73,6 +73,18 @@ config SERIAL_AMBA_PL011_CONSOLE
>  	  your boot loader (lilo or loadlin) about how to pass options to the
>  	  kernel at boot time.)
>  
> +config SERIAL_AMBA_PL011_SOFT_RS485
> +	bool "RS485 software direction switching for ARM AMBA PL011 serial"
> +	depends on SERIAL_AMBA_PL011=y

Why "=y" here?  Shouldn't this just read:
	depends on SERIAL_AMBA_PL011?

> +	select SERIAL_CORE

Is this needed?  SERIAL_AMBA_PL011 already selects this.

thanks,

greg k-h
