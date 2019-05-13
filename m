Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63558C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3590221019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfEMHow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:44:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34193 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfEMHov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:44:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so16182005eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lK59c9/NQKUYHMzx6IhpTBWSV/2wPVZROlh8D68u+Fs=;
        b=Wla+feUP3vva4/r23rCo2BDt3H0aYVJgS8yT2oXsX/ZEoDQVToHwXMZkjxXDPemHmx
         5Ggkzt8j7W03GfcQa3rUrFsBi3kN0164gSq3+0rd1rzQ5yihaXHhV+0yQ4l5VB1rcrXN
         NmkTRIcSCNzIrgL0PX7Agh3N3RkBHLSLO8O/sx3IOrnrwEX5oBfce7lcnxEdeDpQEQwx
         whAYATzGo6ZQOG/ceJNQpbgFVhMm0MRzgiijgPBMrVbVE1NPyAi4DcFz189v2rz+Gvar
         /sndfQVpCbg66VpbJP68UalszSlZ8xPyYhtNJ9YFAUj6nSLjrXb8Mra5twlKwHLtM7tT
         T0Ug==
X-Gm-Message-State: APjAAAVroTC5P1xFi4FOOQLulwQkPrn6VMIdu1IYgT79sXRxtk+nxqSg
        69hxKZ7hJY6kJn8kF7n+y69EVg==
X-Google-Smtp-Source: APXvYqxMhreLvOcLIPKDGLO37Uc6pgRaPn7s70HkaX9M/+QJuQVNJhzIXqg6i8G36h95UtMtb6CfZg==
X-Received: by 2002:a50:cb4d:: with SMTP id h13mr28042035edi.110.1557733488614;
        Mon, 13 May 2019 00:44:48 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id o3sm1681376ejb.71.2019.05.13.00.44.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 00:44:47 -0700 (PDT)
Subject: Re: [RFC PATCH v2 RESEND] drivers: ata: ahci_sunxi: Increased
 SATA/AHCI DMA TX/RX FIFOs
To:     Uenal Mutlu <um@mutluit.com>, Jens Axboe <axboe@kernel.dk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Schinagl <oliver@schinagl.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        FUKAUMI Naoki <naobsd@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>
References: <20190512205954.18435-1-um@mutluit.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <413dcf9f-25a5-61f5-159f-a75e7b1f1522@redhat.com>
Date:   Mon, 13 May 2019 09:44:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512205954.18435-1-um@mutluit.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-05-19 22:59, Uenal Mutlu wrote:
> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS, ie.
> TX_TRANSACTION_SIZE and RX_TRANSACTION_SIZE) from default 0x0 each
> to 0x3 each, gives a write performance boost of 120 MiB/s to 132 MiB/s
> from lame 36 MiB/s to 45 MiB/s previously.
> Read performance is about 200 MiB/s.
> [tested on SSD using dd bs=2K/4K/8K/12K/16K/24K/32K: peak-perf at 12K].
> 
> Tested on the Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 SBCs
> with Allwinner A20 32bit-SoCs (ARMv7-a / arm-linux-gnueabihf).
> These devices are RaspberryPi-like small devices.
> 
> This problem of slow SATA write-speed with these small devices lasts now
> for more than 5 years. Many commentators throughout the years wrongly
> assumed the slow write speed was a hardware limitation. This patch finally
> solves the problem, which in fact was just a hard-to-fix software problem
> (b/c of lack of documentation by the SoC-maker Allwinner Technology).
> 
> RFC: Since more than about 25 similar SBC/SoC models do use the
> ahci_sunxi driver, users are encouraged to test it on all the
> affected boards and give feedback

The SATA controller on these boards is inside the A10/A20 SoC, the
A10 and A20 use the same controller, so it is the same on all the boards.

IOW I don't see this only being tested on 1 board as a reason for the patch
to be RFC.

> Lists of the affected sunxi and other boards and SoCs with SATA using
> the ahci_sunxi driver:
>    $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
>    and http://linux-sunxi.org/SATA#Devices_with_SATA_ports
>    See also http://linux-sunxi.org/Category:Devices_with_SATA_port
> 
> Patch v2:
>    - Commented the patch in-place in ahci_sunxi.c
>    - With bs=12K and no conv=... passed to dd, the write performance
>      rises further to 132 MiB/s
>    - Changed MB/s to MiB/s
>    - Posted the story behind the patch:
>      http://lkml.iu.edu/hypermail/linux/kernel/1905.1/03506.html
>    - Posted a dd test script to find optimal bs, and some results:
>      https://bit.ly/2YoOzEM
> 
> Patch v1:
>    - States bs=4K for dd and a write performance of 120 MiB/s
> 
> Signed-off-by: Uenal Mutlu <um@mutluit.com>
> ---
>   drivers/ata/ahci_sunxi.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
> index 911710643305..ed19f19808c5 100644
> --- a/drivers/ata/ahci_sunxi.c
> +++ b/drivers/ata/ahci_sunxi.c
> @@ -157,8 +157,51 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
>   	void __iomem *port_mmio = ahci_port_base(ap);
>   	struct ahci_host_priv *hpriv = ap->host->private_data;
>   
> -	/* Setup DMA before DMA start */
> -	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
> +	/* Setup DMA before DMA start
> +	 *
> +	 * NOTE: A similar SoC with SATA/AHCI by Texas Instruments documents
> +	 *   this Vendor Specific Port (P0DMACR, aka PxDMACR) in its
> +	 *   User's Guide document (TMS320C674x/OMAP-L1x Processor
> +	 *   Serial ATA (SATA) Controller, Literature Number: SPRUGJ8C,
> +	 *   March 2011, Chapter 4.33 Port DMA Control Register (P0DMACR),
> +	 *   p.68, https://www.ti.com/lit/ug/sprugj8c/sprugj8c.pdf)
> +	 *   as equivalent to the following struct:
> +	 *
> +	 *   struct AHCI_P0DMACR_t
> +	 *     {
> +	 *       unsigned TXTS     : 4,
> +	 *                RXTS     : 4,
> +	 *                TXABL    : 4,
> +	 *                RXABL    : 4,
> +	 *                Reserved : 16;
> +	 *     };
> +	 *
> +	 *   TXTS: Transmit Transaction Size (TX_TRANSACTION_SIZE).
> +	 *     This field defines the DMA transaction size in DWORDs for
> +	 *     transmit (system bus read, device write) operation. [...]
> +	 *
> +	 *   RXTS: Receive Transaction Size (RX_TRANSACTION_SIZE).
> +	 *     This field defines the Port DMA transaction size in DWORDs
> +	 *     for receive (system bus write, device read) operation. [...]
> +	 *
> +	 *   TXABL: Transmit Burst Limit.
> +	 *     This field allows software to limit the VBUSP master read
> +	 *     burst size. [...]
> +	 *
> +	 *   RXABL: Receive Burst Limit.
> +	 *     Allows software to limit the VBUSP master write burst
> +	 *     size. [...]
> +	 *
> +	 *   Reserved: Reserved.
> +	 *
> +	 *
> +	 * NOTE: According to the above document, the following alternative
> +	 *   to the code below could perhaps be a better option
> +	 *   (or preparation) for possible further improvements later:
> +	 *     sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff,
> +	 *		0x00000033);
> +	 */
> +	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);

Have you tried / benchmarked the 0x00000033 option?

Regards,

Hans

