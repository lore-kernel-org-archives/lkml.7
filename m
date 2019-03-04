Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB07C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4D52082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfCDE50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:57:26 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:54811 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCDE50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:57:26 -0500
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 4 Mar
 2019 12:56:42 +0800
Subject: Re: [RFC PATCH nand-next 0/2] meson-nand: support for older SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jianxin.pan@amlogic.com>
References: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <98776767-c4d7-1207-6d42-97105f289bec@amlogic.com>
Date:   Mon, 4 Mar 2019 12:56:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
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

Hello Martin,

On 2019/3/2 2:29, Martin Blumenstingl wrote:
> Hi Liang,
> 
> I am trying to add support for older SoCs to the meson-nand driver.
> Back when the driver was in development I used an early revision (of
> your driver) and did some modifications to make it work on older SoCs.
> 
> Now that the driver is upstream I wanted to give it another try and
> make a real patch out of it. Unfortunately it's not working anymore.
> 
> As far as I know the NFC IP block revision on GXL is similar (or even
> the same?) as on all older SoCs. As far as I can tell only the clock
> setup is different on the older SoCs (which have a dedicated NAND
> clock):
> - we don't need the "amlogic,mmc-syscon" property on the older SoCs
>    because we don't need to setup any muxing (common clock framework
>    will do everything for us)
> - "rx" and "tx" clocks don't exist
> - I could not find any other differences between Meson8, Meson8b,
>    Meson8m2, GXBB and GXL
> 
That is right. the serials NFC is almost the same except:
1) The clock control and source that M8-serials are not share with EMMC.
2) The base register address
3) DMA encryption option which we don't care on NFC driver.

