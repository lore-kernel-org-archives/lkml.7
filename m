Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	TVD_RCVD_SPACE_BRACKET,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C89DC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314932146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfELQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 12:08:24 -0400
Received: from mutluit.com ([82.211.8.197]:52800 "EHLO mutluit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfELQIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 12:08:24 -0400
Received: from [127.0.0.1] (s2.mutluit.com [82.211.8.197]:40052)
        by mutluit.com (s2.mutluit.com [82.211.8.197]:50025) with ESMTP ([XMail 1.27 ESMTP Server])
        id <S16FACF4> for <linux-kernel@vger.kernel.org> from <um@mutluit.com>;
        Sun, 12 May 2019 12:08:19 -0400
Subject: Re: [RFC PATCH] drivers: ata: ahci_sunxi: Increased SATA/AHCI DMA
 TX/RX FIFOs
To:     Maxime Ripard <maxime.ripard@bootlin.com>
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
References: <20190510192550.17458-1-um@mutluit.com>
 <20190512121245.l3cvg4std6yanwix@flea>
From:   "U.Mutlu" <um@mutluit.com>
Organization: mutluit.com
Message-ID: <5CD844F3.5080103@mutluit.com>
Date:   Sun, 12 May 2019 18:08:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:40.0) Gecko/20100101
 Firefox/40.0 SeaMonkey/2.37a1
MIME-Version: 1.0
In-Reply-To: <20190512121245.l3cvg4std6yanwix@flea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime & Others,

what follows is a somewhat lengthy technical story behind this patch;
you can just skip it and jump to the end.


As can be seen in the ahci_sunxi.c, the port used in this patch
is this one (32bit):
   #define AHCI_P0DMACR    0x0170
It's a so called "Vendor Specific Port" according to the SATA/AHCI specs by Intel.
The data behind it is actually a struct, consisting of 4 fields,
each 4bits long, plus a 16bits long field that is marked as Reserved
in secondary literature (see below):

struct AHCI_P0DMACR_t
{
   unsigned TXTS  : 4,
            RXTS  : 4,
            TXABL : 4,
            RXABL : 4,
            Res1  : 16;
};

This struct is just my creation for my own tests as it's not part of the
driver source. The patch touches only the first 2 fields: TXTS and RXTS.

See this similar product documentation by Texas Instruments for the above struct:
https://www.ti.com/lit/ug/sprugj8c/sprugj8c.pdf
TMS320C674x/OMAP-L1x Processor, Serial ATA (SATA) Controller, User's Guide,
Literature Number: SPRUGJ8C, March 2011,
Page 68, Chapter 4.33 "Port DMA Control Register (P0DMACR)"

The above TI document describes the two fields as follows:

TXTS:
   Transmit Transaction Size (TX_TRANSACTION_SIZE). This field defines the DMA 
transaction size in
   DWORDs for transmit (system bus read, device write) operation. [...]

RXTS:
   Receive Transaction Size (RX_TRANSACTION_SIZE). This field defines the Port 
DMA transaction size
   in DWORDs for receive (system bus write, device read) operation. [...]


So, in my patch the fields TXTS and RXTS are set to 3 each.
Without the patch, these fields seem to have some random content
(I'vee seen 5 and 6, 4 and 4, and 0 and 0 on different devices),
as the previous code doesn't touch these 2 fields (ie. these two fields
are not within the used old mask of 0xff00; cf. ahci_sunxi.c, function 
ahci_sunxi_start_engine(...)).


Some background story in my hunt for obtaining product documentation:

I couldn't find any product documentation for the SATA/AHCI
in these SoCs by Allwinner Technology (allwinnertech.com),
unlike with such products from other such companies.

I asked Allwinner, but they just said that the A20 of my SBC
would (allegedly) no more be actual and that the support for it
has ended (but this statement somehow cannot be true as the
A20 SoC is still continued being marketed at their website).
They instead sent me a bunch of really irrelevant PDFs which have
nothing to do with SATA/AHCI.

So, the company Allwinner Technology unfortunately was not cooperative
to provide me information on their SATA/AHCI-implementation in their SoCs :-(
Even the ports used in the actual ahci_sunxi.c in the linux tree are undocumented;
it is even commented with "/* This magic is from the original code */"
and below it many ports are used for which no documentation is available,
or at least I couldn't find any on the Internet. And the initial programmer
in 2014 and prior was Daniel Wang (danielwang@allwinnertech.com),
but email to that address bounces.

So, I was forced to research secondary literature from other vendors
like Texas Instruments (thanks TI !) and Intel, and also studying
very old source codes in the old Linux repositories (as it differs
much from the current version) going back to the year 2014, and had
to do many (blind) experiments until I found this solution.

The above given User's Guide by Texas Instruments (and their such
documents for their newer such products) helped me much to find the solution.
It's of course not really the correct documentation for the Allwinner SoCs,
but still better than nothing.

If I only had the right documentation, then I for sure could try
to further improve that already achieved result by this patch,
as with SATA-II upto 300 MiB/s is possible.


Yes, I'll resend the patch with some appropriate comments.

Uenal Mutlu



Maxime Ripard wrote on 05/12/2019 02:12 PM:
> Hi,
>
> On Fri, May 10, 2019 at 09:25:50PM +0200, Uenal Mutlu wrote:
>> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS) from
>> default 0x0 each to 0x3 each gives a write performance boost of 120MB/s
>> from lame 36MB/s to 45MB/s previously. Read performance is about 200MB/s
>> [tested on SSD using dd bs=4K count=512K].
>>
>> Tested on the Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 SBCs
>> with Allwinner A20 32bit-SoCs (ARMv7-a / arm-linux-gnueabihf).
>> These devices are RaspberryPi-like small devices.
>>
>> RFC: Since more than about 25 similar SBC/SoC models do use the
>> ahci_sunxi driver, users are encouraged to test it on all the
>> affected boards and give feedback.
>>
>> List of the affected sunxi and other boards and SoCs with SATA using
>> the ahci_sunxi driver:
>>    $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
>>    and http://linux-sunxi.org/Category:Devices_with_SATA_port
>>
>> Signed-off-by: Uenal Mutlu <um@mutluit.com>
>> ---
>>   drivers/ata/ahci_sunxi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
>> index 911710643305..257986431c79 100644
>> --- a/drivers/ata/ahci_sunxi.c
>> +++ b/drivers/ata/ahci_sunxi.c
>> @@ -158,7 +158,7 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
>>   	struct ahci_host_priv *hpriv = ap->host->private_data;
>>
>>   	/* Setup DMA before DMA start */
>> -	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
>> +	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);
>
> Having comments / defines here would be great, once fixed:
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

