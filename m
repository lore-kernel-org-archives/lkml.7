Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03417C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 07:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2F120840
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 07:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VZl7Z6L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFWHEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 03:04:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38216 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFWHEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 03:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561273473; x=1592809473;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/aAI0t7SceW7uN7ZHFC+JZPULVDAEYWGqO6WQts3cPk=;
  b=VZl7Z6L2O5YplhreYwv2tzfl71y0GzvhIyS6GXHFmfdKbfbyQRtxv3aN
   o2M2ok+HISbDepXL72ZR33CyNv9bIc+a3zr/3LhuIlunqiaiUewiU4kEs
   wd1hdaHbj0IVlsrO8k/L5BPHTzzTH7RQv5R3tVkZ624BGMrbp1keBxc3j
   upC+OYUqg49jhWhPyG4sl3ZKjv3yOK7650/6iRpbv8+iPuHaIrVht202Z
   zE9dmquK4biMDptvhAIeQC0OHmRKywtj1wqTNB7+XwqBrxHeAqN45mJ+z
   9AgxrcZ8FXskfXI5nDRSxgegu2dmaMYuVhrOllRxq2OKhuEkjlZwduTeu
   A==;
X-IronPort-AV: E=Sophos;i="5.63,407,1557158400"; 
   d="scan'208";a="116160441"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2019 15:04:32 +0800
IronPort-SDR: VYnVda1M3sGsQTMLd123K+2VX0dlESJafy7kWJZnjVEvVSh8ugWlLWkcBRsV8NavfKT6qFCDQm
 eMNEakY2MS3UkKL7unQrXrRka4otkDYDlReBRJf9X+YvU8mMSNFxcLPz5Ze3v1SRBjBqsCqbBT
 cdaOolRU19v1EjFiwPeTH/kHtVaabh4XSMZAYutfAiYM7MSzTJzqh/DLx/wSb0vqpjdq2RA4ul
 jHzRQaPHMZXvyIA5ec/fskGyv/0XMc/ekPxCdDb4T8vhshykW0hb5A/IU47EoZ5rye0u0ltEcw
 EfAqLI68o79Rrqsq12CZr0y6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 23 Jun 2019 00:03:45 -0700
IronPort-SDR: DxxiGAzKwK72J6F0YPI8XyUpqJTgv4mSmHAO5J/ATvgIPhjzcl2oVQxda3RF837bGJOxqpc0Nm
 GG3M8NCgj4Fxl3/F1i2kJDS28i9no3RNsWjS8j4IlSgEPEgJ5QQnMzU7T1WdBs1Bz567jnattr
 Crb+LKfgWO/05RFiR5T7Qxvp9Y4GX2zFUATRJDxxgiHchVJTEaFqP4R8RSFDuPKXgNfLeyHkPl
 MbEvE5xcwnaf8/T4OyJDH/dGCE9iGyFxZ6z9j4zUcRiGUX4NDAk+3Q1lmBuVigDaOn3wtyu5VA
 u1U=
Received: from usa003128.ad.shared (HELO [10.225.97.206]) ([10.225.97.206])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jun 2019 00:04:30 -0700
Subject: Re: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
To:     Troy Benjegerdes <troy.benjegerdes@sifive.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "sachin.ghadi@sifive.com" <sachin.ghadi@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yash.shah@sifive.com" <yash.shah@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
 <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
 <18c7992607dd1fed062bd295ac0738a759eff078.camel@wdc.com>
 <CAF5mof3QB8C7VjOyEvCsf9NEDkJhV3cBO5sBD+8z-GrWrnrAyg@mail.gmail.com>
 <3f91c8032e113a19dcec10ca71b017af1427ef7e.camel@wdc.com>
 <43da99709709d2a480b78f25356cda9255205372.camel@wdc.com>
 <A3E7D245-ABFA-4D81-87D6-3F6983AA3A93@sifive.com>
 <54493821-0155-4826-B165-B75FBB329D1A@sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <da45c3aa-d8c1-137c-d0f8-2ba5641293bf@wdc.com>
