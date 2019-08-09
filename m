Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51598C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15900208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sShPyJ8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405620AbfHIGSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:18:53 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:40238
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405550AbfHIGSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:18:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEf1VGHvwd3nCUMcAuXVyFph8DQEr3iZAxByKtX+KM62oVlPSjQo6ylfHMqRkQ8WL48AKeBrfa1JVwaFFv5ZgJhJVzeQ+sQGM/TfX22CfpL848n/32KPSGymDglEYkDnh0ZqxXO+VWTUJUH8El4UCIZPKxqw7vQbIPH07j6ZDIB8MQmf5oqZtdbC/OF1nrU7ShcG7ew+fKvuwQd/CcPmZfi/S/5dChgIcsJenhSagGcL61nrXttkKM5rFHJLZihPWTTrtPNlUATK61Iw9rzD5+zd4nWQBwfWtKu5cPb/UcPV3g6r2kwAg5m6spYtgIPW4gTIv6cGICwwPzzWU3+bFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKbjWU+bBYnloma39ILsKN4v9tEditZ/aYS7lALNgqY=;
 b=F1v4JNxN24OQ0ClZAagmqY6sEscGCx3CRkgRSb+GD221VGp11oaH9SMhIx3Od+nJpxwYQ8+DPKbiQCGBicsV6DzL86VGEdgqCxwxHrnafuLkOhrqLJOlNzEYd4GLn+O7d7javDqYP+uEEksfNQRDkNYxppoQh1S+gxEHs/kLtMS18zPVyhkoYl/B05ONT7GkA0dWLEQZu716A/TlQLKltV0H/Pf4UlKZwf887KjWTv6uFpIlKCM2Pg3CaAXVXZg4g4kGnKEyRLKUC/r1P1y2myfI7Dj0ED+MrFQpRw3eO/rpomuMwG+W+FrFfr41c0tVuJ0VAJMZcoroolCFOWFnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKbjWU+bBYnloma39ILsKN4v9tEditZ/aYS7lALNgqY=;
 b=sShPyJ8w3GkRAxtAHbmY4D19Sjb4x5wVexb5CuOtQNbcpRnT1RS/0zh6RLVUsm5D6hTSQ4AdxKjohCN7VsIB8Wl6mpujrcm8f5RPHsSuN8OsUiJI69E0WXl0v8rpIoRro7Kcj/BHAwbd5CCN+DsbN6hfcWXz3K7ysdqlagPKg5U=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2415.eurprd04.prod.outlook.com (10.169.134.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Fri, 9 Aug 2019 06:18:48 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::d805:690a:9e8a:9a74]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::d805:690a:9e8a:9a74%12]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 06:18:48 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [PATCH 2/2] ARM64: dts: Remove unused properties from FSL QSPI
 nodes
Thread-Topic: [PATCH 2/2] ARM64: dts: Remove unused properties from FSL QSPI
 nodes
Thread-Index: AQHU3yvM8yMRGyNksEqd6u7/XzJALabzNSzg
Date:   Fri, 9 Aug 2019 06:18:47 +0000
Message-ID: <VI1PR0401MB2496C44034AB6DB5F5379904F1D60@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190320143800.3555-1-frieder.schrempf@kontron.de>
 <20190320143800.3555-2-frieder.schrempf@kontron.de>
In-Reply-To: <20190320143800.3555-2-frieder.schrempf@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.0.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bee526f-0cf0-4654-4493-08d71c9170a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2415;
x-ms-traffictypediagnostic: VI1PR0401MB2415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB241523CC8C5257824F2A470BF1D60@VI1PR0401MB2415.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(13464003)(189003)(199004)(7736002)(53936002)(305945005)(102836004)(3846002)(478600001)(6636002)(66066001)(6246003)(66476007)(186003)(229853002)(4326008)(55016002)(25786009)(26005)(14454004)(9686003)(8676002)(53546011)(76176011)(446003)(6506007)(81166006)(476003)(8936002)(74316002)(7696005)(99286004)(76116006)(486006)(44832011)(2906002)(33656002)(64756008)(66556008)(66946007)(52536014)(66446008)(5660300002)(71200400001)(6116002)(110136005)(86362001)(54906003)(6436002)(5024004)(81156014)(14444005)(316002)(71190400001)(11346002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2415;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 54KTFGs9xJaV/c/ssJ8B4tiIUCCsq+DusWhLfimtSf+oewqkgdYztToULVOIi2sQBv/HT7a3x0m8ST3Jqpvzkl2G/KfHUflNhP7GaDnvkPGcbw9gD2Z8s9LnkUlTZk8GEcXzxKBUhYvVmmnLSoCUuUhv2l0641eNyQVBFzvpOhDZSfkzVXria4tEnqNVul2Jc6Fh6yG2uH3BPjd5+cv15P7ryq6naItpsJMP+pBAb9ZqETpsj10zilj2TlIaLuuDBxv80aTe4S6zlIIWBQYJHZ6250BE/bu7zLa+GN/e6WJEcnAqYlszDt+CMYzg+9rXPViPrL+wOdgNe3QY1ShZgS1ZDggSdKYDjYe4PltsM2eRf2WErR2ug/9DidPaty/QsU8pc4AluYP53jzAAKkJBDp1CHmSe+RVjbyT/UbY8qM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bee526f-0cf0-4654-4493-08d71c9170a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 06:18:48.0063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRpS0K584wRpT3MGi7DwS7MZBJGjW8ZzRKP4QhczzjPxjneCn/s9BlQpffumlLMVw8/NTSbhrcpYSkUukv9ooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn/Leo,

Removing the "big-endian" property has caused problems in our UEFI firmware=
.
In UEFI, we use the device tree to detect and use the qspi controller and f=
lashes attached to it.
We don't maintain a list of platforms like linux driver.

Can you please revert the endianness change from linux mainline ?

Regards,
Pankaj Bansal

> -----Original Message-----
> From: devicetree-owner@vger.kernel.org <devicetree-owner@vger.kernel.org>
> On Behalf Of Schrempf Frieder
> Sent: Wednesday, 20 March, 2019 08:08 PM
> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>
> Cc: Schrempf Frieder <frieder.schrempf@kontron.de>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 2/2] ARM64: dts: Remove unused properties from FSL QSPI
> nodes
>=20
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> After switching to the new FSL QSPI driver the properties 'fsl,qspi-has-s=
econd-
> chip' and 'big-endian' are not used anymore.
>=20
> The driver now uses the 'reg' property to determine the bus and the chips=
elect.
> The endianness is selected by the driver depending on which SoC is used.
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
> arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 --
>  2 files changed, 3 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 6fd6116509cc..2fb8138c6bb0 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -296,7 +296,6 @@
>  			interrupts =3D <0 99 0x4>;
>  			clock-names =3D "qspi_en", "qspi";
>  			clocks =3D <&clockgen 4 0>, <&clockgen 4 0>;
> -			big-endian;
>  			status =3D "disabled";
>  		};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index cb7185014d3a..b0ef08b090dd 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -215,8 +215,6 @@
>  			interrupts =3D <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "qspi_en", "qspi";
>  			clocks =3D <&clockgen 4 1>, <&clockgen 4 1>;
> -			big-endian;
> -			fsl,qspi-has-second-chip;
>  			status =3D "disabled";
>  		};
>=20
> --
> 2.17.1