> In this series I'm sending two patches which add support for the older
> SoCs.
> 
> Unfortunately these patches are currently not working for me (hence the
> "RFC" prefix). I get a (strange) crash which is triggered by the
> kzalloc() in meson_nfc_read_buf() - see below for more details.
> 
> Can you please help me on this one? I'd like to know whether:
> - the meson-nand driver works for you on GXL or AXG on linux-next?
>    (I was running these patches on top of next-20190301 on my M8S
>    board which uses a 32-bit Meson8m2 SoC. I don't have any board using
>    a GXL SoC which also has NAND)
Yes, it works on AXG platform using a MXIC slc nand flash(MX30LF4G); but 
i an not sure it runs the same flow with yours. because i see the print 
"Counld not find a valid ONFI parameter page, ...." in yours. i will try 
to reproduce it on AXG(i don't have a M8 platform now).

> - you see any issue with my patches? (maybe I missed more differences
>    between GXL and the older SoCs)
> 
i think it is ok now.
> 
> kernel log extract:
> [...]
> Could not find a valid ONFI parameter page, trying bit-wise majority to recover it
> ONFI parameter recovery failed, aborting
> Unable to handle kernel paging request at virtual address 80110000
> pgd = (ptrval)
> [80110000] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc8-next-20190301-00053-g50ac6f7757e2 #4145
> Hardware name: Amlogic Meson platform
> PC is at kmem_cache_alloc_trace+0xc8/0x268
> LR is at kmem_cache_alloc_trace+0x2c/0x268
> pc : [<c046479c>]    lr : [<c0464700>]    psr: 60000013
> sp : c02adc58  ip : e9e7a440  fp : 00004ee2
> r10: 80110000  r9 : ffffe000  r8 : c110918c
> r7 : 00000008  r6 : c08967c0  r5 : 00000dc0  r4 : c0201e40
> r3 : c109dd30  r2 : 00000000  r1 : 00004ee2  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 0020404a  DAC: 00000051
> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> Stack: (0xc02adc58 to 0xc02ae000)
> dc40:                                                       e9d84048 00000003
> dc60: e9e7a440 c02add18 00000028 e9e68680 c02adcf0 00000003 e9d84048 00000002
> dc80: e9e7a440 c08967c0 c1108cb4 c02adcdc 10624dd3 c02adce4 10624dd3 00000005
> dca0: e9e7a440 c0f5c310 00000028 c0f09998 00000005 e9d84048 00000005 c02add57
> dcc0: c1108c88 e9e7a440 c02adcf0 e9d84428 e9d843b0 c0882258 000000ff 40000000
> dce0: c02adce8 00000000 c02adcf0 00000003 00000000 00000090 00000000 00000000
> dd00: 00000000 00000001 00000001 c02adcdf 00000000 00000190 00000002 00000005
> dd20: c02add57 00000001 00000000 a10a1ef7 00000000 c1108c88 c1180250 e9d843c0
> dd40: 00000001 000000de 00000000 c088d114 c0f08db4 00d843c0 00000000 a10a1ef7
> dd60: 00000015 e9d84048 c1108c88 c088d470 e9d84048 c08888b4 00000000 60000013
> dd80: c0eebc9c 000000ad c0da01ac 00000000 e9e7a48c c0cc6d50 c12122cc a10a1ef7
> dda0: e9e7a440 e9e7a440 e9d84040 c0eebc9c e987f410 eafd6748 e9d84048 c1108c88
> ddc0: e9e7a48c c0895c70 00000000 e9871f00 e9e7a440 c04eef60 00000000 eafd64bc
> dde0: e9e7a534 00000000 00000000 00000000 00000001 a10a1ef7 00000000 e987f410
> de00: 00000000 c1180728 00000000 00000000 c1180728 00000000 c1071854 c07fd388
> de20: c120da38 e987f410 c120da3c 00000000 00000000 c07fb410 e987f410 c1180728
> de40: c1180728 c07fb910 00000000 c1071834 c10004a8 c07fb65c c10004a8 c0a917b4
> de60: c0da1914 e987f410 00000000 c1180728 c07fb910 00000000 c1071834 c10004a8
> de80: c1071854 c07fb908 00000000 c1180728 e987f410 c07fb968 e98b8eb4 c1108c88
> dea0: c1180728 c07f97d4 c1175260 c029a958 e98b8eb4 a10a1ef7 c029a96c c1180728
> dec0: e9e1fa80 c1175260 00000000 c07fa844 c0f09c64 c1108c88 ffffe000 c1180728
> dee0: c1108c88 ffffe000 c103b788 c07fc494 c11c2ca0 c1108c88 ffffe000 c0302f1c
> df00: ebfffd96 c0346f90 c0fab8a0 c0f2ad00 00000000 00000006 00000006 c0e9e26c
> df20: 00000000 c1108c88 c0eb11b0 c0e9e2e0 c11d1300 ebfffd84 ebfffd89 a10a1ef7
> df40: c1071838 c11c2ca0 c10914b8 a10a1ef7 c11c2ca0 c1091804 00000007 c11d1300
> df60: c11d1300 c1001180 00000006 00000006 00000000 c10004a8 0000013d 00000000
> df80: c02c0504 00000000 c0cbf6e8 00000000 00000000 00000000 00000000 00000000
> dfa0: 00000000 c0cbf6f0 00000000 c03010e8 00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [<c046479c>] (kmem_cache_alloc_trace) from [<c08967c0>] (meson_nfc_exec_op+0x2c4/0x3e8)
> [<c08967c0>] (meson_nfc_exec_op) from [<c0882258>] (nand_readid_op+0x128/0x1c4)
> [<c0882258>] (nand_readid_op) from [<c088d114>] (hynix_nand_has_valid_jedecid+0x34/0x78)
> [<c088d114>] (hynix_nand_has_valid_jedecid) from [<c088d470>] (hynix_nand_decode_id+0x64/0x3fc)
> [<c088d470>] (hynix_nand_decode_id) from [<c08888b4>] (nand_scan_with_ids+0xa04/0x171c)
> [<c08888b4>] (nand_scan_with_ids) from [<c0895c70>] (meson_nfc_probe+0x460/0x690)
> [<c0895c70>] (meson_nfc_probe) from [<c07fd388>] (platform_drv_probe+0x48/0x98)
> [<c07fd388>] (platform_drv_probe) from [<c07fb410>] (really_probe+0x1e0/0x2cc)
> [<c07fb410>] (really_probe) from [<c07fb65c>] (driver_probe_device+0x60/0x16c)
> [<c07fb65c>] (driver_probe_device) from [<c07fb908>] (device_driver_attach+0x58/0x60)
> [<c07fb908>] (device_driver_attach) from [<c07fb968>] (__driver_attach+0x58/0xcc)
> [<c07fb968>] (__driver_attach) from [<c07f97d4>] (bus_for_each_dev+0x74/0xb4)
> [<c07f97d4>] (bus_for_each_dev) from [<c07fa844>] (bus_add_driver+0x1b8/0x1d8)
> [<c07fa844>] (bus_add_driver) from [<c07fc494>] (driver_register+0x74/0x108)
> [<c07fc494>] (driver_register) from [<c0302f1c>] (do_one_initcall+0x54/0x284)
> [<c0302f1c>] (do_one_initcall) from [<c1001180>] (kernel_init_freeable+0x2d4/0x36c)
> [<c1001180>] (kernel_init_freeable) from [<c0cbf6f0>] (kernel_init+0x8/0x110)
> [<c0cbf6f0>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xc02adfb0 to 0xc02adff8)
> dfa0:                                     00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: e5943000 e5942014 e3130007 1a000038 (e79ae002)
> ---[ end trace 28d391ed14b0f021 ]---
> 
> 
> Martin Blumenstingl (2):
>    dt-bindings: nand: meson: add support for more SoCs
>    mtd: rawnand: meson: support for older SoCs up to Meson8
> 
>   .../bindings/mtd/amlogic,meson-nand.txt       | 14 ++++--
>   drivers/mtd/nand/raw/meson_nand.c             | 46 +++++++++++++------
>   2 files changed, 42 insertions(+), 18 deletions(-)
> 
