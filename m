Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FD7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407AA22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u3wBjXpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfHTMGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:06:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44821 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTMGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:06:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190820120618euoutp022f14824407490d884d1900cda0f58d68~8oBQcLQuT2395923959euoutp02Q
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 12:06:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190820120618euoutp022f14824407490d884d1900cda0f58d68~8oBQcLQuT2395923959euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566302778;
        bh=BzcCkHRTbzmM5ZSwsq73zQeDv/bh8Evnqn49cphH/OI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u3wBjXpazuzfa3lpbtzIVJpen63PIZXKt+xqOtiHbcsmnw8/iqJtEzOpHYp+sJCC6
         Fq+cr5uKfX1RspXfF4mV0wjR29ok6yGLmFMdQ9SOZJXG89N09r1y+ULuQ2tPv4gTP2
         OIZrzqv66/k5Ka9nF/0W7GNg4muh/A2hf5KTJmKA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820120617eucas1p268147c730fae571ee76a03f6f80d63ab~8oBPygOSa1502815028eucas1p2d;
        Tue, 20 Aug 2019 12:06:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.22.04374.932EB5D5; Tue, 20
        Aug 2019 13:06:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190820120617eucas1p27f378b14d1e0ed4777cfa4a876e1a47f~8oBPCW2_41502715027eucas1p2j;
        Tue, 20 Aug 2019 12:06:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820120616eusmtrp1887adcf49cd97a06e4458baf6df4315e~8oBOz4OAe0397703977eusmtrp17;
        Tue, 20 Aug 2019 12:06:16 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-3e-5d5be2397230
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 80.3B.04117.832EB5D5; Tue, 20
        Aug 2019 13:06:16 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820120616eusmtip1bf8af4045fe19b0ee7048454ece5fcb2~8oBOR4zq_0304303043eusmtip1k;
        Tue, 20 Aug 2019 12:06:16 +0000 (GMT)
Subject: Re: [PATCH v5] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, schmitzmic@gmail.com,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <9966f79c-278b-5ec9-3c4b-e1de55af55f0@samsung.com>
Date:   Tue, 20 Aug 2019 14:06:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190812164830.16244-1-max@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87qWj6JjDSadULNYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFrvf32e0eNj0gclibut0dgcOj8NfN7N57Jx1l93j8tlSj0OHOxg9
        Dp47x+jxeZNcAFsUl01Kak5mWWqRvl0CV8b2O8+ZCzYkVPR86GBqYDzq2cXIySEhYCLx7O1e
        ZhBbSGAFo0TvT6suRi4g+wujxLYHbawQzmdGie/TulhhOr5M/ccO0bGcUeLcrkKIoreMEtO/
        /mIBSQgLBErMeP8YrEhEQE7iY+tVRpAiZoFtjBJHT78CS7AJWElMbF/FCGLzCthJrP4yiQ3E
        ZhFQlZh0+QJYjahAhMT9YxtYIWoEJU7OfAK0gIODU8BY4tFHB5Aws4C4xK0n85kgbHmJ7W/n
        MIPskhA4xC4x+eppJoirXSR2rPnHDGELS7w6voUdwpaROD25hwWiYR2jxN+OF1Dd2xkllk/+
        xwZRZS1x+PhFVpDNzAKaEut36UOEHSV2f9/FBBKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq
        1SQ2LNvABrO2a+dK5gmMSrOQfDYLyTuzkLwzC2HvAkaWVYziqaXFuempxcZ5qeV6xYm5xaV5
        6XrJ+bmbGIEp6fS/4193MO77k3SIUYCDUYmHN+F6dKwQa2JZcWXuIUYJDmYlEd6KOVGxQrwp
        iZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhgLrnYcUHbctaBl
        61GZiXefTrebe5B7yvq0aaoBptNWV1gtDZ/4Wmryv1NlNSqytWn7Te8u23tpltPtk4uCFAWO
        Kr7olb5u/EDkYagyX8hcUavJuwv8Gm/mL1GSL4l0SFU/lZa/zmD2z7fu2ooF/+aIN01OP3M0
        2bxLLYVlvwGX7gVZy/Lw07+UWIozEg21mIuKEwFEG7P0RQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7oWj6JjDZZNNLZYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFrvf32e0eNj0gclibut0dgcOj8NfN7N57Jx1l93j8tlSj0OHOxg9
        Dp47x+jxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsb2O8+ZCzYkVPR86GBqYDzq2cXIySEhYCLxZeo/9i5GLg4hgaWMEjfevGbpYuQA
        SshIHF9fBlEjLPHnWhcbRM1rRonN7fvYQBLCAoESM94/ZgexRQTkJD62XmUEKWIW2MYo8fXa
        dEaIjjZGiVVPL4NVsQlYSUxsX8UIYvMK2Ems/jIJbBKLgKrEpMsXwGpEBSIkzrxfwQJRIyhx
        cuYTsIs4BYwlHn10AAkzC6hL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYxCs5B0z0LSMgtJyywk
        LQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERuG2Yz+37GDsehd8iFGAg1GJh3fHzehY
        IdbEsuLK3EOMEhzMSiK8FXOiYoV4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5H5gg8kriDU0N
        zS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MLZ+emvJ45rWw3d6k2fvvI12
        JhZv85Luli9/z/z370Fr+56jttzT9LQEfh5Wl9XtPXdil6KmnjrXP7ein4ICc6655ut3q78L
        3sjg9eHj/auJq/cbZgSuEprR/2MlZ+rNayLp8o7bJh6UyNgd9WM9x03527HHRaaEfZiR/OxA
        Feeey+UF4Sp93UosxRmJhlrMRcWJANptVTfYAgAA
