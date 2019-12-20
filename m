Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C56C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0678A24679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y6oJ3aJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfLTHfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:35:20 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12616 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:35:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfc79ac0000>; Thu, 19 Dec 2019 23:35:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 19 Dec 2019 23:35:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 19 Dec 2019 23:35:19 -0800
Received: from [10.19.108.118] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec
 2019 07:35:16 +0000
Subject: Re: [Patch V2 00/18] Tegra XUSB OTG support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <20191219131349.GI1440537@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <5212a532-1366-ff4f-e9c2-94b04e23eefd@nvidia.com>
Date:   Fri, 20 Dec 2019 15:35:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219131349.GI1440537@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576827309; bh=g6cinNKpqTaYMi4kn9LaHC8VtZ+9vfK0NwqwRxkQQ3I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Y6oJ3aJwLN3PCdxpS/MejfceoJ/njnLjWhXyjSgJzYIPFt/fV07ypdyLLpTNfFBNC
         izOP0QGOVSKIB7Jz/JojMSMykpP2CpgzaBSz6b3BVB40xDF+30ookfvkVbt1/gUG5G
         dfW0U12nPyeMoqY2rwD4bxZD5nzHmiRFqTqC7xJdNXydb1dA/zIwm8yxmqy92JQUxt
         UTkgu+MlWTMR+DfvPEqEIKhtQ+XOHvb+0ya/iQNoyC4W4S1XCvomqhK0bIZhWausf3
         DIdpYg6ReBr2cr+KVMterj4QrHBholgCH/z7B5nXxiP8jNHUtRVkBH7YQgeqL2hp7J
         POgkki8pSP55A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/19 9:13 PM, Thierry Reding wrote:
> On Wed, Dec 18, 2019 at 02:46:13PM +0530, Nagarjuna Kristam wrote:
>> This patch series adds OTG support on XUSB hardware used in Tegra210 and
>> Tegra186 SoCs.
>>
>> This patchset is composed with :
>>  - dt bindings of XUSB Pad Controller
>>  - dt bindings for XUSB device Driver
>>  - Tegra PHY driver for usb-role-switch and usb-phy
>>  - Tegra XUSB host mode driver to support OTG mode
>>  - Tegra XUSB device mode driver to use usb-phy and multi device mode
>>  - dts for XUSB pad controller
>>  - dts for xudc
>>
>> Tegra Pad controller driver register for role switch updates for
>> OTG/peripheral capable USB ports and adds usb-phy for that corresponding
>> USB ports.
>>
>> Host and Device mode drivers gets usb-phy from USB2's phy and registers
>> notifier for role changes to perform corresponding role tasks.
>>
>> Tests done:
>>  - device mode support using micro-B USB cable connection between ubuntu
>>    host and DUT on micro-B port
It's a micro-AB port according to Micro USB specifications.

>>  - host mode support by connecting pen-drive to micro USB port on DUT
>>    using micro-B OTG cable.
It's a standard-A to micro-A converter.

>>  - toggling between these 2 modes by hot plugging corresponding cables.
> 
> Are there any tests we can run without manual intervention? Can we force
> the device into peripheral mode and then setup a configuration using
> configfs? I'm not sure how useful that would be since it doesn't really
> exercise the driver code very much and doesn't tell whether it's
> actually working.
> 
> Any other way how we can test this?
> 
I don't think there is a way to test role-swap and host/device driver without
swapping cables. Thanks.

> Thierry
> 
>>
>> DUT: Jetson-tx1, Jetson tx2.
>>
>> V2:
>>  - Updated usb-role-switch documentation for Padctl driver.
>>  - Update XUDC bindings doc as suggested by Rob.
>>  - Used standard error codes for error return.
>>  - Added of_platform_depopulate during error and driver removal.
>>  - Updated error variable during phy initialization in XUDC driver.
>>  - Updated Tegra210 soc dtb file as per changes to binding doc.
>>
>> Nagarjuna Kristam (18):
>>   dt-bindings: phy: tegra-xusb: Add usb-role-switch
>>   dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
>>   phy: tegra: xusb: Add usb-role-switch support
>>   phy: tegra: xusb: Add usb-phy support
>>   phy: tegra: xusb: Add support to get companion USB 3 port
>>   phy: tegra: xusb: Add set_mode support for USB 2 phy on Tegra210
>>   phy: tegra: xusb: Add set_mode support for utmi phy on Tegra186
>>   usb: xhci-tegra: Add OTG support
>>   usb: gadget: tegra-xudc: Remove usb-role-switch support
>>   usb: gadget: tegra-xudc: Add usb-phy support
>>   usb: gadget: tegra-xudc: use phy_set_mode to set/unset device mode
>>   usb: gadget: tegra-xudc: support multiple device modes
>>   arm64: tegra: update OTG port entries for jetson-tx1
>>   arm64: tegra: update OTG port entries for jetson-tx2
>>   arm64: tegra: Add xudc node for Tegra210
>>   arm64: tegra: Enable xudc on Jetson TX1
>>   arm64: tegra: Add xudc node for Tegra186
>>   arm64: tegra: Enable xudc node on Jetson TX2
>>
>>  .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |   6 +
>>  .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 190 ++++++++++++++
>>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  23 +-
>>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  19 ++
>>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |  34 ++-
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  19 ++
>>  drivers/phy/tegra/Kconfig                          |   1 +
>>  drivers/phy/tegra/xusb-tegra186.c                  | 109 ++++++--
>>  drivers/phy/tegra/xusb-tegra210.c                  | 126 ++++++++--
>>  drivers/phy/tegra/xusb.c                           | 134 ++++++++++
>>  drivers/phy/tegra/xusb.h                           |   5 +
>>  drivers/usb/gadget/udc/tegra-xudc.c                | 276 ++++++++++++++-------
>>  drivers/usb/host/xhci-tegra.c                      | 225 ++++++++++++++++-
>>  include/linux/phy/tegra/xusb.h                     |   2 +
>>  14 files changed, 1031 insertions(+), 138 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
>>
>> -- 
>> 2.7.4
>>
