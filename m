Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBD4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4044920818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="QrkEgSkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfDOO6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:58:19 -0400
Received: from node.akkea.ca ([192.155.83.177]:46428 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfDOO6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:58:18 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id A67A84E204B; Mon, 15 Apr 2019 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555340297; bh=Kc7cUyZtAWJIy0UnVNkOS5QC/tEpOGH2fKeWYUfecqc=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=QrkEgSkQV4YROtNXnbTUHsWU6N14qlv3LeRchQDTvymkIcQzI3HmSK5DhJ1H/13Ml
         7YABmnMjvUBmNdMNoFjtpGGhkttUTOMghSyt2jAf3WAdRLnk8PJEG4P3eIYg2Agem2
         tS71+Bce0V49mjN1ncViIH7XZaH5PdVBSy+oDWIA=
To:     Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: fsl: librem5: Add a device tree for  the Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Apr 2019 07:58:17 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        dl-linux-imx <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
        mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Gong <yibin.gong@nxp.com>, kernel@pengutronix.de,
        s.hauer@pengutronix.de
In-Reply-To: <baef6ba37a7a8d6e4dec0cfbc4ab8252b1d7a3fa.camel@nxp.com>
References: <20190412130427.13418-1-angus@akkea.ca>
 <20190412130427.13418-2-angus@akkea.ca>
 <baef6ba37a7a8d6e4dec0cfbc4ab8252b1d7a3fa.camel@nxp.com>
Message-ID: <8e0b801194e1a3e2961ccceeb9de5381@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-12 07:39, Leonard Crestez wrote:
> On Fri, 2019-04-12 at 07:04 -0600, Angus Ainslie (Purism) wrote:
>> +&i2c1 {
>> +       clock-frequency = <400000>;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_i2c1>;
>> +       status = "okay";
>> +
>> +       pmic: pmic@4b {
>> +               reg = <0x4b>;
>> +               compatible = "rohm,bd71837";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pinctrl_pmic>;
>> +               clocks = <&pmic_osc>;
>> +               clock-names = "osc";
>> +               clock-output-names = "pmic_clk";
>> +               interrupt-parent = <&gpio1>;
>> +               interrupts = <3 GPIO_ACTIVE_LOW>;
>> +               interrupt-names = "irq";
>> +               rohm,reset-snvs-powered;
>> +
>> +               gpo {
>> +                       /* 0b0000_1100 all gpos with cmos output mode
>> */
>> +                       rohm,drv = <0x0C>;
>> +               };
> 
> After searching for this gpo/rohm,drv property it does not seem to be
> documented or handled anywhere?
> 
> Should probably just drop.

Right I can't find it in the driver either. I'll drop it.

Thanks
Angus

> 
>> +               regulators {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       buck1_reg: BUCK1@0 {
>> +                               reg = <0>;
>> +                               regulator-name = "buck1";
>> +                               regulator-min-microvolt = <700000>;
>> +                               regulator-max-microvolt = <1300000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                               regulator-ramp-delay = <1250>;
>> +                               rohm,dvs-run-voltage = <900000>;
>> +                               rohm,dvs-idle-voltage = <850000>;
>> +                               rohm,dvs-suspend-voltage = <800000>;
>> +                       };
>> +
>> +                       buck2_reg: BUCK2@1 {
>> +                               reg = <1>;
>> +                               regulator-name = "buck2";
>> +                               regulator-min-microvolt = <700000>;
>> +                               regulator-max-microvolt = <1300000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                               regulator-ramp-delay = <1250>;
>> +                               rohm,dvs-run-voltage = <1000000>;
>> +                               rohm,dvs-idle-voltage = <900000>;
>> +                       };
>> +
>> +                       buck3_reg: BUCK3@2 {
>> +                               reg = <2>;
>> +                               regulator-name = "buck3";
>> +                               regulator-min-microvolt = <700000>;
>> +                               regulator-max-microvolt = <1300000>;
>> +                               rohm,dvs-run-voltage = <1000000>;
>> +                       };
>> +
>> +                       buck4_reg: BUCK4@3 {
>> +                               reg = <3>;
>> +                               regulator-name = "buck4";
>> +                               regulator-min-microvolt = <700000>;
>> +                               regulator-max-microvolt = <1300000>;
>> +                               rohm,dvs-run-voltage = <1000000>;
>> +                       };
>> +
>> +                       buck5_reg: BUCK5@4 {
>> +                               reg = <4>;
>> +                               regulator-name = "buck5";
>> +                               regulator-min-microvolt = <700000>;
>> +                               regulator-max-microvolt = <1350000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                       };
>> +
>> +                       buck6_reg: BUCK6@5 {
>> +                               reg = <5>;
>> +                               regulator-name = "buck6";
>> +                               regulator-min-microvolt = <3000000>;
>> +                               regulator-max-microvolt = <3300000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                       };
>> +
>> +                       buck7_reg: BUCK7@6 {
>> +                               reg = <6>;
>> +                               regulator-name = "buck7";
>> +                               regulator-min-microvolt = <1605000>;
>> +                               regulator-max-microvolt = <1995000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                       };
>> +
>> +                       buck8_reg: BUCK8@7 {
>> +                               reg = <7>;
>> +                               regulator-name = "buck8";
>> +                               regulator-min-microvolt = <800000>;
>> +                               regulator-max-microvolt = <1400000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                       };
>> +
>> +                       ldo1_reg: LDO1@8 {
>> +                               reg = <8>;
>> +                               regulator-name = "ldo1";
>> +                               regulator-min-microvolt = <3000000>;
>> +                               regulator-max-microvolt = <3300000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                       };
>> +
>> +                       ldo2_reg: LDO2@9 {
>> +                               reg = <9>;
>> +                               regulator-name = "ldo2";
>> +                               regulator-min-microvolt = <900000>;
>> +                               regulator-max-microvolt = <900000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                       };
>> +
>> +                       ldo3_reg: LDO3@10 {
>> +                               reg = <10>;
>> +                               regulator-name = "ldo3";
>> +                               regulator-min-microvolt = <1800000>;
>> +                               regulator-max-microvolt = <3300000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                       };
>> +
>> +                       ldo4_reg: LDO4@11 {
>> +                               reg = <11>;
>> +                               regulator-name = "ldo4";
>> +                               regulator-min-microvolt = <900000>;
>> +                               regulator-max-microvolt = <1800000>;
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                       };
>> +
>> +                       ldo5_reg: LDO5@12 {
>> +                               reg = <12>;
>> +                               regulator-name = "ldo5";
>> +                               regulator-min-microvolt = <1800000>;
>> +                               regulator-max-microvolt = <3300000>;
>> +                       };
>> +
>> +                       ldo6_reg: LDO6@13 {
>> +                               reg = <13>;
>> +                               regulator-name = "ldo6";
>> +                               regulator-min-microvolt = <900000>;
>> +                               regulator-max-microvolt = <1800000>;
>> +                       };
>> +
>> +                       ldo7_reg: LDO7@14 {
>> +                               reg = <14>;
>> +                               regulator-name = "ldo7";
>> +                               regulator-min-microvolt = <1800000>;
>> +                               regulator-max-microvolt = <3300000>;
>> +                       };
>> +               };
>> +       };

