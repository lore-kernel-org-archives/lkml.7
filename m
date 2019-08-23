Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C7121897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="luGn/MUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfHWLSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:18:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35388 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbfHWLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:18:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190823111836euoutp0151ec82a6ae05f93467ec1008c80bcfe3~9iTd9VuuH1600416004euoutp01_
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 11:18:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190823111836euoutp0151ec82a6ae05f93467ec1008c80bcfe3~9iTd9VuuH1600416004euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566559116;
        bh=MksplQx4DCRVuN3jc2njcBm+CvP/mn5+Cn1+XcN4OOs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=luGn/MUvQgjJJCD6Cm+GDxDiUxYN1cG9pKPJyxMVZBYwHpwogDDIOoEZOmKALhAZr
         0+9sZ04gdtxpcxjAhoFgxi1Ee7P9v7MADoPNfeFX0O6IHGzZBNNSnexBmJQ2KepE+7
         Na3xuHKz5dv8mjR9W1ALhO+eBM0/r00c4OFCxR7w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190823111836eucas1p184fe094a5546f7cb293511bc4e2e6869~9iTdR9dD81169511695eucas1p14;
        Fri, 23 Aug 2019 11:18:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.D5.04374.B8BCF5D5; Fri, 23
        Aug 2019 12:18:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190823111835eucas1p14df9d8867cdc9e8776e4653a061cb5b1~9iTcZa8GY1563615636eucas1p1n;
        Fri, 23 Aug 2019 11:18:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190823111834eusmtrp2f00fdb2acc7e587fde4c5d9706c434c8~9iTcJz0bS2045020450eusmtrp2B;
        Fri, 23 Aug 2019 11:18:34 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-de-5d5fcb8bfd11
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.B3.04117.A8BCF5D5; Fri, 23
        Aug 2019 12:18:34 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190823111834eusmtip27adb0f22be8374bfbc1e27eae5c12b6b~9iTbsa_0S2635026350eusmtip2M;
        Fri, 23 Aug 2019 11:18:34 +0000 (GMT)
Subject: Re: [PATCH v7] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, schmitzmic@gmail.com,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a7f20fbb-bb28-d65f-76d1-fd0543902cd8@samsung.com>
Date:   Fri, 23 Aug 2019 13:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190823104911.6840-1-max@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjtvXe7u0qT1/n1oKIwSdBI0yQulaLQj0FEBv6QlenSi0puyq6z
        tH5M0ZpKH9Mf5jTUH7WyqGG6TTMxPzbFEkUimYgfmYk2/CbK0pxXyX/nOc857zkPvDQpaRX6
        09mqfFatUuRIKXeB2fZr+ETlUGrKSUtfJPNy8iHFzDveE0zdcghjs84SzFhHPcW8W55CzEzJ
        CsE8KasRxdOy3s23lKzdMCmSjX3SyHp6dUj2YXgYydZbghIpufu5DDYnu4BVR8aluWdNtJVQ
        eaZLt5p060It6j5XgdxowDFQNVpMVCB3WoKfI6j+UYf4YQPBwHKpkB/WEXw1G4gDS+UX3b7K
        iGCrXE/xgxPBt5bveyovfBl+OiYELuyNg2C17POeg8RmBP1DiyLXgsJnQH+vGbmwGMfBeJt5
        10zTAnwMirtjXbQPToYpm0nISzxhsHZu7003HA2d2ibShUnsB465BoLHwWBx1pOuLMBdIhhp
        3hbwtc/DRn854rEXLNpbRTwOhJ32BoI3vEbwV7ew77YgMFZvU7zqLPTaR4WudiQOgzcdkTyd
        AHWPS/dowB4w7vTkS3hAlbmG5Gkx6O5KeHUomJ6ZqIPYivYX5CMkNRw6zXDoHMOhcwz/cxuR
        oBn5sRpOmclyp1TszQhOoeQ0qsyI9FxlC9r9S0Pb9k0r6vpzvQdhGkmPigcqrqVIhIoCrlDZ
        g4Ampd7iAv0uJc5QFBax6txUtSaH5XpQAC2Q+olvH5m+IsGZinz2BsvmseqDLUG7+WtR1Eg4
        WaQ/bu/0XQtZnjfF3nlQe3rBOi0aTE4y+pifxmmDI3yqGatFl6BdWcp55bYWrYlyeiXG1i5d
        zAtrVG2EznDiHVO7b2sNZ/PwnG3bUq+myz96BA6l/V6vFhX2hVyYc2A9Wx9fFHNVbiDuG5Xd
        +gVHTKwpoCuJXJmVSwVcliIqnFRzin8lRjrbRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7pdp+NjDeZf0LdYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFrvf32e0eNj0gclibut0dgcOj8NfN7N57Jx1l93j8tlSj0OHOxg9
        Dp47x+jxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsbtrU1sBRv8KxZ2fGZtYDxg08XIySEhYCLRfb2DsYuRi0NIYCmjxKEFP5i7GDmA
        EjISx9eXQdQIS/y51sUGUfOaUaJ98no2kISwQKDE91u3WUBsEQE5iY+tV8EGMQtsY5T4em06
        1NRWRomTXVcYQarYBKwkJravArN5BewkbmzdxgSyjUVAVaLxgC1IWFQgQuLM+xUsECWCEidn
        PgGzOQWMJPY0LGQGsZkF1CX+zLsEZYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmFpGUWkpYF
        jCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqNw27GfW3Ywdr0LPsQowMGoxMN7oisuVog1
        say4MvcQowQHs5IIb9lEoBBvSmJlVWpRfnxRaU5q8SFGU6DfJjJLiSbnAxNEXkm8oamhuYWl
        obmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxrggizl6AuzdG8KeJO1/aX4+Jpz3
        353jQb/Od3Xe/z/zc5XjyqxUkeNLy1SmOduHato/mR10+/+i6snT/0y0WdRpaqBVzRIuFf9B
        iUP/61bZgP0zzLp7Nft2dS3LuxbAKLRpg9k+5kn3zooXPFrxxlXqgMG8lXc6qk0T3F4pP1gh
        oOAmzWiZpMRSnJFoqMVcVJwIAOAdw8LYAgAA