X-CMS-MailID: 20190820120617eucas1p27f378b14d1e0ed4777cfa4a876e1a47f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c
References: <CGME20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c@epcas2p4.samsung.com>
        <20190812164830.16244-1-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Max,

Few more review comments below.

On 8/12/19 6:48 PM, Max Staudt wrote:
> Up until now, the pata_buddha driver would only check for cards on
> initcall time. Now, the kernel will call its probe function as soon
> as a compatible card is detected.
> 
> v5: Remove module_exit(): There's no good way to handle the X-Surf hack.
>     Also include a workaround to save X-Surf's drvdata in case zorro8390
>     is active.
> 
> v4: Clean up pata_buddha_probe() by using ent->driver_data.
>     Support X-Surf via late_initcall()
> 
> v3: Clean up devm_*, implement device removal.
> 
> v2: Rename 'zdev' to 'z' to make the patch easy to analyse with
>     git diff --ignore-space-change
> 
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/ata/pata_buddha.c | 234 +++++++++++++++++++++++++++-------------------
>  1 file changed, 140 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
> index 11a8044ff..6014befc9 100644
> --- a/drivers/ata/pata_buddha.c
> +++ b/drivers/ata/pata_buddha.c
> @@ -18,7 +18,9 @@
>  #include <linux/kernel.h>
>  #include <linux/libata.h>
>  #include <linux/mm.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/types.h>
>  #include <linux/zorro.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_host.h>
> @@ -29,7 +31,7 @@
>  #include <asm/setup.h>
>  
>  #define DRV_NAME "pata_buddha"
> -#define DRV_VERSION "0.1.0"
> +#define DRV_VERSION "0.1.1"
>  
>  #define BUDDHA_BASE1	0x800
>  #define BUDDHA_BASE2	0xa00
> @@ -47,11 +49,11 @@ enum {
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
> @@ -145,111 +147,155 @@ static struct ata_port_operations pata_xsurf_ops = {
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
> +	unsigned int type = ent->driver_data;
> +	unsigned int nr_ports = (type == BOARD_CATWEASEL) ? 3 : 2;
> +	void *old_drvdata;
> +	int i;
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
> +		}
> +	}
> +
> +	/* Workaround for X-Surf: Save drvdata in case zorro8390 has set it */
> +	old_drvdata = dev_get_drvdata(&z->dev);

This should be done only for type == BOARD_XSURF.

