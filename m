Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB917CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 21:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10762064A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 21:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQWqVR22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfJSVOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 17:14:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39147 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfJSVOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 17:14:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so9154808wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUTf/lOt6SS4SJtQXE4b6+Co3iYmTllN3b72HsB1Kl4=;
        b=gQWqVR22ihM1OPZAElhvcH/MAoFMeGOw713EL0oJ7abyZnihZfDR+bM1/4dBZwKQFr
         2jfU7xYuEbQCMNIduFcOhk2NFMuouznVoUNZ6wV+eYT0KwRAjhj8q/di1lvGuQ1YH96b
         fheaB23F5VgkQkpy2DZjhTYY+mj8Lc2MzQv6ZDq0MPsuwibot7xtbwq7JM2KAhtQFnp6
         o2Xy2hd1BV60NoMiK/6Gy2qA5wILBr/VQjRlrg7T7ewaJuzVkXBgCbJNtex4yDFZnTlB
         hxs0Cs8kAYS9sVcp/RhftzZRvcpJREk/ekMqsF9T4aMuhJsTYHEC2k30cJmC/IKqESZu
         nusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUTf/lOt6SS4SJtQXE4b6+Co3iYmTllN3b72HsB1Kl4=;
        b=QZ6glrJl3kU+Y0OFmd7np7JPawC9H7/Y+YREGq54WG5IMZgC/7bEKa1u6qe3RWfgI7
         QCROJVBx7vEFoaf25UtduvF8oPJaO8E9y6jo8cbK6APND0Oc1YeRlIWOD7W+K6aB5w+j
         DsuyhTbzH1T97ph6WdSOxENJHjoQGMWdH9SyTaXNm+2vZ6pcBn6ot39HdoOXf+zQCdcn
         rkndAsD5Za0gzQ7lhxfSvsvaW7wWZK9t/dLZRUDRlfr7TEteu+fZcC5aO34VwGLggOzP
         N7kQ0/XCIhEwY1LwDBZyF9f8ywgmHUuvYcHNetnT9SBd6w+sM1xo0e/zTbV+0r5hYAXU
         rEbw==
X-Gm-Message-State: APjAAAX6icKHLTQRgHgJY3UfnmIILX4oV71EKJ5RglQ/tiLvunCRupkF
        aUoDPm2Sx7pmMMrvKHWXczI=
X-Google-Smtp-Source: APXvYqxPwwVnYflF2Dls7DFWo16qVQv8tLeE1mI7nTEjmKMrF/znLWz2hPm10nQvrQQyfwnxldocGw==
X-Received: by 2002:a7b:cf28:: with SMTP id m8mr13164691wmg.63.1571519659895;
        Sat, 19 Oct 2019 14:14:19 -0700 (PDT)
Received: from giga-mm ([62.68.26.146])
        by smtp.gmail.com with ESMTPSA id t8sm9719092wrx.76.2019.10.19.14.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 14:14:19 -0700 (PDT)
Date:   Sat, 19 Oct 2019 23:14:18 +0200
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hubert Feurstein <hubert.feurstein@contec.at>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 2/6] ARM: ep93xx: enable SPARSE_IRQ
Message-Id: <20191019231418.c17b05f73276539536b4732c@gmail.com>
In-Reply-To: <CAK8P3a3UztT5aqDTiBNDssHWcdYQNqbhiY_hxJ+AHuM54hgCWQ@mail.gmail.com>
References: <20191018163047.1284736-1-arnd@arndb.de>
        <20191018163047.1284736-2-arnd@arndb.de>
        <20191019184234.4cdb37a735fe632528880d76@gmail.com>
        <CAK8P3a0LWeGJshr=AdeE3QXHYe2jVmc90K_2prc=4=ZFk0hr=g@mail.gmail.com>
        <20191019222413.52f7b79369d085c4ce29bc23@gmail.com>
        <CAK8P3a3UztT5aqDTiBNDssHWcdYQNqbhiY_hxJ+AHuM54hgCWQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, 19 Oct 2019 22:44:18 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> > > > # cat /proc/interrupts
