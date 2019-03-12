Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CE52147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfCLJFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:05:23 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:48294 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfCLJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:05:23 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 12 Mar
 2019 17:06:18 +0800
Subject: Re: [RFC PATCH nand-next 0/2] meson-nand: support for older SoCs
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <jianxin.pan@amlogic.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
 <98776767-c4d7-1207-6d42-97105f289bec@amlogic.com>
 <CAFBinCC7P40sqrDGTuM8M=jVOFTgZLDUK6rGdNpigFoepyCASw@mail.gmail.com>
 <20190307140959.10092d45@xps13>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <ccb95e75-e62f-c510-cabd-853481f77fc8@amlogic.com>
Date:   Tue, 12 Mar 2019 17:06:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190307140959.10092d45@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.125]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin and Miquel,

On 2019/3/7 21:09, Miquel Raynal wrote:
> Hello,
> 
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote on Tue,
> 5 Mar 2019 23:12:51 +0100:
> 
>> Hi Liang,
>>
>> On Mon, Mar 4, 2019 at 5:55 AM Liang Yang <liang.yang@amlogic.com> wrote:
>>>
>>> Hello Martin,
>>>
>>> On 2019/3/2 2:29, Martin Blumenstingl wrote:
>>>> Hi Liang,
>>>>
>>>> I am trying to add support for older SoCs to the meson-nand driver.
>>>> Back when the driver was in development I used an early revision (of
>>>> your driver) and did some modifications to make it work on older SoCs.
>>>>
>>>> Now that the driver is upstream I wanted to give it another try and
>>>> make a real patch out of it. Unfortunately it's not working anymore.
>>>>
>>>> As far as I know the NFC IP block revision on GXL is similar (or even
>>>> the same?) as on all older SoCs. As far as I can tell only the clock
>>>> setup is different on the older SoCs (which have a dedicated NAND
>>>> clock):
>>>> - we don't need the "amlogic,mmc-syscon" property on the older SoCs
>>>>     because we don't need to setup any muxing (common clock framework
>>>>     will do everything for us)
>>>> - "rx" and "tx" clocks don't exist
>>>> - I could not find any other differences between Meson8, Meson8b,
>>>>     Meson8m2, GXBB and GXL
>>>>   
>>> That is right. the serials NFC is almost the same except:
>>> 1) The clock control and source that M8-serials are not share with EMMC.
>>> 2) The base register address
>>> 3) DMA encryption option which we don't care on NFC driver.
>> great, thank you for confirming this!
>>
>>>> In this series I'm sending two patches which add support for the older
>>>> SoCs.
>>>>
>>>> Unfortunately these patches are currently not working for me (hence the
>>>> "RFC" prefix). I get a (strange) crash which is triggered by the
>>>> kzalloc() in meson_nfc_read_buf() - see below for more details.
>>>>
>>>> Can you please help me on this one? I'd like to know whether:
>>>> - the meson-nand driver works for you on GXL or AXG on linux-next?
>>>>     (I was running these patches on top of next-20190301 on my M8S
>>>>     board which uses a 32-bit Meson8m2 SoC. I don't have any board using
>>>>     a GXL SoC which also has NAND)
>>> Yes, it works on AXG platform using a MXIC slc nand flash(MX30LF4G); but
>>> i an not sure it runs the same flow with yours. because i see the print
>>> "Counld not find a valid ONFI parameter page, ...." in yours. i will try
>>> to reproduce it on AXG(i don't have a M8 platform now).
>> I'm looking forward to hear about the test results on your AXG boards
>> for reference: my board has a SK Hynix H27UCG8T2B (ID bytes: 0xad 0xde
>> 0x94 0xeb 0x74 0x44, 20nm MLC)
>> I have another board (where I haven't tested the NFC driver yet) with
>> a SK Hynix H27UCG8T2E (ID bytes: 0xad 0xde 0x14 0xa7 0x42 0x4a, 1Ynm
>> MLC). if it helps with your analysis I can test on that board as well
> 
> Liang, you just have to fake the output of the ONFI page detection and
> you will probably run into this error which will then be easy to
> reproduce.
> 
i don't reproduce it by using a SK Hynix nand flash H27UCG8T2E on gxl 
platform. it runs well.
[......]
[    0.977127] loop: module loaded
[    0.998625] Could not find a valid ONFI parameter page, trying 
bit-wise majority to recover it
[    1.001619] ONFI parameter recovery failed, aborting
[    1.006684] Could not find valid JEDEC parameter page; aborting
[    1.012391] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xde
[    1.018660] nand: Hynix NAND 8GiB 3,3V 8-bit
[    1.022885] nand: 8192 MiB, MLC, erase size: 4096 KiB, page size: 
16384, OOB size: 1664
[    1.047033] Bad block table not found for chip 0
[    1.054950] Bad block table not found for chip 0
[    1.054970] Scanning device for bad blocks
[    1.522664] random: fast init done
[    4.893731] Bad eraseblock 1985 at 0x0001f07fc000
[    5.020637] Bad block table written to 0x0001ffc00000, version 0x01
[    5.028258] Bad block table written to 0x0001ff800000, version 0x01
[    5.029905] 5 fixed-partitions partitions found on MTD device 
d0074800.nfc
[    5.035714] Creating 5 MTD partitions on "d0074800.nfc":
[......]

Martin, Now i am not sure whether NFC driver leads to kernel panic when
calling kmem_cache_alloc_trace.

> .
> 
