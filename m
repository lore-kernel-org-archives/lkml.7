Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B5AC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A9D2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="mqU4v4a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfEKRsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:48:43 -0400
Received: from node.akkea.ca ([192.155.83.177]:33202 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfEKRsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:48:43 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id AC2D44E204D; Sat, 11 May 2019 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557596922; bh=lJqKVF9Utmeexu4/9PvbN0VcjTxvy2f//T2aaSg+rQk=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=mqU4v4a7n3qhR1GBajJI64EU2VrEK899V7D8wNt+0UF7FUr+tRSioFeo7WwfF/aev
         zX/TozE2AkN+VikUSexxn9QbObQPov88Rxb4wfHTAhBv6xKpn8gKrN8tmD3gg5aUlU
         FBdw4uNcr7yuXYMBpet3bm+l3CxUrLtao2L3Md8c=
To:     Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v8 1/3] arm64: dts: fsl: librem5: Add a device tree for  the Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 11 May 2019 10:48:42 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAOMZO5APMf+iuJuqXCrMNX0Ud73iANXvEs+Y59iH+g6tuMX++Q@mail.gmail.com>
References: <20190501225719.3257-1-angus@akkea.ca>
 <20190501225719.3257-2-angus@akkea.ca>
 <CAOMZO5APMf+iuJuqXCrMNX0Ud73iANXvEs+Y59iH+g6tuMX++Q@mail.gmail.com>
Message-ID: <592c6d80582d0571bc49cfaa114adc83@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 2019-05-11 08:34, Fabio Estevam wrote:
> Hi Angus,
> 
> This looks good. Only minor issues:
> 
> On Wed, May 1, 2019 at 7:57 PM Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> @@ -0,0 +1,823 @@
>> +/* SPDX-License-Identifier: GPL-2.0+
> 
> This should be
> // SPDX-License-Identifier: GPL-2.0+
> 
> as pointed out by checkpatch.
> 
>> +       reg_1v8_p: regulator-1V8-P {
> 
> Maybe lowercase instead?
> 

Ok, I'll fix those 2.

>> +       wifi_pwr_en: wifi-en {
>> +               compatible = "regulator-fixed";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pinctrl_wifi_pwr_en>;
>> +               regulator-name = "WIFI_EN";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
>> +               enable-active-high;
>> +               regulator-always-on;
> 
> Do you really needs all these regulators to be 'regulator-always-on'?
> 

Unfortunately yes.

>> +&i2c1 {
>> +       clock-frequency = <400000>;
> 
> Maybe you could use 100kHz instead in order to avoid the problem
> described by the following i.MX8M erratum:
> 
> e7805: I2C: When the I2C clock speed is configured for 400 kHz, the
> SCL low period violates the I2C spec of 1.3 uS min
> https://www.nxp.com/docs/en/errata/IMX8MDQLQ_1N14W.pdf
> 

I discovered this a few days ago.

https://source.puri.sm/angus.ainslie/linux-next/commit/10c9d9e55aba0e179166001b9292e37a37bfe0ea

You're right 100kHz is a better choice.

>> +&usdhc2 {
>> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +       pinctrl-0 = <&pinctrl_usdhc2>;
>> +       pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
>> +       pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
>> +       bus-width = <4>;
>> +       vmmc-supply = <&reg_usdhc2_vmmc>;
>> +       power-supply = <&wifi_pwr_en>;
>> +
> 
> Unneeded blank line.

I'll fix it for the next rev.

Thanks
Angus

