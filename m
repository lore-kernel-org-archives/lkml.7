Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	TVD_RCVD_SPACE_BRACKET autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F5EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B0E208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfEMKe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:34:56 -0400
Received: from mutluit.com ([82.211.8.197]:56846 "EHLO mutluit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfEMKe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:34:56 -0400
Received: from [127.0.0.1] (s2.mutluit.com [82.211.8.197]:43978)
        by mutluit.com (s2.mutluit.com [82.211.8.197]:50025) with ESMTP ([XMail 1.27 ESMTP Server])
        id <S16FAD46> for <linux-kernel@vger.kernel.org> from <um@mutluit.com>;
        Mon, 13 May 2019 06:34:52 -0400
Subject: Re: [RFC PATCH v2 RESEND] drivers: ata: ahci_sunxi: Increased
 SATA/AHCI DMA TX/RX FIFOs
To:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
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
 <413dcf9f-25a5-61f5-159f-a75e7b1f1522@redhat.com>
From:   "U.Mutlu" <um@mutluit.com>
Organization: mutluit.com
Message-ID: <5CD94848.3090407@mutluit.com>
Date:   Mon, 13 May 2019 12:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:40.0) Gecko/20100101
 Firefox/40.0 SeaMonkey/2.37a1
MIME-Version: 1.0
In-Reply-To: <413dcf9f-25a5-61f5-159f-a75e7b1f1522@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans de Goede wrote on 05/13/2019 09:44 AM:
> On 12-05-19 22:59, Uenal Mutlu wrote:
>> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS, ie.
>> TX_TRANSACTION_SIZE and RX_TRANSACTION_SIZE) from default 0x0 each
>> to 0x3 each, gives a write performance boost of 120 MiB/s to 132 MiB/s
>> from lame 36 MiB/s to 45 MiB/s previously.
>> Read performance is about 200 MiB/s.
>> [tested on SSD using dd bs=2K/4K/8K/12K/16K/24K/32K: peak-perf at 12K].
>>
>> Tested on the Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 SBCs
>> with Allwinner A20 32bit-SoCs (ARMv7-a / arm-linux-gnueabihf).
>> These devices are RaspberryPi-like small devices.
>>
>> This problem of slow SATA write-speed with these small devices lasts now
>> for more than 5 years. Many commentators throughout the years wrongly
>> assumed the slow write speed was a hardware limitation. This patch finally
>> solves the problem, which in fact was just a hard-to-fix software problem
>> (b/c of lack of documentation by the SoC-maker Allwinner Technology).
>>
>> RFC: Since more than about 25 similar SBC/SoC models do use the
>> ahci_sunxi driver, users are encouraged to test it on all the
>> affected boards and give feedback
>
> The SATA controller on these boards is inside the A10/A20 SoC, the
> A10 and A20 use the same controller, so it is the same on all the boards.

Ok, thanks for the clarification.
This fact of course simplifies the whole issue.

> IOW I don't see this only being tested on 1 board as a reason for the patch
> to be RFC.

I just wanted to be on the safe side :-) since I personally
have only 2 of the 25+ affected systems here for testing.
But I now understand that if it works on the tested two
A20 systems, then it normally should work on all of the
affected different boards/models as they all are using
the same SATA/AHCI-IP-Core, much like you also stated.

But of course I still wouldn't like it if someone loses data
and possibly blames my patch or even me myself, as the issue
is indeed a sensitive one where data loss (corruption of the
filesystem, partition, or the partition table) can indeed happen.
To be honest, it happened to me during my experiments with
some wrong, too high, values.
But I think the current version is mature and stable.

