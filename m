Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4FBFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652E4214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="isAkNQJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKHOko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:40:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43742 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKHOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:40:43 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191108144042euoutp022e208ba6f97a3d678e57659719b2ac09~VNu5eThoh1399413994euoutp02O
        for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2019 14:40:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191108144042euoutp022e208ba6f97a3d678e57659719b2ac09~VNu5eThoh1399413994euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573224042;
        bh=FgyVFyuCJHWS+qKVf2bnwTdN8Rtc4PgvOj9/7MINFoo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=isAkNQJugGMm/PP/gcNnzlZGm2sIqBg/pXvVDSYMLN9+B+Pr0T50HNNhqlEIgdA77
         D23JGzpthdwvaNGI8KZf9Gy1SN3X/LVrQ+WP9E5oQMO/9E5YbYNBjldsk+gAfK/9p/
         97qpn5y4VG5KPguGAUuOMcPg2FZld6Vj6u4cC2F0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191108144042eucas1p11915113d458b62a08bafa3c8c7423875~VNu5RiSp52585925859eucas1p1r;
        Fri,  8 Nov 2019 14:40:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.5C.04469.96E75CD5; Fri,  8
        Nov 2019 14:40:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191108144041eucas1p184de963ca635a6d6325903bf960b1652~VNu4_mk802593625936eucas1p1m;
        Fri,  8 Nov 2019 14:40:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191108144041eusmtrp1cd3a7901aa05aeda9a3daa9efdac2cfe~VNu4971TZ1442914429eusmtrp1b;
        Fri,  8 Nov 2019 14:40:41 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-5a-5dc57e6964c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.B9.04117.96E75CD5; Fri,  8
        Nov 2019 14:40:41 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191108144041eusmtip245f93ed2e2edcb2559c51f012b5153e2~VNu4lB6L71069710697eusmtip2D;
        Fri,  8 Nov 2019 14:40:41 +0000 (GMT)
Subject: Re: [PATCH 14/46] ARM: pxa: use pdev resource for palmld mmio
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <490c888b-a034-c883-2f6e-d8a08753ef4d@samsung.com>
Date:   Fri, 8 Nov 2019 15:40:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191018154201.1276638-14-arnd@arndb.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3ZfdjecXKfpSc1opJGRLxR20ZISq0ufjKCssJx5mUM3ZXOW
        BiUqaiJamqRDKCJdGup8n9qH1HxjZC+alCjMl0KkmenKLLWcV8lvv/M///Oc/4GHwqSdhDul
        VCdzGrU8QUaK8Zbe5cFDyts9UQFWC8OsFvUKmefjhSSTsTqLM29rjzIPVgwCpmFqhGB6TZMC
        Zqi9nGT0X51PiNg/v4sQW1i7SLBt+nEhO/Rax46NvCDZxqd32MUGL7a1w4BHUJfFx2K5BGUK
        p/EPjRbHZVrNRFKz1825XwtYOirZlYdEFNBHwNi0SuQhMSWlnyGob/i+WdgQmO9WkXyxiKBg
        fgDfGunqNuB8w4DA2Lck4AsrgsyeGqHd5UyfhjF9NmFnF3ovlMx8weyM0ZUCKMyKsTNJB8P9
        nGpkZwkdCqW2pQ0PTu+Dir/TpJ130pGwYOkmeI8TDJRNb6QQ0UGQVWMW8m+6wej0IwHPe6DV
        Wo7ZAwE9IoTR0s+bscOhonQC49kZZvuahDx7grk4H+cHahGs5s5sTrciMBSvkbwrBLr73q3H
        oNZXHIC6dn9ePgnWMZPALgPtCB+tTnwIRyhqeYjxsgRys6W82weMlUZya21eWxV2D8n0207T
        bztHv+0c/f+9jxFejdw4nVal4LSBau6Gn1au0urUCr/riaoGtP6xzGt9Cyb0431MF6IpJHOQ
        RHq+ipIS8hRtqqoLAYXJXCSirHVJEitPTeM0idc0ugRO24U8KFzmJrm1w3JFSivkyVw8xyVx
        mq2ugBK5p6P4oDNj3uUO1DeTasXS3QnSotqzTSnVveTBeczY4u0TXr92PMQ0obyq+en7SXxh
        rkwSHO7wZtDjSfnkxYKE/dGHk6tybP75daxrhVv/uYwPtpzGZQXhE6dUTK9MNYfRutQ02hYh
        w9mJaHVAfyM5vFz38lLYqfMdnWddrbstwzJcGycP9MU0Wvk/szZfdFQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7qZdUdjDa5N07T4O+kYu8Xqu/1s
        Fk1/X7FYXFhnbjHlz3Imi02Pr7FaHNvxiMni8q45bBaz3gg7cHr8/jWJ0aN/3WdWj52z7rJ7
        XD5b6nHn2h42j81L6j0+b5Lz2L57OUsAR5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6h
        sXmslZGpkr6dTUpqTmZZapG+XYJeRvPb06wFW+Uq3v34xNzAOFWyi5GTQ0LAROLQ4eUsXYxc
        HEICSxklzq7awtjFyAGUkJE4vr4MokZY4s+1LjaImteMEgfmnmMGSQgLuEncmdXGCmKLCChK
        TH3xjBmkiFlgGZPE/7tLGUESQgJbGCW+rFQFsdkErCQmtq8Ci/MK2EnM+PIdbBCLgIrE0v9P
        2EBsUYEIicM7ZkHVCEqcnPmEBcTmFDCTaFl7mh3EZhZQl/gz7xIzhC0ucevJfCYIW15i+9s5
        zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzPbcd+btnB
        2PUu+BCjAAejEg/vi+qjsUKsiWXFlbmHGCU4mJVEeDlbjsQK8aYkVlalFuXHF5XmpBYfYjQF
        em4is5Rocj4wdeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBs
        y7v+aWX1z8QbXMWnLxVpsIiqNDopn/a4pWVin2gm5c/Y0RIVUZ51UVb85+S+gHsmmafLbKVu
        xZ8v6/0eKtkbWy5e5tkhKSnYsHjWfLktvg5VTvZ3P/9uLmhzMDLrbDvBrVlV8VqKK6KD4+Ci
        VXsyT51TTU3Yv+7FbV2lnPZmzxW8IZ5mSizFGYmGWsxFxYkAa5A+X+UCAAA=