> > > >            CPU0
> > > >  39:        146       VIC   7 Edge      eth0
> > > >  51:     162161       VIC  19 Edge      ep93xx timer
> > > >  52:        139       VIC  20 Edge      uart-pl010
> > > >  53:          4       VIC  21 Edge      ep93xx-spi
> > > >  60:          0       VIC  28 Edge      ep93xx-i2s
> > > > Err:          0
> > >
> > > I guess that is partial success: some irqs do work ;-)
> >
> > Yep, VIC1 is working, while VIC0 is not.
> >
> > > The two interrupts that did not get registered are for the
> > > dmaengine driver, and that makes sense given the error
> > > message about the DMA not working. No idea how
> > > that would be a result of the irq changes though.
> >
> > Seems, that it has exposed some incompatibilities of
> > starting IRQ 0 in EP93xx platform fir VIC0 and VIC code
> > itself, which assumes 0 means "auto assignment" (refer
> > to vic_init()).
> 
> Ah, that makes sense. so all interrupt numbers need to
> be shifted by a fixed number (e.g. 1) like we did for
> other platforms (see attachment).

Yes, the below patch resolved both GPIO and DMA issues.
Previous patch (selecting IRQ_DOMAIN_HIERARCHY) is not
required.

If you re-spin all 3 ep93xx-relevant patches together, you can put my
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
on them.

> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 6fb19a393fd2..f0a71d4e076f 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -47,6 +47,7 @@
>  #include <asm/mach/map.h>
>  
>  #include "soc.h"
> +#include "irqs.h"
>  
>  /*************************************************************************
>   * Static I/O mappings that are needed for all EP93xx platforms
> @@ -75,8 +76,8 @@ void __init ep93xx_map_io(void)
>   *************************************************************************/
>  void __init ep93xx_init_irq(void)
>  {
> -	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
> -	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK, 0);
> +	vic_init(EP93XX_VIC1_BASE, IRQ_EP93XX_VIC0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
> +	vic_init(EP93XX_VIC2_BASE, IRQ_EP93XX_VIC1, EP93XX_VIC2_VALID_IRQ_MASK, 0);
>  }
>  
>  
> diff --git a/arch/arm/mach-ep93xx/irqs.h b/arch/arm/mach-ep93xx/irqs.h
> index 3ffdb3a2f3e4..353201b90c66 100644
> --- a/arch/arm/mach-ep93xx/irqs.h
> +++ b/arch/arm/mach-ep93xx/irqs.h
> @@ -2,69 +2,73 @@
>  #ifndef __ASM_ARCH_IRQS_H
>  #define __ASM_ARCH_IRQS_H
>  
> -#define IRQ_EP93XX_COMMRX		2
> -#define IRQ_EP93XX_COMMTX		3
> -#define IRQ_EP93XX_TIMER1		4
> -#define IRQ_EP93XX_TIMER2		5
> -#define IRQ_EP93XX_AACINTR		6
> -#define IRQ_EP93XX_DMAM2P0		7
> -#define IRQ_EP93XX_DMAM2P1		8
> -#define IRQ_EP93XX_DMAM2P2		9
> -#define IRQ_EP93XX_DMAM2P3		10
> -#define IRQ_EP93XX_DMAM2P4		11
> -#define IRQ_EP93XX_DMAM2P5		12
> -#define IRQ_EP93XX_DMAM2P6		13
> -#define IRQ_EP93XX_DMAM2P7		14
> -#define IRQ_EP93XX_DMAM2P8		15
> -#define IRQ_EP93XX_DMAM2P9		16
> -#define IRQ_EP93XX_DMAM2M0		17
> -#define IRQ_EP93XX_DMAM2M1		18
> -#define IRQ_EP93XX_GPIO0MUX		19
> -#define IRQ_EP93XX_GPIO1MUX		20
> -#define IRQ_EP93XX_GPIO2MUX		21
> -#define IRQ_EP93XX_GPIO3MUX		22
> -#define IRQ_EP93XX_UART1RX		23
> -#define IRQ_EP93XX_UART1TX		24
> -#define IRQ_EP93XX_UART2RX		25
> -#define IRQ_EP93XX_UART2TX		26
> -#define IRQ_EP93XX_UART3RX		27
> -#define IRQ_EP93XX_UART3TX		28
> -#define IRQ_EP93XX_KEY			29
> -#define IRQ_EP93XX_TOUCH		30
> +#define IRQ_EP93XX_VIC0			1
> +
> +#define IRQ_EP93XX_COMMRX		(IRQ_EP93XX_VIC0 + 2)
> +#define IRQ_EP93XX_COMMTX		(IRQ_EP93XX_VIC0 + 3)
> +#define IRQ_EP93XX_TIMER1		(IRQ_EP93XX_VIC0 + 4)
> +#define IRQ_EP93XX_TIMER2		(IRQ_EP93XX_VIC0 + 5)
> +#define IRQ_EP93XX_AACINTR		(IRQ_EP93XX_VIC0 + 6)
> +#define IRQ_EP93XX_DMAM2P0		(IRQ_EP93XX_VIC0 + 7)
> +#define IRQ_EP93XX_DMAM2P1		(IRQ_EP93XX_VIC0 + 8)
> +#define IRQ_EP93XX_DMAM2P2		(IRQ_EP93XX_VIC0 + 9)
> +#define IRQ_EP93XX_DMAM2P3		(IRQ_EP93XX_VIC0 + 10)
> +#define IRQ_EP93XX_DMAM2P4		(IRQ_EP93XX_VIC0 + 11)
> +#define IRQ_EP93XX_DMAM2P5		(IRQ_EP93XX_VIC0 + 12)
> +#define IRQ_EP93XX_DMAM2P6		(IRQ_EP93XX_VIC0 + 13)
> +#define IRQ_EP93XX_DMAM2P7		(IRQ_EP93XX_VIC0 + 14)
> +#define IRQ_EP93XX_DMAM2P8		(IRQ_EP93XX_VIC0 + 15)
> +#define IRQ_EP93XX_DMAM2P9		(IRQ_EP93XX_VIC0 + 16)
> +#define IRQ_EP93XX_DMAM2M0		(IRQ_EP93XX_VIC0 + 17)
> +#define IRQ_EP93XX_DMAM2M1		(IRQ_EP93XX_VIC0 + 18)
> +#define IRQ_EP93XX_GPIO0MUX		(IRQ_EP93XX_VIC0 + 19)
> +#define IRQ_EP93XX_GPIO1MUX		(IRQ_EP93XX_VIC0 + 20)
> +#define IRQ_EP93XX_GPIO2MUX		(IRQ_EP93XX_VIC0 + 21)
> +#define IRQ_EP93XX_GPIO3MUX		(IRQ_EP93XX_VIC0 + 22)
> +#define IRQ_EP93XX_UART1RX		(IRQ_EP93XX_VIC0 + 23)
> +#define IRQ_EP93XX_UART1TX		(IRQ_EP93XX_VIC0 + 24)
> +#define IRQ_EP93XX_UART2RX		(IRQ_EP93XX_VIC0 + 25)
> +#define IRQ_EP93XX_UART2TX		(IRQ_EP93XX_VIC0 + 26)
> +#define IRQ_EP93XX_UART3RX		(IRQ_EP93XX_VIC0 + 27)
> +#define IRQ_EP93XX_UART3TX		(IRQ_EP93XX_VIC0 + 28)
> +#define IRQ_EP93XX_KEY			(IRQ_EP93XX_VIC0 + 29)
> +#define IRQ_EP93XX_TOUCH		(IRQ_EP93XX_VIC0 + 30)
>  #define EP93XX_VIC1_VALID_IRQ_MASK	0x7ffffffc
>  
> -#define IRQ_EP93XX_EXT0			32
> -#define IRQ_EP93XX_EXT1			33
> -#define IRQ_EP93XX_EXT2			34
> -#define IRQ_EP93XX_64HZ			35
> -#define IRQ_EP93XX_WATCHDOG		36
> -#define IRQ_EP93XX_RTC			37
> -#define IRQ_EP93XX_IRDA			38
> -#define IRQ_EP93XX_ETHERNET		39
> -#define IRQ_EP93XX_EXT3			40
> -#define IRQ_EP93XX_PROG			41
> -#define IRQ_EP93XX_1HZ			42
> -#define IRQ_EP93XX_VSYNC		43
> -#define IRQ_EP93XX_VIDEO_FIFO		44
> -#define IRQ_EP93XX_SSP1RX		45
> -#define IRQ_EP93XX_SSP1TX		46
> -#define IRQ_EP93XX_GPIO4MUX		47
> -#define IRQ_EP93XX_GPIO5MUX		48
> -#define IRQ_EP93XX_GPIO6MUX		49
> -#define IRQ_EP93XX_GPIO7MUX		50
> -#define IRQ_EP93XX_TIMER3		51
> -#define IRQ_EP93XX_UART1		52
> -#define IRQ_EP93XX_SSP			53
> -#define IRQ_EP93XX_UART2		54
> -#define IRQ_EP93XX_UART3		55
> -#define IRQ_EP93XX_USB			56
> -#define IRQ_EP93XX_ETHERNET_PME		57
> -#define IRQ_EP93XX_DSP			58
> -#define IRQ_EP93XX_GPIO_AB		59
> -#define IRQ_EP93XX_SAI			60
> +#define IRQ_EP93XX_VIC1			(IRQ_EP93XX_VIC0 + 32)
> +
> +#define IRQ_EP93XX_EXT0			(IRQ_EP93XX_VIC1 + 0)
> +#define IRQ_EP93XX_EXT1			(IRQ_EP93XX_VIC1 + 1)
> +#define IRQ_EP93XX_EXT2			(IRQ_EP93XX_VIC1 + 2)
> +#define IRQ_EP93XX_64HZ			(IRQ_EP93XX_VIC1 + 3)
> +#define IRQ_EP93XX_WATCHDOG		(IRQ_EP93XX_VIC1 + 4)
> +#define IRQ_EP93XX_RTC			(IRQ_EP93XX_VIC1 + 5)
> +#define IRQ_EP93XX_IRDA			(IRQ_EP93XX_VIC1 + 6)
> +#define IRQ_EP93XX_ETHERNET		(IRQ_EP93XX_VIC1 + 7)
> +#define IRQ_EP93XX_EXT3			(IRQ_EP93XX_VIC1 + 8)
> +#define IRQ_EP93XX_PROG			(IRQ_EP93XX_VIC1 + 9)
> +#define IRQ_EP93XX_1HZ			(IRQ_EP93XX_VIC1 + 10)
> +#define IRQ_EP93XX_VSYNC		(IRQ_EP93XX_VIC1 + 11)
> +#define IRQ_EP93XX_VIDEO_FIFO		(IRQ_EP93XX_VIC1 + 12)
> +#define IRQ_EP93XX_SSP1RX		(IRQ_EP93XX_VIC1 + 13)
> +#define IRQ_EP93XX_SSP1TX		(IRQ_EP93XX_VIC1 + 14)
> +#define IRQ_EP93XX_GPIO4MUX		(IRQ_EP93XX_VIC1 + 15)
> +#define IRQ_EP93XX_GPIO5MUX		(IRQ_EP93XX_VIC1 + 16)
> +#define IRQ_EP93XX_GPIO6MUX		(IRQ_EP93XX_VIC1 + 17)
> +#define IRQ_EP93XX_GPIO7MUX		(IRQ_EP93XX_VIC1 + 18)
> +#define IRQ_EP93XX_TIMER3		(IRQ_EP93XX_VIC1 + 19)
> +#define IRQ_EP93XX_UART1		(IRQ_EP93XX_VIC1 + 20)
> +#define IRQ_EP93XX_SSP			(IRQ_EP93XX_VIC1 + 21)
> +#define IRQ_EP93XX_UART2		(IRQ_EP93XX_VIC1 + 22)
> +#define IRQ_EP93XX_UART3		(IRQ_EP93XX_VIC1 + 23)
> +#define IRQ_EP93XX_USB			(IRQ_EP93XX_VIC1 + 24)
> +#define IRQ_EP93XX_ETHERNET_PME		(IRQ_EP93XX_VIC1 + 25)
> +#define IRQ_EP93XX_DSP			(IRQ_EP93XX_VIC1 + 26)
> +#define IRQ_EP93XX_GPIO_AB		(IRQ_EP93XX_VIC1 + 27)
> +#define IRQ_EP93XX_SAI			(IRQ_EP93XX_VIC1 + 28)
>  #define EP93XX_VIC2_VALID_IRQ_MASK	0x1fffffff
>  
> -#define NR_EP93XX_IRQS			(64 + 24)
> +#define NR_EP93XX_IRQS			(IRQ_EP93XX_VIC1 + 32 + 24)
>  
>  #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
>  #define EP93XX_BOARD_IRQS		32

-- 
Alexander Sverdlin.