X-CMS-MailID: 20190823111835eucas1p14df9d8867cdc9e8776e4653a061cb5b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190823104917epcas2p235985fff8eaa4b0822f1c056068ff2b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190823104917epcas2p235985fff8eaa4b0822f1c056068ff2b7
References: <CGME20190823104917epcas2p235985fff8eaa4b0822f1c056068ff2b7@epcas2p2.samsung.com>
        <20190823104911.6840-1-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/23/19 12:49 PM, Max Staudt wrote:
> Up until now, the pata_buddha driver would only check for cards on
> initcall time. Now, the kernel will call its probe function as soon
> as a compatible card is detected.
> 
> v7: Removed suppress_bind_attrs that slipped in
> 
> v6: Only do the drvdata workaround for X-Surf (remove breaks otherwise)
>     Style
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

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_buddha.c | 228 +++++++++++++++++++++++++++-------------------
>  1 file changed, 135 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
> index 11a8044ff..27d4c417f 100644
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
> @@ -145,111 +147,151 @@ static struct ata_port_operations pata_xsurf_ops = {
>  	.set_mode	= pata_buddha_set_mode,
>  };
>  
> -static int __init pata_buddha_init_one(void)
> +static int pata_buddha_probe(struct zorro_dev *z,
> +			     const struct zorro_device_id *ent)
>  {
> -	struct zorro_dev *z = NULL;
> +	static const char * const board_name[] = {
> +		"Buddha", "Catweasel", "X-Surf"
> +	};
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
> +	if (type == BOARD_XSURF)
> +		old_drvdata = dev_get_drvdata(&z->dev);
> +
> +	/* allocate host */
> +	host = ata_host_alloc(&z->dev, nr_ports);
> +	if (type == BOARD_XSURF)
> +		dev_set_drvdata(&z->dev, old_drvdata);
> +	if (!host)
> +		return -ENXIO;
> +
> +	buddha_board = ZTWO_VADDR(board);
> +
> +	/* enable the board IRQ on Buddha/Catweasel */
> +	if (type != BOARD_XSURF)
> +		z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
>  
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
> +	{ 0 }
> +};
> +MODULE_DEVICE_TABLE(zorro, pata_buddha_zorro_tbl);
> +
> +static struct zorro_driver pata_buddha_driver = {
> +	.name           = "pata_buddha",
> +	.id_table       = pata_buddha_zorro_tbl,
> +	.probe          = pata_buddha_probe,
> +	.remove         = pata_buddha_remove,
> +};
> +
> +/*
> + * We cannot have a modalias for X-Surf boards, as it competes with the
> + * zorro8390 network driver. As a stopgap measure until we have proper
> + * MFD support for this board, we manually attach to it late after Zorro
> + * has enumerated its boards.
> + */
> +static int __init pata_buddha_late_init(void)
> +{
> +	struct zorro_dev *z = NULL;
> +
> +	/* Auto-bind to regular boards */
> +	zorro_register_driver(&pata_buddha_driver);
> +
> +	/* Manually bind to all X-Surf boards */
> +	while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {
> +		static struct zorro_device_id xsurf_ent = {
> +			ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF
> +		};
> +
> +		pata_buddha_probe(z, &xsurf_ent);
> +	}
> +
> +	return 0;
> +}
> +late_initcall(pata_buddha_late_init);
>  
>  MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
>  MODULE_DESCRIPTION("low-level driver for Buddha/Catweasel/X-Surf PATA");
