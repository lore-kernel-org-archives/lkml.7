Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB49C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA2920878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfDXJhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:37:15 -0400
Received: from gecko.sbs.de ([194.138.37.40]:45774 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfDXJhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:37:15 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x3O9b1oZ000883
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 11:37:02 +0200
Received: from [139.22.114.195] ([139.22.114.195])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x3O9axhK030796;
        Wed, 24 Apr 2019 11:36:59 +0200
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <cover.1555579429.git.jan.kiszka@siemens.com>
 <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
 <20190424075816.GU2654@lahna.fi.intel.com>
 <8999d3f8-d169-eb85-bd2f-08c99d184ea2@siemens.com>
 <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
Date:   Wed, 24 Apr 2019 11:36:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190424084259.GW2654@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.19 10:42, Mika Westerberg wrote:
> On Wed, Apr 24, 2019 at 10:25:40AM +0200, Jan Kiszka wrote:
>> On 24.04.19 10:18, Mika Westerberg wrote:
>>> On Wed, Apr 24, 2019 at 10:12:42AM +0200, Jan Kiszka wrote:
>>>> On 24.04.19 09:58, Mika Westerberg wrote:
>>>>> +Rafael and linux-acpi.
>>>>>
>>>>> On Thu, Apr 18, 2019 at 11:23:49AM +0200, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Validated on the Quark platform, this adds interrupt support on rising
>>>>>> and/or falling edges.
>>>>>
>>>>> The irqchip parts look good to me but but the ACPI SCI handling seems
>>>>> weird. This is typically handled by ACPI core based on the values read
>>>>> from FADT ACPI table. What does it contain on this Quark platform?
>>>>
>>>> There is no FADT on the original Quark firmware, nor did we add one. As we
>>>> are talking about existing devices, possibly not only Quarks, I was going
>>>> down the ACPI-independent way to hook into the interrupt. But I'm open to
>>>> learn about better alternatives.
>>>
>>> Hmm, if it does not have FADT table why would you need SCI then? Is this
>>> implementing some real use case?
>>>
>>
>> Maybe I'm looking at the wrong place: Where would I find it? There is
>> definitely no separate entry under /sys/firmware/acpi/tables - but that's
>> also true for my workstation.
> 
> The table signature and name is FACP for historical reasons.
> 

OK, there is that table, but what is it supposed to tell me about the
event and where to hook into it better?

[000h 0000   4]                    Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
[004h 0004   4]                 Table Length : 000000F4
[008h 0008   1]                     Revision : 03
[009h 0009   1]                     Checksum : CB
[00Ah 0010   6]                       Oem ID : "INTEL "
[010h 0016   8]                 Oem Table ID : "TIANO   "
[018h 0024   4]                 Oem Revision : 00000004
[01Ch 0028   4]              Asl Compiler ID : "INTL"
[020h 0032   4]        Asl Compiler Revision : 0100000D

[024h 0036   4]                 FACS Address : 371B7000
[028h 0040   4]                 DSDT Address : 37002000
[02Ch 0044   1]                        Model : 00
[02Dh 0045   1]                   PM Profile : 01 [Desktop]
[02Eh 0046   2]                SCI Interrupt : 0009
[030h 0048   4]             SMI Command Port : 000000B2
[034h 0052   1]            ACPI Enable Value : A0
[035h 0053   1]           ACPI Disable Value : A1
[036h 0054   1]               S4BIOS Command : 00
[037h 0055   1]              P-State Control : 00
[038h 0056   4]     PM1A Event Block Address : 00001000
[03Ch 0060   4]     PM1B Event Block Address : 00000000
[040h 0064   4]   PM1A Control Block Address : 00001004
[044h 0068   4]   PM1B Control Block Address : 00000000
[048h 0072   4]    PM2 Control Block Address : 00000000
[04Ch 0076   4]       PM Timer Block Address : 00001008
[050h 0080   4]           GPE0 Block Address : 00001100
[054h 0084   4]           GPE1 Block Address : 00000000
[058h 0088   1]       PM1 Event Block Length : 04
[059h 0089   1]     PM1 Control Block Length : 02
[05Ah 0090   1]     PM2 Control Block Length : 00
[05Bh 0091   1]        PM Timer Block Length : 04
[05Ch 0092   1]            GPE0 Block Length : 08
[05Dh 0093   1]            GPE1 Block Length : 00
[05Eh 0094   1]             GPE1 Base Offset : 00
[05Fh 0095   1]                 _CST Support : 00
[060h 0096   2]                   C2 Latency : 0065
[062h 0098   2]                   C3 Latency : 03E9
[064h 0100   2]               CPU Cache Size : 0400
[066h 0102   2]           Cache Flush Stride : 0010
[068h 0104   1]            Duty Cycle Offset : 01
[069h 0105   1]             Duty Cycle Width : 03
[06Ah 0106   1]          RTC Day Alarm Index : 00
[06Bh 0107   1]        RTC Month Alarm Index : 00
[06Ch 0108   1]            RTC Century Index : 00
[06Dh 0109   2]   Boot Flags (decoded below) : 0001
               Legacy Devices Supported (V2) : 1
            8042 Present on ports 60/64 (V2) : 0
                        VGA Not Present (V4) : 0
                      MSI Not Supported (V4) : 0
                PCIe ASPM Not Supported (V4) : 0
                   CMOS RTC Not Present (V5) : 0
[06Fh 0111   1]                     Reserved : 00
[070h 0112   4]        Flags (decoded below) : 000084B5
      WBINVD instruction is operational (V1) : 1
              WBINVD flushes all caches (V1) : 0
                    All CPUs support C1 (V1) : 1
                  C2 works on MP system (V1) : 0
            Control Method Power Button (V1) : 1
            Control Method Sleep Button (V1) : 1
        RTC wake not in fixed reg space (V1) : 0
            RTC can wake system from S4 (V1) : 1
                        32-bit PM Timer (V1) : 0
                      Docking Supported (V1) : 0
               Reset Register Supported (V2) : 1
                            Sealed Case (V3) : 0
                    Headless - No Video (V3) : 0
        Use native instr after SLP_TYPx (V3) : 0
              PCIEXP_WAK Bits Supported (V4) : 0
                     Use Platform Timer (V4) : 1
               RTC_STS valid on S4 wake (V4) : 0
                Remote Power-on capable (V4) : 0
                 Use APIC Cluster Model (V4) : 0
     Use APIC Physical Destination Mode (V4) : 0
                       Hardware Reduced (V5) : 0
                      Low Power S0 Idle (V5) : 0

[074h 0116  12]               Reset Register : [Generic Address Structure]
[074h 0116   1]                     Space ID : 01 [SystemIO]
[075h 0117   1]                    Bit Width : 08
[076h 0118   1]                   Bit Offset : 00
[077h 0119   1]         Encoded Access Width : 00 [Undefined/Legacy]
[078h 0120   8]                      Address : 0000000000000CF9

[080h 0128   1]         Value to cause reset : 02
[081h 0129   2]    ARM Flags (decoded below) : 0000
                              PSCI Compliant : 0
                       Must use HVC for PSCI : 0

[083h 0131   1]          FADT Minor Revision : 00
[084h 0132   8]                 FACS Address : 0000000000000000
[08Ch 0140   8]                 DSDT Address : 0000000037002000
[094h 0148  12]             PM1A Event Block : [Generic Address Structure]
[094h 0148   1]                     Space ID : 01 [SystemIO]
[095h 0149   1]                    Bit Width : 20
[096h 0150   1]                   Bit Offset : 00
[097h 0151   1]         Encoded Access Width : 00 [Undefined/Legacy]
[098h 0152   8]                      Address : 0000000000001000

[0A0h 0160  12]             PM1B Event Block : [Generic Address Structure]
[0A0h 0160   1]                     Space ID : 01 [SystemIO]
[0A1h 0161   1]                    Bit Width : 00
[0A2h 0162   1]                   Bit Offset : 00
[0A3h 0163   1]         Encoded Access Width : 00 [Undefined/Legacy]
[0A4h 0164   8]                      Address : 0000000000000000

[0ACh 0172  12]           PM1A Control Block : [Generic Address Structure]
[0ACh 0172   1]                     Space ID : 01 [SystemIO]
[0ADh 0173   1]                    Bit Width : 10
[0AEh 0174   1]                   Bit Offset : 00
[0AFh 0175   1]         Encoded Access Width : 00 [Undefined/Legacy]
[0B0h 0176   8]                      Address : 0000000000001004

[0B8h 0184  12]           PM1B Control Block : [Generic Address Structure]
[0B8h 0184   1]                     Space ID : 01 [SystemIO]
[0B9h 0185   1]                    Bit Width : 00
[0BAh 0186   1]                   Bit Offset : 00
[0BBh 0187   1]         Encoded Access Width : 00 [Undefined/Legacy]
[0BCh 0188   8]                      Address : 0000000000000000

[0C4h 0196  12]            PM2 Control Block : [Generic Address Structure]
[0C4h 0196   1]                     Space ID : 01 [SystemIO]
[0C5h 0197   1]                    Bit Width : 00
[0C6h 0198   1]                   Bit Offset : 00
[0C7h 0199   1]         Encoded Access Width : 00 [Undefined/Legacy]
[0C8h 0200   8]                      Address : 0000000000000000

[0D0h 0208  12]               PM Timer Block : [Generic Address Structure]
[0D0h 0208   1]                     Space ID : 01 [SystemIO]
[0D1h 0209   1]                    Bit Width : 20
[0D2h 0210   1]                   Bit Offset : 00
[0D3h 0211   1]         Encoded Access Width : 00 [Undefined/Legacy]
[0D4h 0212   8]                      Address : 0000000000001008

[0DCh 0220  12]                   GPE0 Block : [Generic Address Structure]
[0DCh 0220   1]                     Space ID : 01 [SystemIO]
[0DDh 0221   1]                    Bit Width : 40
[0DEh 0222   1]                   Bit Offset : 00
[0DFh 0223   1]         Encoded Access Width : 00 [Undefined/Legacy]
[0E0h 0224   8]                      Address : 0000000000001100

[0E8h 0232  12]                   GPE1 Block : [Generic Address Structure]
[0E8h 0232   1]                     Space ID : 01 [SystemIO]
[0E9h 0233   1]                    Bit Width : 00
[0EAh 0234   1]                   Bit Offset : 00
[0EBh 0235   1]         Encoded Access Width : 00 [Undefined/Legacy]
[0ECh 0236   8]                      Address : 0000000000000000


Raw Table Data: Length 244 (0xF4)

  0000: 46 41 43 50 F4 00 00 00 03 CB 49 4E 54 45 4C 20  // FACP......INTEL 
  0010: 54 49 41 4E 4F 20 20 20 04 00 00 00 49 4E 54 4C  // TIANO   ....INTL
  0020: 0D 00 00 01 00 70 1B 37 00 20 00 37 00 01 09 00  // .....p.7. .7....
  0030: B2 00 00 00 A0 A1 00 00 00 10 00 00 00 00 00 00  // ................
  0040: 04 10 00 00 00 00 00 00 00 00 00 00 08 10 00 00  // ................
  0050: 00 11 00 00 00 00 00 00 04 02 00 04 08 00 00 00  // ................
  0060: 65 00 E9 03 00 04 10 00 01 03 00 00 00 01 00 00  // e...............
  0070: B5 84 00 00 01 08 00 00 F9 0C 00 00 00 00 00 00  // ................
  0080: 02 00 00 00 00 00 00 00 00 00 00 00 00 20 00 37  // ............. .7
  0090: 00 00 00 00 01 20 00 00 00 10 00 00 00 00 00 00  // ..... ..........
  00A0: 01 00 00 00 00 00 00 00 00 00 00 00 01 10 00 00  // ................
  00B0: 04 10 00 00 00 00 00 00 01 00 00 00 00 00 00 00  // ................
  00C0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
  00D0: 01 20 00 00 08 10 00 00 00 00 00 00 01 40 00 00  // . ...........@..
  00E0: 00 11 00 00 00 00 00 00 01 00 00 00 00 00 00 00  // ................
  00F0: 00 00 00 00                                      // ....

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