X-CMS-MailID: 20191108144041eucas1p184de963ca635a6d6325903bf960b1652
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191018154230epcas4p3a961777ba34c3eaa7d416665f934185d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191018154230epcas4p3a961777ba34c3eaa7d416665f934185d
References: <20191018154052.1276506-1-arnd@arndb.de>
        <CGME20191018154230epcas4p3a961777ba34c3eaa7d416665f934185d@epcas4p3.samsung.com>
        <20191018154201.1276638-14-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/19 5:41 PM, Arnd Bergmann wrote:
> The palmld header is almost unused in drivers, the only
> remaining thing now is the PATA device address, which should
> really be passed as a resource.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  arch/arm/mach-pxa/palmld-pcmcia.c             |  3 ++-
>  arch/arm/mach-pxa/palmld.c                    | 12 +++++++++---
>  arch/arm/mach-pxa/{include/mach => }/palmld.h |  2 +-
>  drivers/ata/pata_palmld.c                     |  3 +--
>  4 files changed, 13 insertions(+), 7 deletions(-)
>  rename arch/arm/mach-pxa/{include/mach => }/palmld.h (98%)
> 
> diff --git a/arch/arm/mach-pxa/palmld-pcmcia.c b/arch/arm/mach-pxa/palmld-pcmcia.c
> index 07e0f7438db1..720294a50864 100644
> --- a/arch/arm/mach-pxa/palmld-pcmcia.c
> +++ b/arch/arm/mach-pxa/palmld-pcmcia.c
> @@ -13,9 +13,10 @@
>  #include <linux/gpio.h>
>  
>  #include <asm/mach-types.h>
> -#include <mach/palmld.h>
>  #include <pcmcia/soc_common.h>
>  
> +#include "palmld.h"
> +
>  static struct gpio palmld_pcmcia_gpios[] = {
>  	{ GPIO_NR_PALMLD_PCMCIA_POWER,	GPIOF_INIT_LOW,	"PCMCIA Power" },
>  	{ GPIO_NR_PALMLD_PCMCIA_RESET,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
> diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
> index d85146957004..d821606ce0b5 100644
> --- a/arch/arm/mach-pxa/palmld.c
> +++ b/arch/arm/mach-pxa/palmld.c
> @@ -29,8 +29,8 @@
>  #include <asm/mach/map.h>
>  
>  #include "pxa27x.h"
> +#include "palmld.h"
>  #include <linux/platform_data/asoc-pxa.h>
> -#include <mach/palmld.h>
>  #include <linux/platform_data/mmc-pxamci.h>
>  #include <linux/platform_data/video-pxafb.h>
>  #include <linux/platform_data/irda-pxaficp.h>
> @@ -279,9 +279,15 @@ static inline void palmld_leds_init(void) {}
>   * HDD
>   ******************************************************************************/
>  #if defined(CONFIG_PATA_PALMLD) || defined(CONFIG_PATA_PALMLD_MODULE)
> +static struct resource palmld_ide_resources[] = {
> +	DEFINE_RES_MEM(PALMLD_IDE_PHYS, 0x1000),
> +};
> +
>  static struct platform_device palmld_ide_device = {
> -	.name	= "pata_palmld",
> -	.id	= -1,
> +	.name		= "pata_palmld",
> +	.id		= -1,
> +	.resource	= palmld_ide_resources,
> +	.num_resources	= ARRAY_SIZE(palmld_ide_resources),
>  };
>  
>  static struct gpiod_lookup_table palmld_ide_gpio_table = {
> diff --git a/arch/arm/mach-pxa/include/mach/palmld.h b/arch/arm/mach-pxa/palmld.h
> similarity index 98%
> rename from arch/arm/mach-pxa/include/mach/palmld.h
> rename to arch/arm/mach-pxa/palmld.h
> index 99a6d8b3a1e3..ee3bc15b71a2 100644
> --- a/arch/arm/mach-pxa/include/mach/palmld.h
> +++ b/arch/arm/mach-pxa/palmld.h
> @@ -9,7 +9,7 @@
>  #ifndef _INCLUDE_PALMLD_H_
>  #define _INCLUDE_PALMLD_H_
>  
> -#include "irqs.h" /* PXA_GPIO_TO_IRQ */
> +#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
>  
>  /** HERE ARE GPIOs **/
>  
> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
> index 2448441571ed..400e65190904 100644
> --- a/drivers/ata/pata_palmld.c
> +++ b/drivers/ata/pata_palmld.c
> @@ -25,7 +25,6 @@
>  #include <linux/gpio/consumer.h>
>  
>  #include <scsi/scsi_host.h>
> -#include <mach/palmld.h>
>  
>  #define DRV_NAME "pata_palmld"
>  
> @@ -63,7 +62,7 @@ static int palmld_pata_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* remap drive's physical memory address */
> -	mem = devm_ioremap(dev, PALMLD_IDE_PHYS, 0x1000);
> +	mem = devm_platform_ioremap_resource(pdev, 0);
>  	if (!mem)
>  		return -ENOMEM;
>  