> +	/* allocate host */
> +	host = ata_host_alloc(&z->dev, nr_ports);
> +	dev_set_drvdata(&z->dev, old_drvdata);

ditto

> +	if (!host)
> +		return -ENXIO;
> +
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
>  }
>  
> -module_init(pata_buddha_init_one);
> +static void pata_buddha_remove(struct zorro_dev *z)
> +{
> +	struct ata_host *host = dev_get_drvdata(&z->dev);
> +
> +	ata_host_detach(host);
> +}
> +
> +static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
> +	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, BOARD_BUDDHA},
> +	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, BOARD_CATWEASEL},
> +	/* { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF}, */

Commented out code should be removed.

> +	{ 0 }
> +};
> +

Extra newline, please remove it.

> +MODULE_DEVICE_TABLE(zorro, pata_buddha_zorro_tbl);
> +
> +static struct zorro_driver pata_buddha_driver = {
> +	.name           = "pata_buddha",
> +	.id_table       = pata_buddha_zorro_tbl,
> +	.probe          = pata_buddha_probe,
> +	.remove         = pata_buddha_remove,

I think that we should also add:

	.driver  = {
		.suppress_bind_attrs = true,
	},

to prevent the device from being unbinded (and thus ->remove called)
from the driver using sysfs interface.

> +};
> +

Extra newline, please remove it.

> +

ditto

> +
> +/*
> + * We cannot have a modalias for X-Surf boards, as it competes with the
> + * zorro8390 network driver. As a stopgap measure until we have proper
> + * MFC support for this board, we manually attach to it late after Zorro

s/MFC/MFD/

> + * has enumerated its boards.
> + */
> +static int __init pata_buddha_late_init(void)
> +{
> +        struct zorro_dev *z = NULL;
> +
> +	pr_info("pata_buddha: Scanning for stand-alone IDE controllers...\n");

I think that there is no need for being extra verbose,
please remove it.

> +	zorro_register_driver(&pata_buddha_driver);
> +
> +	pr_info("pata_buddha: Scanning for X-Surf boards...\n");

ditto

> +        while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {
> +		static struct zorro_device_id xsurf_ent =
> +			{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF};
> +
> +		pata_buddha_probe(z, &xsurf_ent);
> +        }
> +
> +        return 0;
> +}
> +
> +late_initcall(pata_buddha_late_init);
> +

Extra newline, please remove it.

>  
>  MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
>  MODULE_DESCRIPTION("low-level driver for Buddha/Catweasel/X-Surf PATA");

Please also always check your patches with scripts/checkpatch.pl and
fix the reported issues:

ERROR: code indent should use tabs where possible
#348: FILE: drivers/ata/pata_buddha.c:281:
+        struct zorro_dev *z = NULL;$

WARNING: please, no spaces at the start of a line
#348: FILE: drivers/ata/pata_buddha.c:281:
+        struct zorro_dev *z = NULL;$

WARNING: line over 80 characters
#354: FILE: drivers/ata/pata_buddha.c:287:
+        while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {

ERROR: code indent should use tabs where possible
#354: FILE: drivers/ata/pata_buddha.c:287:
+        while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {$

WARNING: please, no spaces at the start of a line
#354: FILE: drivers/ata/pata_buddha.c:287:
+        while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {$

ERROR: that open brace { should be on the previous line
#356: FILE: drivers/ata/pata_buddha.c:289:
+               static struct zorro_device_id xsurf_ent =
+                       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF};

ERROR: code indent should use tabs where possible
#359: FILE: drivers/ata/pata_buddha.c:292:
+        }$

WARNING: please, no spaces at the start of a line
#359: FILE: drivers/ata/pata_buddha.c:292:
+        }$

ERROR: code indent should use tabs where possible
#361: FILE: drivers/ata/pata_buddha.c:294:
+        return 0;$

WARNING: please, no spaces at the start of a line
#361: FILE: drivers/ata/pata_buddha.c:294:
+        return 0;$

total: 5 errors, 6 warnings, 276 lines checked


Otherwise the patch looks fine.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
