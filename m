Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5DBC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1616B20644
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfH0CXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:23:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:32174 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfH0CXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:23:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 19:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="264130010"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 26 Aug 2019 19:23:11 -0700
Received: from [10.226.39.5] (leichuan-mobl.gar.corp.intel.com [10.226.39.5])
        by linux.intel.com (Postfix) with ESMTP id 13BC8580444;
        Mon, 26 Aug 2019 19:23:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     eswara.kota@linux.intel.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, qi-ming.wu@intel.com, robh@kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <20190824211158.5900-1-martin.blumenstingl@googlemail.com>
 <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com>
 <CAFBinCA_B9psNGBeDyhkewhoutNh6HsLUN+TRfO_8vuNqhis4Q@mail.gmail.com>
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Message-ID: <48b90943-e23d-a27a-c743-f321345c9151@linux.intel.com>
Date:   Tue, 27 Aug 2019 10:23:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCA_B9psNGBeDyhkewhoutNh6HsLUN+TRfO_8vuNqhis4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Please check the reply below.

On 8/27/2019 5:49 AM, Martin Blumenstingl wrote:
> Hi,
>
> On Mon, Aug 26, 2019 at 6:01 AM Chuan Hua, Lei
> <chuanhua.lei@linux.intel.com> wrote:
>> Hi Martin,
>>
>> Thanks for your comment.
> thank you for the quick reply
>
>> On 8/25/2019 5:11 AM, Martin Blumenstingl wrote:
>>> Hi Dilip,
>>>
>>>> Add driver for the reset controller present on Intel
>>>> Lightening Mountain (LGM) SoC for performing reset
>>>> management of the devices present on the SoC. Driver also
>>>> registers a reset handler to peform the entire device reset.
>>> [...]
>>>> +static const struct of_device_id intel_reset_match[] = {
>>>> +    { .compatible = "intel,rcu-lgm" },
>>>> +    {}
>>>> +};
>>> how is this IP block differnet from the one used in many Lantiq SoCs?
>>> there is already an upstream driver for the RCU IP block on the Lantiq
>>> SoCs: drivers/reset/reset-lantiq.c
>>>
>>> some background:
>>> Lantiq was started as a spinoff from Infineon in 2009. Intel then
>>> acquired Lantiq in 2015. source: [0]
>>> Intel is re-using some of the IP blocks from the MIPS Lantiq SoCs
>>> (Intel even has some own MIPS SoCs as part of the Lantiq acquisition,
>>> typically used for PON/GPON/ADSL/VDSL capable network devices).
>>> Thus I think it is likely that the new "Lightening Mountain" SoCs use
>>> an updated version of the Lantiq RCU IP.
>> I would not say there is a fundamental difference since reset is a
>> really simple
>> stuff from all reset drivers.  However, it did have some difference
>> from existing reset-lantiq.c since SoC becomes more and more complex.
> OK, let me go through your detailed list
>
>> 1. reset-lantiq.c use index instead of register offset + bit position.
>> index reset is good for a small system (< 64). However, it will become very
>> difficult to use if you have  > 100 reset. So we use register offset +
>> bit position
> reset-lantiq uses bit bit positions for specifying the reset line.
> for example this is from OpenWrt's vr9.dtsi:
>    reset0: reset-controller@10 {
>      ...
>      reg = <0x10 4>, <0x14 4>;
>      #reset-cells = <2>;
>    };
>
>    gphy0: gphy@20 {
>      ...
>      resets = <&reset0 31 30>, <&reset1 7 7>;
>      reset-names = "gphy", "gphy2";
>    };
>
> in my own words this means:
> - all reset0 reset bits are at offset 0x10 (parent is RCU)
> - all reset0 status bits are at offset 0x14 (parent is RCU)
> - the first reset line uses reset bit 31 and status bit 30
> - the second reset line uses reset bit 7 and status bit 7
> - there can be multiple reset-controller instances, each taking the
> reset and status offsets (OpenWrt's vr9.dtsi specifies the second RCU
> reset controller "reset1" with reset offset 0x48 and status offset
> 0x24)