>> Lists of the affected sunxi and other boards and SoCs with SATA using
>> the ahci_sunxi driver:
>>    $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
>>    and http://linux-sunxi.org/SATA#Devices_with_SATA_ports
>>    See also http://linux-sunxi.org/Category:Devices_with_SATA_port
>>
>> Patch v2:
>>    - Commented the patch in-place in ahci_sunxi.c
>>    - With bs=12K and no conv=... passed to dd, the write performance
>>      rises further to 132 MiB/s
>>    - Changed MB/s to MiB/s
>>    - Posted the story behind the patch:
>>      http://lkml.iu.edu/hypermail/linux/kernel/1905.1/03506.html
>>    - Posted a dd test script to find optimal bs, and some results:
>>      https://bit.ly/2YoOzEM
>>
>> Patch v1:
>>    - States bs=4K for dd and a write performance of 120 MiB/s
>>
>> Signed-off-by: Uenal Mutlu <um@mutluit.com>
>> ---
>>   drivers/ata/ahci_sunxi.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
>> index 911710643305..ed19f19808c5 100644
>> --- a/drivers/ata/ahci_sunxi.c
>> +++ b/drivers/ata/ahci_sunxi.c
>> @@ -157,8 +157,51 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
>>       void __iomem *port_mmio = ahci_port_base(ap);
>>       struct ahci_host_priv *hpriv = ap->host->private_data;
>> -    /* Setup DMA before DMA start */
>> -    sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
>> +    /* Setup DMA before DMA start
>> +     *
>> +     * NOTE: A similar SoC with SATA/AHCI by Texas Instruments documents
>> +     *   this Vendor Specific Port (P0DMACR, aka PxDMACR) in its
>> +     *   User's Guide document (TMS320C674x/OMAP-L1x Processor
>> +     *   Serial ATA (SATA) Controller, Literature Number: SPRUGJ8C,
>> +     *   March 2011, Chapter 4.33 Port DMA Control Register (P0DMACR),
>> +     *   p.68, https://www.ti.com/lit/ug/sprugj8c/sprugj8c.pdf)
>> +     *   as equivalent to the following struct:
>> +     *
>> +     *   struct AHCI_P0DMACR_t
>> +     *     {
>> +     *       unsigned TXTS     : 4,
>> +     *                RXTS     : 4,
>> +     *                TXABL    : 4,
>> +     *                RXABL    : 4,
>> +     *                Reserved : 16;
>> +     *     };
>> +     *
>> +     *   TXTS: Transmit Transaction Size (TX_TRANSACTION_SIZE).
>> +     *     This field defines the DMA transaction size in DWORDs for
>> +     *     transmit (system bus read, device write) operation. [...]
>> +     *
>> +     *   RXTS: Receive Transaction Size (RX_TRANSACTION_SIZE).
>> +     *     This field defines the Port DMA transaction size in DWORDs
>> +     *     for receive (system bus write, device read) operation. [...]
>> +     *
>> +     *   TXABL: Transmit Burst Limit.
>> +     *     This field allows software to limit the VBUSP master read
>> +     *     burst size. [...]
>> +     *
>> +     *   RXABL: Receive Burst Limit.
>> +     *     Allows software to limit the VBUSP master write burst
>> +     *     size. [...]
>> +     *
>> +     *   Reserved: Reserved.
>> +     *
>> +     *
>> +     * NOTE: According to the above document, the following alternative
>> +     *   to the code below could perhaps be a better option
>> +     *   (or preparation) for possible further improvements later:
>> +     *     sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff,
>> +     *        0x00000033);
>> +     */
>> +    sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);
>
> Have you tried / benchmarked the 0x00000033 option?

Yes, I did, but not that extensively yet. So far I couldn't see any
difference in the outcome.
There is in the TI doc just the following statement regarding this:

"Note that programming a burst size of greater than a transaction size,
while not invalid, is meaningless because the DMA maximizes out at
transaction size." (Ch. 3.4 DMA, p.15 in the TI doc).

I understand this as a neutral statement, ie. it doesn't hurt or make
any difference in practice if one sets TXABL effectively higher than
TXTS and/or RXABL effectively higher than RXTS,
FYI: these value are just some index-values, ie. index-value x means real value y.
0 for TXABL and/or RXABL means "Limit VBUSP burst size to 256 DWORDS",
ie. to the highest possible value for Transmit Burst Limit (TXABL) and
Receive Burst Limit (RXABL), respectively.

I'll test this alternative version now extensively in my test series.

But I could need an advice on what step I should take next in this
issue regarding getting the patch merged into the mainline kernel.
Shall I post a v3 of the patch with RFC removed, some more comments
added, and switching to the above alternative function argument
together with its test results, or shall I do these additions only
after the current version has already been merged into the kernel?
[actually I'm now unsure if patches with "RFC" flag ever get merged :-].

Thx.

> Regards,
>
> Hans

