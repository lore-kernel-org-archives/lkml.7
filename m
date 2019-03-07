Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3493FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D15F20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCGNfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:35:44 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:16206 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:35:43 -0500
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 7 Mar
 2019 21:36:37 +0800
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
Message-ID: <c507cbf2-5b68-7ac1-dd5d-75df2fe8407c@amlogic.com>
Date:   Thu, 7 Mar 2019 21:36:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307140959.10092d45@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.18.125]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

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

I have tested it on AXG platform; I find MX30LF4G also enter this flow , 
but it doesn't crash. log as follow:
[    1.018056] Could not find a valid ONFI parameter page, trying 
bit-wise majority to recover it
[    1.021057] ONFI parameter recovery failed, aborting
[    1.025966] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
[    1.032237] nand: Macronix NAND 512MiB 3,3V 8-bit
[    1.036889] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, 
OOB size: 64
[    1.045741] Bad block table not found for chip 0
[    1.050077] Bad block table not found for chip 0
[    1.053538] Scanning device for bad blocks
[    1.069094] Bad eraseblock 20 at 0x000000280000
[    1.071074] Bad eraseblock 24 at 0x000000300000
[    1.127494] random: fast init done
[    1.348754] Bad eraseblock 519 at 0x0000040e0000
[    1.632819] Bad eraseblock 1028 at 0x000008080000
[    2.405420] Bad eraseblock 2411 at 0x000012d60000
[    3.349276] Bad block table written to 0x00001ffe0000, version 0x01
[    3.350967] Bad block table written to 0x00001ffc0000, version 0x01
[    3.356429] 5 fixed-partitions partitions found on MTD device 
ffe07800.nfc
[    3.362925] Creating 5 MTD partitions on "ffe07800.nfc":
[    3.368188] 0x000000000000-0x000000200000 : "boot"
[    3.373970] 0x000000200000-0x000000600000 : "env"
[    3.378564] 0x000000600000-0x000001000000 : "system"
[    3.383511] 0x000001000000-0x000004000000 : "rootfs"
[    3.388525] 0x000004000000-0x00000c000000 : "media"

I am looking forward to a Hynix nand flash to test on GXL platform, and 
there should be something different from MXIC flash on ONFI page 
detection. I will update the result asap net week.
Do you have another type of nand flash to test on M8 platform ?
> 
> Thanks,
> Miquèl
> 
> .
> 
