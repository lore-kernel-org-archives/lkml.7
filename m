Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A3C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B2621901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H9YaX4r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfGYREG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:04:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53719 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfGYRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:04:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190725170401euoutp014228c2117d408b4f2ea41433136703b4~0tTxF8SpK2644426444euoutp01W
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 17:04:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190725170401euoutp014228c2117d408b4f2ea41433136703b4~0tTxF8SpK2644426444euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564074241;
        bh=Mfpey/ruic/j+xAgZYV+W+8HKX6JD3HnjEmysLsec0A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=H9YaX4r9TM/XIbUPp9XUUvV8blgYa3L2rWwus4ljK8IE6bVw56OiXR0ww24Kr8lLL
         6OrowiwdtUvQr2HuuyXSQrSyrann6W8odC7q+rzAYGRRZg2jEp7r21UDOpb/8yWoFv
         qyaywhkFQ6WjUQ55BWzsTO9/svDJoQTW+cGAYK4k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190725170400eucas1p2cd4eba15ea1365fda5c0096771768303~0tTwRUnV-1556315563eucas1p2S;
        Thu, 25 Jul 2019 17:04:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.62.04298.FF0E93D5; Thu, 25
        Jul 2019 18:03:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190725170359eucas1p271187268f749869088f60bf961194169~0tTvZQkWi1556415564eucas1p2P;
        Thu, 25 Jul 2019 17:03:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190725170359eusmtrp228d3b640ebddfaee1d50055c3938f886~0tTvYwT4n1001810018eusmtrp2K;
        Thu, 25 Jul 2019 17:03:59 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-39-5d39e0ff1b29
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AD.E7.04146.FF0E93D5; Thu, 25
        Jul 2019 18:03:59 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190725170358eusmtip28483f35892b31283a8babd485bcf48ee~0tTu-DRP32161621616eusmtip2c;
        Thu, 25 Jul 2019 17:03:58 +0000 (GMT)
Subject: Re: [PATCH v2] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <01cfe282-6ce6-ff40-9e85-e23724f9d50f@samsung.com>
Date:   Thu, 25 Jul 2019 19:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190725102211.8526-1-max@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7r/H1jGGjw7bGrx7NZeJovZ75Ut
        ju14xGRxedccNovd7+8zWjxs+sBkMbd1OrsDu8fhr5vZPHbOusvucehwB6PHwXPnGD0+b5IL
        YI3isklJzcksSy3St0vgyliy5T5rwdHgipsT3BoYL9l3MXJySAiYSNzqmMbexcjFISSwglHi
        1LJrbBDOF0aJA5f/MUI4nxklWpfuYIJpebjoNVTVckaJn3cOQzlvGSVezn3FBlIlLBAocf3E
        R3YQW0RATuJj61VGEJtZ4BWjxK1uDhCbTcBKYmL7KrA4r4CdxN6P11lAbBYBVYnDf26DzREV
        iJC4f2wDK0SNoMTJmU/AajgFjCROTDrCCjFTXOLWk/lMELa8xPa3c5hBDpIQ2MUusXHmFmaI
        s10knv48zQ5hC0u8Or4FypaR+L8TpBmkYR2jxN+OF1Dd2xkllk/+xwZRZS1x+PhFoHUcQCs0
        Jdbv0ocIO0pMXw7yGQeQzSdx460gxBF8EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpXMExiV
        ZiF5bRaSd2YheWcWwt4FjCyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPQ6X/HP+1g
        /Hop6RCjAAejEg/vheWWsUKsiWXFlbmHGCU4mJVEeLfuAArxpiRWVqUW5ccXleakFh9ilOZg
        URLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpgTDr4dW3vj9e7g9P2bJ7brzpJxlEuI+LkTLek
        6GClO79mP1pVcUMyde4nt40XvzboaEteTQjb//fd0el2qcqzVestY2TL+S/KWtkd5n7dZeeQ
        WTeTyeHynUfp/AIPS1Ui1p958UV+i/OJ5qlRLo9dHSPfl2y4urdR16itdqnq6v1HHflYz92c
        rMRSnJFoqMVcVJwIAIHUvtY9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7r/H1jGGkzYxmXx7NZeJovZ75Ut
        ju14xGRxedccNovd7+8zWjxs+sBkMbd1OrsDu8fhr5vZPHbOusvucehwB6PHwXPnGD0+b5IL
        YI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1iy
        5T5rwdHgipsT3BoYL9l3MXJySAiYSDxc9Jqti5GLQ0hgKaPE6wMr2bsYOYASMhLH15dB1AhL
        /LnWxQZiCwm8ZpQ49csAxBYWCJS4fuIjO4gtIiAn8bH1KiPIHGaBN4wSWw/MYgKZIyRgKLH/
        WA1IDZuAlcTE9lWMIDavgJ3E3o/XWUBsFgFVicN/boPNFxWIkDjzfgULRI2gxMmZT8BsTgEj
        iROTjrCC2MwC6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwi
        qaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHRtu3Yz807GC9tDD7EKMDBqMTDe2G5ZawQa2JZcWXu
        IUYJDmYlEd6tO4BCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MBHkl8YamhuYWlobmxubG
        ZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhhL/gtJdDV1LxOxkvDz2GpxjvX2tQmXVVct
        dn89m6HzttPts305V1WUKv4xn9gfLpP5gTnrReHknTacO6IEvP1O6G7hvfz94Pp/IfViPNuf
        95f/2eDhLZLjaPlV58Oqv0pnXJOVuz/e/Se2uaH6sNxJE5Vn73rvaHp/5Z+ld3DCz/qnwbNW
        ZHEpsRRnJBpqMRcVJwIAWpZViswCAAA=