in reset-lantiq.c, we split each reset request /status pair into one 
reset controller.

Each reset controller handles up to 32 resets. It will create up to 9 
even more

reset controllers in the new SoCs. In reality, there is only one RCU 
controller for all

SoCs. These designs worked but did not follow what hardware implemented.

After checking the existing code and referring to other implementation, 
we decided to

use register offset + bit position method. It can support all SoCs with 
this methods

without code change(device tree change only).

>
>> 2. reset-lantiq.c does not support device restart which is part of the
>> reset in
>> old lantiq SoC. It moved this part into arch/mips/lantiq directory.
> it was moved to the .dts instead of the arch code. again from
> OpenWrt's vr9.dtsi [0]:
>    reboot {
>      compatible = "syscon-reboot";
>      regmap = <&rcu0>;
>      offset = <0x10>;
>      mask = <0xe0000000>;
>    };
>
> this sets the reset0 reset bits 31, 30 and 29 at reboot
ok. but not sure why we need to reset bit 31 and 29. global softwre 
reset is bit 30.
>
>> 3. reset-lantiqc reset callback doesn't implement what hardware implemented
>> function. In old SoCs, some bits in the same register can be hardware
>> reset clear.
>>
>> It just call assert + assert. For these SoCs, we should only call
>> assert, hardware will auto deassert.
> I didn't know that. so to confirm I understand this correctly:
> - some reset lines must be asserted and de-asserted manually (setting
> and clearing the bit manually). the _assert and _deassert functions
> should be used in this case

Yes. We call software managed reset. callers call assert, deassert and delay

duration according to their specific requirement.

> - other reset lines only support reset pulses. the _reset function
> should be used in this case
> - the _reset function should only assert the reset line, then wait
> until the hardware automatically de-asserts it (without any further
> write)
Yes, this is called hardware reset. We can't control reset duration.
> is this the same for all, old and new SoCs?

New SoCs have removed support for hardware reset after software's feedback.

Old SoCs such as VRX200/ARX300 has both software/hardware resets

>
> only two mainline Lantiq drivers are using reset lines - both are
> using the _assert and _deassert variants:
> - drivers/net/dsa/lantiq_gswip.c
> - drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
It means migration will be very easy:)
>
>> 4. Code not optimized and intel internal review not assessed.
> insights from you (like the issue with the reset callback) are very
> valuable - this shows that we should focus on having one driver.
>
>> Based on the above findings, I would suggest reset-lantiq.c to move to
>> reset-intel-syscon.c
> my concern with having two separate drivers is that it will be hard to
> migrate from reset-lantiq to the "optimized" reset-intel-syscon
> driver.
> I don't have access to the datasheets for the any Lantiq/Intel SoC
> (VRX200 and even older).
> so debugging issues after switching from one driver to another is
> tedious because I cannot tell which part of the driver is causing a
> problem (it's either "all code from driver A" vs "all code from driver
> B", meaning it's hard to narrow it down).
> with separate commits/patches that are improving the reset-lantiq
> driver I can do git bisect to find the cause of a problem on the older
> SoCs (VRX200 for example)

Our internal version supports XRX350/XRX500/PRX300(MIPS based) and

latest Lighting Mountain(X86 based). Migration to reset-intel-syscon.c

should be straight forward.

>
>> What is your opinion?
> I explained why I would like to avoid having two separate drivers
> (even just for a limited amount of time)
>
>
> Martin
>
>
> [0] https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/lantiq/files/arch/mips/boot/dts/vr9.dtsi;h=e8b87dbcc7de2fb928a4e602f1a650030d2f7c35;hb=c3a78955f34a61d402044f357f54f21c75a19ff9#l103
