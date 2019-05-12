Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF00C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0C220C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfELMMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 08:12:54 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46659 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 08:12:53 -0400
X-Originating-IP: 109.190.253.16
Received: from localhost (unknown [109.190.253.16])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2A98E1C0004;
        Sun, 12 May 2019 12:12:46 +0000 (UTC)
Date:   Sun, 12 May 2019 14:12:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Uenal Mutlu <um@mutluit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Chen-Yu Tsai <wens@csie.org>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Schinagl <oliver@schinagl.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        FUKAUMI Naoki <naobsd@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [RFC PATCH] drivers: ata: ahci_sunxi: Increased SATA/AHCI DMA
 TX/RX FIFOs
Message-ID: <20190512121245.l3cvg4std6yanwix@flea>
References: <20190510192550.17458-1-um@mutluit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510192550.17458-1-um@mutluit.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 10, 2019 at 09:25:50PM +0200, Uenal Mutlu wrote:
> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS) from
> default 0x0 each to 0x3 each gives a write performance boost of 120MB/s
> from lame 36MB/s to 45MB/s previously. Read performance is about 200MB/s
> [tested on SSD using dd bs=4K count=512K].
>
> Tested on the Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 SBCs
> with Allwinner A20 32bit-SoCs (ARMv7-a / arm-linux-gnueabihf).
> These devices are RaspberryPi-like small devices.
>
> RFC: Since more than about 25 similar SBC/SoC models do use the
> ahci_sunxi driver, users are encouraged to test it on all the
> affected boards and give feedback.
>
> List of the affected sunxi and other boards and SoCs with SATA using
> the ahci_sunxi driver:
>   $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
>   and http://linux-sunxi.org/Category:Devices_with_SATA_port
>
> Signed-off-by: Uenal Mutlu <um@mutluit.com>
> ---
>  drivers/ata/ahci_sunxi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
> index 911710643305..257986431c79 100644
> --- a/drivers/ata/ahci_sunxi.c
> +++ b/drivers/ata/ahci_sunxi.c
> @@ -158,7 +158,7 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
>  	struct ahci_host_priv *hpriv = ap->host->private_data;
>
>  	/* Setup DMA before DMA start */
> -	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
> +	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);

Having comments / defines here would be great, once fixed:
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
