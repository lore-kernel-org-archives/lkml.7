Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,TVD_RCVD_SPACE_BRACKET,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD19AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5948208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfEMLU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:20:57 -0400
Received: from mutluit.com ([82.211.8.197]:36258 "EHLO mutluit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfEMLU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:20:56 -0400
Received: from [127.0.0.1] (s2.mutluit.com [82.211.8.197]:51448)
        by mutluit.com (s2.mutluit.com [82.211.8.197]:50025) with ESMTP ([XMail 1.27 ESMTP Server])
        id <S16FAD52> for <linux-kernel@vger.kernel.org> from <um@mutluit.com>;
        Mon, 13 May 2019 07:20:52 -0400
Subject: Re: [RFC PATCH v2 RESEND] drivers: ata: ahci_sunxi: Increased
 SATA/AHCI DMA TX/RX FIFOs
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Chen-Yu Tsai <wens@csie.org>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Schinagl <oliver@schinagl.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        FUKAUMI Naoki <naobsd@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>
References: <20190512205954.18435-1-um@mutluit.com>
 <20190513095916.yyjdtueeefkf4v4b@flea>
From:   "U.Mutlu" <um@mutluit.com>
Organization: mutluit.com
Message-ID: <5CD95314.4060307@mutluit.com>
Date:   Mon, 13 May 2019 13:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:40.0) Gecko/20100101
 Firefox/40.0 SeaMonkey/2.37a1
MIME-Version: 1.0
In-Reply-To: <20190513095916.yyjdtueeefkf4v4b@flea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard wrote on 05/13/2019 11:59 AM:
> On Sun, May 12, 2019 at 10:59:54PM +0200, Uenal Mutlu wrote:
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
>> affected boards and give feedback.
>>
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
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thx!

> Just a minor nitpick though, the part starting with RFC: and with the
> version changelog should be after the --- below so that it doesn't get
> applied as part of the commit log.

Ok, I'll do it better in the future.
Thx again.


> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

