Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FAEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09362465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHs2MlgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfLJVf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:35:28 -0500
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:12926
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730116AbfLJVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:35:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKCdYHip9aAWl9zyHNqX7vjQ2LHSFK/2gLWfuSaN5EHkjhEdhfjVotuV4BjOtKdtHc6AejCqpjBmwfW+hH0gIjolZdMHlGnqBwdxHSw8AMXJXMBFUtPMuX0hW1U5zKJhamxwyAQHhM+DsqTb6tn6PbIiE6n296Qtt2BdXYwHsO3btsHqXFkjW7Pw4oErT4vy52rZcXgkLoEDKBINzjN9aBFcMTK5R4HbJ9Qoo9NIlS9ZgaKGh+ePEOXYXqdD5aMpoib8wy5ILbpl6UySGudR4pTw8w0TrXREM4khpw6KGCknL8nutPvWIYLZX8Qtb3LwNK5ALjZYeaYQNUhVJ75XTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBa6W2EnmqyH/qIIPQSxXs1Hmfu9gT7EGy5p9BMuvXI=;
 b=mRyytKdWo2+QssO8mTXrxHGW/rrVUOAEL+xOsjBpUOu4WPqY75OVKU7TXaXySmgtI4Yr17v84kaibqBqc1qHCal5C3drA13W44OiaUU1vbGUbnCiftOozhZwP3ubxFTRCDJfw0NGI2PvjS2gN8MxOx9SY1rLbFGyTCdOjZ1jag7zA11eSf0gQD02fzT7D/dO0eOXrwfVJOII6KZ0F4kqWAEtEM4mqNQ6YPGlA8kLi650r3aBvjXeY0ConxGsXHBaeilO6IBO7GzqFBwThGpqnSq8UZN5Eb3fNGqOu47Mei/8KJqR/mhJA/5KTXUbs5tCXDXyx088arT38Sksxepzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBa6W2EnmqyH/qIIPQSxXs1Hmfu9gT7EGy5p9BMuvXI=;
 b=IHs2MlgG490+/i+vaKrreIwLPF1BHfSHvLeW6P3FFQQ56FZea4qkava52IeZ74bO7z1JHfUPtFMuDqfZrib7guzrdPidOqpw0M4gCNILVgU2MS7tRYv/c5/5IxVr8c7ccSraxIaF2O0HdmkvzvArd4t7PX66NIWbsxN2oAZlQ1c=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3085.eurprd04.prod.outlook.com (10.170.227.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 21:35:05 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 21:35:05 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO
 regulator
Thread-Topic: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO
 regulator
Thread-Index: AQHVikhFuKo1SLIff0mMLrsG10nb5A==
Date:   Tue, 10 Dec 2019 21:35:05 +0000
Message-ID: <VI1PR04MB7023CD288FCC57806F067FD9EE5B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1571906920-29966-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8575ba3-bd1d-4885-9d1a-08d77db8d259
x-ms-traffictypediagnostic: VI1PR04MB3085:|VI1PR04MB3085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB308563EBBB3C8B7CC278C697EE5B0@VI1PR04MB3085.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(44832011)(186003)(53546011)(6506007)(91956017)(5660300002)(9686003)(52536014)(26005)(66946007)(478600001)(76116006)(66446008)(110136005)(66476007)(66556008)(64756008)(7696005)(54906003)(8936002)(4326008)(81156014)(33656002)(81166006)(55016002)(86362001)(316002)(2906002)(8676002)(71200400001)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3085;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CEW2d9IoSCK1DiSDbehpQun/hNpEMA0fzhVEYGn35QePVe6f4f8aFZ2c5D449pBhZ1eMwoBajgKD7yOnVbtMbLsih37VO0jXr62CIL7YHeBgfSKcYCAm8iedp/vPulYIgahw70jdHsve4yAhsDAJO2+2Fx2aMW3f1tHQ0Ms4Kr9EA0k0EvI5+x+QisLGORsDeQFbA/4Aq9CBsemyIWQXFxH/AQRLd0VReg3AJJmWUGnMps//SvhfRWDrriH/oULSub1hF8Jn6kGlsQnRtGrCQOzXXZFldo7suYVYHenIy24qxmU2eie1CX6OSU8d5rC5CMbF1hgil6hMJjWPLhFKv0mpO+UQL/hfdB8kIE0QqGOwuEfc7iaB9BQbY79Q7P18OLxlzrbkGpE6Ciz76K5C8f2TUz97GCcaVaO26/8JZH126AoPDfRd8rENx6Ec/lhEIIoShIv8jmDtZRKJXl0G2/OCUhdVKNtQPI0PV0e7BceV5O2HSkedTqrgGP1kQF6IxBWHyvAfWsgLsFSefckaACxXW63x5weg/v3UZoHtCgA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8575ba3-bd1d-4885-9d1a-08d77db8d259
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 21:35:05.1124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ga9GvwvObAZ6hv+CV2sJB/a7CeV5zaP19u9ifHgd23xINcUDOMHFw23qMyF1VXuzi9pJ7OrkL0rqNq3DBVn9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.2019 11:51, Anson Huang wrote:=0A=
> On i.MX6UL 14x14 EVK board, sensors' power are controlled=0A=
> by GPIO5_IO02, add GPIO regulator for sensors to manage=0A=
> their power.=0A=
> =0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
=0A=
For me this breaks network boot on imx6ul evk, relevant log snippet is this=
:=0A=
=0A=
     fec 20b4000.ethernet eth0: Unable to connect to phy=0A=
     IP-Config: Failed to open eth0=0A=
=0A=
Looking at schematics (SPF-28616_C2.pdf) I see that SNVS_TAMPER2 pin is =0A=
connected to PERI_PWREN which controls VPERI_3V3 which is used across =0A=
the board:=0A=
  * Sensors (VSENSOR_3V3)=0A=
  * Ethernet (VENET_3V3)=0A=
  * Bluetooth=0A=
  * CAN=0A=
  * Arduino header=0A=
  * Camera=0A=
=0A=
Maybe there are board revision differences? As far as I can tell this =0A=
regulator is not specific to sensors so it should be always on.=0A=
=0A=
> ---=0A=
>   arch/arm/boot/dts/imx6ul-14x14-evk.dtsi | 16 ++++++++++++++++=0A=
>   1 file changed, 16 insertions(+)=0A=
> =0A=
> diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/=
imx6ul-14x14-evk.dtsi=0A=
> index c2a9dd5..4074570 100644=0A=
> --- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi=0A=
> +++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi=0A=
> @@ -30,6 +30,16 @@=0A=
>   		enable-active-high;=0A=
>   	};=0A=
>   =0A=
> +	reg_sensors: regulator-sensors {=0A=
> +		compatible =3D "regulator-fixed";=0A=
> +		pinctrl-names =3D "default";=0A=
> +		pinctrl-0 =3D <&pinctrl_sensors_reg>;=0A=
> +		regulator-name =3D "sensors-supply";=0A=
> +		regulator-min-microvolt =3D <3300000>;=0A=
> +		regulator-max-microvolt =3D <3300000>;=0A=
> +		gpio =3D <&gpio5 2 GPIO_ACTIVE_LOW>;=0A=
> +	};=0A=
> +=0A=
>   	reg_can_3v3: regulator-can-3v3 {=0A=
>   		compatible =3D "regulator-fixed";=0A=
>   		regulator-name =3D "can-3v3";=0A=
> @@ -448,6 +458,12 @@=0A=
>   		>;=0A=
>   	};=0A=
>   =0A=
> +	pinctrl_sensors_reg: sensorsreggrp {=0A=
> +		fsl,pins =3D <=0A=
> +			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0=0A=
> +		>;=0A=
> +	};=0A=
> +=0A=
>   	pinctrl_pwm1: pwm1grp {=0A=
>   		fsl,pins =3D <=0A=
>   			MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0=0A=
> =0A=
=0A=