Date:   Sun, 23 Jun 2019 00:04:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <54493821-0155-4826-B165-B75FBB329D1A@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/19 6:57 PM, Troy Benjegerdes wrote:
> 
> 
>> On Jun 21, 2019, at 7:33 PM, Troy Benjegerdes <troy.benjegerdes@sifive.com> wrote:
>>
>>
>>
>>> On Jun 21, 2019, at 4:59 PM, Atish Patra <Atish.Patra@wdc.com> wrote:
>>>
>>> On Fri, 2019-06-21 at 14:46 -0700, Atish Patra wrote:
>>>> On Fri, 2019-06-21 at 14:18 -0500, Troy Benjegerdes wrote:
>>>>> Can you post the fsbl and other images you used to boot/test this?
>>>>>
>>>>
>>>
>>> Resending it without the attachment. Obviously, the mail did not go
>>> through with the binary blob attached :( :(. My bad.
>>>
>>> Let me know if you still want me to share the binary with you. I will
>>> probably share it via some other method.
>>
>> The bl came through as it was sent direct to me, and I can deal with
>> the tftp config manually. I have a kernel image, but not the boot.scr.uimg
>> that it looks like you are using. Is that from Yocto?
> 
> I got console output, after extracting the boot script from yocto.
> 

Glad it worked for you.
> The important part seems to be calling
> ‘bootm $kernel_addr_r - $fdt_addr_r’
> 
> Which maybe leads into a discussion of what can we do to at
> least output some sort of useful debug information if the device
> tree is not found or invalid?
> 
At least serial & clock needs to be correct for uart to work so that 
useful debug information can be displayed.

> I’d also like to propose that on RiscV, we use the chosen node
> for kernel command line
and initrd location (like qemu does), and
> in u-boot, default to always passing the device tree from bootm
> and other commands (like bootelf)
> 

If I understand you correctly, you want a kernel command line with fixed 
initrd location set in chosen node that U-Boot can pass on to kernel ?

If that's the case, that's not feasible as everybody's kernel command 
line may not be same and will probably override it using CONFIG_CMDLINE.

So I don't see the point int setting a fixed one. What's the advantage 
in doing that ?

>>
>>>
>>>> I have not changed fsbl. It's the default one came with the board.
>>>> Here are the heads of OpenSBI + U-Boot + Linux repo.
>>>>
>>>> OpenSBI: cd2dfdc870ed (master)
>>>> U-boot: 77f6e2dd0551 + Anup's patch series (v4)
>>>> https://github.com/atishp04/u-boot/tree/unleashed_working
>>>>
>>>> Linux: bed3c0d84e7e + Yash's Macb Series + this patch
>>>> https://github.com/atishp04/linux/tree/5.2-rc6-pre
>>>>
>>>> I have also attached the OpenSBI + U-boot binary as well. But this is
>>>> pre-configured with my tftpboot server. You need to change that.
>>>>
>>>>> I keep running into various failures when I build from source and I
>>>>> want to rule out potential hardware issues related to clock and/or
>>>>> ddr initialization
>>>>>
>>>>> On Fri, Jun 21, 2019, 2:14 PM Atish Patra <Atish.Patra@wdc.com>
>>>>> wrote:
>>>>>> On Fri, 2019-06-21 at 16:23 +0530, Yash Shah wrote:
>>>>>>> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver
>>>>>> added
>>>>>>> Signed-off-by: Yash Shah <yash.shah@sifive.com>
>>>>>>> ---
>>>>>>> arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 16
>>>>>>> ++++++++++++++++
>>>>>>> arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9
>>>>>> +++++++++
>>>>>>> 2 files changed, 25 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>>>> b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>>>> index 4e8fbde..c53b4ea 100644
>>>>>>> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>>>> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>>>> @@ -225,5 +225,21 @@
>>>>>>>                      #address-cells = <1>;
>>>>>>>                      #size-cells = <0>;
>>>>>>>              };
>>>>>>> +             eth0: ethernet@10090000 {
>>>>>>> +                     compatible = "sifive,fu540-macb";
>>>>>>> +                     interrupt-parent = <&plic0>;
>>>>>>> +                     interrupts = <53>;
>>>>>>> +                     reg = <0x0 0x10090000 0x0 0x2000
>>>>>>> +                            0x0 0x100a0000 0x0 0x1000>;
>>>>>>> +                     reg-names = "control";
>>>>>>> +                     status = "disabled";
>>>>>>> +                     local-mac-address = [00 00 00 00 00 00];
>>>>>>> +                     clock-names = "pclk", "hclk";
>>>>>>> +                     clocks = <&prci PRCI_CLK_GEMGXLPLL>,
>>>>>>> +                              <&prci PRCI_CLK_GEMGXLPLL>;
>>>>>>> +                     #address-cells = <1>;
>>>>>>> +                     #size-cells = <0>;
>>>>>>> +             };
>>>>>>> +
>>>>>>>      };
>>>>>>> };
>>>>>>> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-
>>>>>>> a00.dts
>>>>>>> b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>>>> index 4da8870..d783bf2 100644
>>>>>>> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>>>> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>>>> @@ -63,3 +63,12 @@
>>>>>>>              disable-wp;
>>>>>>>      };
>>>>>>> };
>>>>>>> +
>>>>>>> +&eth0 {
>>>>>>> +     status = "okay";
>>>>>>> +     phy-mode = "gmii";
>>>>>>> +     phy-handle = <&phy1>;
>>>>>>> +     phy1: ethernet-phy@0 {
>>>>>>> +             reg = <0>;
>>>>>>> +     };
>>>>>>> +};
>>>>>>
>>>>>> Thanks. I am able to boot Unleashed with networking enabled with
>>>>>> this
>>>>>> patch.
>>>>>>
>>>>>> FWIW,
>>>>>> Tested-by: Atish Patra <atish.patra@wdc.com>
>>>>>>
>>>>>> Regards,
>>>>>> Atish
>>>>>> _______________________________________________
>>>>>> linux-riscv mailing list
>>>>>> linux-riscv@lists.infradead.org
>>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
> 
> 


-- 
Regards,
Atish