X-CMS-MailID: 20190725170359eucas1p271187268f749869088f60bf961194169
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190725170359eucas1p271187268f749869088f60bf961194169
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190725170359eucas1p271187268f749869088f60bf961194169
References: <20190725102211.8526-1-max@enpas.org>
        <CGME20190725170359eucas1p271187268f749869088f60bf961194169@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Max,

On 7/25/19 12:22 PM, Max Staudt wrote:
> Up until now, the pata_buddha driver would only check for cards on
> initcall time. Now, the kernel will call its probe function as soon
> as a compatible card is detected.
> 
> Device removal remains unimplemented. A WARN_ONCE() serves as a
> reminder.
> 
> v2: Rename 'zdev' to 'z' to make the patch easy to analyse with
>     git diff --ignore-space-change
> 
> Tested-by: Max Staudt <max@enpas.org>
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/ata/pata_buddha.c | 240 ++++++++++++++++++++++++++++------------------
>  1 file changed, 146 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
> index 11a8044ff..76804a4c1 100644
> --- a/drivers/ata/pata_buddha.c
> +++ b/drivers/ata/pata_buddha.c
> @@ -19,6 +19,7 @@
>  #include <linux/libata.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/types.h>
>  #include <linux/zorro.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_host.h>
> @@ -29,7 +30,7 @@
>  #include <asm/setup.h>
>  
>  #define DRV_NAME "pata_buddha"
> -#define DRV_VERSION "0.1.0"
> +#define DRV_VERSION "0.1.1"
>  
>  #define BUDDHA_BASE1	0x800
>  #define BUDDHA_BASE2	0xa00
> @@ -47,11 +48,11 @@ enum {
>  	BOARD_XSURF
>  };
>  
> -static unsigned int buddha_bases[3] __initdata = {
> +static unsigned int buddha_bases[3] = {
>  	BUDDHA_BASE1, BUDDHA_BASE2, BUDDHA_BASE3
>  };
>  
> -static unsigned int xsurf_bases[2] __initdata = {
> +static unsigned int xsurf_bases[2] = {
>  	XSURF_BASE1, XSURF_BASE2
>  };
>  
> @@ -145,111 +146,162 @@ static struct ata_port_operations pata_xsurf_ops = {
>  	.set_mode	= pata_buddha_set_mode,
>  };
>  
> -static int __init pata_buddha_init_one(void)
> +static int pata_buddha_probe(struct zorro_dev *z,
> +			     const struct zorro_device_id *ent)
>  {
> -	struct zorro_dev *z = NULL;
> -
> -	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
> -		static const char *board_name[]
> -			= { "Buddha", "Catweasel", "X-Surf" };
> -		struct ata_host *host;
> -		void __iomem *buddha_board;
> -		unsigned long board;
> -		unsigned int type, nr_ports = 2;
> -		int i;
> -
> -		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
> -			type = BOARD_BUDDHA;
> -		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL) {
> -			type = BOARD_CATWEASEL;
> -			nr_ports++;
> -		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF) {
> -			type = BOARD_XSURF;
> -		} else
> -			continue;
> -
> -		dev_info(&z->dev, "%s IDE controller\n", board_name[type]);
> -
> -		board = z->resource.start;
> +	static const char * const board_name[]
> +		= { "Buddha", "Catweasel", "X-Surf" };
> +	struct ata_host *host;
> +	void __iomem *buddha_board;
> +	unsigned long board;
> +	unsigned int type, nr_ports = 2;
> +	int i;
> +
> +	switch (z->id) {
> +	case ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA:
> +	default:
> +		type = BOARD_BUDDHA;
> +		break;
> +	case ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL:
> +		type = BOARD_CATWEASEL;
> +		nr_ports++;
> +		break;
> +	case ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF:
> +		type = BOARD_XSURF;
> +		break;
> +	}
> +
> +	dev_info(&z->dev, "%s IDE controller\n", board_name[type]);
> +
> +	board = z->resource.start;
> +
> +	if (type != BOARD_XSURF) {
> +		if (!devm_request_mem_region(&z->dev,
> +					     board + BUDDHA_BASE1,
> +					     0x800, DRV_NAME))
> +			return -ENXIO;
> +	} else {
> +		if (!devm_request_mem_region(&z->dev,
> +					     board + XSURF_BASE1,
> +					     0x1000, DRV_NAME))
> +			return -ENXIO;
> +		if (!devm_request_mem_region(&z->dev,
> +					     board + XSURF_BASE2,
> +					     0x1000, DRV_NAME)) {
> +			devm_release_mem_region(&z->dev,
> +						board + XSURF_BASE1,
> +						0x1000);
> +			return -ENXIO;
> +		}
> +	}
> +
> +	/* allocate host */
> +	host = ata_host_alloc(&z->dev, nr_ports);
> +	if (!host)
> +		goto err_ata_host_alloc;
> +
> +	buddha_board = ZTWO_VADDR(board);
> +
> +	/* enable the board IRQ on Buddha/Catweasel */
> +	if (type != BOARD_XSURF)
> +		z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
> +
> +	for (i = 0; i < nr_ports; i++) {
> +		struct ata_port *ap = host->ports[i];
> +		void __iomem *base, *irqport;
> +		unsigned long ctl = 0;
>  
>  		if (type != BOARD_XSURF) {
> -			if (!devm_request_mem_region(&z->dev,
> -						     board + BUDDHA_BASE1,
> -						     0x800, DRV_NAME))
> -				continue;
> +			ap->ops = &pata_buddha_ops;
> +			base = buddha_board + buddha_bases[i];
> +			ctl = BUDDHA_CONTROL;
> +			irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
>  		} else {
> -			if (!devm_request_mem_region(&z->dev,
> -						     board + XSURF_BASE1,
> -						     0x1000, DRV_NAME))
> -				continue;
> -			if (!devm_request_mem_region(&z->dev,
> -						     board + XSURF_BASE2,
> -						     0x1000, DRV_NAME))
> -				continue;
> +			ap->ops = &pata_xsurf_ops;
> +			base = buddha_board + xsurf_bases[i];
> +			/* X-Surf has no CS1* (Control/AltStat) */
> +			irqport = buddha_board + XSURF_IRQ;
>  		}
>  
> -		/* allocate host */
> -		host = ata_host_alloc(&z->dev, nr_ports);
> -		if (!host)
> -			continue;
> -
> -		buddha_board = ZTWO_VADDR(board);
> -
> -		/* enable the board IRQ on Buddha/Catweasel */
> -		if (type != BOARD_XSURF)
> -			z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
> -
> -		for (i = 0; i < nr_ports; i++) {
> -			struct ata_port *ap = host->ports[i];
> -			void __iomem *base, *irqport;
> -			unsigned long ctl = 0;
> -
> -			if (type != BOARD_XSURF) {
> -				ap->ops = &pata_buddha_ops;
> -				base = buddha_board + buddha_bases[i];
> -				ctl = BUDDHA_CONTROL;
> -				irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
> -			} else {
> -				ap->ops = &pata_xsurf_ops;
> -				base = buddha_board + xsurf_bases[i];
> -				/* X-Surf has no CS1* (Control/AltStat) */
> -				irqport = buddha_board + XSURF_IRQ;
> -			}
> -
> -			ap->pio_mask = ATA_PIO4;
> -			ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
> -
> -			ap->ioaddr.data_addr		= base;
> -			ap->ioaddr.error_addr		= base + 2 + 1 * 4;
> -			ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
> -			ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
> -			ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
> -			ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
> -			ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
> -			ap->ioaddr.device_addr		= base + 2 + 6 * 4;
> -			ap->ioaddr.status_addr		= base + 2 + 7 * 4;
> -			ap->ioaddr.command_addr		= base + 2 + 7 * 4;
> -
> -			if (ctl) {
> -				ap->ioaddr.altstatus_addr = base + ctl;
> -				ap->ioaddr.ctl_addr	  = base + ctl;
> -			}
> -
> -			ap->private_data = (void *)irqport;
> -
> -			ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
> -				      ctl ? board + buddha_bases[i] + ctl : 0);
> +		ap->pio_mask = ATA_PIO4;
> +		ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
> +
> +		ap->ioaddr.data_addr		= base;
> +		ap->ioaddr.error_addr		= base + 2 + 1 * 4;
> +		ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
> +		ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
> +		ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
> +		ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
> +		ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
> +		ap->ioaddr.device_addr		= base + 2 + 6 * 4;
> +		ap->ioaddr.status_addr		= base + 2 + 7 * 4;
> +		ap->ioaddr.command_addr		= base + 2 + 7 * 4;
> +
> +		if (ctl) {
> +			ap->ioaddr.altstatus_addr = base + ctl;
> +			ap->ioaddr.ctl_addr	  = base + ctl;
>  		}
>  
> -		ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
> -				  IRQF_SHARED, &pata_buddha_sht);
> +		ap->private_data = (void *)irqport;
>  
> +		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
> +			      ctl ? board + buddha_bases[i] + ctl : 0);
>  	}
>  
> +	ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
> +			  IRQF_SHARED, &pata_buddha_sht);
> +
> +
>  	return 0;
> +
> +err_ata_host_alloc:
> +	switch (type) {
> +	case BOARD_BUDDHA:
> +	case BOARD_CATWEASEL:
> +	default:
> +		devm_release_mem_region(&z->dev,
> +					board + BUDDHA_BASE1,
> +					0x800);

Could you please explain why this is needed now?

[ The whole idea of using devm_* helpers is to not have to release
  resources explicitly. ]

> +		break;
> +	case BOARD_XSURF:
> +		devm_release_mem_region(&z->dev,
> +					board + XSURF_BASE1,
> +					0x1000);
> +		devm_release_mem_region(&z->dev,
> +					board + XSURF_BASE2,
> +					0x1000);
> +		break;
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static void pata_buddha_remove(struct zorro_dev *zdev)
> +{
> +	/* NOT IMPLEMENTED */
> +
> +	WARN_ONCE(1, "pata_buddha: Attempted to remove driver. This is not implemented yet.\n");

Please try to implement it, should be as simple as:

static void pata_buddha_remove(struct zorro_dev *zdev)
{
	struct ata_host *host = dev_get_drvdata(&zdev->dev);

	ata_host_detach(host);
}

[ ata_host_alloc() in pata_buddha_probe() sets drvdata to host ]

The rest of the patch looks fine, thanks for working on this driver.

>  }
>  
> -module_init(pata_buddha_init_one);
> +static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
> +	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, },
> +	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, },
> +	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },
> +	{ 0 }
> +};
> +
> +MODULE_DEVICE_TABLE(zorro, pata_buddha_zorro_tbl);
> +
> +static struct zorro_driver pata_buddha_driver = {
> +	.name           = "pata_buddha",
> +	.id_table       = pata_buddha_zorro_tbl,
> +	.probe          = pata_buddha_probe,
> +	.remove         = pata_buddha_remove,
> +};
> +
> +module_driver(pata_buddha_driver,
> +	      zorro_register_driver,
> +	      zorro_unregister_driver);
>  
>  MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
>  MODULE_DESCRIPTION("low-level driver for Buddha/Catweasel/X-Surf PATA");

PS Next time please also use scripts/get_maintainer.pl script to get
   the list of people that should be added to Cc:, i.e.:

$ ./scripts/get_maintainer.pl -f drivers/ata/pata_buddha.c
Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> (maintainer:LIBATA PATA DRIVERS)
Jens Axboe <axboe@kernel.dk> (maintainer:LIBATA PATA DRIVERS)
linux-ide@vger.kernel.org (open list:LIBATA PATA DRIVERS)
linux-kernel@vger.kernel.org (open list)

[ I've also added John, Michael & Geert to Cc: (as they were all
  involved in the development of the initial driver version). ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
